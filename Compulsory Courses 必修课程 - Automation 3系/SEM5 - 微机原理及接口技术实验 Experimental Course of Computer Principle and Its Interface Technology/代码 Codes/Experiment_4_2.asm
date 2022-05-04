# 实验源程序
STACK  SEGMENT  STACK
       DW  100  DUP(?)
STACK  ENDS

DATA   SEGMENT
  X  DB 10 DUP(0)
DATA   ENDS

CODE   SEGMENT
 ASSUME CS:CODE,DS:DATA,SS:STACK
MAIN  PROC
      MOV AX,DATA
      MOV DS,AX
COMP: MOV SI,OFFSET X
      MOV DX,298H
      MOV AL,1                                                                                
      OUT DX,AL
      CALL DELAY
      IN  AL,DX
      CMP AL,[SI]
      JZ  COMP
      MOV [SI],AL
      CALL BINARY
      CALL DEC
      CALL HEX
      MOV DL,0FFH
      MOV AH,6
      INT 21H
      JNZ EXIT
      JMP COMP
EXIT: MOV AH,4CH
      INT 21H
MAIN  ENDP
      
BINARY PROC
MOV DL,[SI];
      MOV CX,8
NEXT1:ROL DL,1
      PUSH DX
      AND DL,1
      ADD DL,30H
      MOV AH,2
      INT 21H
      POP DX
      LOOP NEXT1   
      MOV DL,'B'
      MOV AH,2
      INT 21H
      MOV DL,0AH
      MOV AH,2
      INT 21H
      MOV DL,0DH
      MOV AH, 2
      INT 21H
      RET
BINARY ENDP

HEX PROC
MOV DL,[SI];
      MOV CL,4
      SHR DL,CL
      CMP DL,0AH
      JB  NEXT2;
      ADD DL,7
NEXT2:ADD DL,30H
      MOV AH,2
      INT 21H
      MOV DL,[SI]
      AND DL,0FH
      CMP DL,0AH
      JB  NEXT3;
      ADD DL,7
NEXT3:ADD DL,30H
      MOV AH,2
      INT 21H
      MOV DL,'H'
      MOV AH,2
      INT 21H
      MOV DL,0AH
      MOV AH,2
      INT 21H
      MOV DL, 0DH
      MOV AH,2
      INT 21H
      RET
HEX ENDP
      
DEC PROC
MOV AL,[SI];
      MOV AH,0
      MOV BL,100
      DIV BL
      MOV BH,AH
      MOV DL,AL
      ADD DL,30H
      MOV AH,2
      INT 21H
      MOV AL, BH
      MOV AH,0
      MOV BL,10
      DIV BL
      MOV BH,AH
      MOV DL,AL
      ADD DL,30H
      MOV AH, 2
      INT 21H 
      MOV DL,BH
      ADD DL,30H
      MOV AH,2
      INT 21H
      MOV DL,0AH
      MOV AH,2 
      INT 21H
      MOV DL,0DH
      MOV AH, 2
      INT 21H
      RET
DEC ENDP

VOLT PROC
MOV AL,[SI];
      MOV AH,0
      MOV BL,51
      DIV BL
      MOV BH,AH
      MOV DL,AL
      ADD DL,30H
      MOV AH,2
      INT 21H
      MOV DL,2EH
      MOV AH,2
      INT 21H
      MOV AL,BH
      MOV BL,10
      MUL BL
      MOV BL,51
      DIV BL
	  MOV BL,AH
      MOV DL,AL
      ADD DL,30H
      MOV AH,2
      INT 21H
      MOV AL,BL
      MOV BL, 10
      MUL BL
      MOV BL,51 
      DIV BL
      MOV DL,AL
      ADD DL,30H
      MOV AH,2
      INT 21H
      MOV DL,'V'
      MOV AH,2
      INT 21H
      MOV DL,0DH
      MOV AH,2
      INT 21H
      MOV DL,0AH
      MOV AH,2
      INT 21H
VOLT ENDP

DELAY PROC
      PUSH CX
      PUSH BX
      MOV  BX,500
      MOV  CX,0
NEXT4:LOOP NEXT4
      DEC  BX
      JNZ  NEXT4
      POP  BX
      POP  CX
      RET
DELAY ENDP

CODE  ENDS
      END MAI