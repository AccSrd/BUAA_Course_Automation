# 实验源程序
# 1.字符串排序
DATAS SEGMENT
    X1 DB 100 DUP('0')  
DATAS ENDS

STACKS SEGMENT
    X DB 50 DUP('0')
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
MAIN PROC
    MOV AX,DATAS
    MOV DS,AX
    MOV BX,OFFSET X1
KEYIN: MOV AH,1
       INT 21H
       MOV DL,AL
    MOV [BX],AL
    INC BX
    CMP DL,0DH
    JNZ KEYIN
    MOV AL,'$'
    MOV [BX],AL
    SUB BX,2
NEXT:  MOV CX,BX
        MOV SI,OFFSET X1
CHANGE:   MOV AL,[SI]
        CMP AL,[SI+1]
        JBE NEXT1
        XCHG AL,[SI+1]
        MOV [SI],AL
NEXT1:  INC SI
        LOOP    CHANGE
        DEC BX
        JNE NEXT    
        MOV DX,OFFSET X1
        MOV AH,9
        INT 21H
    MOV AH,4CH
    INT 21H
MAIN ENDP     
CODES ENDS
END MAIN

# 2. 4位BCD加法
DATAS SEGMENT
       NUM1  DB  4 DUP('0')
       NUM2  DB  4 DUP('0')
       SUM  DB  5 DUP('0') 
DATAS ENDS

STACKS SEGMENT
     DW  100 DUP('0')
STACKS ENDS

CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
MAIN   PROC
    MOV AX,DATAS
    MOV DS,AX
     MOV  BX,OFFSET NUM1
       MOV  CX,4
IN1:CALL KEYIN
       AND  AL,0FH
       MOV  [BX],AL
       INC  BX
       LOOP IN1
       MOV  AH,2
       MOV  DL,'+'
       INT  21H
       MOV  BX,OFFSET NUM2
       MOV  CX,4
IN2:CALL KEYIN
       AND  AL,0FH
       MOV  [BX],AL
       INC  BX
       LOOP IN2
       MOV  AH,2
       MOV  DL,'='
       INT  21H
MOV SI,(OFFSET NUM1)+3
MOV DI,(OFFSET NUM2)+3
MOV BX,(OFFSET SUM)+4
       MOV  CX,4
       OR   CX,CX
NEXT:  MOV  AL,[SI]
       ADC  AL,[DI]
       AAA
       MOV  [BX],AL
       DEC  SI
       DEC  DI
       DEC  BX
       LOOP NEXT
       MOV  AL,0
       ADC  AL,0
       MOV  [BX],AL
       MOV  CX,5
NEXT1: MOV BX,OFFSET SUM
       MOV AX,5
       SUB AX,CX
       ADD BX,AX
       MOV AL,[BX]
       CMP AL,0
       JNZ OUTP
       CMP CX,1
       JNA OUTP
       LOOP NEXT1
OUTP:  MOV  DL,[BX]
       ADD  DL,30H
       MOV  AH,2
       INT  21H
       INC  BX
       LOOP OUTP
    MOV AH,4CH
    INT 21H
    MAIN   ENDP
    KEYIN  PROC
AGAIN:MOV AH,8
      INT 21H
      CMP AL,30H
      JB AGAIN
      CMP AL,39H
      JA AGAIN
      MOV DL,AL
      MOV AH,2
      INT 21H
      RET
KEYIN ENDP

CODES ENDS
    END MAIN