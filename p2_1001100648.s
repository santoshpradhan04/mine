/******************************************************************************
* @FILE p2_1001100648.s
* 
* Simple program to implement an iterative solution for computing the GCD of 
* two positive integers
*
* @AUTHOR Santosh Pradhan
******************************************************************************/    

  .global main
  .func main
main:
    BL _Operand                         @ branch to _Operand procedure with return
    MOV R5, R0                          @ move return value from R0 to R5
    BL _Operand                         @ branch to _Operand procedure with return
    MOV R6, R0                          @ move return value from R0 to R6
    MOV R1, R5                          @ move R5 to R1
    MOV R2, R6                          @ move R6 to R2
    BL GCD_ITERATIVE                    @ branch to GCD_ITERATIVE procedure with return
    MOV R1, R0                          @ move R0 to R1
    LDR R0, =Printf_Output              @ R0 contains formatted string address
    BL printf                           @ call printf
    B main                              @ call main (to form a loop)
    
_Operand:
    MOV R4, LR                          @ store LR since printf call overwrites
    SUB SP, SP, #4                      @ make room for stack
    LDR R0, =Operand_Prompt             @ RO contains formatted string address
    BL printf                           @ call printf
    LDR R0, =Input_Value                @ R0 contains formatted string address
    MOV R1, SP                          @ move SP to R1 to store entry of stack
    BL scanf                            @ call scanf
    LDR R0, [SP]                        @ load value at SP into R0
    ADD SP, SP, #4                      @ remove value from stack
    MOV PC, R4                          @ return
    
GCD_ITERATIVE:
    MOV R7, R2                          @ copy input register R2 to register R7
    B _iteration                        @ call _iteration 
    
    _iteration:
          
          _mod1:
                SUB R1, R1, R7          @ subtract R7 from R1 and copy to R1
                
          CMP R1, R7                    @ check to see if R1 >= R7
          BHS _mod1                     @ continue loop if R1 >= R7
          
          _mod2:
                SUB R2, R2, R7          @ subtract R7 from R2 and copy to R2
        
          CMP R2, R7                    @ check to see if R2 >= R7
          BHS _mod2                     @ continue loop if R2 >= R7
          
          MOV R8, R1                    @ copy input register R1 to R8
          MOV R9, R2                    @ copy input register R2 to R9
          CMP R8, #0                    @ check to see if R8 >= 0
          BNE _option                   @ branch to not equal handler
          CMP R9, #0                    @ check to see if R9 >= 0
          BNE _option                   @ branch to not equal handler
          MOV R0, R7                    @ move remainder to R0
          MOV PC, LR                    @ return
          
    _option:
          MOV R1, R5                    @ copy register R5 to input register R1
          MOV R2, R6                    @ copy register R6 to input register R2
          SUB R7, R7, #1                @ subtract 1 from R7 and copy to R7
          B _iteration                  @ call _iteration
    
    .data
Operand_Prompt: .asciz "Please enter a positive number: "
Input_Value: .asciz "%d"
Printf_Output: .asciz "The GCD of two given numbers is : %d\n"
