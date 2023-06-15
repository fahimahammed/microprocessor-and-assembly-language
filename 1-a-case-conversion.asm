.MODEL SMALL
.STACK 100H
.DATA

MYSTR DB 100 DUP ('$')
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 0AH, 0DH, 'OUTPUT: $'


.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    ;SHOW INPUT MSG
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H 
    
    ;INPUT STRING
    MOV AH, 1
    XOR CX, CX ; CLEAR CX REGISTER TO BE USED AS A COUNTER
    XOR SI, SI ; CLEAR SI REGISTER TO BE USED AS A INDEX
    INPUT:
        INT 21H
        CMP AL, 0DH
        JE EXIT_LOOP
        
        MOV MYSTR[SI], AL ; STORE THE INPUT IN THE BUFFER
        INC CX
        INC SI
        
        JMP INPUT
    EXIT_LOOP:
     
    ;SHOW OUTPUT MSG 
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H 
    
    XOR SI, SI ; CLEAR SI REGISTER TO BE USED AS A INDEX
    LOOP_THROUGH_MYSTR:
        MOV DL, MYSTR[SI]
        
        CMP DL, 61H
        JL CHECK_UPPERCASE
        
        CMP DL, 7AH
        JG PRINT
        
        SUB DL, 20H
        JMP PRINT
        
        CHECK_UPPERCASE:
            CMP DL, 5AH
            JG PRINT
            
            CMP DL, 41H
            JL PRINT
            
            ADD DL, 20H
            JMP PRINT
        
        PRINT:
            MOV AH, 2
            INT 21H
            INC SI
        
        LOOP LOOP_THROUGH_MYSTR
        
            
    
    MOV AH, 4CH
    INT 21H
    
    MAIN ENDP
END MAIN