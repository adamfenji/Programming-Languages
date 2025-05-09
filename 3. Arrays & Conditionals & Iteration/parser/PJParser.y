/*******************************************************/
/*                     PascalJunior Parser             */
/*                                                     */
/*******************************************************/

/*********************DEFINITIONS***********************/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <util/general.h>
#include <util/symtab.h>
#include <util/dlink.h>
#include <util/string_utils.h>
#include <codegen/codegen.h>
#include <codegen/codegen.h>
#include <codegen/reg.h>
#include <codegen/symfields.h>
  
#define SYMTABLE_SIZE 100

/*********************EXTERNAL DECLARATIONS***********************/

EXTERN(void,yyerror,(char*));
EXTERN(int,yylex,(void));

SymTable globalSymtab;

static DList instList;
static DList dataList;
char *fileName;

int dim1LowerBound = 0;       // Starting index (lower bound) for the first dimension of arrays.
int dim1UpperBound = 0;       // Ending index (upper bound) for the first dimension of arrays.
int dim2LowerBound = 0;       // Starting index (lower bound) for the second dimension of arrays.
int dim2UpperBound = 0;       // Ending index (upper bound) for the second dimension of arrays.
int globalOffset = 0;
int labelCounter = 1;         // Generates unique labels for loops and conditional jumps.
int arrayByteSize = 0;        // Total size in bytes required to allocate memory for the array.
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
%}

%defines

%start Program

%token T_AND
%token T_ELSE
%token T_FLOAT
%token T_FOR
%token T_IF 		
%token T_LONGINT
%token T_BOOLEAN
%token T_PROGRAM	 
%token T_FUNCTION
%token T_NOT 		
%token T_OR 		
%token T_READ
%token T_WHILE
%token T_WRITE
%token T_WRITELN
%token T_BEGIN
%token T_END
%token T_VAR
%token T_DO
%token T_ARRAY
%token T_EXIT
%token T_THEN
%token T_LE
%token T_LT
%token T_GE
%token T_GT
%token T_EQ
%token T_NE
%token T_ASSIGN
%token T_COMMA
%token T_SEMICOLON
%token T_COLON
%token T_LBRACKET
%token T_RBRACKET
%token T_LPAREN
%token T_RPAREN
%token T_PLUS
%token T_TIMES
%token T_IDENTIFIER
%token T_DIV
%token T_STRING	
%token T_INTNUM
%token T_FLOATNUM
%token T_MINUS
%token T_DOT
%token T_DOTDOT
%token T_OF
%token T_TRUE
%token T_FALSE


%left T_LT T_LE T_GT T_GE T_NE T_EQ
%left T_PLUS T_MINUS T_OR
%left T_TIMES T_DIV T_AND
%left T_NOT

%union {
	int     regIndex;
	int	typeId;
	DList	idList;
	char	*name;
	int 	offset;
}

%type <idList> IdentifierList
%type <typeId> WriteToken
%type <regIndex> Expr AddExpr MulExpr Factor Variable Constant Test TestAndThen WhileToken WhileExpr StandardType ArrayType Type
%type <name> T_STRING T_INTNUM  ProgramHead T_IDENTIFIER OutputFormat Dim

%%
/***********************PRODUCTIONS****************************/

Program : ProgramHeadAndProcedures CompoundStatement T_DOT
		{
			emitProcedureExit(instList);
			emitDataPrologue(dataList);
			emitInstructions(instList);
		}
		;

ProgramHeadAndProcedures : ProgramHead Procedures 
		{
			emitProcedurePrologue(instList,$1);
		}
;

ProgramHead : T_PROGRAM T_IDENTIFIER T_SEMICOLON Decls 
		{
			$$ = "main";
		}
	    ;

       
Decls : T_VAR DeclList
		|
	  	;
	  
DeclList : IdentifierList T_COLON Type T_SEMICOLON
{   
// Applies either array initialization or standard symbol table addition based on type specifier
dlinkApply($1, (DLinkApplyFunc)(($3 == 1) ? initializeArraySymbolEntry : addIdToSymtab));
// Frees the nodes of the identifier list after processing
dlinkFreeNodes($1);
}
| DeclList IdentifierList T_COLON Type T_SEMICOLON
{
// For subsequent declarations in a list, apply initialization or addition to symbol table
dlinkApply($2, (DLinkApplyFunc)(($4 == 1) ? initializeArraySymbolEntry : addIdToSymtab));
// Frees the nodes of the identifier list after processing
dlinkFreeNodes($2);
}
;
		 
