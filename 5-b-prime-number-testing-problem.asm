include "emu8086.inc"
.MODEL SMALL
.STACK 100H
.DATA
N DB 0D 

.CODE
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    PRINT "ENTER A NUMBER: "
    MOV AH, 1
    INT 21H
    SUB AL, 48D
    MOV N, AL
    
    CALL NEW_LINE
    CMP N, 2
    JE PRIME_NUM
    
    CMP N, 2
    JL NONPRIME_NUM
    
    MOV CL, N
    DEC CL
    CHECK: 
        MOV AL, N
        MOV AH, 0D
        
        DIV CL   ; AL/CL  >> AL = RESULT, AH=REMAINDER
        
        CMP  AH, 0D
        JE NONPRIME_NUM
        
        CMP CL, 2
        JE PRIME_NUM
    LOOP CHECK
    
    PRIME_NUM:
        PRINTN "PRIME NUMBER"
        JMP EXIT
    
    NONPRIME_NUM:
        PRINTN "NON PRIME NUMBER"
        JMP EXIT
    
    EXIT:
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

NEW_LINE PROC
    MOV AH, 2
    MOV DL, 0DH
    INT 21H
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    RET
    NEW_LINE ENDP

END MAIN