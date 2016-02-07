;
; Program Name		:	PerfectNum
; Program Version	:	Version 1.0a
; Source File Name	:	perfectnum.asm
; Date Created		:	2015/01/26
; Last modified		:	2015/01/26
; Author			: 	0xEDD1E (codemaster.eddie@gmail.com)
; Description		:	This Program Lists all the perfect numbers between 1
; 						and user given number. 
;
; ==================================================================
; ALGORITHM : PerfectNum
; INPUT	    : Maximum number to check for perfectness (M)
; OUTPUT    : All the perfect numbers (P); P is 1 < P < M
; ==================================================================
;
; Later
; 
;

section .bss            ; UNINITIAZED DATA SECTION [BSS]
	MSTRLEN equ 11      ; Bytes to reserve for Mstr
	Mstr: resb MSTRLEN  ; Reserve 100 bytes for Mstr
	PSTRLEN equ 11      ; Bytes to reserve for Pstr
	Pstr: resb PSTRLEN  ; Reserve 100 bytes for Pstr
; END OF BSS SECTION

section .data                                                   ; INITIALIZED DATA SECTION (DATA)
	PromptMsg: db "Input the maximum number (< 4294967295): "   ; Prompt message for Maximum number
	PROMPTLEN equ $-PromptMsg                                   ; Maximum bytes (digits) to read for Maximum number
	E_NotANumber: db "ERROR: Not A Number", 0AH                 ; Error Message if NaN input
	E_NOTANUMLEN equ $-E_NotANumber                             ; NaN Message length
	newLine db 0AH                                              ; A New Line
	InitMsg: db "Perfect number found in the given range: ", 0AH ; Massege to print before calculations
	InitLen equ $-InitMsg                                       ; InitMsg length
	Arrow: db "---->"
; END OF DATA SECTION

section .text
global _start

_start:
	nop

Prompt:
	mov eax, 4
	mov ebx, 1
	mov ecx, PromptMsg
	mov edx, PROMPTLEN
	int 80H

GetMaxStr:
	mov eax, 3
	mov ebx, 0
	mov ecx, Mstr
	mov edx, MSTRLEN
	int 80H
	
PrintInit:
	pushad
	mov eax, 4
	mov ebx, 1
	mov ecx, InitMsg
	mov edx, InitLen
	int 80H
	popad
; ===================================================================
; block Str2Num(String Mstr, Int Num in EAX)
Str2Num:
	dec eax
	mov esi, eax
	xor eax, eax
	xor ecx, ecx
	xor ebx, ebx

Str2Num_Loop:
	mov bl, byte [Mstr + ecx]
	cmp bl, 30H
	jb ERRNAN
	cmp bl, 39H
	ja ERRNAN
	sub bl, 30H
	mov edi, 0AH
	mul edi
	add eax, ebx
	inc ecx
	cmp ecx, esi
	jne Str2Num_Loop
; ==================================================================
	mov esi, eax
	xor eax, eax
	xor edi, edi
	xor ebx, ebx
PerfectNum_BigStep:
	inc ebx
	cmp ebx, esi
	je Exit
	xor edi, edi
	mov ecx, 1
PerfectNum_LittleStep:
	xor edx, edx
	mov eax, ebx
	cmp ecx, ebx
	je PerfectNum_BigStep_Out
	div ecx
	cmp edx, 0
	jne NextLittleStep
	add edi, ecx
NextLittleStep:
	inc ecx
	jmp PerfectNum_LittleStep

PerfectNum_BigStep_Out:
	cmp edi, ebx
	jne PerfectNum_BigStep
	mov eax, edi
	push esi
	push eax
	push ebx
	push ecx
	push edx
	
; ==================================================================
; This procedure converts a Number into its String representation
; Before Jump onto this block push the Number to the stack
Num2Str:                       ; Parent Block, Child of _start:
	mov edi, 0AH
;  	pop eax
	xor ecx, ecx
	mov edi, 0AH
	
; This Loop generate the character string for the number, but in reverse odrder
Num2Str_Loop:                   ; Child of Num2Str
	xor edx, edx                ; clear EDX at the start. this avoids the SIGFPE
	div edi                     ; DIVide EAX's value by EDI (0AH), QUO->EAX, REM->EDX
	add edx, 30H                ; ADD 30H to value in EDX to produce the ASCII character (30H = 0 <--> 39H = 9)
	mov byte [Pstr + ecx], dl   ; MOV DL into the place indicated by Pstr + ECX
	inc ecx	                    ; INCrease the ECX's value
	cmp eax, 0                  ; check if EAX has become 0, If yes it means the end
	jne Num2Str_Loop            ; If EAX is not 0 jump to Num2Str_Loop

; This 
Num2Str_Reverse:
	xor esi, esi
	xor edi, edi
	mov esi, ecx
	dec esi
;   - cmp esi, 0 
;   - je Print 
	jz Print
	
Num2Str_Reverse_Loop:
	mov cl, byte [Pstr + esi]
	mov dl, byte [Pstr + edi]
	mov byte [Pstr + edi], cl
	mov byte [Pstr + esi], dl
	inc edi
	dec esi
	cmp esi, edi
	ja Num2Str_Reverse_Loop
	
Print:
	mov eax, 4
	mov ebx, 1
	mov ecx, Pstr
	mov edx, 100
	int 80H
	
	mov eax, 4
	mov ebx, 1
	mov ecx, newLine
	mov edx, 1
	int 80H
	
	pop edx
	pop ecx
	pop ebx
	pop eax
	pop esi
	jmp PerfectNum_BigStep
	
	
ERRNAN:
; 	mov eax, 4
; 	mov ebx, 1
; 	mov ecx, E_NotANumber
; 	mov edx, E_NOTANUMLEN
; 	int 80H
	
; 	mov eax, 1
; 	mov ebx, 1
; 	int 80H

Exit:
	mov eax, 1
	mov ebx, 0
	int 80H