/*******************************************************/
/*                     PascalJunior Parser             */
/*                                                     */
/*******************************************************/

// -----------------------------------------------------------
// NAME : Adam Fenjiro
// CS4121 SPRING 25
// PROGRAM ASSIGNMENT #2
// FILE NAME : PJParser.y
// -----------------------------------------------------------

/*********************DEFINITIONS***********************/
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <strings.h>
#include <util/general.h>
#include <util/symtab.h>
#include <util/string_utils.h>
#define SYMTABLE_SIZE 100
#define SYMTAB_VALUE_FIELD  "value"
#define SYMTAB_NAME_FIELD  "name"
#define SYMTAB_OFFSET_FIELD  "offset"

/* delete or comment out the line below after you have a good grasp of Project 1. It will turn off all printf statements that print the grammar rules */
//#define PROJECT1
/*********************EXTERNAL DECLARATIONS***********************/

EXTERN(void,yyerror,(char*));
EXTERN(int,yylex,(void));

typedef struct Registers { 
	int used;
	char* reg32;
	char* reg64;
} Register;

int offset = 0; // Tracks the offset for memory allocation.
int currentStringIndex = 0; // Current index for generating unique string constants.
int headerInstructionCount = 0; // Number of instructions in the assembly header.
int bodyInstructionCount = 0; // Number of instructions in the assembly body.
int lastUsedOffset = 0; // Tracks the last used offset for variable placement.
char* fileName;
char buffer[1000]; // Buffer for assembling a single instruction.
char header[1000][1000]; // Stores all assembly instructions for the header.
char body[2000][1000]; // Stores all assembly instructions for the body.
char* reg64[]= {"%r8", "%r9", "%r10", "%r11", "%r12", "%r13", "%r14", "%r15", "%rax", "%rbx", "%rcx", "%rdx", "%rsi", "%rdi"};
char* reg32[]= {"%r8d", "%r9d", "%r10d", "%r11d", "%r12d", "%r13d", "%r14d", "%r15d", "%eax", "%ebx", "%ecx", "%edx", "%esi", "%edi"};
Register registers[14];	

extern int yylineno;
extern char *yytext;
extern FILE *yyin;

SymTable globalSymtab;

static int getValue(char *name);
static void setValue(char *name, int value);
static void setName(char *name, char* str);

static void x86GetInput(); // Reads an integer from standard input and stores it in a designated register.
static void x86PrintString(int newLine, char* string, char* reg); // Prints a string to standard output, appending a newline if 'newLine' is true, using the specified register.
static void x86PrintInt(int newLine, char* frmt, char* reg); // Prints an integer formatted according to 'frmt' to standard output, appending a newline if 'newLine' is true, using the specified register.
static int getFreeRegisterIndex(); // Searches and returns the index of the first available (unused) register.


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
	char*	name;
	int     val;
}
%type <val> WriteToken Expr AddExpr MulExpr Factor Constant T_TRUE T_FALSE
%type <name> OutputFormat Variable T_STRING T_IDENTIFIER T_INTNUM 

%%
/***********************PRODUCTIONS****************************/

Program 	: ProgramHeadAndProcedures CompoundStatement T_DOT
	  	{
		  #ifdef PROJECT1
		  printf("Program : ProgramHeadAndProcedures CompoundStatement T_DOT\n");		
		  #endif
          	}
		;

ProgramHeadAndProcedures : ProgramHead Procedures 
		{
		  #ifdef PROJECT1
		  printf("ProgramHeadAndProcedures : ProgramHead Procedure\n");		
		  #endif
		}
		;

ProgramHead 	: T_PROGRAM T_IDENTIFIER T_SEMICOLON Decls 
		{
		  #ifdef PROJECT1
		  printf("ProgramHead : T_PROGRAM T_IDENTIFIER T_SEMICOLON Decls \n");		
		  #endif
		}
	    	;

       
Decls 		: T_VAR DeclList
		{
		  #ifdef PROJECT1
		  printf("Decls : T_VAR DeclList\n");		
		  #endif
		}
      		|
    		{
		  #ifdef PROJECT1
		  printf("Decls : \n");		
		  #endif
		}
	  	;
	  
DeclList 	: IdentifierList T_COLON Type T_SEMICOLON
		{   
		  #ifdef PROJECT1
		  printf("DeclList : IdentifierList T_COLON Type T_SEMICOLON\n");		
		  #endif
		}
		| DeclList IdentifierList T_COLON Type T_SEMICOLON
		{
		  #ifdef PROJECT1
		  printf("DeclList : DeclList IdentifierList T_COLON Type T_SEMICOLON\n");		
		  #endif
		}
		;
		 
