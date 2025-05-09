#ifndef CODEGEN_H_
#define CODEGEN_H_

EXTERN(void, emitProcedurePrologue, (DList instList, char *name));
EXTERN(void, emitProcedureExit, (DList instList));
EXTERN(void, emitDataPrologue, (DList dataList));
EXTERN(void, emitInstructions, (DList list));
EXTERN(void, emitAssignment, (DList instList, int lhsRegIndex, int rhsRegIndex));
EXTERN(void, emitReadVariable, (DList instList, DList dataList, int addrIndex));
EXTERN(void, emitWriteExpression, (DList instList, DList dataList, int writeType, int regIndex, char *length));
EXTERN(void, emitWriteString, (DList instList, DList dataList, int writeType, char *str, char *length));
EXTERN(int, emitOrExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitAndExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitNotExpression, (DList instList, int operand));
EXTERN(int, emitEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitNotEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitLessEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitLessThanExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitGreaterEqualExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitGreaterThanExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitAddExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitSubtractExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitMultiplyExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitDivideExpression, (DList instList, int leftOperand, int rightOperand));
EXTERN(int, emitComputeVariableAddress, (DList instList, int varIndex));
EXTERN(int, emitLoadVariable, (DList instList, int varIndex));
EXTERN(int, emitLoadIntegerConstant, (DList instList, char *intConst));
EXTERN(void, addIdToSymtab, (DNode node));
EXTERN(void, yyerror, (char *));

//Initializes the dimensions of an array with given start and end indices
EXTERN(void, initializeArrayDimensions, (int index, int start, int end));
//Adds an array's symbol table entry with initialization details
EXTERN(void, initializeArraySymbolEntry, (DNode node));
//Sets up the loop control structure for the given loop index
EXTERN(void, initializeLoopControl, (DList instList, int loop));
//Performs a comparison test between two operands
EXTERN(void, initializeComparisonTest, (DList instList, int leftOperand, int rightOperand));
//Configures a conditional jump based on the opcode and loop label
EXTERN(void, initializeJumpOperation, (DList instList, int loop, char *opCode));
//Calculates the memory address offset for an array element
EXTERN(int, generateArrayOffsetAddress, (DList instList, int varIndex, int expr));
//Calculates the memory address offset for a 2D array element based on two expressions
EXTERN(int, generate2DArrayOffsetAddress, (DList instList, int varIndex, int expr, int expr2));

#define IS_WRITE 0
#define IS_WRITELN 1
#endif /*CODEGEN_H_*/
