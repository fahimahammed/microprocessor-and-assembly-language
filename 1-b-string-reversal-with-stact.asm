.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 0DH, 0AH, 'OUTPUT STRING: $' 

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;SHOW INPUT MSG
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    XOR SI, SI
    MOV AH, 1
    INPUT:
        INT 21H
        
        CMP AL, 0DH
        JE EXIT_FROM_INPUT
        
        PUSH AX
        INC SI 
    
    JMP INPUT 
    EXIT_FROM_INPUT:
    
    ; SHOW OUTPUT MSG
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H 
    
    
    DEC SI
    MOV AH, 2
    LOOP_THROUGH_MYSTR:
        POP DX
        INT 21H
        
        CMP SI, 00H
        JE EXIT_MYSTR_LOOP
        
        DEC SI
    
    LOOP LOOP_THROUGH_MYSTR
    EXIT_MYSTR_LOOP:
    
    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN