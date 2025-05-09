#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <util/string_utils.h>
#include <util/symtab.h>
#include <util/dlink.h>
#include "reg.h"
#include "codegen.h"
#include "symfields.h"

extern SymTable globalSymtab;
extern int globalOffset;
extern int dim2UpperBound; //Holds the upper boundary index for the second dimension of an array
extern int dim1LowerBound; //Stores the lower boundary index for the first dimension of an array
extern int arrayByteSize; //Specifies the total byte size of the array
extern int dim2LowerBound; //Holds the lower boundary index for the second dimension of an array

static void printDataDeclaration(DNode decl);
static void printInstruction(DNode inst);
static char* makeDataDeclaration(DList dataList, char *str);
static int emitBinaryExpression(DList instList, int leftOperand, int rightOperand, char* opcode);
static int emitBinaryCompareExpression(DList instList, int leftOperand, int rightOperand,
				       char *opcode);

/**
 * Print a data declaration to stdout. This function is called by dlinkApply only.
 *
 * @param decl a DNode containing a data declaration
 */
static void printDataDeclaration(DNode decl) {
	printf("\t%s\n",(char*)dlinkNodeAtom(decl));

}

/**
 * Emit the assembly prologue for a procedure
 * @param instList a list of instructions
 * @param name procedure/function name
 */
void emitProcedurePrologue(DList instList, char* name) {
	char* inst = nssave(2,"\t.globl ",name);
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	inst = nssave(3,"\t.type ",name,",@function");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	inst = nssave(2,name,":\tnop");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	inst = ssave("\tpushq %rbp");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	inst = ssave("\tmovq %rsp, %rbp");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
}


/**
 * Print the assembly prologue that includes the data section, declare the global area and string consts 
 *
 * @param dataList a list of data declarations (strings)
 */
void emitDataPrologue(DList dataList) {

	printf("\t.section\t.rodata\n");
	if (globalOffset != 0)
		printf("\t.comm _gp, %d, 4\n",globalOffset);  
		                                               
	dlinkApply(dataList,(DLinkApplyFunc)printDataDeclaration);
	printf("\t.text\n");
}

/**
 * Print an assembly instruction to stdout. This function is only called by dlinkApply.
 *
 * @param inst a DNode containing an assembly instruction.
 */
static void printInstruction(DNode inst) {
	printf("%s\n",(char*)dlinkNodeAtom(inst));
}

/**
 * Print all of the assembly instructions for the main routine to stdout.
 *
 * @param instList a DList of assembly instructions.
 */
void emitInstructions(DList instList) {
	dlinkApply(instList,(DLinkApplyFunc)printInstruction);
}

/**
 * Add an instruction that performs an assignment.
 *
 * @param instList a DList of assembly instructions
 * @param lhsRegIndex the register index of the register for the l-value address
 * @param rhsRegIndex the register index of the register for the r-value
 */
void emitAssignment(DList instList, int lhsRegIndex, int rhsRegIndex) {
	char *inst;
	
	inst = nssave(5,  "\tmovl ", getIntegerRegisterName(rhsRegIndex),
			", (", get64bitIntegerRegisterName(lhsRegIndex), ")");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	freeIntegerRegister(lhsRegIndex);
	freeIntegerRegister(rhsRegIndex);
}

//Initializes a comparison test by using the 'testl' instruction to evaluate the logical conjunction of two operands
void initializeComparisonTest(DList instList, int leftOperand, int rightOperand) {
    //Append a 'testl' instruction to compare two registers and update flags
	dlinkAppend(instList, dlinkNodeAlloc(nssave(4, "\ttestl ", getIntegerRegisterName(leftOperand), ", ", getIntegerRegisterName(rightOperand))));
    //Free the registers used for the comparison
	freeIntegerRegister(leftOperand);
    freeIntegerRegister(rightOperand);
}