IdentifierList 	: T_IDENTIFIER
		{

		// Register the identifier in the symbol table with the current offset.
		SymPutField(globalSymtab, $1, SYMTAB_OFFSET_FIELD, (Generic)offset);
		// Then, increase the offset for the next variable
		offset = offset + 4;

		#ifdef PROJECT1
		printf("IdentifierList : T_IDENTIFIER\n");		
		#endif
		}
	       	| IdentifierList T_COMMA T_IDENTIFIER
		{

		// Register each subsequent identifier in the symbol table with the current offset.
		SymPutField(globalSymtab, $3, SYMTAB_OFFSET_FIELD, (Generic)offset);
		// Then, increase the offset for the next variable
		offset = offset + 4;

		#ifdef PROJECT1
		printf("IdentifierList : IdentifierList T_COMMA T_IDENTIFIER\n");		
		#endif
		}
	
Type 		: StandardType
		{
		  #ifdef PROJECT1
		  printf("Type : StandardType\n");		
		  #endif
		}
	 	| ArrayType
	 	{
		  #ifdef PROJECT1
		  printf("Type : ArrayType\n");		
		  #endif
	 	}
	 	;

StandardType 	: T_LONGINT
		{
		  #ifdef PROJECT1
		  printf("StandardType : T_LONGINT\n");		
		  #endif
		} 
		| T_BOOLEAN
		{
		  #ifdef PROJECT1
		  printf("StandardType : T_BOOLEAN\n");		
		  #endif
		}
		| T_FLOAT
		{
		  #ifdef PROJECT1
		  printf("StandardType : T_FLOAT\n");		
		  #endif
		}
		;
			
ArrayType 	: T_ARRAY T_LBRACKET Dim T_RBRACKET T_OF StandardType
		{
		  #ifdef PROJECT1
		  printf("ArrayType : T_ARRAY T_LBRACKET Dim T_RBRACKET T_OF StandardType\n");		
		  #endif
		}
		| T_ARRAY T_LBRACKET Dim T_COMMA Dim T_RBRACKET T_OF StandardType
		{
		  #ifdef PROJECT1
		  printf("ArrayType : T_ARRAY T_LBRACKET Dim T_COMMA Dim T_RBRACKET T_OF StandardType\n");		
		  #endif
		}
		;

Dim 		: T_INTNUM T_DOTDOT T_INTNUM
		{
		  #ifdef PROJECT1
		  printf("Dim : T_INTNUM T_DOTDOT T_INTNUM\n");		
		  #endif
		}
		;

Procedures 	: Procedures ProcedureDecl
		{
		  #ifdef PROJECT1
		  printf("Procedures : Procedures ProcedureDecl\n");		
		  #endif
		}
	   	| 
		{
		  #ifdef PROJECT1
		  printf("Procedures :\n");		
		  #endif
		}
	   	;

ProcedureDecl 	: ProcedureHead ProcedureBody
		{
		  #ifdef PROJECT1
		  printf("ProcedureDecl : ProcedureHead ProcedureBody\n");
		  #endif
		}
              	;

ProcedureHead 	: FunctionDecl Decls 
		{
		  #ifdef PROJECT1
		  printf("ProcedureHead : FunctionDecl Decls\n");		
		  #endif
		}
              	;

FunctionDecl 	: T_FUNCTION T_IDENTIFIER T_COLON StandardType T_SEMICOLON
		{
		  #ifdef PROJECT1
		  printf("FunctionDecl : T_FUNCTION T_IDENTIFIER T_COLON StandardType T_SEMICOLON\n");		
		  #endif
		}
   	     	;
	      
ProcedureBody 	: CompoundStatement T_SEMICOLON
		{
		  #ifdef PROJECT1
		  printf("ProcedureBody : CompoundStatement T_SEMICOLON\n");		
		  #endif
		}
	      	;

Statement 	: Assignment
		{
		  #ifdef PROJECT1
		  printf("Statement : Assignment\n");		
		  #endif
		}
          	| IfStatement
		{
		  #ifdef PROJECT1
		  printf("Statement : IfStatement\n");		
		  #endif
		}
	  	| WhileStatement
		{
		  #ifdef PROJECT1
		  printf("Statement : WhileStatement\n");		
		  #endif
		}
          	| IOStatement 
		{
		  #ifdef PROJECT1
		  printf("Statement : IOStatement\n");		
		  #endif
		}
	  	| ExitStatement
		{
		  #ifdef PROJECT1
		  printf("Statement : ExitStatement\n");		
		  #endif
		}
	  	| CompoundStatement
		{
		  #ifdef PROJECT1
		  printf("Statement : CompoundStatement\n");		
		  #endif
		}
          	;