IdentifierList : T_IDENTIFIER
		{
			int symTabIndex = SymIndex(globalSymtab,$1);
			$$ = dlinkListAlloc(NULL);
			dlinkAppend($$,dlinkNodeAlloc((Generic)symTabIndex));
		}
	       | IdentifierList T_COMMA T_IDENTIFIER
		{
			int symTabIndex = SymIndex(globalSymtab,$3);
			dlinkAppend($1,dlinkNodeAlloc((Generic)symTabIndex));
			$$ = $1;
		}
	
Type : StandardType{ $$ = -1; } | ArrayType{ $$ = 1; };

StandardType 	: T_LONGINT | T_BOOLEAN | T_FLOAT;

ArrayType : T_ARRAY T_LBRACKET Dim T_RBRACKET T_OF StandardType{
	// Retrieves the symbol index for the dimension specifier
int symIndex = SymIndex(globalSymtab, $3);
// Sets the lower bound of the array's first dimension
dim1LowerBound = (int)SymGetFieldByIndex(globalSymtab, symIndex, SYMTAB_DIM1_LOWER_FIELD);
// Sets the upper bound of the array's first dimension
dim1UpperBound = (int)SymGetFieldByIndex(globalSymtab, symIndex, SYMTAB_DIM1_UPPER_FIELD);
// Calculates the total byte size required for the array based on the dimension size
arrayByteSize = 4 * (int)SymGetFieldByIndex(globalSymtab, symIndex, SYMTAB_ARRAY_SIZE_FIELD);
}
| T_ARRAY T_LBRACKET Dim T_COMMA Dim T_RBRACKET T_OF StandardType{
	// Retrieves symbol indices for the dimensions of a 2D array
	int symIndex1 = SymIndex(globalSymtab, $3);
	int symIndex2 = SymIndex(globalSymtab, $5);
	// Retrieves and computes the size for each dimension
	int firstDimensionLength = (int)SymGetFieldByIndex(globalSymtab, symIndex1, SYMTAB_ARRAY_SIZE_FIELD);
	int secondDimensionLength = (int)SymGetFieldByIndex(globalSymtab, symIndex2, SYMTAB_ARRAY_SIZE_FIELD);
	// Calculates the total byte size for the 2D array based on product of dimensions
	arrayByteSize  = 4 * firstDimensionLength * secondDimensionLength;
	// Retrieves and sets the bounds for the dimensions of the array
	dim1UpperBound = (int)SymGetFieldByIndex(globalSymtab, symIndex1, SYMTAB_DIM1_UPPER_FIELD);
	dim1LowerBound = (int)SymGetFieldByIndex(globalSymtab, symIndex1, SYMTAB_DIM1_LOWER_FIELD);
	dim2UpperBound = (int)SymGetFieldByIndex(globalSymtab, symIndex2, SYMTAB_DIM1_UPPER_FIELD);
	dim2LowerBound = (int)SymGetFieldByIndex(globalSymtab, symIndex2, SYMTAB_DIM1_LOWER_FIELD);
}
;

Dim : T_INTNUM T_DOTDOT T_INTNUM{
	// Retrieve the symbol index and initialize dimensions with positive integer bounds
int symIndex = SymIndex(globalSymtab, $$);
initializeArrayDimensions(symIndex, atoi($3), atoi($1));	
}
| T_MINUS T_INTNUM T_DOTDOT T_INTNUM{
	// Retrieve the symbol index and initialize dimensions where the lower bound is negative
int symIndex = SymIndex(globalSymtab, $$);
initializeArrayDimensions(symIndex, atoi($4), -atoi($2));	
}
|  T_MINUS T_INTNUM T_DOTDOT T_MINUS T_INTNUM{
	// Retrieve the symbol index and initialize dimensions with both bounds as negative
int symIndex = SymIndex(globalSymtab, $$);
initializeArrayDimensions(symIndex, -atoi($5), -atoi($2));	
};

Procedures : Procedures ProcedureDecl
	   | 
	   ;

ProcedureDecl : ProcedureHead ProcedureBody
       ;

ProcedureHead : FunctionDecl Decls 
    	;

FunctionDecl : T_FUNCTION T_IDENTIFIER T_COLON StandardType T_SEMICOLON
   	     ;
	      
ProcedureBody : CompoundStatement T_SEMICOLON
	      ;

