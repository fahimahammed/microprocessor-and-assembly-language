.MODEL SMALL
.STACK 100H
.DATA
MYSTR DB 100 DUP ('$')
INPUT_MSG DB 'ENTER YOUR STRING: $'
FIRST_MSG DB 'FIRST LETTER: $'
LAST_MSG DB 'LAST LETTER: $'
NOCAP_MSG DB 'NO CAPITAL $'

FIRST_CAP DB '['
LAST_CAP DB '@'

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
        JE EXIT_FROM_INPUT
        
        MOV MYSTR[SI], AL
        INC SI
        
        
        CMP AL, 'A'
        JGE CHECK_LESS_Z
        
        JMP INPUT
        
        CHECK_LESS_Z:
            CMP AL, 'Z'
            JLE CHECK_FIRST
            JMP INPUT
            
        CHECK_FIRST:
            CMP AL, FIRST_CAP
            JL UPDATE_FIRST
            JMP CHECK_LAST
            
        CHECK_LAST:
            CMP AL, LAST_CAP
            JG UPDATE_LAST
            JMP INPUT
            
        UPDATE_FIRST:
            MOV FIRST_CAP, AL
            JMP CHECK_LAST
            
            
        UPDATE_LAST:
            MOV LAST_CAP, AL
            JMP INPUT
        
        
    
    EXIT_FROM_INPUT:
    
    CALL NEW_LINE
    
    CMP FIRST_CAP, '['
    JE NO_CAP
    
    MOV AH, 9
    LEA DX, FIRST_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, FIRST_CAP
    INT 21H 
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, LAST_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, LAST_CAP
    INT 21H 
    
    JMP EXIT
    
    NO_CAP:
        MOV AH, 9
        LEA DX, NOCAP_MSG
        INT 21H
    
    
    EXIT:
    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

NEW_LINE PROC
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    
    MOV DL, 0DH
    INT 21H
    RET
NEW_LINE ENDP
    
END MAIN
