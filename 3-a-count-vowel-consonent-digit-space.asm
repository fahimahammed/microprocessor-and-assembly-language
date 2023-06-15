.MODEL SMALL
.STACK 100H
.DATA
INPUT_MSG DB 'ENTER YOUR STIRNG: $'
VOWEL_MSG DB 'NUMBER OF VOWELS: $'
CONSONENT_MSG DB 'NUMBER OF CONSONENTS: $'
DIGIT_MSG DB 'NUMBER OF DIGITS: $'
SPACE_MSG DB 'NUMBER OF SPACES: $'

MYSTR DB 100 DUP ?
VOWEL DB 48
CONSONENT DB 48
DIGIT DB 48
SPACE DB 48

.CODE
MAIN PROC 
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H 
    
    MOV SI, 0
    MOV DI, 0
    
    INPUT_STR:
        MOV AH, 1
        INT 21H
        
        CMP AL, 0DH
        JE EXIT_INPUT_STR
        
        CMP AL, 20H
        JE SPACE_COUNT
        JMP DIGIT_
        
        DIGIT_:
            CMP AL, '0'
            JGE LESS_EQUAL_NINE
            JMP VOWEL_
            
            LESS_EQUAL_NINE:
                CMP AL, '9'
                JLE DIGIT_COUNT
                JMP VOWEL_
        
        VOWEL_:
            CMP AL, 'A'
            JE VOWEL_COUNT
            CMP AL, 'E'
            JE VOWEL_COUNT
            CMP AL, 'I'
            JE VOWEL_COUNT
            CMP AL, 'O'
            JE VOWEL_COUNT
            CMP AL, 'U'
            JE VOWEL_COUNT
            
            JMP CONSONENT_
            
        CONSONENT_:
            CMP AL, 'A'
            JGE LESS_EQUAL_Z
            JMP INPUT_STR
            
            LESS_EQUAL_Z:
                CMP AL, 'Z'
                JLE CONSONENT_COUNT
                JMP INPUT_STR
        
        SPACE_COUNT:
            INC SPACE
            INC SI
            JMP INPUT_STR
            
        VOWEL_COUNT:
            INC VOWEL
            INC SI
            JMP INPUT_STR        
            
        DIGIT_COUNT:
            INC DIGIT
            INC SI
            JMP INPUT_STR
            
        CONSONENT_COUNT:
            INC CONSONENT
            INC SI
            JMP INPUT_STR
    EXIT_INPUT_STR:
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, VOWEL_MSG  
    INT 21H
    
    MOV AH, 2
    MOV DL, VOWEL
    INT 21H
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, CONSONENT_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, CONSONENT
    INT 21H
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, DIGIT_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, DIGIT
    INT 21H
    
    CALL NEW_LINE
    
    MOV AH, 9
    LEA DX, SPACE_MSG
    INT 21H
    
    MOV AH, 2
    MOV DL, SPACE
    INT 21H
    
    
    
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
