.MODEL SMALL
.STACK 100H
.DATA

INPUT_STRING DB 100 DUP ('$')               ; define a buffer to store string
INPUT_MSG DB 'ENTER YOUR STRING: $'         ; msg prompt for input
OUTPUT_MSG DB 0DH, 0AH, 'OUTPUT STRING: $'  ; msg prompt for output
                                            
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 9
    LEA DX, INPUT_MSG
    INT 21H
    
       
    ; take input
    MOV AH, 1
    XOR CX, CX  ; clear CX register to be used as a counter
    XOR SI, SI  ; clear SI register to be used as an index
    INPUT:
        INT 21H
        CMP AL, 0DH        ; check if the input is a carriage return
        JE EXIT_FROM_INPUT
        
        MOV INPUT_STRING[SI], AL  ; store the input in the buffer
        INC CX     
        INC SI
        JMP INPUT
    EXIT_FROM_INPUT:
    
    MOV AH, 9
    LEA DX, OUTPUT_MSG
    INT 21H 
    
    ; convert case
    XOR SI, SI  
    
    LOOP_THROUGH_STR:
        MOV DL, INPUT_STRING[SI]
        
        CMP DL, 61H
        JL CHECK_UPPERCASE   ;  60, 59 ...., upper case
        
        CMP DL, 7AH          
        JG PRINT             ; z, y, x .....
        
        SUB DL, 20H
        JMP PRINT
        
        CHECK_UPPERCASE:
            CMP DL, 41H      
            JL PRINT         ; @, ?, > ,.....
            
            CMP DL, 5AH
            JG PRINT         ; Z, Y, X, .....
            
            ADD DL, 20H
            JMP PRINT
        
        PRINT:
            MOV AH, 2
            INT 21H
        
        INC SI
        LOOP  LOOP_THROUGH_STR 
        
        MOV AH, 4CH
        INT 21H
        
    
    
ENDP MAIN
END MAIN