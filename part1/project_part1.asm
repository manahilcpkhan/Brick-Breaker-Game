.model small
.stack 100h
.data
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~hiba

menuStatus db 1		;to call menu proc initially
newGameString db "START GAME$"
GameName db "BRICK BREAKER"
ExitGameString db "EXIT$"
MadeByGameString db "MADE BY:$"
Instruction db "USE MOUSE TO NAVIGATE THE BAR"
Ali db "Ali Arfa$" 
Manahil db "Manahil Kamran$"
Hiba db "Hiba Imran$"
theEndString db "THE END$"

winString db "YOU WIN$"
loseString db "YOU LOSE$"

pressEnterString db "PRESS ENTER$"
toStartNewGameString db "TO START NEW GAME$"
pressEscapeString db "PRESS ESCAPE$"
toExitString db "TO EXIT$"
x dw 0
y dw 25
z dw 25
color db 2
columnNo db 0
;menu db 10 ,10 ,'          Welcome to Brick Breaker  ',10,10,'             Made by Manahil ',10,10,'                    Ali',10,10,'                    Hiba',10,10,'       1. to PLAY  ',10, 10,'       2. SELECT LEVEL  ',10,10,'       3. Check HiScore Board ',10,10,'       4. GAME INFO '
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~hiba 
lose db 'you lose'
;-------------life 
lifes db 2
;-------------bar
bar_x dw 140
bar_y dW 194
BARMOV DB ?
;-----------MOUSE

;------------------brick

bric db 0, 5, 10, 15, 20, 25, 30, 35, 40; 9 blocks each wall
w1 db 11; set dh 11
w2 db 0; set dh 0
;a db ?
count db 9
;-------------------ball variables
ballsize dB 4
ball_x dW 150
ball_y dW 150
ballx sWord -1
bally sWord -1

TEMP1 DB 0
TEMP2 DB 0
;-------------MOVING BALL




.code
jmp main

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~hiba
Write_Highscore MACRO

        MOV AH, 3CH
        MOV CX, 0
        MOV DX, OFFSET FileName
        INT 21H

        MOV Buffer, AX

        MOV AH, 40H
        MOV BX, Buffer
        MOV DX, OFFSET PlayerHighscore
        MOV CX, LENGTHOF PlayerHighscore
        INT 21H

        MOV AH, 3EH
        MOV BX, Buffer
        INT 21H

    ENDM

    Read_Highscore MACRO
        
        MOV AH, 3DH
        MOV AL, 02H
        MOV DX, OFFSET FileName
        INT 21H

        MOV Buffer, AX

        MOV AH, 3FH
        MOV DX, OFFSET PlayerHighscore
        MOV CX, LENGTHOF PlayerHighscore
        MOV BX, Buffer
        INT 21H
        
        MOV AH, 09H
        INT 21H

        MOV AH, 3EH
        MOV BX, Buffer
        INT 21H

    ENDM

;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~hiba

;----------------MOUSE
mousein proc 
MOV AX, 1
INT 33H
MOV AX, 2
INT 33H
mov ax, 3
int 33h
mov  BAR_X,cx
ret 4
mousein endp
;--------------BRICK PROC----------------------------
brick proc
push dx 
push cx 
mov ah, 6h
mov al, 1
mov bh, 14h
mov ch, 0
mov cl, dl; x axis mov
mov dh, dh; y aix mov
add dl, 3
mov dl, dl; distance from left
int 10h

pop cx
pop dx
ret 
brick endp
;-----------------------bar
bar proc
push dx 
push cx 
mov ah, 6h
mov al, 1
mov bh, 14h
mov ch, 0
mov cl, dl; x axis mov
mov dh, dh; y aix mov
add dl, 3
mov dl, dl; distance from left
int 10h

pop cx
pop dx
ret 
bar endp
;--------------------delay-----------------------------
delay proc 
push bx 
	mov bx ,3F90h
	l:
	dec bx
	cmp bx ,1
	jne l
pop bx
ret 4 
delay endp
;--------------------LEVEL1------------------
LEVEL1 PROC
	mov ah, 0Bh
	mov bh, 00h
	mov bl, 9h
	int 10h
mov di, offset bric
WALL1:

  mov dl, [di]
  mov dh, w1
  call brick
  inc di
  DEC COUNT
  cmp count, 0
  jne WALL1

;mov count, 9
mov di, offset bric
WALL2:
   mov dl, [di]
   mov dh, w2
   call brick
   inc di
   inc count
   cmp count, 9
   jne WALL2
;MOV COUNT,9

RET 4 
LEVEL1 ENDP
;-----------------------level-2
LEVEL2 PROC
	mov ah, 0Bh
	mov bh, 00h
	mov bl, 9h
	;int 10h
mov di, offset bric
WALL1:

  mov dl, [di]
  mov dh, w1
  call brick
  inc di
  DEC COUNT
  cmp count, 0
  jne WALL1
mov di, offset bric
mov count ,9

RET 4 
LEVEL2 ENDP
;----------------bar
drawbar proc
  push bx
push cx
 MOV bl,30
 MOV temp1,bl
 MOV CX, bar_x
B:
   DEC TEMP1
    MOV DX, bar_y
    MOV AL, 14h
    MOV AH, 0CH 
    ;INT 10H
	
	MOV bl,4
	MOV temp2,bl
    D:
	INC DX
	DEC TEMP2
  	MOV AL, 14h
    	MOV AH, 0CH 
    	INT 10H
	CMP temp2,0
	JG D
	INC CX
	CMP temp1,0
    JG B
mov bar_y,194
pop cx
pop bx
ret 4
drawbar endp
;--------------------reset ball coordinates
resetball proc
mov ball_x ,150
mov ball_y ,105

ret
resetball endp
;--------------------collision
checkcollision proc
tl:
MOV AX,BALL_X
add ax ,6
MOV CX ,AX
MOV AX,BALL_Y
add ax,1
MOV DX,AX
MOV ah,0DH
MOV BH,0
INT 10H
cmp al,14h
je right

Tr:
MOV AX,BALL_X
sub ax,1
MOV CX ,AX
MOV AX,BALL_Y
add ax,1
MOV DX,AX
MOV ah,0DH
MOV BH,0
INT 10H
cmp al,14h
je left

Lo:
MOV AX,BALL_X
add ax,1
MOV CX ,AX
MOV AX,BALL_Y
add ax,6
MOV DX,AX
MOV ah,0DH
MOV BH,0
INT 10H
cmp al,14h
je top

br:
MOV AX,BALL_X
add ax,1 
MOV CX ,AX
MOV AX,BALL_Y
sub ax,1
MOV DX,AX
MOV ah,0DH
MOV BH,0
INT 10H
cmp al,14h
je down
jmp exit
top:
mov bally,-1
jmp exit
down:
mov bally,1
jmp exit
left:
mov ballx,1
jmp exit
right:
mov ballx,-1

EXIT:
ret 
checkcollision endp
;--------------------losegame 

losegame proc
mov AX, @data
mov DS, AX   
c1:
mov cx ,sizeof lose
mov si, offset lose
d1:
mov dl,[si]
mov ah,2h
int 21h 
inc si
loop d1
mov ah,0
    int 16h
    cmp al,13
back:
    call main
exit:

ret 
losegame endp
;-------------------flipping ball directions

; -------------------------Moving ball
MOVBALL PROC

CMP BALL_X,0
JLe FLIPXP
CMP BALL_X,314
JGe FLIPXN
CMP BALL_y,0
JLe FLIPYP
CMP BALL_y,194
;-------------------------call lose func
jGe FLIPYN
JMP EXIT

FLIPXn:
mov ballx,-1
jmp exit
FLIPYn:
 ;call flip_y
;mov bally,-1

cmp lifes,0
jne m1
call losegame 
jmp exit
m1:
call resetball

dec lifes

jmp exit
FLIPXp:
 ;call flip_x
mov ballx,1
jmp exit
FLIPYp:
 ;call flip_y
mov bally,1
jmp exit
EXIT:
push ax
mov ax,ballx
add ball_x,ax
mov ax,bally
add ball_Y,ax
pop ax
RET 4 
MOVBALL ENDP
;-------------------flip
flip_x proc 
cmp ballx,1
je l1
mov ballx,1
jmp exit
l1:
mov ballx,-1
exit:
ret 4
flip_x endp

flip_y proc 
cmp bally,1
je l2
mov bally,1
jmp exit
l2:
mov bally,-1
exit:
ret 4
flip_y endp
;-------------------------info display
infodisplay proc 
   mov ah,1h
   int 16h
ret
infodisplay endp
; ------------------------- ball
DRAWBALL PROC

push bx
push cx
 MOV bl,BALLSIZE
 MOV temp1,bl
 MOV CX, ball_x 
B:
   DEC TEMP1
    MOV DX, ball_y
    MOV AL, 01h
    MOV AH, 0CH 
    ;INT 10H
	
	MOV bl,BALLSIZE
	MOV temp2,bl
    D:
	INC DX
	DEC TEMP2
  	MOV AL, 01h
    	MOV AH, 0CH 
    	INT 10H
	;DEC BL
	CMP temp2,0
	JG D
	INC CX
	CMP temp1,0
    JG B
pop cx
pop bx
RET 4
DRAWBALL ENDP
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ menu~~~~~~~~~~~~~~~~~~~~~~~~~~
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
drawPixel proc
mov ah, 0ch
mov cx, x
mov dx, y
mov al, color
int 10h
ret
drawPixel endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
backgroundForMenu proc

mov x,0
mov y,0
mov z,0
mov color, 9

mov ah,00h
mov al,13
int 10h