Assignment 	: Variable T_ASSIGN Expr
		{ 
		
		// Retrieve register addresses for the source and destination.
		char* sourceReg = registers[$3].reg32; // Source register for the expression's result.
		char* destinationReg = registers[getValue($1)].reg64; // Destination register for the variable.
		
		// Generate assembly instruction to move the value from the source register to the destination memory location.
		sprintf(buffer, "\tmovl %s, (%s)\n", sourceReg, destinationReg);
		strcat(body[bodyInstructionCount++], buffer);
		
		// Mark the registers used for source and destination as free for reuse.
		registers[$3].used = 0; // Free up the register used for the expression.
		registers[getValue($1)].used = 0; // Free up the register associated with the variable.

		
		  
		#ifdef PROJECT1
		printf("Assignment : Variable T_ASSIGN Expr\n");		
		#endif
		}
		;
 
IfStatement 	: T_IF TestAndThen T_ELSE Statement
		{
		  #ifdef PROJECT1
		  printf("IfStatement : T_IF TestAndThen T_ELSE Statement\n");		
		  #endif
		}
	    	| T_IF TestAndThen
		{
		  #ifdef PROJECT1
		  printf("IfStatement : T_IF TestAndThen\n");		
		  #endif
		}
  	    	;
				
TestAndThen	: Test T_THEN Statement
	   	{
		  #ifdef PROJECT1
		  printf("TestAndThen : Test T_THEN Statement\n");		
		  #endif
	    	}
		;
				
Test 		: Expr 
		{
		  #ifdef PROJECT1
		  printf("Test : Expr \n");		
		  #endif
		}
	 	;

WhileStatement 	: WhileToken WhileExpr T_DO Statement
		{
		  #ifdef PROJECT1
		  printf("WhileStatement : WhileToken WhileExpr T_DO Statement\n");		
		  #endif
		}
                ;
                
WhileExpr : 	Expr 
		{
		  #ifdef PROJECT1
		  printf("WhileExpr : Expr \n");		
		  #endif
		}
		;
				
WhileToken	: T_WHILE
		{
		  #ifdef PROJECT1
		  printf("WhileToken : T_WHILE\n");		
		  #endif
		}
		;

IOStatement 	: T_READ T_LPAREN Variable T_RPAREN
		{ 
		
		// Execute read operation to input a value directly into a variable's associated register.
		x86GetInput(registers[getValue($3)].reg64); //handle reading an integer from stdin.
		
		// Generate assembly instruction to invoke the 'scanf' function from the PLT
		sprintf(buffer, "\tcall scanf@PLT\n");
		strcat(body[bodyInstructionCount++], buffer);
		
		// Mark the register used by the variable as free after reading the value.
		registers[getValue($3)].used = 0;
		  

		#ifdef PROJECT1
		printf("IOStatement : T_READ T_LPAREN Variable T_RPAREN\n");		
		#endif
		}
		| WriteToken T_LPAREN Expr OutputFormat T_RPAREN
		{ 
		char fmtStr[10];
		strcpy(fmtStr, "%");

		if ($4 != NULL) strcat(fmtStr, $4);
		strcat(fmtStr, "d");
		  	
		// If WriteToken indicates a writeln, append a newline
		//else print without new line
		if ($1 == 1) x86PrintInt(1, fmtStr, registers[$3].reg32);
		else x86PrintInt(0, fmtStr, registers[$3].reg32);

		// Generate the assembly instruction to call printf from the PLT
		strcat(body[bodyInstructionCount++], "\tcall printf@PLT\n");
		
		// Mark the register used to hold the expression result as free for reuse
		registers[$3].used = 0;

		#ifdef PROJECT1
		printf("IOStatement : WriteToken T_LPAREN Expr OutputFormat T_RPAREN\n");		
		#endif
		}
		| WriteToken T_LPAREN T_STRING OutputFormat T_RPAREN      
		{ 
		char fmtStr[10];
		strcpy(fmtStr, "%");

		if ($4 != NULL) strcat(fmtStr, $4);
		strcat(fmtStr, "s");
		  
		  // Setup the format string for printf in the correct register
		x86PrintString(0,fmtStr,"%rdi");
		  
		  // Check if writeln is used which requires a newline
		  //else printing without new line
		if ($1 == 1) x86PrintString(1,$3,"%rsi");
		else x86PrintString(0,$3,"%rsi");

		// Call printf function to execute formatted output
		strcat(body[bodyInstructionCount++], "\tcall printf@PLT\n");
		  
		#ifdef PROJECT1
		printf("IOStatement : WriteToken T_LPAREN T_STRING OutputFormat T_RPAREN\n");		
		#endif
		}
		;

