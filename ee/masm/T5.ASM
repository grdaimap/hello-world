DSEG SEGMENT 
ADDOP1 DD 1234 
JIA  DB  '+','$' 
DENGYU DB  '=','$' 
TEN    DW  10 
SUM DD ? 
DSEG ENDS 

ESEG SEGMENT 
ADDOP2 DD 6789
ESEG ENDS 

STACK  SEGMENT PARA STACK 'STACK' 
DB   100   DUP(?) 
STACK ENDS 

CODE SEGMENT 
ASSUME DS:DSEG,CS:CODE,ES:ESEG 
START: MOV AX,DSEG 
    MOV DS,AX 
    MOV AX,ESEG 
    MOV ES,AX 
    MOV AX,WORD PTR ADDOP1 ;低位普通加法
    ADD AX,WORD PTR ADDOP2 
    MOV WORD PTR SUM,AX 
    MOV AX,WORD PTR ADDOP1+2 ;高位进位加法
    ADC AX,WORD PTR ADDOP2+2 
    MOV WORD PTR SUM+2,AX 

MOV BX,WORD PTR ADDOP1+2 ;输出被加数高8位
CALL DISPLAY 
MOV BX,WORD PTR ADDOP1 ;输出被加数低8位
CALL DISPLAY 
MOV AH,09H 
MOV DX,OFFSET JIA 
INT 21H ;输出加号
MOV BX,WORD PTR ADDOP2+2 ;加数高8位
CALL DISPLAY
MOV BX,WORD PTR ADDOP2 ;加数低8位
CALL DISPLAY 
MOV AH,09H 
MOV DX,OFFSET DENGYU 
INT 21H ;等于号
MOV BX,WORD PTR SUM+2 ;结果高8位
CALL DISPLAY 
MOV BX,WORD PTR SUM ;结果低8位
CALL DISPLAY 
MOV AH,4CH 
INT 21H 

DISPLAY PROC NEAR ;转换成10进制输出
MOV CX,10000D       
CALL DEC_DIV 
MOV CX,1000D       
CALL DEC_DIV 
MOV CX,100D       
CALL DEC_DIV 
MOV CX,10D        
CALL DEC_DIV 
MOV CX,1D       
CALL DEC_DIV 
RET

DEC_DIV PROC NEAR     
MOV AX,BX      
MOV DX,0       
DIV CX       
MOV BX,DX        
MOV DL,AL     
ADD DL,30H        
MOV AH,2H  
INT 21H ;在屏幕上打印       
RET        
DEC_DIV ENDP 
DISPLAY ENDP 
CODE  ENDS 
END START
