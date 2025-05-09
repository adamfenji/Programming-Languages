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
EXTERN(int, emitIfTest, (DList instList, int regIndex));
EXTERN(void, emitEndBranchTarget, (DList instList, int endLabelIndex));
EXTERN(int, emitThenBranch, (DList instList, int elseLabelIndex));
EXTERN(int, emitWhileLoopLandingPad, (DList instList));
EXTERN(int, emitWhileLoopTest, (DList instList, int regIndex));
EXTERN(void, emitWhileLoopBackBranch, (DList instList, int beginLabelIndex, int endLabelIndex));
EXTERN(int, emitComputeVariableAddress, (DList instList, int varIndex, SymtabStack SymtabStack, SymTable symtab));
EXTERN(int, emitComputeArrayAddress, (DList instList, int varIndex, int subIndex, SymtabStack stack, SymTable symtab));
EXTERN(int, emitCompute2DArrayAddress, (DList instList, int varIndex, int subIndex1, int subIndex2, SymtabStack stack, SymTable symtab));
EXTERN(int, emitLoadVariable, (DList instList, int varIndex));
EXTERN(int, emitLoadIntegerConstant, (DList instList, char *intConst));
EXTERN(void, addIdToSymtab, (DNode node, Generic gtypeid, SymtabStack stack));
EXTERN(void, yyerror, (char *));

// Added
EXTERN(void, assignReturnValueToRegister, (DList instList, int rhsRegIndex)); // Stores the return value of a function call into a specified register.
EXTERN(int, generateFunctionCall, (DList instList, char *name));              // Emits assembly to call a function by name and manage register preservation.
EXTERN(void, generateFunctionPrologue, (DList instList));                     // Generates assembly instructions to set up a local function stack frame.
EXTERN(void, generateFunctionEpilogue, (DList instList));                     // Emits assembly to clean up the local stack and restore callee-saved registers.
EXTERN(void, setupFunctionReturn, (DList instList, int reg));                 // Moves the value from a specified register to %eax for function return.

#define IS_WRITE 0
#define IS_WRITELN 1
#endif /*CODEGEN_H_*/
