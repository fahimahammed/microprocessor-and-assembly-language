.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'ENTER A NUMBER: $'
OUTPUT_MSG DB 'SUM: $'
N DB 0D
D DB 2D
SUM DB 0D

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    MOV AH, 1
    INT 21H
    SUB AL, 48D
    MOV N, AL
    INC N
    
    MUL N
    DIV D
    MOV SUM, AL
    ADD SUM, 48D
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, SUM
    INT 21H
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP 

NEW_LINE PROC
    MOV AH,2
    MOV DL,0DH
    INT 21H
    MOV DL,0AH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN