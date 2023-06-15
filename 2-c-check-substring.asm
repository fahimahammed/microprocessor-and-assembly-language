.MODEL SMALL
.STACK 100H
.DATA
MAIN_STR_INPUT DB 'ENTER THE MAIN STRING: $'
SUB_STR_INPUT DB 'ENTER THE SUB STRING: $'
FOUND_MSG DB 'SUBSTRING FOUND! $'
NOT_FOUND_MSG DB 'SUBSTRING NOT FOUND! $'

MAIN_STR DB 100 DUP ('$')
SUB_STR DB 100 DUP ('$')

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, MAIN_STR_INPUT
    INT 21H
    
    MOV SI, 0
    
    MAIN_STR_IN:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_MAIN_STR_IN
        
        MOV MAIN_STR[SI], AL
        INC SI
        JMP MAIN_STR_IN
    END_MAIN_STR_IN: 
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, SUB_STR_INPUT
    INT 21H
    
    MOV SI, 0
    
    SUB_STR_IN:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE END_SUB_STR_IN
        
        MOV SUB_STR[SI], AL
        INC SI
        JMP SUB_STR_IN
    END_SUB_STR_IN:
    
    CALL NEW_LINE
    
    MOV SI, 0
    CHECK:
        MOV DI, 0
        PUSH SI
        
        LOOP1:
            MOV AH, MAIN_STR[SI]
            MOV AL, SUB_STR[DI]
            
            INC SI
            INC DI
            
            CMP AL, '$'
            JE SUB_STR_FOUND
            
            CMP AH, AL
            JE LOOP1
            JMP UPDATE
        
        UPDATE:
            POP SI
            INC SI
            MOV AH, MAIN_STR[SI]
            CMP AH, '$'
            JE SUB_STR_NOT_FOUND
            JMP CHECK
            
        SUB_STR_FOUND:
            MOV AH, 9
            LEA DX, FOUND_MSG
            INT 21H
            JMP EXIT
        
        SUB_STR_NOT_FOUND:
            MOV AH, 9
            LEA DX, NOT_FOUND_MSG
            INT 21H
            JMP EXIT
            
    EXIT:
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

NEW_LINE PROC
    MOV AH,2
    MOV DL,0AH
    INT 21H
    MOV DL,0DH
    INT 21H
    RET
NEW_LINE ENDP

END MAIN