//Initializes a jump operation using the provided opcode and loop label for conditional branching
void initializeJumpOperation(DList instList, int loop, char* opCode) {
    char buffer[16];
	//Format the jump label based on the loop number
    sprintf(buffer, " .L%d", loop);
	//Append the jump instruction to the instruction list
    dlinkAppend(instList, dlinkNodeAlloc(nssave(3, "\t", opCode, buffer)));
}

//Sets up a loop control label in assembly language to mark the beginning of a loop block
void initializeLoopControl(DList instList, int loop) {
    char buffer[16];
	//Format the loop label with a 'nop' operation for stability
    sprintf(buffer, "\t.L%d:\tnop", loop);
	//Append the loop label to the instruction list
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, buffer)));
}

/**
 * Add the instructions needed to read a variable using the scanf system call.
 *
 * @param instList a DList of instructions
 * @param dataList a Dlist of data declarations
 * @param addrIndex the register index of the register holding the address that is to be read into
 */
void emitReadVariable(DList instList, DList dataList, int addrIndex) {
    char *inst;
    char *fmtLabel = makeDataDeclaration(dataList, "\"%d\"");
	inst = nssave(3,"\tleaq ", fmtLabel, "(%rip), %rdi");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	free(fmtLabel);
	 
	inst = nssave(3,"\tmovq ", get64bitIntegerRegisterName(addrIndex), ", %rsi");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	inst = ssave("\tmovl $0, %eax");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	inst = ssave("\tcall scanf@PLT");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

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
void emitWriteExpression(DList instList, DList dataList, int writeType, int regIndex, char *length) {
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
	dlinkAppend(instList,dlinkNodeAlloc(inst));
    free(fmtLabel);
	
	inst = nssave(3,"\tmovl ", getIntegerRegisterName(regIndex), ", %esi");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	inst = ssave("\tmovl $0, %eax");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	freeIntegerRegister(regIndex);
	  
	inst = ssave("\tcall printf@PLT");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
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
void emitWriteString(DList instList,  DList dataList, int writeType, char *str, char *length) {
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
	dlinkAppend(instList,dlinkNodeAlloc(inst));
    free(fmtLabel);

	char *quotedStr = nssave(3, "\"", str, "\"");
	char *strLabel = makeDataDeclaration(dataList, quotedStr);

	inst = nssave(4,"\tleaq ", strLabel, "(%rip), ", "%rsi");
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	free(strLabel);

	inst = ssave("\tcall printf@PLT");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
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
static int emitBinaryExpression(DList instList, int leftOperand, int rightOperand, char* opcode) {
	char* leftName = getIntegerRegisterName(leftOperand);
	char* rightName = getIntegerRegisterName(rightOperand);

	char* inst = nssave(6,"\t",opcode," ", rightName,", ",leftName);
	dlinkAppend(instList,dlinkNodeAlloc(inst));

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
int emitOrExpression(DList instList, int leftOperand, int rightOperand) {
	return emitBinaryExpression(instList,leftOperand,rightOperand,"orl");
}

/**
 * Add instructions for logical and
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitAndExpression(DList instList, int leftOperand, int rightOperand) {
	return emitBinaryExpression(instList,leftOperand,rightOperand,"andl");
}

/**
 * Add instructions for logical not
 *
 * @param instList a DList of instructions
 * @param operand the register index of the register holding the operand
 * @return the register index for the result register
 */
int emitNotExpression(DList instList, int operand) {
 	int tmpOp = allocateIntegerRegister();
	char *tmpName = getIntegerRegisterName(tmpOp);
	
	char* inst = nssave(2, "\tmovl $1, ", tmpName);
	dlinkAppend(instList,dlinkNodeAlloc(inst));

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
				       char *opcode) {
	leftOperand = emitBinaryExpression(instList,leftOperand,rightOperand,"cmpl");
	freeIntegerRegister(rightOperand);

	char *inst = nssave(2,"\tmovl $0, ", getIntegerRegisterName(leftOperand));
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	int tregIndex = allocateIntegerRegister();

	inst = nssave(2,"\tmovl $1, ", getIntegerRegisterName(tregIndex));
	dlinkAppend(instList,dlinkNodeAlloc(inst));

	return emitBinaryExpression(instList,leftOperand,tregIndex,opcode);
}

/**
 * Add instructions that performs a == comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitEqualExpression(DList instList, int leftOperand, int rightOperand) {
    return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmove");
}
/**
 * Add instructions that performs a != comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */

int emitNotEqualExpression(DList instList, int leftOperand, int rightOperand) {
  return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmovne");
}

/**
 * Add instructions that performs a <= comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitLessEqualExpression(DList instList, int leftOperand, int rightOperand) {
  return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmovle");
}

/**
 * Add instructions that performs a < comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitLessThanExpression(DList instList,int leftOperand, int rightOperand) {
  return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmovl");
}

/**
 * Add instructions that performs a >= comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 */
int emitGreaterEqualExpression(DList instList, int leftOperand, int rightOperand) {
  return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmovge");
}

/**
 * Add instructions that performs a > comparison
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitGreaterThanExpression(DList instList, int leftOperand, int rightOperand) {
  return emitBinaryCompareExpression(instList,leftOperand,rightOperand,"cmovg");
}


/**
 * Add instructions that performs addtion
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitAddExpression(DList instList, int leftOperand, int rightOperand) {
	return emitBinaryExpression(instList,leftOperand,rightOperand,"addl");
}

/**
 * Add instructions that performs substruction
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitSubtractExpression(DList instList, int leftOperand, int rightOperand) {
	return emitBinaryExpression(instList,leftOperand,rightOperand,"subl");
}

/**
 * Add instructions that performs multiplication
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitMultiplyExpression(DList instList, int leftOperand, int rightOperand) {
	return emitBinaryExpression(instList,leftOperand,rightOperand,"imull");
}

/**
 * Add instructions that performs division
 *
 * @param instList a DList of instructions
 * @param leftOperand the register index of the register holding the left operand
 * @param rightOperand the register index of the register holding the right operand
 * @return the register index for the result register
 */
int emitDivideExpression(DList instList, int leftOperand, int rightOperand) {
        char *inst;
	
	    inst = nssave(3,"\tmovl ", getIntegerRegisterName(leftOperand), ", %eax");
	    dlinkAppend(instList,dlinkNodeAlloc(inst));


		inst = ssave("\tcdq");
		dlinkAppend(instList,dlinkNodeAlloc(inst));

		inst = nssave(2,"\tidivl ", getIntegerRegisterName(rightOperand));
		dlinkAppend(instList,dlinkNodeAlloc(inst));

	    inst = nssave(2,"\tmovl %eax, ", getIntegerRegisterName(leftOperand)); 
		dlinkAppend(instList,dlinkNodeAlloc(inst));


	    freeIntegerRegister(rightOperand);

		return leftOperand;
}

/**
 * Add an instruction to compute the address of a variable.
 *
 * @param instList a Dlist of instructions
 * @param varIndex the register index for a variable
 * @return the register index of the address register
 */
int emitComputeVariableAddress(DList instList, int varIndex) {
	
  int addrRegIndex = allocateIntegerRegister();   
  char* addrRegName = (char*)get64bitIntegerRegisterName(addrRegIndex);

  int offset = (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_OFFSET_FIELD);
  char offsetStr[10];
  snprintf(offsetStr,9,"%d",offset);

  char *inst; 
  inst = nssave(2,"\tleaq _gp(%rip), ", addrRegName);
  dlinkAppend(instList,dlinkNodeAlloc(inst));
  inst = nssave(4,"\taddq $", offsetStr, ", ", addrRegName);
  dlinkAppend(instList,dlinkNodeAlloc(inst));
  
  return addrRegIndex;
}

//Calculates and appends the offset address calculation for an array element to the instruction list
int generateArrayOffsetAddress(DList instList, int varIndex, int expr) {
    
	int addrReg = allocateIntegerRegister();
    char inst[128];

    //Compute the base address using the variable's offset
    sprintf(inst, "\tleaq _gp+%d(%%rip), %s", (int)SymGetFieldByIndex(globalSymtab, varIndex, SYMTAB_OFFSET_FIELD), get64bitIntegerRegisterName(addrReg));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, inst)));

    //Convert the index from 32-bit to 64-bit and adjust for the lower bound of the array
    sprintf(inst, "\tmovslq %s, %s", getIntegerRegisterName(expr), get64bitIntegerRegisterName(expr));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, inst)));

    sprintf(inst, "\tsubq $%d, %s", (int)SymGetFieldByIndex(globalSymtab, varIndex, SYMTAB_DIM1_LOWER_FIELD), get64bitIntegerRegisterName(expr));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, inst)));

	//Multiply the index by the size of each element (assuming 4 bytes each)
    sprintf(inst, "\timulq $4, %s", get64bitIntegerRegisterName(expr));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, inst)));

    //Add the computed offset to the base address to get the final address
    sprintf(inst, "\taddq %s, %s", get64bitIntegerRegisterName(expr), get64bitIntegerRegisterName(addrReg));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, inst)));

	//Free the index register after use
    freeIntegerRegister(expr);

    return addrReg;
}

