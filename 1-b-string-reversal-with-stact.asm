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
    
    XOR SI, SI
    MOV AH, 1
    INPUT:
        INT 21H
        
        CMP AL, 0DH
        JE EXIT_FROM_LOOP
        
        PUSH AX
        INC SI
        
    JMP INPUT
    EXIT_FROM_LOOP: 
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    DEC SI
    MOV AH, 2
    
    OUTPUT:
        POP DX
        INT 21H
        
        CMP SI, 00H
        JE EXIT_OUTPUT
        
        DEC SI
    LOOP OUTPUT
    EXIT_OUTPUT:
    
    
    
    MOV AH, 4CH
    INT 21H
ENDP MAIN
END MAIN