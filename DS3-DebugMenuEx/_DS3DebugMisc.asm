EXTERN bClearRenderTargetViewGrey:QWORD

.data
	pSprjFlipper QWORD 144888440h
	greyColor DWORD 3F000000h, 3F000000h, 3F000000h, 3F800000h
	pGetTargetViewSth QWORD 1400CD160h
	D3DClearRenderTargetView QWORD 141912230h
.code

ClearRenderTargetViewGrey PROC
	mov edx, [rsi+0B88h]
	mov rax, [rsi+88h] ;probably wrong
	mov rcx, [rax+rdx*8+0A8h]
	mov rax, [rcx+70h]
	;mov rcx, [rax+0A8h]
	xor edx, edx
	add rcx, 70h
	call qword ptr [rax+8]
	;call pGetTargetViewSth
	cmp byte ptr [rsi+80h], 0
	je dunno
	mov rdi, [rsi+70h]
	jmp dunno2
dunno:
	mov rdi, [rsi+10h]
dunno2:
	mov rcx, [rdi+8]
	lea r9, greyColor
	lea rdx, [rcx+10h]
	mov r8, rax
	call D3DClearRenderTargetView
	mov rcx, [pSprjFlipper]
	mov rcx, [rcx]
	jmp [bClearRenderTargetViewGrey]
ClearRenderTargetViewGrey ENDP

END