//Calculates the effective address for a 2D array element based on two index expressions
int generate2DArrayOffsetAddress(DList instList, int varIndex, int expr1, int expr2) {
    
	char buf[64];
    int addrReg = allocateIntegerRegister();

    //Initialize base address of the array
    sprintf(buf, "\tleaq _gp(%%rip), %s", get64bitIntegerRegisterName(addrReg));
    dlinkAppend(instList, dlinkNodeAlloc(nssave(1, buf)));

    //Add offset of the array variable to the base address
    sprintf(buf, "\taddq $%d, %s", (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_OFFSET_FIELD), get64bitIntegerRegisterName(addrReg));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    //Adjust the row index and scale it according to the number of columns
    sprintf(buf, "\tmovslq %s, %s", getIntegerRegisterName(expr1), get64bitIntegerRegisterName(expr1));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    sprintf(buf, "\tsubq $%d, %s", (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_DIM1_LOWER_FIELD), get64bitIntegerRegisterName(expr1));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    int dim2Size = (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_DIM2_UPPER_FIELD) - (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_DIM2_LOWER_FIELD) + 1;

    sprintf(buf, "\timulq $%d, %s", dim2Size, get64bitIntegerRegisterName(expr1));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    //Adjust the column index and combine it with the row offset
    sprintf(buf, "\tmovslq %s, %s", getIntegerRegisterName(expr2), get64bitIntegerRegisterName(expr2));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    sprintf(buf, "\tsubq $%d, %s", (int)SymGetFieldByIndex(globalSymtab,varIndex,SYMTAB_DIM2_LOWER_FIELD), get64bitIntegerRegisterName(expr2));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    sprintf(buf, "\taddq %s, %s", get64bitIntegerRegisterName(expr2), get64bitIntegerRegisterName(expr1));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

	//Scale the total offset by the size of each element and add to base address
    sprintf(buf, "\timulq $4, %s", get64bitIntegerRegisterName(expr1));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

    sprintf(buf, "\taddq %s, %s", get64bitIntegerRegisterName(expr1), get64bitIntegerRegisterName(addrReg));
    dlinkAppend(instList,dlinkNodeAlloc(nssave(1,buf)));

	//Release registers after use
    freeIntegerRegister(expr1);
    freeIntegerRegister(expr2);

    return addrReg;
}

