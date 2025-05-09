//Adam Fenjiro
//Spring 2025
//CS4121, P4

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <util/string_utils.h>
#include <util/symtab.h>
#include <util/dlink.h>
#include <util/symtab_stack.h>
#include "reg.h"
#include "codegen.h"
#include "types.h"
#include "symfields.h"

extern SymTable globalSymtab;
extern int globalOffset;
extern int dataSize;
extern int localOffset;

static void printDataDeclaration(DNode decl);
static void printInstruction(DNode inst);
static char *makeDataDeclaration(DList dataList, char *str);
static int emitBinaryExpression(DList instList, int leftOperand, int rightOperand, char *opcode);
static int emitBinaryCompareExpression(DList instList, int leftOperand, int rightOperand,
									   char *opcode);
static void makeLabel(char label[20]);

/**
 * Print a data declaration to stdout. This function is called by dlinkApply only.
 *
 * @param decl a DNode containing a data declaration
 */
static void printDataDeclaration(DNode decl)
{
	printf("\t%s\n", (char *)dlinkNodeAtom(decl));
}

/**
 * Emit the assembly prologue for a procedure
 * @param instList a list of instructions
 * @param name procedure/function name
 */
void emitProcedurePrologue(DList instList, char *name)
{
	char *inst = nssave(2, "\t.globl ", name);
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(3, "\t.type ", name, ",@function");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(2, name, ":\tnop");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = ssave("\tpushq %rbp");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = ssave("\tmovq %rsp, %rbp");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

// Emits the assembly prologue for a function, aligning the stack and preserving callee-saved registers.
void generateFunctionPrologue(DList instList)
{

	// Ensure stack alignment to 16 bytes
	int alignedStackOffset = (localOffset % 16 == 0) ? localOffset : (localOffset - (localOffset % 16));
	alignedStackOffset = (-alignedStackOffset) + 16; // Adjust offset for stack alignment

	char stackOffsetString[12]; // Buffer to hold the string representation of the offset
	sprintf(stackOffsetString, "%d", alignedStackOffset);

	// Create and append the stack adjustment instruction to the instruction list.
	char *inst = nssave(4, "\tsubq $", stackOffsetString, ",", " %rsp");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Push callee-saved registers onto the stack to preserve their values across function calls.
	inst = nssave(1, "\tpushq %rbx");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r12");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r13");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r14");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r15");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tsubq $8, %rsp");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

/**
 * Print the assembly prologue that includes the data section, declare the global area and string consts
 *
 * @param dataList a list of data declarations (strings)
 */
void emitDataPrologue(DList dataList)
{

	printf("\t.section\t.rodata\n");
	if (globalOffset != 0)
		printf("\t.comm _gp, %d, 4\n", globalOffset);

	dlinkApply(dataList, (DLinkApplyFunc)printDataDeclaration);
	printf("\t.text\n");
}

/**
 * Print an assembly instruction to stdout. This function is only called by dlinkApply.
 *
 * @param inst a DNode containing an assembly instruction.
 */
static void printInstruction(DNode inst)
{
	printf("%s\n", (char *)dlinkNodeAtom(inst));
}

/**
 * Print all of the assembly instructions for the main routine to stdout.
 *
 * @param instList a DList of assembly instructions.
 */
void emitInstructions(DList instList)
{
	dlinkApply(instList, (DLinkApplyFunc)printInstruction);
}

/**
 * Add an instruction that performs an assignment.
 *
 * @param instList a DList of assembly instructions
 * @param lhsRegIndex the register index of the register for the l-value address
 * @param rhsRegIndex the register index of the register for the r-value
 */
void emitAssignment(DList instList, int lhsRegIndex, int rhsRegIndex)
{
	char *inst;

	inst = nssave(5, "\tmovl ", getIntegerRegisterName(rhsRegIndex),
				  ", (", get64bitIntegerRegisterName(lhsRegIndex), ")");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(rhsRegIndex);
	freeIntegerRegister(lhsRegIndex);
}

