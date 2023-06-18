.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'ENTER A NUMBER: $'
EVEN_MSG DB 'NUMBER IS EVEN$'
ODD_MSG DB 'NUMBER IS ODD$'
N DB 0D
D DB 2D

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
    
    DIV D
    CMP AH, 0D
    JE EVEN
    JMP ODD
    
    EVEN: 
        CALL NEW_LINE
        MOV AH, 9
        LEA DX, EVEN_MSG
        INT 21H
        JMP EXIT
        
    ODD:
       CALL NEW_LINE
       MOV AH, 9
       LEA DX, ODD_MSG
       INT 21H
       
    EXIT:
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