Statement : Assignment
		| IfStatement
		| WhileStatement
		| IOStatement 
		| ExitStatement
	  	| CompoundStatement
		;

Assignment : Variable T_ASSIGN Expr
		{ 
			emitAssignment(instList,$1,$3);
		}
		;
 
IfStatement : T_IF TestAndThen T_ELSE Statement{ initializeLoopControl(instList, $2);} | T_IF TestAndThen{ initializeLoopControl(instList, $2);};
	
TestAndThen	: Test T_THEN Statement{ 
	// Initialize a jump operation based on the result of the test; jump if the condition is false
initializeJumpOperation(instList, labelCounter, "jmp");
// Setup a loop control point using the test's result to manage the flow after the jump
initializeLoopControl(instList, $1);
// Assign the current label counter to the production for referencing in other rules
$$ = labelCounter;
// Increment the label counter for future unique label generation
labelCounter = labelCounter +1;};

Test : Expr {
	// Load a constant into a register, commonly used for comparison; here, '-1' might be used as a flag or mask.
int leftOperand = emitLoadIntegerConstant(instList, "-1");
// Perform a comparison test between the loaded constant and the result of the expression.
initializeComparisonTest(instList, leftOperand, $1);
// Initialize a conditional jump operation based on the comparison; jump if equal (je)
initializeJumpOperation(instList, labelCounter, "je");
// Store the current label counter as the result for further jump reference in calling context.
$$ = labelCounter;
// Increment
labelCounter = labelCounter +1;};

WhileStatement : WhileToken WhileExpr T_DO Statement{
		// Initialize a jump operation back to the start of the loop condition, creating a loop structure.
initializeJumpOperation(instList, $1, "jmp");
// Set a loop control point at the start of the loop body to manage the execution sequence.
initializeLoopControl(instList, $2);
};

WhileExpr : Expr{
	// Load a constant into a register to be used in a comparison test, here it's typically used for a bitwise operation or a mask.
int leftOperand = emitLoadIntegerConstant(instList, "-1");
// Compare the result of the expression to the constant, updating flags based on the result.
initializeComparisonTest(instList, leftOperand, $1);
// Store the current label counter for reference in the jump operation
$$ = labelCounter;
// Initialize a conditional jump operation based on the comparison result to implement the loop's exit condition
initializeJumpOperation(instList, labelCounter++, "je");
};
	
WhileToken	: T_WHILE{
	// Establish a loop control label at the beginning of the while loop using the current label counter.
initializeLoopControl(instList, labelCounter);
// Assign the current label counter to the production result for reference in loop operations.
$$ = labelCounter;
//INcr
labelCounter = labelCounter +1;};

IOStatement : T_READ T_LPAREN Variable T_RPAREN
		{ 
			emitReadVariable(instList,dataList,  $3);
		}
            | WriteToken T_LPAREN Expr OutputFormat T_RPAREN
		{ 
			emitWriteExpression(instList, dataList, $1, $3, $4);
		}
            | WriteToken T_LPAREN T_STRING OutputFormat T_RPAREN      
		{ 
			emitWriteString(instList, dataList, $1, $3, $4);
		}
            ;

OutputFormat : T_COLON T_INTNUM
        	{
		   $$ = $2;
		} |
		{
		   $$ = NULL;
		}
		;

WriteToken : T_WRITE
		{$$ = IS_WRITE;}
	    | T_WRITELN
		{$$ = IS_WRITELN;}
		;
			 
ExitStatement : T_EXIT T_LPAREN Expr T_RPAREN 
		;

CompoundStatement : T_BEGIN StatementList T_END
		;
                  
StatementList : StatementList T_SEMICOLON Statement
			  | Statement
              ;

 
Expr	: AddExpr
		{
			$$ = $1; 
		}
                | Expr T_EQ AddExpr
		{
			$$ = emitEqualExpression(instList,$1,$3);
		}
                | Expr T_NE AddExpr
		{
			$$ = emitNotEqualExpression(instList,$1,$3);
		}
                | Expr T_LE AddExpr
		{
			$$ = emitLessEqualExpression(instList,$1,$3);
		}
                | Expr T_LT AddExpr
		{
			$$ = emitLessThanExpression(instList,$1,$3);
		}
                | Expr T_GE AddExpr
		{
			$$ = emitGreaterEqualExpression(instList,$1,$3);
		}
                | Expr T_GT AddExpr
		{
			$$ = emitGreaterThanExpression(instList,$1,$3);
		}
                ;