// Transfer the function return value from EAX to a specified register and free the latter
void assignReturnValueToRegister(DList instList, int rhsRegIndex)
{
	char *inst = nssave(3, "\tmovl %eax", ", ", getIntegerRegisterName(rhsRegIndex));
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	freeIntegerRegister(rhsRegIndex);
}

/**
 * Add the instructions needed to read a variable using the scanf system call.
 *
 * @param instList a DList of instructions
 * @param dataList a Dlist of data declarations
 * @param addrIndex the register index of the register holding the address that is to be read into
 */
void emitReadVariable(DList instList, DList dataList, int addrIndex)
{
	char *inst;
	char *fmtLabel = makeDataDeclaration(dataList, "\"%d\"");
	inst = nssave(3, "\tleaq ", fmtLabel, "(%rip), %rdi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	free(fmtLabel);

	inst = nssave(3, "\tmovq ", get64bitIntegerRegisterName(addrIndex), ", %rsi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = ssave("\tmovl $0, %eax");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = ssave("\tcall scanf@PLT");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(addrIndex);
}

/**
 * Add the instructions needed to write a value using the printf system call.
 *
 * @param instList a Dlist of instructions
 * @param dataList a Dlist of data declarations
 * @param writeType write vs writeln
 * @param regIndex the index of the register to be printed
 * @param length restricted length of the output
 */
void emitWriteExpression(DList instList, DList dataList, int writeType, int regIndex, char *length)
{
	char *inst;
	char *fmtLabel;
	char *fmtStr;
	char lenStr[10];

	if (length)
		strcpy(lenStr, length);
	else
		strcpy(lenStr, "");

	if (writeType == IS_WRITE)
		fmtStr = nssave(3, "\"%", lenStr, "d\"");
	else
		fmtStr = nssave(3, "\"%", lenStr, "d\\n\"");

	fmtLabel = makeDataDeclaration(dataList, fmtStr);
	free(fmtStr);

	inst = nssave(3, "\tleaq ", fmtLabel, "(%rip), %rdi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	free(fmtLabel);

	inst = nssave(3, "\tmovl ", getIntegerRegisterName(regIndex), ", %esi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = ssave("\tmovl $0, %eax");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	freeIntegerRegister(regIndex);

	inst = ssave("\tcall printf@PLT");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

/**
 * Add the instructions needed to write a string using the printf system call.
 *
 * @param instList a Dlist of instructions
 * @param dataList a Dlist of data declarations
 * @param writeType write vs writeln
 * @param str the string to print
 * @param length restricted length of the output
 */
void emitWriteString(DList instList, DList dataList, int writeType, char *str, char *length)
{
	char *inst;
	char *fmtLabel;
	char *fmtStr;
	char lenStr[10];

	if (length)
		strcpy(lenStr, length);
	else
		strcpy(lenStr, "");

	if (writeType == IS_WRITE)
		fmtStr = nssave(3, "\"%", lenStr, "s\"");
	else
		fmtStr = nssave(3, "\"%", lenStr, "s\\n\"");

	fmtLabel = makeDataDeclaration(dataList, fmtStr);
	free(fmtStr);

	inst = nssave(3, "\tleaq ", fmtLabel, "(%rip), %rdi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	free(fmtLabel);

	char *quotedStr = nssave(3, "\"", str, "\"");
	char *strLabel = makeDataDeclaration(dataList, quotedStr);

	inst = nssave(4, "\tleaq ", strLabel, "(%rip), ", "%rsi");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	free(strLabel);

	inst = ssave("\tcall printf@PLT");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

/**
 * Add an instruction that performs a binary computation.
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @param opcode the opcode of the x86 assembly instruction
 * @return
 */
static int emitBinaryExpression(DList instList, int leftOperand, int rightOperand, char *opcode)
{
	char *leftName = getIntegerRegisterName(leftOperand);
	char *rightName = getIntegerRegisterName(rightOperand);

	char *inst = nssave(6, "\t", opcode, " ", rightName, ", ", leftName);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(rightOperand);

	return leftOperand;
}

/**
 * Add instructions for logical or
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitOrExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryExpression(instList, leftOperand, rightOperand, "orl");
}

/**
 * Add instructions for logical and
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitAndExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryExpression(instList, leftOperand, rightOperand, "andl");
}

/**
 * Add instructions for logical not
 *
 * @param instList a DList of instructions
 * @param operand the register index of the register holding the operand
 * @return the register index for the result register
 */
int emitNotExpression(DList instList, int operand)
{
	int tmpOp = allocateIntegerRegister();
	char *tmpName = getIntegerRegisterName(tmpOp);

	char *inst = nssave(2, "\tmovl $1, ", tmpName);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	emitBinaryExpression(instList, operand, tmpOp, "xorl");

	freeIntegerRegister(tmpOp);

	return operand;
}

/**
 * Add instructions that performs a binary comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @param opcode the opcode of the x86 assembly instruction
 * @return the register index for the result register
 */
static int emitBinaryCompareExpression(DList instList, int leftOperand, int rightOperand,
									   char *opcode)
{
	leftOperand = emitBinaryExpression(instList, leftOperand, rightOperand, "cmpl");
	freeIntegerRegister(rightOperand);

	char *inst = nssave(2, "\tmovl $0, ", getIntegerRegisterName(leftOperand));
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	int tregIndex = allocateIntegerRegister();

	inst = nssave(2, "\tmovl $1, ", getIntegerRegisterName(tregIndex));
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	return emitBinaryExpression(instList, leftOperand, tregIndex, opcode);
}

/**
 * Add instructions that performs a == comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitEqualExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmove");
}
/**
 * Add instructions that performs a != comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */

int emitNotEqualExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmovne");
}

/**
 * Add instructions that performs a <= comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitLessEqualExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmovle");
}

/**
 * Add instructions that performs a < comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitLessThanExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmovl");
}

/**
 * Add instructions that performs a >= comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 */
int emitGreaterEqualExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmovge");
}

/**
 * Add instructions that performs a > comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitGreaterThanExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryCompareExpression(instList, leftOperand, rightOperand, "cmovg");
}

/**
 * Add instructions that performs addtion
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitAddExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryExpression(instList, leftOperand, rightOperand, "addl");
}

/**
 * Add instructions that performs substruction
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitSubtractExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryExpression(instList, leftOperand, rightOperand, "subl");
}

/**
 * Add instructions that performs multiplication
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitMultiplyExpression(DList instList, int leftOperand, int rightOperand)
{
	return emitBinaryExpression(instList, leftOperand, rightOperand, "imull");
}

/**
 * Add instructions that performs division
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitDivideExpression(DList instList, int leftOperand, int rightOperand)
{
	char *inst;

	inst = nssave(3, "\tmovl ", getIntegerRegisterName(leftOperand), ", %eax");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = ssave("\tcdq");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = nssave(2, "\tidivl ", getIntegerRegisterName(rightOperand));
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = nssave(2, "\tmovl %eax, ", getIntegerRegisterName(leftOperand));
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(rightOperand);

	return leftOperand;
}

// Computes and appends assembly instruction to set the address of a variable into a register.
int emitComputeVariableAddress(DList instList, int varIndex, SymtabStack symtabStack, SymTable symtab)
{

	// Declare variables to hold assembly instructions and offset as a string
	char *inst;
	char variableOffset[10];
	int addressRegisterIndex = allocateIntegerRegister();								   // Allocate a new integer register to store the computed address
	char *addressRegisterName = (char *)get64bitIntegerRegisterName(addressRegisterIndex); // Retrieve the name of the allocated register

	// Get the offset of the variable within the symbol table and format it as a string
	snprintf(variableOffset, sizeof(variableOffset), "%d", (int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_OFFSET_FIELD));

	// Check if the variable is in the local or global symbol table
	if (symtab != globalSymtab)
	{

		inst = nssave(2, "\tmovq %rbp, ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		inst = nssave(4, "\taddq $", variableOffset, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
	}
	else
	{
		inst = nssave(2, "\tleaq _gp(%rip), ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
		inst = nssave(4, "\taddq $", variableOffset, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
	}

	return addressRegisterIndex; // Return the index of the register containing the address
}

// This function handles the calculation of a 2D array element's address by first determining the array's base address, then calculating the offset for each dimension of the array,
// and finally combining these to form the complete address, which is stored in a register.
int emitCompute2DArrayAddress(DList instList, int varIndex, int subIndex1, int subIndex2, SymtabStack stack, SymTable symtab)
{

	int addressRegisterIndex = allocateIntegerRegister(); // Allocate a register to store the final computed address.

	// Check if the variable at varIndex is indeed an array.
	if (isArrayType((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)))
	{
		char *addressRegisterName = get64bitIntegerRegisterName(addressRegisterIndex);
		char *inst;
		char offsetString[10];

		// Retrieve the array's offset within its symbol table and format it as a string.
		snprintf(offsetString, sizeof(offsetString), "%d", (int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_OFFSET_FIELD));

		// Load the base pointer for local arrays or the global pointer for global arrays.
		if (symtab != globalSymtab)
			inst = nssave(2, "\tmovq %rbp, ", addressRegisterName);
		else
			inst = nssave(2, "\tleaq _gp(%rip), ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Add the base offset of the array to the register.
		inst = nssave(4, "\taddq $", offsetString, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Allocate a temporary register and load the first subscript, extended to 64 bits.
		int tempRegisterIndex = allocateIntegerRegister();
		char *firstSubscriptReg32Name = getIntegerRegisterName(subIndex1);
		char *firstSubscriptRegName = get64bitIntegerRegisterName(subIndex1);
		char *tempRegisterName = get64bitIntegerRegisterName(tempRegisterIndex);
		inst = nssave(4, "\tmovslq ", firstSubscriptReg32Name, ", ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Subtract the base of the first dimension to get the correct index and scale it.
		snprintf(offsetString, 9, "%d", get1stDimensionbase((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)));
		inst = nssave(4, "\tsubq $", offsetString, ", ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Calculate the total offset contributed by the first dimension.
		snprintf(offsetString, 9, "%d", get2ndDimensionSize((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)));
		inst = nssave(4, "\tmovq $", offsetString, ", ", tempRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
		inst = nssave(4, "\timulq ", tempRegisterName, ", ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
		freeIntegerRegister(tempRegisterIndex); // this is temp

		// Extend the second subscript to 64 bits and add it to the offset from the first dimension.
		char *secondSubscriptReg32Name = getIntegerRegisterName(subIndex2);
		char *secondSubscriptRegName = get64bitIntegerRegisterName(subIndex2);
		inst = nssave(4, "\tmovslq ", secondSubscriptReg32Name, ", ", secondSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
		inst = nssave(4, "\taddq ", secondSubscriptRegName, ", ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Subtract the base of the second dimension and adjust the calculated index.
		snprintf(offsetString, 9, "%d", get2ndDimensionbase((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)));
		inst = nssave(4, "\tsubq $", offsetString, ", ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Multiply the final computed index by the size of the array elements
		inst = nssave(2, "\timulq $4, ", firstSubscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Add the computed address offset to the base address register
		inst = nssave(4, "\taddq ", firstSubscriptRegName, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
	}
	else
	{ // If the variable is not an array, output an error message.
		char errorMessage[80];
		snprintf(errorMessage, 80, "Scalar variable %s used as an array", (char *)SymGetFieldByIndex(globalSymtab, varIndex, SYM_NAME_FIELD));
		yyerror(errorMessage);
	}

	// Free the integer registers allocated for the subscripts.
	freeIntegerRegister(subIndex1);
	freeIntegerRegister(subIndex2);

	return addressRegisterIndex; // Return the register index holding the address of the array element
}

//  This function calculates the precise memory address of a specific element within a one-dimensional array based on its index. After computing the address, it
// then stores this value into a designated register for further use in assembly operations.
int emitComputeArrayAddress(DList instList, int varIndex, int subIndex, SymtabStack stack, SymTable symtab)
{

	int addressRegisterIndex = allocateIntegerRegister(); // Allocate a new register to store the computed address.

	// Verify if the variable is indeed an array.
	if (isArrayType((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)))
	{

		char *addressRegisterName = get64bitIntegerRegisterName(addressRegisterIndex);
		char *inst;
		char offsetString[10];

		// Get and format the array base offset from the symbol table.
		snprintf(offsetString, sizeof(offsetString), "%d", (int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_OFFSET_FIELD));

		// Load the appropriate base pointer for the variable scope.
		if (symtab != globalSymtab)
			inst = nssave(2, "\tmovq %rbp, ", addressRegisterName);
		else
			inst = nssave(2, "\tleaq _gp(%rip), ", addressRegisterName);
		// Append the instruction to load the base pointer.
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Add the offset to compute the array base address.
		inst = nssave(4, "\taddq $", offsetString, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Convert the subscript value to 64-bit and store in the same register.
		char *subscriptReg32Name = getIntegerRegisterName(subIndex);
		char *subscriptRegName = get64bitIntegerRegisterName(subIndex);
		inst = nssave(4, "\tmovslq ", subscriptReg32Name, ", ", subscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Subtract the base of the first dimension to adjust the subscript.
		snprintf(offsetString, 9, "%d", get1stDimensionbase((int)SymGetFieldByIndex(symtab, varIndex, SYMTAB_TYPE_INDEX_FIELD)));
		inst = nssave(4, "\tsubq $", offsetString, ", ", subscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Multiply the subscript by the size of the element
		inst = nssave(2, "\timulq $4, ", subscriptRegName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));

		// Add the adjusted subscript to the base address to compute the final address.
		inst = nssave(4, "\taddq ", subscriptRegName, ", ", addressRegisterName);
		dlinkAppend(instList, dlinkNodeAlloc(inst));
	}
	else
	{ // Handle the case where a scalar variable is mistakenly used as an array.
		char errorMessage[80];
		snprintf(errorMessage, 80, "Scalar variable %s used as an array", (char *)SymGetFieldByIndex(globalSymtab, varIndex, SYM_NAME_FIELD));
		yyerror(errorMessage);
	}

	// Free the register used for the subscript.
	freeIntegerRegister(subIndex);

	return addressRegisterIndex;
}

/**
 * Add an instruction to load a variable from memory.
 *
 * @param instList a Dlist of instructions
 * @param regIndex the register index for the address of a variable
 * @return the register index of the result register
 */
int emitLoadVariable(DList instList, int regIndex)
{
	int dstRegIndex = allocateIntegerRegister();
	char *dstRegName = getIntegerRegisterName(dstRegIndex);

	char *srcaddressRegisterName = get64bitIntegerRegisterName(regIndex);

	char *inst = nssave(4, "\tmovl (", srcaddressRegisterName, "), ", dstRegName);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(regIndex);

	return dstRegIndex;
}

/**
 * Add an instruction to load an integer constant
 *
 * @param instList a Dlist of instructions
 * @param intConst the const string of an integer constant
 * @return the register index of the result register holding the const
 */
int emitLoadIntegerConstant(DList instList, char *intConst)
{
	int regIndex = allocateIntegerRegister();
	char *regName = (char *)getIntegerRegisterName(regIndex);
	char *inst;

	inst = nssave(4, "\tmovl $", intConst, ", ", regName);

	dlinkAppend(instList, dlinkNodeAlloc(inst));

	return regIndex;
}

/**
 * Add a .asciiz declaration for a string constant if it hasn't been declared
 *
 * @param dataList a DList of data declarations
 * @param str string constant to put into data section
 * @return the label of the string constant
 */
static char *makeDataDeclaration(DList dataList, char *str)
{
	static int stringNum = 0;
	int symIndex = SymQueryIndex(globalSymtab, str);
	int labelcount;
	char *strLabel = (char *)malloc(sizeof(char) * 15);

	if (symIndex == SYM_INVALID_INDEX)
	{
		symIndex = SymIndex(globalSymtab, str);
		labelcount = stringNum++;
		SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_OFFSET_FIELD, (Generic)labelcount);

		snprintf(strLabel, 17, ".string_const%d", labelcount);

		char *decl = nssave(3, strLabel, ": .string ", str);
		dlinkAppend(dataList, dlinkNodeAlloc(decl));
	}
	else
	{
		labelcount = (int)SymGetFieldByIndex(globalSymtab, symIndex, SYMTAB_OFFSET_FIELD);
		snprintf(strLabel, 15, ".string_const%d", labelcount);
	}

	return strLabel;
}

//  This function adds identifier to the symbol table to then store its offset in the activation record
void addIdToSymtab(DNode node, Generic gtypeid, SymtabStack stack)
{

	// Check if there are more than one symbol tables in the stack
	if (stackSize(stack) > 1)
	{
		// Check if the type size of the identifier is greater than 4 bytes
		// If not, simply use the current localOffset without adjustment.
		if (getTypeSize((int)gtypeid) > 4)
			SymPutFieldByIndex(currentSymtab(stack), (int)dlinkNodeAtom(node), SYMTAB_OFFSET_FIELD, (Generic)(localOffset - getTypeSize((int)gtypeid)));
		else
			SymPutFieldByIndex(currentSymtab(stack), (int)dlinkNodeAtom(node), SYMTAB_OFFSET_FIELD, (Generic)(localOffset));
		SymPutFieldByIndex(currentSymtab(stack), (int)dlinkNodeAtom(node), SYMTAB_TYPE_INDEX_FIELD, (Generic)(int)gtypeid);
		localOffset = localOffset - getTypeSize((int)gtypeid);
	}
	else
	{ // If there's only the global symbol table in the stack.
		SymPutFieldByIndex(globalSymtab, (int)dlinkNodeAtom(node), SYMTAB_OFFSET_FIELD, (Generic)(globalOffset));
		SymPutFieldByIndex(globalSymtab, (int)dlinkNodeAtom(node), SYMTAB_TYPE_INDEX_FIELD, (Generic)(int)gtypeid);
		globalOffset = globalOffset + getTypeSize((int)gtypeid);
	}
}

//  This function appends the procedure exit instructions to an instruction list, managing stack frame restoration and function exit.
void emitProcedureExit(DList instList)
{
	char *inst;

	// Append 'leave' instruction to restore the caller's stack frame.
	inst = ssave("\tleave");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Append 'ret' instruction to return control to the calling function.
	inst = ssave("\tret");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

// Emit instructions for cleaning up the local stack environment and restoring callee-saved registers.
// This function is used at the end of a procedure to undo modifications to the stack and restore the state of saved registers.
void generateFunctionEpilogue(DList instList)
{
	char *inst;

	// Adjust the stack pointer to deallocate local variables or alignment padding.
	inst = nssave(1, "\taddq $8, %rsp");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Restore callee-saved registers in reverse order of their saving.
	inst = nssave(1, "\tpopq %r15");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r14");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r13");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r12");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %rbx");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

/**
 * Create a unique label
 * @param label a character array of size 20 in which the label will be stored
 */
static void makeLabel(char label[20])
{
	static int labelCount = 0;

	snprintf(label, 19, ".L%d", labelCount++);
}

/**
 * Insert instructions to test whether the expression of a if-statement is false, if false, branch around the then-part
 * of the if-statement.
 *
 * @param instList a list of instructions
 * @param regIndex the index of the register holding the rest of the test expression of an if-statement
 * @return the symbol table index of the label that must follow the then-part of an if-statement
 */
int emitIfTest(DList instList, int regIndex)
{
	char label[20];
	makeLabel(label);

	int treg = allocateIntegerRegister();
	char *symReg = getIntegerRegisterName(treg);

	char *inst = nssave(2, "\tmovl $-1, ", symReg);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = nssave(4, "\ttestl ", getIntegerRegisterName(regIndex), ", ", symReg);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(regIndex);
	freeIntegerRegister(treg);

	inst = nssave(2, "\tje ", label); /* jump to false*/
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	return SymIndex(globalSymtab, label);
}
/**
 * Insert a nop as a branch target in the list of instructions.
 *
 * @param instList a list of instructions
 * @param endLabelIndex the symbol table index of the label for the nop
 */
void emitEndBranchTarget(DList instList, int endLabelIndex)
{
	char *inst = nssave(2, SymGetFieldByIndex(globalSymtab, endLabelIndex, SYM_NAME_FIELD), ":\t nop");

	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

/**
 * Insert a branch to an ending label after the else-part of an if-statement.
 *
 * @param instList a list of instructions
 * @param elseLabelIndex the symbol table index of the label for the beginning of the else-part of an if-statement
 * @return a symbol table index for the end label of an if-statement
 */
int emitThenBranch(DList instList, int elseLabelIndex)
{
	char label[20];
	makeLabel(label);

	char *inst = nssave(2, "\tjmp ", label);

	dlinkAppend(instList, dlinkNodeAlloc(inst));

	emitEndBranchTarget(instList, elseLabelIndex);

	return SymIndex(globalSymtab, label);
}
/**
 * Insert a labeled nop to serve as a target of the backwards branch of a while-statement
 *
 * @param instList a list of instructions
 * @return the label for the backwards branch target
 */
int emitWhileLoopLandingPad(DList instList)
{
	char label[20];
	makeLabel(label);

	char *inst = nssave(2, label, ":\tnop");

	dlinkAppend(instList, dlinkNodeAlloc(inst));

	return SymIndex(globalSymtab, label);
}

/**
 * Insert a test to enter a while loop. If the test is false, branch to a label after the loop.
 *
 * @param instList a list of instructions
 * @param regIndex the index for the register holding the result of the test expression of a while-statement
 * @return a symbol table index for the label at the end of the while-loop
 */
int emitWhileLoopTest(DList instList, int regIndex)
{
	char label[20];
	makeLabel(label);

	int treg = allocateIntegerRegister();
	char *symReg = getIntegerRegisterName(treg);

	char *inst = nssave(2, "\tmovl $-1, ", symReg);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = nssave(4, "\ttestl ", getIntegerRegisterName(regIndex), ", ", symReg);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	freeIntegerRegister(regIndex);
	freeIntegerRegister(treg);

	inst = nssave(2, "\tje ", label);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	return SymIndex(globalSymtab, label);
}

/**
 * Insert a branch back to the the landing pad of a while loop, followed by a branch target for loop exit.
 *
 * @param instList a list of instructions
 * @param beginLabelIndex a symbol table index of the label for the while loop landing pad
 * @param endLabelIndex a symbol table index of the label for the exit of the while loop
 */
void emitWhileLoopBackBranch(DList instList, int beginLabelIndex, int endLabelIndex)
{
	char *inst = nssave(2, "\tjmp ", (char *)SymGetFieldByIndex(globalSymtab, beginLabelIndex, SYM_NAME_FIELD));

	dlinkAppend(instList, dlinkNodeAlloc(inst));

	inst = nssave(2, (char *)SymGetFieldByIndex(globalSymtab, endLabelIndex, SYM_NAME_FIELD), ":\t nop");

	dlinkAppend(instList, dlinkNodeAlloc(inst));
}

// Emit assembly instructions for calling a function by name and handling register preservation.
int generateFunctionCall(DList instList, char *name)
{
	char *inst;

	// Save caller-saved registers (r8 to r11) on the stack before the function call
	inst = nssave(1, "\tpushq %r8");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r9");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r10");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpushq %r11");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Issue the call instruction to invoke the function by name.
	inst = nssave(2, "\tcall ", name);
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Restore the caller-saved registers in reverse order after the function call.
	inst = nssave(1, "\tpopq %r11");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r10");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r9");
	dlinkAppend(instList, dlinkNodeAlloc(inst));
	inst = nssave(1, "\tpopq %r8");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Allocate a register to potentially store any return value from the function call.
	return allocateIntegerRegister();
}

// Emit instructions to move the value from a specified register to the EAX register and clean up.
void setupFunctionReturn(DList instList, int reg)
{
	char *inst;

	// Move the value from the given register to %eax to prepare for returning it from a function.
	inst = nssave(3, "\tmovl ", getIntegerRegisterName(reg), ", %eax");
	dlinkAppend(instList, dlinkNodeAlloc(inst));

	// Free the used register to ensure it's available for reuse after the function returns.
	freeIntegerRegister(reg);
}