//Sets up the dimension bounds and the total size for an array in the symbol table
void initializeArrayDimensions (int index, int end, int start) {
	//Store the lower bound of the array dimension
	SymPutFieldByIndex(globalSymtab, index, SYMTAB_DIM1_LOWER_FIELD, (Generic)start);
	//Store the upper bound of the array dimension
	SymPutFieldByIndex(globalSymtab, index, SYMTAB_DIM1_UPPER_FIELD, (Generic)end);
	//Calculate and store the total size of the array
	SymPutFieldByIndex(globalSymtab, index, SYMTAB_ARRAY_SIZE_FIELD, (Generic)((end - start) + 4));
} 

/**
 * Add an instruction to load a variable from memory.
 *
 * @param instList a Dlist of instructions
 * @param regIndex the register index for the address of a variable
 * @return the register index of the result register
 */
int emitLoadVariable(DList instList, int regIndex) {
	int dstRegIndex = allocateIntegerRegister();
	char* dstRegName = getIntegerRegisterName(dstRegIndex);

	char* srcAddrRegName = get64bitIntegerRegisterName(regIndex);

	char *inst = nssave(4,"\tmovl (",srcAddrRegName,"), ", dstRegName);
	dlinkAppend(instList,dlinkNodeAlloc(inst));

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
int emitLoadIntegerConstant(DList instList, char * intConst) {
	int regIndex = allocateIntegerRegister();
	char* regName = (char*)getIntegerRegisterName(regIndex);
	
	char *inst = nssave(4,"\tmovl $", intConst, ", ", regName);

	dlinkAppend(instList,dlinkNodeAlloc(inst));

	return regIndex;
}

/**
 * Add a .asciiz declaration for a string constant if it hasn't been declared
 *
 * @param dataList a DList of data declarations
 * @param str string constant to put into data section
 * @return the label of the string constant
 */
static char* makeDataDeclaration(DList dataList, char* str) {
	static int stringNum = 0;
	int symIndex = SymQueryIndex(globalSymtab, str);
	int labelcount;
	char* strLabel = (char*)malloc(sizeof(char)*15);
		
	if (symIndex == SYM_INVALID_INDEX) {
	   symIndex = SymIndex(globalSymtab, str);
	   labelcount = stringNum++;
           SymPutFieldByIndex(globalSymtab,symIndex,SYMTAB_OFFSET_FIELD, (Generic)labelcount);

	   snprintf(strLabel, 17, ".string_const%d",labelcount);

	   char* decl = nssave(3, strLabel, ": .string ", str);
 	   dlinkAppend(dataList,dlinkNodeAlloc(decl));
	} else {
	   labelcount = (int)SymGetFieldByIndex(globalSymtab,symIndex,SYMTAB_OFFSET_FIELD);
	   snprintf(strLabel,15,".string_const%d",labelcount);
	}
	
	return strLabel;
}


/**
 * Add an identifier to the symbol table and store its offset in the activation record.
 * This function is called by dlinkApply1.
 *
 * @param node a node on a linked list containing the symbol table index of a variable
 *                delcared in a program
 */
void addIdToSymtab(DNode node) {
	int symIndex = (int)dlinkNodeAtom(node);
	
	SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_OFFSET_FIELD, (Generic)(globalOffset));
	globalOffset += 4;
}

//Initializes an array's symbol table entry with dimensions and offset information
void initializeArraySymbolEntry(DNode node) {
	//Retrieve the symbol index from the node
	int symIndex = (int)dlinkNodeAtom(node);
	//Set the array's offset in the symbol table
	SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_OFFSET_FIELD, (Generic)(globalOffset));
	//Set the lower bound of the first dimension
	SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_DIM1_LOWER_FIELD, (Generic)(dim1LowerBound));
	//Set the lower bound of the second dimension
	SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_DIM2_LOWER_FIELD, (Generic)(dim2LowerBound));
	//Set the upper bound of the second dimension
	SymPutFieldByIndex(globalSymtab, symIndex, SYMTAB_DIM2_UPPER_FIELD, (Generic)(dim2UpperBound));
	//Update the global offset to include the size of the array
	globalOffset = globalOffset + arrayByteSize;
}

/**
 * Print out the procedure exit instructios
 *
 * @param instList a DList of instructions
 */
void emitProcedureExit(DList instList) {
	char *inst = ssave("\tleave");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
	inst = ssave("\tret");
	dlinkAppend(instList,dlinkNodeAlloc(inst));
}