AddExpr		:  MulExpr            
		{
			$$ = $1; 
		}
		| AddExpr T_OR MulExpr 
		{
			$$ = emitOrExpression(instList,$1,$3);
		}
                |  AddExpr T_PLUS MulExpr
		{
			$$ = emitAddExpression(instList,$1,$3);
		}
                |  AddExpr T_MINUS MulExpr
		{
			$$ = emitSubtractExpression(instList,$1,$3);
		}
                ;

MulExpr		:  Factor
        	{$$ =$1;}
	    	| MulExpr T_TIMES Factor
		{
			$$ = emitMultiplyExpression(instList,$1,$3);
		}
                |  MulExpr T_DIV Factor
		{
			$$ = emitDivideExpression(instList,$1,$3);
		}	
		     | MulExpr T_AND Factor 
		{
			$$ = emitAndExpression(instList,$1,$3);
		}	
                ;
		

Factor          : Variable
		{ 
			$$ = emitLoadVariable(instList, $1);
		}
                | Constant
		{ 
			$$ = $1;
		}
		|  T_NOT Factor
		{
			$$ = emitNotExpression(instList,$2);
		}
		| T_IDENTIFIER T_LPAREN T_RPAREN
		| T_LPAREN Expr T_RPAREN
		{
			$$ = $2;
		}
                ;  

 
Variable : T_IDENTIFIER
{
int symIndex = SymQueryIndex(globalSymtab,$1);
$$ = emitComputeVariableAddress(instList, symIndex);
}
| T_IDENTIFIER T_LBRACKET Expr T_RBRACKET 
{
int symIndex = SymQueryIndex(globalSymtab,$1);
$$ = generateArrayOffsetAddress(instList, symIndex, $3);
}   
| T_IDENTIFIER T_LBRACKET Expr T_COMMA Expr T_RBRACKET {
int symIndex = SymQueryIndex(globalSymtab,$1);
$$ = generate2DArrayOffsetAddress(instList, symIndex, $3, $5);	
};			       

        		       
Constant        : T_FLOATNUM    
		| T_MINUS T_INTNUM
		{   
			char *negstr = nssave(2, "-", $2);
			$$ = emitLoadIntegerConstant(instList,negstr); 
		}
        	| T_INTNUM
		{ 
			$$ = emitLoadIntegerConstant(instList,$1); 
		}
		| T_TRUE
		{ 
			$$ = emitLoadIntegerConstant(instList,"1"); 
		}
		| T_FALSE
		{ 
			$$ = emitLoadIntegerConstant(instList,"0"); 
		}
                ;

%%


/********************C ROUTINES *********************************/
void yyerror(char *s)
{
  fprintf(stderr,"%s: line %d, found %s: %s\n",fileName,yylineno,yytext,s);
}

int yywrap() {
	return 1;
}


static void initialize(char* inputFileName) {
	yyin = fopen(inputFileName,"r");
        if (yyin == NULL) {
          fprintf(stderr,"Error: Could not open file %s\n",inputFileName);
          exit(-1);
        }

	char* dotChar = rindex(inputFileName,'.');
	int endIndex = strlen(inputFileName) - strlen(dotChar);
	char *outputFileName = nssave(2,substr(inputFileName,0,endIndex),".s");
	stdout = freopen(outputFileName,"w",stdout);
        if (stdout == NULL) {
          fprintf(stderr,"Error: Could not open file %s\n",outputFileName);
          exit(-1);
        }

	
	globalSymtab = SymInit(SYMTABLE_SIZE);
	SymInitField(globalSymtab,SYMTAB_OFFSET_FIELD,(Generic)-1,NULL);
	initRegisters();
	
	instList = dlinkListAlloc(NULL);
	dataList = dlinkListAlloc(NULL);
}

static void finalize() {

    fclose(stdin);
    fclose(stdout);
    
    SymKillField(globalSymtab,SYMTAB_OFFSET_FIELD);
    SymKill(globalSymtab);
 
    cleanupRegisters();
    
    dlinkFreeNodesAndAtoms(instList);
    dlinkFreeNodesAndAtoms(dataList);

}

int main(int argc, char** argv)

{	
	fileName = argv[1];
	initialize(fileName);
	
	yyparse();
    
	finalize();
  
	return 0;
}
/******************END OF C ROUTINES**********************/
