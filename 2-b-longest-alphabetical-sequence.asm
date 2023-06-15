.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'ENTER YOUR STRING: $'
OUTPUT_MSG DB 'OUTPUT: $'
MYSTR DB 100 DUP (?)
MAX DW 1
INDEX DW 0

.CODE 
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
    LEA SI, MYSTR
    
    INPUT:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE EXIT_INPUT
        
        MOV MYSTR[SI], AL
        INC SI 
        
        JMP INPUT
    EXIT_INPUT:  
    
    LEA SI, MYSTR
    MOV CX, 1
    
    CHECK:
        MOV AL, MYSTR[SI]
        MOV AH, MYSTR[SI+1]
        
        CMP AH, 00H
        JE END_CHECK 
        
        INC AL
        CMP AL, AH
        JNE CHECK_MAX 
        
        INC SI
        INC CX 
        JMP CHECK
        
        CHECK_MAX:
            CMP CX, MAX
            JG UPDATE_LENGTH
            
            INC SI
            MOV CX, 1
            JMP CHECK
            
        UPDATE_LENGTH:
            MOV MAX, CX
            MOV BX, SI
            SUB BX, CX
            INC BX
            MOV INDEX, BX
            MOV CX, 1
            INC SI
            JMP CHECK
        
    END_CHECK: 
    
    CMP CX, MAX
    JG LAST_UPDATE
    JMP END_LAST_UPDATE
    
    LAST_UPDATE:
        MOV MAX, CX
        MOV BX, SI
        SUB BX, CX
        INC BX
        MOV INDEX, BX
        
    END_LAST_UPDATE:
    
    CALL NEW_LINE
    
    MOV DX, MAX
    ADD DL, 30H
    MOV AH, 2
    INT 21H
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H
    
    MOV SI, INDEX
    MOV CX, MAX
    
    SHOW_OUTPUT:
        MOV AH, 2
        MOV DL, MYSTR[SI]
        INT 21H
        INC SI
        LOOP SHOW_OUTPUT
    
    
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