OutputFormat 	: T_COLON T_INTNUM
        {
		  $$ = $2;	
		  #ifdef PROJECT1
		  printf("OutputFormat : T_COLON T_INTNUM\n");		
		  #endif
		} 
		|
		{
		  $$ = NULL;	
		  #ifdef PROJECT1
		  printf("OutputFormat : \n");		
		  #endif
		}
		;

WriteToken 	: T_WRITE
             	{
		  $$ =  0;			
		  #ifdef PROJECT1
		  printf("WriteToken : T_WRITE\n");		
		  #endif
		}
	    	| T_WRITELN
            	{
		  $$ = 1;			
		  #ifdef PROJECT1
		  printf("WriteToken : T_WRITELN\n");		
		  #endif
		}
                ;
			 
ExitStatement 	: T_EXIT T_LPAREN Expr T_RPAREN 
		{
		  #ifdef PROJECT1
		  printf("ExitStatement : T_EXIT T_LPAREN Expr T_RPAREN\n");		
		  #endif
		}
                ;

CompoundStatement : T_BEGIN StatementList T_END
		{
		  #ifdef PROJECT1
		  printf("CompoundStatement : T_BEGIN StatementList T_END\n");		
		  #endif
		}
                ;
                  
StatementList 	: StatementList T_SEMICOLON Statement
		{
		  #ifdef PROJECT1
		  printf("StatementList : StatementList T_SEMICOLON Statement\n");		
		  #endif
		}
		| Statement
		{
		  #ifdef PROJECT1
		  printf("StatementList : Statement\n");		
		  #endif
		}
		;

 
