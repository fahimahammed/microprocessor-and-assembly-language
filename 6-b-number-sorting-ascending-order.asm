.MODEL SMALL
.STACK 100H

.DATA
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 'AFTER SORTING: $'

MYSTR DB 100 DUP ('$')

.CODE
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    MOV SI, 0
    
    INPUT_STR:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH 
        JE EXIT_INPUT_STR
        
        MOV MYSTR[SI], AL
        INC SI
        JMP INPUT_STR
    EXIT_INPUT_STR: 
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    MOV SI, 0
    
    LOOP1:
        MOV DI, SI 
        
        MOV AL, MYSTR[SI]
        CMP AL, '$'
        JE END_LOOP1
        
        LOOP2:
            INC DI
            MOV AL, MYSTR[DI]
            MOV AH, MYSTR[SI]
            
            CMP AL, '$'
            JE END_LOOP2
            
            CMP AH, AL
            JG SWAP
            JMP LOOP2
            
        SWAP:
            MOV MYSTR[DI], AH
            MOV MYSTR[SI], AL
            JMP LOOP2
            
        END_LOOP2:
            INC SI
            JMP LOOP1
    END_LOOP1:
    
    MOV AH, 9
    LEA DX, MYSTR
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
    
   