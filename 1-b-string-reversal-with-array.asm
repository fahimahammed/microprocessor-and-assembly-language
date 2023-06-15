.MODEL SMALL
.STACK 100H
.DATA 
MYSTR DB 100 DUP ('$')
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 0DH, 0AH, 'OUTPUT STRING: $'

.CODE
MAIN PROC
    MOV AX, @DATA 
    MOV DS, AX
    
    ; SHOW INPUT MSG
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H  
    
    ;TAKE INPUT 
    MOV AH, 1
    XOR SI, SI
    INPUT:
        INT 21H 
        
        CMP AL, 0DH
        JE EXIT_LOOP
        
        MOV MYSTR[SI], AL
        INC SI
        
        JMP INPUT
    EXIT_LOOP:
    
    ; SHOW OUTPUT MSG
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    DEC SI
    MOV AH, 2
    
    LOOP_THROUGH_MYSTR:
        MOV DL, MYSTR[SI]
        INT 21H
        
        CMP SI, 00H
        JE EXIT_FROM_LOOP
        
        
        DEC SI
    
    
    LOOP LOOP_THROUGH_MYSTR
    EXIT_FROM_LOOP:
    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN