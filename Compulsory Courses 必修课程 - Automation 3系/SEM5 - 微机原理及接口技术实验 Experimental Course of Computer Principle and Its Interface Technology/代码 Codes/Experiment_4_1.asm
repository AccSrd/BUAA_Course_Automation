# 预习思考题及实验验证
# 4
STACK  SEGMENT  STACK
       DW  100  DUP(?)
STACK  ENDS

DATA   SEGMENT
       DT1  DB  5CH 
DATA   ENDS

CODE   SEGMENT
 ASSUME CS:CODE,DS:DATA,SS:STACK
MAIN  PROC
      MOV AX,DATA
      MOV DS,AX
      MOV AL,DT1
      MOV [SI],AL
      CALL TWO
      CALL TEN
      CALL SIXTEEN
EXIT: MOV AH,4CH
      INT 21H
MAIN  ENDP

TWO PROC
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
TWO ENDP

TEN PROC
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
TEN ENDP
      

SIXTEEN PROC
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
SIXTEEN ENDP

 CODE ENDS
 END MAIN