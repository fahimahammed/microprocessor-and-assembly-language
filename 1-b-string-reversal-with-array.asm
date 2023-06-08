.MODEL SMALL
.STACK 100H

.DATA
INPUT_STR DB 100 DUP ('$')
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 0AH, 0DH, 'OUTPUT STRING: $'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    ;TAKE INPUT
    MOV AH, 1
    XOR SI, SI
    ;XOR CX, CX
    
    INPUT: 
        INT 21H
        CMP AL, 0DH
        JE EXIT_LOOP
        
        MOV INPUT_STR[SI], AL
        ;INC CX
        INC SI
        
        JMP INPUT
    EXIT_LOOP: 
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    DEC SI
    MOV AH, 2
    LOOP_THROUGH_STR:
        MOV DL, INPUT_STR[SI]
        INT 21H
        
        CMP SI, 00H
        JE EXIT_FROM_LOOP
        
        DEC SI
        
        LOOP LOOP_THROUGH_STR
    EXIT_FROM_LOOP:
     
    
    
    MOV AH, 4CH
    INT 21H
    
ENDP MAIN
END MAIN