mov ah, 0Bh
mov bh, 00h
mov bl, color
int 10h

;.WHILE y<200;96
;mov ax,z
;mov x,ax
;   .WHILE x < 320;128
;       call drawPixel
;       inc x 
;   .ENDW
;   inc y
;.ENDW

ret
backgroundForMenu endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

menuText proc


mov columnNo , 10
mov si,0
.WHILE  si<8
mov ah,02 ;interrupt function number  (set cursor)
mov bh,0 ;page number 0
mov dh,13 ;Row number
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number (to write char)

mov al, [MadeByGameString+si] ;Character to be printed  
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,15 ;colour
int 10h  
inc di
inc si
inc columnNo
.ENDW

;************************Ali Arfa************************
mov columnNo ,10
mov si,0
.WHILE  si<8
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,14 ;Row number
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [Ali+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,78 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW



;************************Manahil Karman*****************************
mov columnNo ,10
mov si,0
.WHILE  si<14
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,15 ;Row number
mov dl,columnNo ;column number
int 10h

mov ah, 09h ;interrupt function number
mov al, [Manahil+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,78 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW
;*************************Hiba*****************************************

mov columnNo ,10
;mov di,OFFSET newGameString ; DI = address of newGameString
mov si,0
.WHILE  si<5
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,16 ;Row number
mov dl,columnNo ;column number
int 10h


mov ah, 09h ;interrupt function number
mov al, [Hiba+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,78 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW

;********************************** TO NAVIGATE****************************
mov columnNo ,9
;mov di,OFFSET newGameString ; DI = address of newGameString
mov si,0
.WHILE  si<21
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,18 ;Row number
mov dl,columnNo ;column number
int 10h


mov ah, 09h ;interrupt function number
mov al, [Instruction+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,100 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW
;******************************to display Game NAME DISPLAY **************************************


mov columnNo ,14
mov si,0
.WHILE  si<13
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,3 ;Row number
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [GameName+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,88 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW

;******************************to display 'P','R','E','S','S',' ','E','N','T','E','R'**************************************


mov columnNo ,10
mov si,0
.WHILE  si<11
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,8 ;Row number
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [pressEnterString+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,78 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW

;******************************to display 'T','O',' ','S','T','A','R','T',' ','N','E','W',' ','G','A','M','E'**************************************

mov columnNo ,10 ;starting x-position
mov si,0
.WHILE  si<17
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,7 ;Row number ;;starting y-position
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [toStartNewGameString+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,15 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW

;******************************to display PRESS ESCAPE*************************


mov columnNo ,10 ;starting x-position
mov si,0
.WHILE  si<12
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,11 ;Row number ;;starting y-position
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [pressEscapeString+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,78 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW

;******************************to display TO EXIT *************************

mov columnNo ,10 ;starting x-position
mov si,0
.WHILE  si<7
mov ah,02 ;interrupt function number
mov bh,0 ;page number 0
mov dh,10 ;Row number ;;starting y-position
mov dl,columnNo ;column number
int 10h
mov ah, 09h ;interrupt function number

mov al, [toExitString+si] ;Character to be printed
mov cx,1 ;Number of times
mov bh,0 ;page number
mov bl,15 ;colour
int 10h
inc di
inc si
inc columnNo
.ENDW


ret 
menuText endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


menuBox proc
mov ah, 0ch
mov x,40;84					;starting x-pos
mov y,20					;starting y-pos
mov color,5
	.WHILE y<180
		.WHILE x < 280;94
		 call drawPixel
		 add x,1 
		.ENDW
		mov x,43

	add y,1	
	.ENDW
	

mov x,45;84					;starting x-pos
mov y,22					;starting y-pos
mov color,1
	.WHILE y<177;52
		.WHILE x < 277;8194
		call drawPixel
		add x,1 
		.ENDW
		mov x,45

	add y,1
	.ENDW

ret 
menuBox endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;




menu proc
call backgroundForMenu
call menuBox
call menuText
ret 
menu endp
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~menu~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~




;--------------------------------------------main
main proc
mov AX, @data
mov DS, AX


    mov ah, 0
    mov al, 13h    ;320x200
    int 10h
	mov ah, 0Bh
	mov bh, 00h
	mov bl, 9h
	int 10h

call menu

   mov ah,1h
   int 21h
   cmp al,27; enter key
   je break
   cmp al, 13
    JE a1
    cmp al,48
    ;JE 
    jmp a1
a2:
    call infodisplay
A1:  
    mov ax,2 ; hide
    int 33h
    mov ah, 0
    mov al, 13h    ;320x200
    int 10h
;------------------
    call mousein
    CALL LEVEL1
    CALL MOVBALL
    CALL DRAWBALL
    call drawbar
    call checkcollision
    call delay
    call delay
;-----------------------
    mov ah,1
    int 16h
    cmp al,13
    je break
    JMP a1
break:

mov ah, 4ch
int 21h
main endp
end main