Expr		: AddExpr
		{
		  $$ = $1;
		  #ifdef PROJECT1
		  printf("Expr : AddExpr\n");		
		  #endif
		}
        | Expr T_EQ AddExpr
		{

    	int freeRegIndex = getFreeRegisterIndex();
    	char* operationReg = registers[freeRegIndex].reg32; // Register for temporary storage during operations
    	char* targetReg = registers[$1].reg32; // Register associated with the target variable from grammar
    	char* sourceReg = registers[$3].reg32; // Register associated with the expression result

    	// Construct assembly code to compare two registers and conditionally move data
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n" 
             "\tmovl $0, %s\n" 
             "\tmovl $1, %s\n" 
             "\tcmove %s, %s\n",
             sourceReg, targetReg, targetReg, operationReg, operationReg, targetReg);
    	strcat(body[bodyInstructionCount++], buffer); // Append this assembly instruction to the body

		// Mark the registers as unused post-operation
		registers[$3].used = 0;
    	registers[freeRegIndex].used = 0;
		
		// Set the semantic value to the first expression's result register
		$$ = $1;

		#ifdef PROJECT1
		printf("Expr : Expr T_EQ AddExpr\n");		
		#endif
		}

        | Expr T_NE AddExpr
		{

		int freeRegIndex = getFreeRegisterIndex();
    	char* tempReg = registers[freeRegIndex].reg32;
    	char* targetReg = registers[$1].reg32;
    	char* sourceReg = registers[$3].reg32;

    	// Generate assembly for not equal comparison and conditional move
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n"
             "\tmovl $0, %s\n"
             "\tmovl $1, %s\n"
             "\tcmovne %s, %s\n", 
             sourceReg, targetReg, targetReg, tempReg, tempReg, targetReg);
    	strcat(body[bodyInstructionCount++], buffer);

    	// Free the used registers
    	registers[$3].used = 0;
    	registers[freeRegIndex].used = 0;

		$$ = $1; // Assign the result register index

		#ifdef PROJECT1
		printf("Expr : Expr T_NE AddExpr\n");		
		#endif
		}
        | Expr T_LE AddExpr
		{
		  
    	int freeRegIndex = getFreeRegisterIndex();
    	char* tempReg = registers[freeRegIndex].reg32; // Temporary register for condition evaluation.
    	char* targetReg = registers[$1].reg32; // Target register associated with the left-hand side variable.
    	char* sourceReg = registers[$3].reg32; // Source register containing the right-hand side expression result.
    
    	// Compile the comparison and conditional move instructions into the buffer.
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n"
             "\tmovl $0, %s\n"   
             "\tmovl $1, %s\n"  
             "\tcmovle %s, %s\n",
             sourceReg, targetReg, targetReg, tempReg, tempReg, targetReg);
    	strcat(body[bodyInstructionCount++], buffer); // Append compiled instructions to the body and increment the instruction counter.

    	// Free the used registers after the operation.
    	registers[$3].used = 0;
    	registers[freeRegIndex].used = 0;
		  
		$$ = $1;	

		#ifdef PROJECT1
		printf("Expr : Expr T_LE AddExpr\n");		
		#endif
		}
        | Expr T_LT AddExpr
		{
		   
		int availableRegIndex = getFreeRegisterIndex();
   	 	char* tempRegister = registers[availableRegIndex].reg32; // Temporary register for the operation
    	char* targetRegister = registers[$1].reg32; // Target register associated with the left-hand side variable
    	char* sourceRegister = registers[$3].reg32; // Source register containing the right-hand side expression result

    	// Compile the comparison and conditional move instructions into the buffer
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n"
             "\tmovl $0, %s\n" 
             "\tmovl $1, %s\n" 
             "\tcmovl %s, %s\n", 
             sourceRegister, targetRegister, targetRegister, tempRegister, tempRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the compiled instructions to the body and increment counter

    	// Free the registers after use
    	registers[$3].used = 0; 
    	registers[availableRegIndex].used = 0;

		$$ = $1;	
		  
		#ifdef PROJECT1
		printf("Expr : Expr T_LT AddExpr\n");		
		#endif
		}
        | Expr T_GE AddExpr
		{
		  
		int availableRegIndex = getFreeRegisterIndex();
    	char* tempRegister = registers[availableRegIndex].reg32; // Temporary register for comparison result
    	char* targetRegister = registers[$1].reg32; // Target register from the left-hand side expression
    	char* sourceRegister = registers[$3].reg32; // Source register from the right-hand side expression

    	// Compile the assembly code for comparing and conditionally moving values based on 'greater than or equal' condition
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n"   
             "\tmovl $0, %s\n" 
             "\tmovl $1, %s\n"    
             "\tcmovge %s, %s\n",    
             sourceRegister, targetRegister, targetRegister, tempRegister, tempRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append compiled instructions to the body

    	// Mark the used registers as free after operation
    	registers[$3].used = 0; 
    	registers[availableRegIndex].used = 0; 

		$$ = $1;	
		  
		#ifdef PROJECT1
		printf("Expr : Expr T_GE AddExpr\n");		
		#endif
		}
        | Expr T_GT AddExpr
		{
		  
		int availableRegIndex = getFreeRegisterIndex();
    	char* tempRegister = registers[availableRegIndex].reg32; // Temporary register for comparison result
   	 	char* targetRegister = registers[$1].reg32; // Target register from the left-hand side expression
    	char* sourceRegister = registers[$3].reg32; // Source register containing the right-hand side expression result

    	// Compile the assembly code for comparing and conditionally moving values based on 'greater than' condition
    	snprintf(buffer, sizeof(buffer), 
             "\tcmpl %s, %s\n"      
             "\tmovl $0, %s\n"        
             "\tmovl $1, %s\n"        
             "\tcmovg %s, %s\n",     
             sourceRegister, targetRegister, targetRegister, tempRegister, tempRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append compiled instructions to the body

    	// Mark the used registers as free after operation
    	registers[$3].used = 0; 
    	registers[availableRegIndex].used = 0; 

		$$ = $1;
		  
		#ifdef PROJECT1
		printf("Expr : Expr T_GT AddExpr\n");		
		#endif
		}
                ;

AddExpr		: MulExpr            
		{
		  $$ = $1;
		  #ifdef PROJECT1
		  printf("AddExpr : MulExpr\n");		
		  #endif
		}
		| AddExpr T_OR MulExpr 
		{ 

		char* targetRegister = registers[$1].reg32; // Register for the left-hand side expression result
    	char* sourceRegister = registers[$3].reg32; // Register for the right-hand side expression result
	  
		  // Compile the OR operation into the assembly instruction buffer
		sprintf(buffer,"\torl %s, %s\n", sourceRegister, targetRegister);
		strcat(body[bodyInstructionCount++],buffer);
		  
		registers[$3].used = 0;	
		 
		$$ = $1;

		#ifdef PROJECT1
		printf("AddExpr : AddExpr T_OR MulExpr\n");		
		#endif
		}
                | AddExpr T_PLUS MulExpr
		{

		char* targetRegister = registers[$1].reg32; // Register holding the first operand
    	char* sourceRegister = registers[$3].reg32; // Register holding the second operand to add
		
		// Generate assembly code for adding the second operand to the first
    	snprintf(buffer, sizeof(buffer), "\taddl %s, %s\n", sourceRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer);
		  
		  // Mark the source register as free after its value has been added
		registers[$3].used = 0;
		
		$$ = $1;
		  
		#ifdef PROJECT1
		printf("AddExpr : AddExpr T_PLUS MulExpr\n");		
		#endif
		}
                | AddExpr T_MINUS MulExpr
		{

		char* targetRegister = registers[$1].reg32; // Register for the first operand (minuend)
    	char* sourceRegister = registers[$3].reg32; // Register for the second operand (subtrahend)
    
		 // Compile assembly code for subtracting the second operand from the first.
    	snprintf(buffer, sizeof(buffer), "\tsubl %s, %s\n", sourceRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the compiled assembly code to the body and increment the instruction counter.

		// Free the source register as it is no longer needed after the operation.
		registers[$3].used = 0;

		$$ = $1;

		#ifdef PROJECT1
		printf("AddExpr : AddExpr T_MINUS MulExpr\n");		
		#endif
		}
                ;

MulExpr		:  Factor
        	{
		  $$ = $1;		
		  #ifdef PROJECT1
		  printf("MulExpr : Factor\n");		
		  #endif
                }
	    	| MulExpr T_TIMES Factor
		{
		  
		char* targetRegister = registers[$1].reg32; // Register holding the first operand
    	char* sourceRegister = registers[$3].reg32; // Register holding the second operand to multiply

		// Generate assembly code for multiplying the second operand with the first
    	snprintf(buffer, sizeof(buffer), "\timull %s, %s\n", sourceRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly code to the body and increment the instruction counter

		// Free the source register after its value has been used for multiplication
    	registers[$3].used = 0; 
		  
		$$ = $1;

		#ifdef PROJECT1
		printf("MulExpr : MulExpr T_TIMES Factor\n");		
		#endif
		}
                | MulExpr T_DIV Factor
		{

		char* dividendRegister = registers[$1].reg32; // Register holding the dividend
    	char* divisorRegister = registers[$3].reg32; // Register holding the divisor

		// Generate assembly code for division, handling the division process with x86 specific operations
    	snprintf(buffer, sizeof(buffer),
             "\tmovl %s, %%eax\n"     
             "\tcdq\n"                  
             "\tidivl %s\n"              
             "\tmovl %%eax, %s\n",       
             dividendRegister, divisorRegister, dividendRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the compiled assembly code to the body

    	// Free the divisor register after its value has been used for division
    	registers[$3].used = 0;

		$$ = $1;

		#ifdef PROJECT1
		printf("MulExpr : MulExpr T_DIV Factor\n");		
		#endif
		}	
		| MulExpr T_AND Factor 
		{
		    
		char* targetRegister = registers[$1].reg32; // Register holding the first operand
    	char* sourceRegister = registers[$3].reg32; // Register holding the second operand to AND

		// Generate assembly code for performing the bitwise AND operation
    	snprintf(buffer, sizeof(buffer), "\tandl %s, %s\n", sourceRegister, targetRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the compiled assembly code to the body and increment the instruction counter

    	// Free the source register after its value has been used for the AND operation
    	registers[$3].used = 0;
		  
		$$ = $1; 

		#ifdef PROJECT1
		printf("MulExpr : MulExpr T_AND Factor\n");		
		#endif
		}	
                ;
		

Factor          : Variable
		{ 

    	int freeRegIndex = getFreeRegisterIndex(); 
    	char* freeRegister = registers[freeRegIndex].reg32; // New register for holding the variable's value
    	int variableIndex = getValue($1); 
    	char* variableRegister = registers[variableIndex].reg64; // Register currently holding the variable
		  
    	snprintf(buffer, sizeof(buffer), "\tmovl (%s), %s\n", variableRegister, freeRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly code to the body and increment the instruction counter

		// Set the result to use the new register index
    	$$ = freeRegIndex;

		// Free the original register after transferring the value
    	registers[variableIndex].used = 0;

		#ifdef PROJECT1
		printf("Factor : Variable\n");		
		#endif
		}
                | Constant
		{ 
		  $$ = $1;	
		  #ifdef PROJECT1
		  printf("Factor : Constant\n");		
		  #endif
		}
	    	| T_NOT Factor
		{

		// Retrieve the register for the operand to apply the NOT operation.
		char* operandRegister = registers[$2].reg32;

		// Generate assembly code to perform bitwise NOT using XOR with 1
    	snprintf(buffer, sizeof(buffer), "\txorl $1, %s\n", operandRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly code to the body and increment the instruction counter

		$$ = $2;	
		
		#ifdef PROJECT1
		printf("Factor : T_NOT Factor\n");		
		#endif
		}
                | T_IDENTIFIER T_LPAREN T_RPAREN
       		{					
		  #ifdef PROJECT1
		  printf("Factor : T_IDENTIFIER T_LPAREN T_RPAREN\n");		
		  #endif
		}
         	| T_LPAREN Expr T_RPAREN
		{
		  $$ = $2;	
		  #ifdef PROJECT1
		  printf("Factor : T_LPAREN Expr T_RPAREN\n");		
		  #endif
		}
                ;  

 

Variable        : T_IDENTIFIER
		{
		  
		// Allocate a free register to hold the address of the variable.
    	int registerIndex = getFreeRegisterIndex(); 
    	char* variableRegister = registers[registerIndex].reg64; // Register for the variable address

    	// Retrieve the offset of the variable within the global symbol table.
    	int variableOffset = (int)SymGetField(globalSymtab, $1, SYMTAB_OFFSET_FIELD);

    	// Generate assembly code to compute the absolute address of the variable using its offset.
    	snprintf(buffer, sizeof(buffer), 
             "\tleaq _gp(%%rip), %s\n" 
             "\taddq $%d, %s\n",       
             variableRegister, variableOffset, variableRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly code to the body and increment the instruction counter
			
		setValue($$, registerIndex);
		lastUsedOffset = getValue($1);

		#ifdef PROJECT1
		printf("Variable : T_IDENTIFIER\n");		
		#endif
		}
                | T_IDENTIFIER T_LBRACKET Expr T_RBRACKET    
               	{
		  #ifdef PROJECT1
		  printf("Variable : T_IDENTIFIER T_LBRACKET Expr T_RBRACKET\n");		
		  #endif
               	}
		| T_IDENTIFIER T_LBRACKET Expr T_COMMA Expr T_RBRACKET   
               	{
		  #ifdef PROJECT1
		  printf("Variable  : T_IDENTIFIER T_LBRACKET Expr T_COMMA Expr T_RBRACKET\n");		
		  #endif
               	}
                ;			       

        		       
Constant        : T_FLOATNUM    
		{ 
		  #ifdef PROJECT1
		  printf("Constant : T_FLOATNUM\n");		
		  #endif
		}
		| T_MINUS T_INTNUM
		{ 

		// Allocate a free register to store the negated integer value
    	int registerIndex = getFreeRegisterIndex();
    	char* valueRegister = registers[registerIndex].reg32; // Register to hold the integer value

		// Convert string to integer, negate it, and move it into the allocated register
    	snprintf(buffer, sizeof(buffer), "\tmovl $%d, %s\n", -atoi($2), valueRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly instruction to the body and increment the counter

		$$ = registerIndex;

		#ifdef PROJECT1
		printf("Constant : T_MINUS T_INTNUM\n");		
		#endif
		}
        	| T_INTNUM
		{ 

		// Allocate a free register to store the integer value
    	int registerIndex = getFreeRegisterIndex();
   	 	char* valueRegister = registers[registerIndex].reg32; // Register to hold the integer value

		// Convert string to integer and move it into the allocated register
    	snprintf(buffer, sizeof(buffer), "\tmovl $%d, %s\n", atoi($1), valueRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly instruction to the body and increment the counter

		$$ = registerIndex;

		#ifdef PROJECT1
		printf("Constant : T_INTNUM\n");		
		#endif
		}
		| T_TRUE
		{ 
		 
		// Allocate a free register to store the boolean value true
    	int registerIndex = getFreeRegisterIndex();
    	char* valueRegister = registers[registerIndex].reg32; // Register to hold the boolean value true

		// Set the register to 1, representing true
    	snprintf(buffer, sizeof(buffer), "\tmovl $1, %s\n", valueRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly instruction to the body and increment the instruction counter

		$$ = registerIndex;

		#ifdef PROJECT1
		printf("Constant : T_TRUE\n");		
		#endif
		}
		| T_FALSE
		{ 

		// Allocate a free register to store the boolean value false
    	int registerIndex = getFreeRegisterIndex();
    	char* booleanRegister = registers[registerIndex].reg32; // Register to hold the boolean value false

		// Set the register to 0, representing false
    	snprintf(buffer, sizeof(buffer), "\tmovl $0, %s\n", booleanRegister);
    	strcat(body[bodyInstructionCount++], buffer); // Append the assembly instruction to the body and increment the instruction counter

		$$ = registerIndex;	

		#ifdef PROJECT1
		printf("Constant : T_FALSE\n");		
		#endif
		}
                ;

%%


/********************C ROUTINES *********************************/

static int getFreeRegisterIndex(){
	// Iterate over the array of registers to find one that is not currently in use
	for(int i = 0; i < 15; i++){
		 // Check if the register at index i is unused
		 //if used then add it as used, else return the index that is free
		if(registers[i].used == 0){
			registers[i].used = 1;
			return i;
		}
	}
	printf("No reg is available");
	return -1;
}

static void x86PrintString (int newLine, char* string, char* reg){
	char format[1024];
	
	// Append a newline character if newLine is true.
	snprintf(format, sizeof(format), "\t.string_const%d: .string \"%s%s\"\n", currentStringIndex, string, newLine ? "\\n" : "");
    // Add the formatted string to the header section and increment the header instruction count.
	strcat(header[headerInstructionCount++], format);

	// Load the address of the string constant into the given register.
	snprintf(format, sizeof(format), "\tleaq .string_const%d(%%rip), %s\n", currentStringIndex, reg);
    strcat(body[bodyInstructionCount++], format);

	// Increment the current string index for the next usage.
    currentStringIndex++;
}

static void x86PrintInt(int newLine, char* frmt, char* reg){
	char format[1024];
	// Initialize and increment the string index for unique identification
    int stringIndex = currentStringIndex++;

	// Create a string constant with the specified format, appending a newline if requested
    snprintf(format, sizeof(format), "\t.string_const%d: .string \"%s%s\"\n", stringIndex, frmt, newLine ? "\\n" : "");
    // Append the formatted string to the header and increment the instruction count
	strcat(header[headerInstructionCount++], format);

	// Load the effective address of the string constant into the appropriate register
    snprintf(format, sizeof(format), "\tleaq .string_const%d(%%rip), %s\n", stringIndex, newLine ? "%%rdi" : reg);
    strcat(body[bodyInstructionCount++], format);

	// Move the integer value from the specified register to the ESI register, preparing it for printing
    snprintf(format, sizeof(format), "\tmovl %s, %%esi\n", reg);
    strcat(body[bodyInstructionCount++], format);
}

static void x86GetInput(char* reg){

	// Create a string constant for the input format "%d" and add it to the header
	sprintf(buffer,"\t.string_const%d: .string \"%%d\"\n",currentStringIndex); 
	strcat(header[headerInstructionCount++], buffer);

	// Load the address of the string constant into RDI for the format parameter of scanf
	sprintf(buffer,"\tleaq .string_const%d(%%rip), %%rdi\n\tmovq %s, %%rsi\n",currentStringIndex , reg);
	strcat(body[bodyInstructionCount++], buffer);

	// Increment the current string index for the next usage, ensuring unique labels
	currentStringIndex++;
}

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

    /* uncomment this section for Project 2
	char* dotChar = rindex(inputFileName,'.');
	int endIndex = strlen(inputFileName) - strlen(dotChar);
	char *outputFileName = nssave(2,substr(inputFileName,0,endIndex),".s");
	stdout = freopen(outputFileName,"w",stdout);
        if (stdout == NULL) {
          fprintf(stderr,"Error: Could not open file %s\n",outputFileName);
          exit(-1);
        }
		*/

	globalSymtab = SymInit(SYMTABLE_SIZE);
	SymInitField(globalSymtab,SYMTAB_VALUE_FIELD,(Generic)-1,NULL);	
}

static void finalize() {
	SymKillField(globalSymtab,SYMTAB_VALUE_FIELD);
    SymKill(globalSymtab);
    fclose(yyin);
    // fclose(stdout); //uncomment this line for Project 2
}

int main(int argc, char** argv)

{
	
	// Initialize the array of register usage flags and names for 32-bit and 64-bit registers
	// Initialize the used reg to be 0
	//Then assign a 32-bit reg
	//Then assign a 64-bit reg
	for (int i = 0; i < 14; i++){
		registers[i].used = 0;
		registers[i].reg32 = reg32[i];
		registers[i].reg64 = reg64[i];
	}

	fileName = argv[1];
	initialize(fileName);
	
	printf("\t.section\t.rodata \n");
	yyparse();

	// If there is any offset, declare a global pointer in the assembly
	if(offset != 0) printf("\t.comm _gp, %d, 4\n", offset);
	
	// Print all header instructions collected during parsing
	for(int i = 0; i < headerInstructionCount; i++) printf("%s",header[i]);
	//then start the text section and define the main function for assembly
	printf("\t.text\n\t.globl main\n\t.type main,@function\nmain:\tnop\n\tpushq %%rbp\n\tmovq %%rsp, %%rbp\n");
	
	// Print all body instructions, adding an instruction to move 0 to eax before the last instruction if necessary
	for(int i = 0; i < bodyInstructionCount; i++){
		if(i == bodyInstructionCount-1) printf("\tmovl $0, %%eax\n"); //set return to be 0
		printf("%s",body[i]);
	}
	// Print the leave and return instructions to finish the main function
	printf("\tleave\n\tret\n");
	
	finalize();
  
	return 0;
}

/**
 *
 * retrieve the value of a key
 *
 * @param name a C character string which is a key
 * @return the value of the key
 */
static int getValue(char *name)
{
  return (int)SymGetField(globalSymtab, name, SYMTAB_VALUE_FIELD); 
}

/**
 *
 * Set the value for a key
 *
 * @param name a C character string which is a key
 * @param value the value of the key
 */
static void setValue(char *name, int value)
{
  SymPutField(globalSymtab, name, SYMTAB_VALUE_FIELD, (Generic)value); 
}
/******************END OF C ROUTINES**********************/
