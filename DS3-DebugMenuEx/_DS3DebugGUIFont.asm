EXTERN fCreateCompatibleDC:QWORD
EXTERN fDeleteDC:QWORD
EXTERN initThingySuper:QWORD
EXTERN sub_14246B840:QWORD
EXTERN free:QWORD

.data
	numbers DWORD 1, 4, 5, 6
	thing WORD 0, 1, 0, 0, 0, 0, 0, 1
	pGXDeviceMaybe QWORD 14494BFD0h
	initGXTexture2D QWORD 14002AC20h
	pGetDC QWORD 144DA3E00h
	pSelectObject QWORD 144DA3708h
	pDeleteObject QWORD 144DA3700h
	pGetTextMetricsW QWORD 144DA36F8h
	pGetGlyphOutlineW QWORD 144DA36E0h
	pCreateFontW QWORD 144DA36F0h
	dword_14494C0F4 QWORD 14494C0F4h
	qword_14494C100 QWORD 14494C100h
	memset QWORD 141FC3570h
	floatsie DWORD 3F800000h
	__alloca_probe QWORD 141FC5A00h
.code

sub_142F6ADF0 PROC
	mov rax, rsp
	mov [rax+8], rcx
	push rsi
	push rdi
	push r14
	sub rsp, 60h
	mov qword ptr [rax-48h], 0FFFFFFFFFFFFFFFEh
	mov [rax+10h], rbx
	mov [rax+20h], rbp
	mov r14d, r9d
	mov rbp, r8
	mov ebx, edx
	mov rdi, rcx
	test r8, r8
	je loc_142F6AEA4
	lea rsi, [rcx+70h]
	mov rax, [rsi]
	mov rcx, [rax+8]
	mov rdx, rax
	cmp byte ptr [rcx+19h], 0
	jne loc_142F6AE4E
loc_142F6AE37:
	cmp [rcx+20h], ebx
	jnb loc_142F6AE42
	mov rcx, [rcx+10h]
	jmp loc_142F6AE48
loc_142F6AE42:
	mov rdx, rcx
	mov rcx, [rcx]
loc_142F6AE48:
	cmp byte ptr [rcx+19h], 0
	je loc_142F6AE37
loc_142F6AE4E:
	cmp rdx, rax
	je loc_142F6AE60
	cmp ebx, [rdx+20h]
	mov [rsp+90h], rdx
	jnb loc_142F6AE68
loc_142F6AE60:
	mov [rsp+90h], rax
loc_142F6AE68:
	lea rax, [rsp+90h]
	mov rax, [rax]
	cmp rax, [rsi]
	je loc_142F6AEAB
	cmp qword ptr [rax+28h], 0
	je loc_142F6AEAB
loc_142F6AEA4:
	xor al, al
	jmp loc_142F6AFFD
loc_142F6AEAB:
	mov dword ptr [rsp+20h], 11Ah
	mov r8, [rdi+88h]
	mov edx, 8
	lea ecx, [rdx+60h]
	mov rax, 141769A30h
	call rax
	mov [rsp+90h], rax
loc_142F6AED6:
	test rax, rax
	je loc_142F6AEF2
	mov rdx, [rdi+88h]
	mov r8, rdx
	mov rcx, rax
	call sub_14303F450
	mov rdi, rax
	jmp loc_142F6AEF4
loc_142F6AEF2:
	xor edi, edi
loc_142F6AEF4:
	test rdi, rdi
	jne loc_142F6AF1B
loc_142F6AF1B:
	mov r9d, 3;[rsp+0A0h]
	mov r8d, r14d
	mov rdx, rbp
	mov rcx, rdi
	call sub_14303F580
	test al, al
	jne loc_142F6AFD2
	test rdi, rdi
	je loc_142F6AEA4
	mov rcx, rdi
	mov rax, 140E9CA20h
	call rax
	mov rbx, rax
	mov r8, [rdi]
	xor edx, edx
	mov rcx, rdi
	call qword ptr [r8] ;;;;;;;;;;;;CAREFUL, DESTRUCTOR MIGHT NOT BE SET RIGHT
	mov r8, [rbx]
	mov rdx, rdi
	mov rcx, rbx
	call qword ptr [r8+68h]
	xor al, al
	jmp loc_142F6AFFD
loc_142F6AFD2:
	mov [rsp+38h], ebx
	mov [rsp+40h], rdi
	mov eax, 0 ;this is normally reading from a byte, but it's never set afaik, so what gives
	mov byte ptr [rsp+20h], al
	lea r9, [rsp+38h]
	xor r8d, r8d
	lea rdx, [rsp+48h]
	mov rcx, rsi
	;mov rax, 1417D3D50h
	mov rax, 14229CCE0h
	call rax
	mov al, 1
loc_142F6AFFD:
	lea r11, [rsp+60h]
	mov rbx, [r11+28h]
	mov rbp, [r11+38h]
	mov rsp, r11
	pop r14
	pop rdi
	pop rsi
	ret
sub_142F6ADF0 ENDP

sub_14303F450 PROC
	mov [rsp+8], rcx
	push rdi
	sub rsp, 30h
	mov qword ptr [rsp+20h], 0FFFFFFFFFFFFFFFEh
	mov [rsp+50h], rbx
	mov rdi, rdx
	mov rbx, rcx
	lea rax, initThingySuper
	call rax
	mov rax, 143D66C68h
	mov [rbx], rax
	mov [rbx+10h], rdi
	mov [rbx+18h], rdi
	mov rax, [rdi]
	xor r8d, r8d
	lea rdx, [rsp+48h]
	mov rcx, rdi
	call qword ptr [rax+18h]
	mov ecx, [rax]
	shr ecx, 5
	test cl, 1
	jne loc_14303F4B4
	nop
loc_14303F4B4:
	mov [rbx+40h], rdi
	mov qword ptr [rbx+38h], 7
	xor eax, eax
	mov [rbx+30h], rax
	mov [rbx+20h], ax
	mov byte ptr [rbx+48h], 1
	mov qword ptr [rbx+50h], 12h
	mov [rbx+58h], al
	mov [rbx+60h], rax
	mov rax, rbx
	mov rbx, [rsp+50h]
	add rsp, 30h
	pop rdi
	ret
sub_14303F450 ENDP

sub_14303F580 PROC
	push rbp
	push rsi
	push rdi
	push r14
	push r15
	lea rbp, [rsp-37h]
	sub rsp, 0F0h
	mov qword ptr [rbp-41h], 0FFFFFFFFFFFFFFFEh
	mov [rsp+138h], rbx
	mov esi, r9d
	mov r15d, r8d
	mov rdi, rdx
	mov r14, rcx
	mov rax, 14176C360h
	call rax
	mov rbx, rax
	mov rax, [rax]
	xor r8d, r8d
	lea rdx, [rbp-49h]
	mov rcx, rbx
	call qword ptr [rax+18h]
	mov ecx, [rax]
	shr ecx, 5
	test cl, 1
	jne loc_14303F5F3
	nop
loc_14303F5F3:
	mov [rbp+1Fh], rbx
	mov qword ptr [rbp+17h], 7
	xor ebx, ebx
	mov [rbp+0Fh], rbx
	mov word ptr [rbp-1], bx
	mov byte ptr [rbp+27h], 1
	mov r8d, 0C8h
	mov rdx, 143D1A290h
	lea rcx, [rbp-1]
	mov rax, 14007C430h
	call rax
	mov eax, esi
	and eax, 1
	test al, al
	je loc_14303F642
	mov r8d, 312h
	mov rdx, 143D19C60h
	lea rcx, [rbp-1]
	mov rax, 14007C430h
	call rax
loc_14303F642:
	mov eax, esi
	and eax, 2
	test al, al
	je loc_14303F661
	mov r8d, 0BB0h
	mov rdx, 143D1BF00h
	lea rcx, [rbp-1]
	mov rax, 14007C430h
	call rax
loc_14303F661:
	and esi, 4
	test sil, sil
	je loc_14303F67F
	mov r8d, 0D58h
	mov rdx, 143D1A440h
	lea rcx, [rbp-1]
	mov rax, 14007C430h
	call rax
loc_14303F67F:
	xor eax, eax
	mov [rsp+30h], rax
	mov [rsp+38h], rax
	mov [rbp-79h], rax
	mov [rbp-71h], rax
	mov [rbp-69h], rax
	mov [rbp-61h], rax
	mov [rbp-59h], rax
	mov dword ptr [rsp+30h], 200h
	mov dword ptr [rsp+34h], 200h
	mov dword ptr [rsp+38h], 1
	mov dword ptr [rbp-7Dh], 1Ch
	mov dword ptr [rbp-79h], r15d
	mov dword ptr [rbp-75h], 3F800000h
	mov dword ptr [rbp-71h], 3F800000h
	mov eax, [r14+54h]
	mov dword ptr [rbp-6Dh], eax
	movzx eax, byte ptr [r14+58h]
	mov byte ptr [rbp-69h], al
	mov byte ptr [rbp-68h], 0
	mov rax, pGXDeviceMaybe
	mov rax, [rax]
	mov r9, [r14+18h]
	mov r8, [r14+10h]
	mov rdx, [rax]
	lea rcx, [rbp-39h]
	call initGXFontBuilder
	lea r8, [rbp-1]
	cmp qword ptr [rbp+17h], 8
	cmovnb r8, [rbp-1]
	mov r9d, dword ptr [rbp+0Fh]
	add r9d, r9d
	lea rax, [rsp+30h]
	mov [rsp+20h], rax
	mov rdx, rdi
	lea rcx, [rbp-39h]
	call sub_143BB8BA0
	test al, al
	je loc_14303F78D
	mov rdx, [rbp-29h]
	test rdx, rdx
	jne loc_14303F73C
	mov rax, rbx
	jmp loc_14303F74D
loc_14303F73C:
	mov r8, [rbp-11h]
	lea rcx, [rbp-51h]
	lea rax, sub_14246B840
	call rax
	mov rax, [rbp-51h]
loc_14303F74D:
	mov [r14+8], rax
	test rax, rax
	je loc_14303F78D
	mov rax, [rbp-19h]
	mov [r14+60h], rax
	lea rcx, [r14+20h]
	cmp word ptr [rdi], 0
	je loc_14303F77A
	or rbx, 0FFFFFFFFFFFFFFFFh
loc_14303F770:
	inc rbx
	cmp word ptr [rdi+rbx*2], 0
	jne loc_14303F770
loc_14303F77A:
	mov r8, rbx
	mov rdx, rdi
	mov rax, 140003C40h
	call rax
	mov [r14+50h], r15d
	mov bl, 1
	jmp loc_14303F78F
loc_14303F78D:
	xor bl, bl
loc_14303F78F:
	lea rcx, [rbp-39h]
	call unloadGXFontBuilder
	cmp qword ptr [rbp+17h], 8
	jb loc_14303F7AF
	mov rcx, [rbp+1Fh]
	mov r8, [rcx]
	mov rdx, [rbp-1]
	call qword ptr [r8+68h]
loc_14303F7AF:
	movzx eax, bl
	mov rcx, [rbp+2Fh]
	mov rbx, [rsp+138h]
	add rsp, 0F0h
	pop r15
	pop r14
	pop rdi
	pop rsi
	pop rbp
	ret
sub_14303F580 ENDP

sub_143BB8BA0 PROC
	push rbp
	push rbx
	push rsi
	push rdi
	push r12
	push r13
	push r14
	push r15
	lea rbp, [rsp-2298h]
	mov eax, 2398h
	call __alloca_probe
	sub rsp, rax
	cmp qword ptr [rcx+10h], 0
	mov rbx, [rbp+2300h]
	mov esi, r9d
	mov r15, r8
	mov rdi, rdx
	mov r14, rcx
	mov [rbp-78h], r8
	je loc_143BB8BF6
	call  sub_143BB9EF0
loc_143BB8BF6:
	xor r12d, r12d
	test rbx, rbx
	je loc_143BB8C37
	mov rax, [rbx]
	mov [rbp-38h], rax
	mov rax, [rbx+8]
	mov [rbp-30h], rax
	mov rax, [rbx+10h]
	mov [rbp-28h], rax
	mov rax, [rbx+18h]
	mov [rbp-20h], rax
	mov rax, [rbx+20h]
	mov [rbp-18h], rax
	mov rax, [rbx+28h]
	mov [rbp-10h], rax
	mov rax, [rbx+30h]
	mov [rbp-8], rax
	jmp loc_143BB8C68
loc_143BB8C37:
	mov dword ptr [rbp-38h], 100h
	mov dword ptr [rbp-34h], 100h
	mov dword ptr [rbp-28h], 0Ch
	mov dword ptr [rbp-24h], 3F800000h
	mov qword ptr [rbp-20h], 3F800000h
	mov word ptr [rbp-18h], r12w
	mov [rbp-10h], r12
	mov dword ptr [rbp-8], r12d
loc_143BB8C68:
	mov eax, 1
	xor ecx, ecx
	mov dword ptr [rbp-2Ch], 1Ch
	mov dword ptr [rbp-30h], eax
	mov rax, [pGetDC]
	mov rax, [rax]
	call rax
	mov rcx, rax
	call fCreateCompatibleDC
	mov r13, rax
	mov [rsp+70h], rax
	test rax, rax
	jne loc_143BB8CC1
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB8CBA
	nop
loc_143BB8CBA:
	xor al, al
	jmp loc_143BB9D3A
loc_143BB8CC1:
	lea rax, [rbp-80h]
	lea r9, [rsp+78h]
	lea r8, [rbp-38h]
	mov rdx, rdi
	mov rcx, r13
	mov [rsp+78h], r12
	mov qword ptr [rsp+20h], rax
	mov [rbp-80h], r12
	call sub_143BBA090
	test al, al
	jne loc_143BB8D20
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB8D10
	nop
loc_143BB8D10:
	mov rcx, r13
	call fDeleteDC
	xor al, al
	jmp loc_143BB9D3A
loc_143BB8D20:
	mov rax, 14176C360h
	call rax
	lea rdx, [rbp-48h]
	xor r8d, r8d
	mov rbx, rax
	mov rax, [rax]
	mov rcx, rbx
	call qword ptr [rax+18h]
	mov ecx, [rax]
	shr ecx, 5
	test cl, 1
	je loc_143BB9D5D
	lea rcx, [rbp+18h]
	mov [rbp+18h], r12
	mov [rbp+20h], r12
	mov [rbp+28h], rbx
	mov rax, 1402E8F70h
;COULD BE WRONG
	call rax
	mov [rbp+18h], rax
	mov eax, dword ptr [rbp-8]
	test eax, eax
	je loc_143BB8DBF
	mov rbx, [rbp-10h]
	mov edi, eax
loc_143BB8D70:
	mov rax, [rbx]
	lea rcx, [rbp+8]
	mov [rbp+8], rax
	call sub_143BBA520
	lea rdx, [rbp+0B0h]
	lea rcx, [rbp+18h]
	mov [rbp+0B8h], rbx
	mov dword ptr [rbp+0B0h], eax
	mov rax, 14007D180h
	call rax
	lea rdx, [rbp+58h]
	lea rcx, [rbp+18h]
	lea r9, [rax+20h]
	xor r8d, r8d
	mov qword ptr [rsp+20h], rax
	mov rax, 14007D1D0h
	call rax
	add rbx, 28h
	dec rdi
	jne loc_143BB8D70
loc_143BB8DBF:
	movaps xmmword ptr [rsp+2380h], xmm6
	movaps xmmword ptr [rsp+2370h], xmm7
	test sil, 1
	je loc_143BB8E12
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB9220
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB9220
	mov rcx, r13
	call fDeleteDC
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB8E12:
	mov ebx, esi
	shr ebx, 1
	mov edx, ebx
	mov rcx, [r14+30h]
	shl rdx, 2
	mov rax, [rcx]
	call qword ptr [rax+48h]
	mov rdi, rax
	mov [rbp+8], rax
	test rax, rax
	jne loc_143BB8EB3
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB9208
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB9208
	jmp loc_143BB9208
loc_143BB8EB3:
	lea rcx, [rbp+264h]
	xor edx, edx
	mov r8d, 1FFCh
	mov [rbp+260h], r12d
	call memset
	mov r12, rdi
	test esi, esi
	je loc_143BB8F1E
loc_143BB8ED5:
	lea rcx, [rbp-78h]
	call sub_143BBA520
	cmp eax, 20h
	jb loc_143BB8F14
	mov edx, eax
	mov ecx, eax
	mov r8d, 1
	and ecx, 1Fh
	shr edx, 5
	shl r8d, cl
	mov ecx, [rbp+rdx*4+260h]
	test r8d, ecx
	jne loc_143BB8F14
	or ecx, r8d
	mov [r12], eax
	add r12, 4
	mov [rbp+rdx*4+260h], ecx
loc_143BB8F14:
	mov eax, dword ptr [rbp-78h]
	sub eax, r15d
	cmp eax, esi
	jb loc_143BB8ED5
loc_143BB8F1E:
	sub r12d, edi
	shr r12d, 2
	test r12d, r12d
	jne loc_143BB8FD7
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB8F53
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB8F53
loc_143BB8F53:
loc_143BB8F90:
	mov rdx, rdi
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	mov rdx, [rbp-80h]
	mov rcx, r13
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov rcx, [rsp+78h]
	mov rax, [pDeleteObject]
	mov rax, [rax]
	call rax
	mov rcx, r13
	call fDeleteDC
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB8FD7:
	lea rdx, [rdi+r12*4]
	mov rcx, rdi
	mov ebx, r12d
	mov r8, rdx
	sub r8, rdi
	sar r8, 2
	mov rax, 1403A55A0h
	call rax
	lea eax, [r12+1]
	shl eax, 5
	mov [r14+18h], eax
	mov r8d, 10h
	mov rcx, [r14+28h]
	mov edx, [r14+18h]
	mov rax, [rcx]
	call qword ptr [rax+50h]
	mov rsi, rax
	mov [rbp-60h], rax
	mov [r14+10h], rax
	test rax, rax
	jne loc_143BB9115
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB9098
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB9098
loc_143BB9098:
loc_143BB90D5:
	mov rcx, [r14+30h]
	mov rax, [rcx]
	mov rdx, rdi
	call qword ptr [rax+68h]
	mov rdx, [rbp-80h]
	mov rcx, r13
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov rcx, [rsp+78h]
	mov rax, [pDeleteObject]
	mov rax, [rax]
	call rax
	mov rcx, r13
	call fDeleteDC
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB9115:
	mov dword ptr [rax], 20000h
	mov eax, [r14+18h]
	lea rdx, [rbp+120h]
	mov [rsi+4], eax
	movzx eax, word ptr [rbp-28h]
	mov rcx, r13
	mov [rsi+8], ax
	movzx eax, word ptr [rbp-38h]
	mov [rsi+0Eh], r12w
	mov [rsi+0Ah], ax
	movzx eax, word ptr [rbp-34h]
	mov [rsi+10h], r12d
	mov [rsi+0Ch], ax
	lea eax, [r12*8+20h]
	mov dword ptr [rsi+14h], 20h
	mov [rsi+18h], eax
	lea rax, [rsi+20h]
	mov dword ptr [rsi+1Ch], 4
	mov [rbp+10h], rax
	lea rax, [rax+r12*8]
	xor r15d, r15d
	mov [rbp-78h], rax
	mov rax, [pGetTextMetricsW]
	mov rax, [rax]
	call rax
	test eax, eax
	jne loc_143BB9230
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB91AC
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB91AC
loc_143BB91AC:
loc_143BB91E9:
	mov rdx, rdi
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
loc_143BB9208:
	mov rdx, [rbp-80h]
	mov rcx, r13
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov rcx, [rsp+78h]
	mov rax, [pDeleteObject]
	mov rax, [rax]
	call rax
loc_143BB9220:
	mov rcx, r13
	call fDeleteDC
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB9230:
	mov edx, [rbp+120h]
	movsxd rax, dword ptr [rbp-1Ch]
	lea rcx, numbers
	mov eax, [rcx+rax*4]
	mov [rbp-48h], edx
	mov [rsp+60h], eax
	movsx eax, dx
	mov [rsp+54h], r15d
	mov ebx, eax
	mov [rsp+58h], r15d
	mov [rbp+38h], rdi
	mov [rsp+64h], eax
	imul ebx, [rbp+138h]
	mov [rbp-58h], ebx
loc_143BB92A9:
	mov edx, ebx
	mov rcx, [r14+30h]
	mov r8d, 4
	mov rax, [rcx]
	call qword ptr [rax+50h]
	mov [rsp+5Ch], r15d
	mov ebx, r15d
	mov r15d, dword ptr [rbp-34h]
	lea rdi, [rbp+70h]
	mov [rbp-50h], rax
loc_143BB92E1:
loc_143BB931E:
	mov rdx, r15
	mov eax, dword ptr [rbp-38h]
	mov rcx, [r14+30h]
	mov r9, [rcx]
	imul rdx, rax
	mov r8d, 4
	shl rdx, 2
	call qword ptr [r9+50h]
	inc ebx
	add rdi, 8
	mov [rdi-8], rax
	cmp ebx, 8
	jb loc_143BB92E1
	mov eax, dword ptr [rbp-38h]
	mov rcx, [rbp+70h]
	xor edx, edx
	lea ebx, [rax*4]
	mov [rbp+40h], rcx
	mov r8d, ebx
	mov [rsp+50h], ebx
	imul r8d, r15d
	call memset
	xor r10d, r10d
	mov [rbp-68h], r10d
	test r12d, r12d
	je loc_143BB983F
	movss xmm6, dword ptr [rbp-20h]
	movss xmm7, dword ptr [rbp-24h]
	mov [rsp+68h], r10d
loc_143BB93A1:
	mov rax, [rbp+38h]
	mov rdx, [rbp+18h]
	mov rbx, r10
	mov r13d, [rax]
	add rax, 4
	lea r8, thing
	mov [rbp+38h], rax
	mov rax, [rdx+8]
	mov [rbp+48h], rbx
	cmp byte ptr [rax+19h], 0
	mov rcx, rdx
	jne loc_143BB93FD
loc_143BB93D0:
	cmp [rax+20h], r13d
	jnb loc_143BB93DC
	mov rax, [rax+10h]
	jmp loc_143BB93E2
loc_143BB93DC:
	mov rcx, rax
	mov rax, [rax]
loc_143BB93E2:
	cmp byte ptr [rax+19h], 0
	je loc_143BB93D0
	cmp rcx, rdx
	je loc_143BB93FD
	cmp r13d, [rcx+20h]
	jb loc_143BB93FD
	mov [rbp+50h], rcx
	lea rax, [rbp+50h]
	jmp loc_143BB9405
loc_143BB93FD:
	mov [rbp+58h], rdx
	lea rax, [rbp+58h]
loc_143BB9405:
	mov rax, [rax]
	cmp rax, rdx
	je loc_143BB9415
	mov rbx, [rax+28h]
	mov [rbp+48h], rbx
loc_143BB9415:
	mov edi, r10d
	mov r15d, r15d
	test rbx, rbx
	je loc_143BB954A
	mov rcx, [rbx+8]
	mov rax, [rcx]
	call qword ptr [rax+30h]
	cmp eax, 1Ch
	jne loc_143BB9991
	mov rax, [rbx+20h]
	mov r11d, [rsp+64h]
	mov rcx, [rbx+18h]
	movd xmm4, r11d
	mov qword ptr [rbp+0B0h], 0
	mov dword ptr [rbp+0B8h], 3F800000h
	mov dword ptr [rbp+0BCh], 3F800000h
	cvtdq2ps xmm4, xmm4
	test rax, rax
	lea rdx, [rbp+0B0h]
	cmovne rdx, rax
	test rcx, rcx
	cmove rcx, rdx
	movss xmm0, dword ptr [rdx+0Ch]
	subss xmm0, dword ptr [rdx+4]
	movss xmm2, dword ptr [rcx]
	movss xmm1, dword ptr [rcx+8]
	divss xmm4, xmm0
	movaps xmm0, xmm2
	subss xmm1, xmm2
	movaps xmm5, xmm4
	mulss xmm5, xmm7
	divss xmm5, xmm6
	mulss xmm0, xmm5
	mulss xmm1, xmm5
	cvttss2si r8d, xmm0
	cvttss2si esi, xmm1
	movss xmm1, dword ptr [rdx+8]
	movaps xmm0, xmm4
	mulss xmm0, dword ptr [rcx+4]
	movsx eax, r8w
	mov [rbp-40h], r8d
	subss xmm1, dword ptr [rdx]
	cvttss2si r9d, xmm0
	movss xmm0, dword ptr [rcx+0Ch]
	mulss xmm1, xmm5
	mov [rbp-70h], r9d
	subss xmm0, dword ptr [rcx+4]
	cvttss2si edx, xmm1
	movsx ecx, si
	add ecx, eax
	mulss xmm0, xmm4
	movsx eax, dx
	mov [rbp-6Ch], edx
	cvttss2si r10d, xmm0
	mov [rbp-44h], r10d
	cmp ecx, eax
	jg loc_143BB951D
	movsx ecx, r10w
	movsx eax, r9w
	add ecx, eax
	cmp ecx, r11d
	jle loc_143BB9675
loc_143BB951D:
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB99DF
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB99DF
loc_143BB954A:
	mov rcx, [rsp+70h]
	mov [rsp+30h], r8
	mov r8d, [rsp+60h]
	mov [rsp+28h], r10
	lea r9, [rbp+0D8h]
	mov edx, r13d
	mov [rsp+20h], r10d
	mov rax, [pGetGlyphOutlineW]
	mov rax, [rax]
	call rax
	mov edi, eax
	cmp eax, 0FFFFFFFFh
	je loc_143BB9A22
	movzx ecx, word ptr [rbp+124h]
	movzx eax, word ptr [rbp+0E0h]
	movzx edx, word ptr [rbp+0E8h]
	sub cx, word ptr [rbp+0E4h]
	mov [rbp-40h], eax
	mov eax, [rbp+0D8h]
	mov word ptr [rbp-70h], cx
	mov ecx, [rbp+0DCh]
	xor r15d, r15d
	movzx esi, ax
	mov [rbp-6Ch], edx
	mov word ptr [rbp-44h], cx
	test edi, edi
	je loc_143BB9610
	cmp dword ptr [rsp+60h], 1
	mov ebx, 8
	mov edx, 1
	cmove ebx, edx
	imul ebx, eax
	add ebx, 1Fh
	shr ebx, 3
	and ebx, 1FFFFFFCh
	imul ebx, ecx
	cmp ebx, edi
	je loc_143BB9610
	jb loc_143BB960A
loc_143BB960A:
	mov r15d, edi
	sub r15d, ebx
loc_143BB9610:
	cmp [rbp-58h], edi
	jnb loc_143BB9670
	mov [rbp-58h], edi
	mov rdx, [rbp-50h]
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	mov rdx, rdi
	mov r8d, 4
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+50h]
	mov [rbp-50h], rax 
loc_143BB9670:
	mov r11d, [rsp+64h]
loc_143BB9675:
	mov r8d, [rsp+54h]
	mov ecx, [rsp+58h]
	movsx ebx, si
	lea eax, [r8+rbx]
	cmp eax, dword ptr [rbp-38h]
	jbe loc_143BB96A0
	inc ecx
	add ecx, r11d
	xor r10d, r10d
	mov r8d, r10d
	mov [rsp+54h], r10d
	mov [rsp+58h], ecx
	jmp loc_143BB96A3
loc_143BB96A0:
	xor r10d, r10d
loc_143BB96A3:
	mov edx, dword ptr [rbp-34h]
	lea eax, [r11+rcx]
	cmp eax, edx
	jb loc_143BB96E3
	mov eax, [rsp+5Ch]
	mov r8d, [rsp+50h]
	inc eax
	mov [rsp+5Ch], eax
	imul r8d, edx
	mov rcx, [rbp+rax*8+70h]
	xor edx, edx
	mov [rbp+40h], rcx
	call memset
	xor r10d, r10d
	mov ecx, r10d
	mov r8d, r10d
	mov [rsp+54h], r10d
	mov [rsp+58h], ecx
loc_143BB96E3:
	mov rdx, [rbp-78h]
	mov r9, [rbp+10h]
	lea eax, [rsi+r8]
	mov [r9+4], ax
	mov [r9+2], cx
	mov [r9], r8w
	movzx eax, cx
	mov ecx, [rsp+68h]
	add ax, word ptr [rbp-48h]
	mov [r9+6], ax
	mov rax, [rbp-60h]
	mov [rdx], r13d
	mov eax, [rax+14h]
	mov [rdx+0Ch], si
	mov qword ptr [rdx+10h], 0
	add ecx, eax
	mov eax, [rsp+5Ch]
	mov [rdx+8], ax
	mov eax, [rbp-6Ch]
	mov [rdx+4], ecx
	mov ecx, [rbp-40h]
	sub ax, cx
	mov [rdx+0Ah], cx
	mov [rdx+0Eh], ax
	cmp ax, si
	jge loc_143BB974A
	mov [rdx+0Eh], si
loc_143BB974A:
	test cx, cx
	jns loc_143BB9754
	mov [rdx+0Ah], r10w
loc_143BB9754:
	cmp qword ptr [rbp+48h], 0
	jne loc_143BB97FA
	test edi, edi
	je loc_143BB97FA
	mov rsi, [rbp-50h]
	lea rax, thing
	mov edx, r13d
	mov r13, [rsp+70h]
	mov [rsp+30h], rax
	mov [rsp+28h], rsi
	mov [rsp+20h], edi
	mov edi, [rsp+60h]
	lea r9, [rbp+0C0h]
	mov r8d, edi
	mov rcx, r13
	mov rax, [pGetGlyphOutlineW]
	mov rax, [rax]
	call rax
	cmp eax, 0FFFFFFFFh
	je loc_143BB99FB
	movsx ecx, word ptr [rbp-44h]
	movsx eax, word ptr [rbp-70h]
	mov r8d, [rsp+50h]
	add eax, [rsp+58h]
	mov [rsp+40h], r8d
	mov r8, [rbp+40h]
	mov [rsp+38h], eax
	mov eax, [rsp+54h]
	mov r9d, r15d
	mov dword ptr [rsp+30h], eax
	mov dword ptr [rsp+28h], ecx
	add r9, rsi
	mov ecx, 1Ch
	mov edx, edi
	mov [rsp+20h], ebx
	call sub_143BBA260
	mov rdx, [rbp-78h]
	mov r8d, [rsp+54h]
	mov r9, [rbp+10h]
	xor r10d, r10d
	jmp loc_143BB97FF
loc_143BB97FA:
	mov r13, [rsp+70h]
loc_143BB97FF:
	add dword ptr [rsp+68h], 8
	inc r8d
	add r9, 8
	add r8d, ebx
	add rdx, 18h
	mov [rbp+10h], r9
	mov [rsp+54h], r8d
	mov r8d, [rbp-68h]
	mov [rbp-78h], rdx
	inc r8d
	mov [rbp-68h], r8d
	cmp r8d, r12d
	jb loc_143BB93A1
	mov rsi, [rbp-60h]
	mov r15d, dword ptr [rbp-34h]
	mov ebx, [rsp+50h]
loc_143BB983F:
	mov r12b, 1
loc_143BB9842:
	mov edi, [rsp+5Ch]
	mov [rbp], r10
	inc edi
	je loc_143BB987A
	lea rcx, [rbp+168h]
	lea rdx, [rbp+70h]
	mov r8d, edi
loc_143BB9860:
	mov rax, [rdx]
	mov [rcx], ebx
	mov [rcx+4], r10d
	mov [rcx-8], rax
	lea rcx, [rcx+10h]
	lea rdx, [rdx+8]
	dec r8
	jne loc_143BB9860
loc_143BB987A:
	mov eax, dword ptr [rbp-38h]
	mov ebx, dword ptr [rbp-30h]
	mov rcx, [pGXDeviceMaybe]
	mov rcx, [rcx]
	mov [rbp+0F0h], eax
	mov eax, r10d
	mov [rsp+30h], r10
	mov [rbp+0FCh], edi
	mov dword ptr [rbp+100h], 1Ch
	mov [rbp+0F4h], r15d
	mov [rbp+0F8h], ebx
	mov qword ptr [rbp+104h], 1
	mov [rbp+10Ch], r10d
	mov qword ptr [rbp+110h], 8
	mov [rsp+28h], r10
	cmp ebx, 1
	setne al
	lea r9, [rbp+160h]
	lea r8, [rbp+0F0h]
	mov [rbp+118h], eax
	mov rax, [r14+28h]
	mov rcx, [rcx]
	lea rdx, [rbp]
	mov qword ptr [rsp+20h], rax
	mov rax, 141917700h
	call rax
	mov rcx, [pGXDeviceMaybe]
	mov rcx, [rcx]
	mov rax, [r14+28h]
	mov r8, [rbp]
	xor r15d, r15d
	mov dword ptr [rbp+0C0h], 1Ch
	mov [rbp+30h], r15
	mov qword ptr [rbp+0C4h], 5
	mov [rbp+0D4h], edi
	mov dword ptr [rbp+0D0h], r15d
	mov [rbp+0CCh], ebx
	mov rcx, [rcx]
	lea r9, [rbp+0C0h]
	lea rdx, [rbp+30h]
	mov qword ptr [rsp+20h], rax
	mov rax, 141917B40h
	call rax
	mov r8, [r14+28h]
	lea edx, [r15+10h]
	lea ecx, [rdx+60h]
	mov dword ptr [rsp+20h], 24Fh
	mov rax, 141769A30h
	call rax
	test rax, rax
	je loc_143BB9B7F
	mov rcx, rax
	call initGXTexture2D
	mov rbx, rax
	jmp loc_143BB9B82
loc_143BB9991:
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB99DF
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB99C5
loc_143BB99C5:
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB99DF
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB99DF
loc_143BB99DF:
	mov r13, [rsp+70h]
loc_143BB99E4:
	mov rsi, [rbp-60h]
	mov r15d, dword ptr [rbp-34h]
	mov ebx, [rsp+50h]
	xor r12b, r12b
	xor r10d, r10d
	jmp loc_143BB9842
loc_143BB99FB:
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB99E4
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB99E4
loc_143BB9A22:
	mov rax, dword_14494C0F4
	cmp dword ptr [rax], 0Ch
	jle loc_143BB9A47
	mov rax, qword_14494C100
	mov rax, [rax]
	mov rcx, [rax+60h]
	test rcx, rcx
	je loc_143BB9A47
loc_143BB9A47:
	xor r15d, r15d
	lea rbx, [rbp+70h]
	mov edi, r15d
loc_143BB9A51:
	mov rsi, [rbx]
	test rsi, rsi
	je loc_143BB9ABA
loc_143BB9A96:
	mov rdx, rsi
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	mov [rbx], r15
	jmp loc_143BB9AC1
loc_143BB9ABA:
loc_143BB9AC1:
	inc edi
	add rbx, 8
	cmp edi, 8
	jb loc_143BB9A51
loc_143BB9B09:
	mov rdx, [rbp-50h]
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
loc_143BB9B5F:
	mov rdx, [rbp+8]
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB9B7F:
	mov rbx, r15
loc_143BB9B82:
	mov rax, [rbx]
	mov r8, [rbp+30h]
	mov rdx, [rbp]
	mov rcx, rbx
	call qword ptr [rax+0A8h]
	mov rcx, [rbp]
	call sub_140A5A430
	mov [r14+20h], rbx
	mov [rsi+1Eh], di
	mov edi, r15d
	lea rbx, [rbp+70h]
loc_143BB9BB0:
	mov rsi, [rbx]
	test rsi, rsi
	je loc_143BB9C17
loc_143BB9BF5:
	mov rdx, rsi
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	mov [rbx], r15
loc_143BB9C17:
	inc edi
	add rbx, 8
	cmp edi, 8
	jb loc_143BB9BB0
loc_143BB9C5F:
	mov rdx, [rbp-50h]
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
loc_143BB9CBC:
	mov rdx, [rbp+8]
	mov rcx, [r14+30h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
	mov rdx, [rbp-80h]
	mov rcx, r13
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov rcx, [rsp+78h]
	mov rax, [pDeleteObject]
	mov rax, [rax]
	call rax
	mov rcx, r13
	call fDeleteDC
	test r12b, r12b
	jne loc_143BB9CFF
	xor bl, bl
	jmp loc_143BB9D01
loc_143BB9CFF:
	mov bl, 1
loc_143BB9D01:
	mov r8, [rbp+18h]
	lea rdx, [rbp+58h]
	lea rcx, [rbp+18h]
	mov r9, r8
	mov r8, [r8]
	mov rax, 1402F0150h
	call rax
	mov rcx, [rbp+28h]
	mov rdx, [rbp+18h]
	mov r8, [rcx]
	call qword ptr [r8+68h]
	movaps xmm6, xmmword ptr [rsp+2380h]
	movaps xmm7, xmmword ptr [rsp+2370h]
	movzx eax, bl
loc_143BB9D3A:
	mov rcx, [rbp+2260h]
	add rsp, 2398h
	pop r15
	pop r14
	pop r13
	pop r12
	pop rdi
	pop rsi
	pop rbx
	pop rbp
	ret
loc_143BB9D5D:
	int 3
sub_143BB8BA0 ENDP

sub_143BB9EF0 PROC
	push rbx
	sub rsp, 20h
	cmp qword ptr [rcx+10h], 0
	mov rbx, rcx
	je loc_143BB9F59
	mov rcx, [rbx+28h]
	mov rdx, [rbx+10h]
	mov rax, [rcx]
	call qword ptr [rax+68h]
loc_143BB9F59:
	xor eax, eax
	mov [rbx+10h], rax
	mov [rbx+18h], eax
	mov [rbx+20h], rax
	add rsp, 20h
	pop rbx
	ret
sub_143BB9EF0 ENDP

sub_143BBA090 PROC
	push rbx
	push rbp
	push rsi
	push rdi
	push r12
	push r13
	push r14
	push r15
	sub rsp, 0C8h
	cmp byte ptr [r8+20h], 0
	mov r14d, [r8+10h]
	movzx r13d, byte ptr [r8+21h]
	mov rsi, [rsp+130h]
	mov [rsp+68h], rdx
	mov dword ptr [rsp+60h], 2
	mov dword ptr [rsp+58h], 2
	mov eax, 2BCh
	mov r15, r9
	mov rbx, r8
	mov r12, rdx
	mov rdi, rcx
	mov ebp, 190h
	cmovne ebp, eax
	xor eax, eax
	neg r14d
	mov [rsp+50h], eax
	mov [rsp+48h], eax
	mov dword ptr [rsp+40h], 1
	mov [rsp+38h], eax
	mov [rsp+30h], eax
	xor r9d, r9d
	xor r8d, r8d
	xor edx, edx
	mov ecx, r14d
	mov [rsp+28h], r13d
	mov [rsp+20h], ebp
	mov rax, [pCreateFontW]
	mov rax, [rax]
	call rax
	mov [r15], rax
	test rax, rax
	jne loc_143BBA140
loc_143BBA139:
	xor al, al
	jmp loc_143BBA21D
loc_143BBA140:
	mov rdx, rax
	mov rcx, rdi
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov [rsi], rax
	movss xmm1, floatsie
	movss xmm0, dword ptr [rbx+14h]
	ucomiss xmm0, xmm1
	jp loc_143BBA173
	jne loc_143BBA173
	movss xmm0, dword ptr [rbx+18h]
	ucomiss xmm0, xmm1
	jp loc_143BBA173
	je loc_143BBA21B
loc_143BBA173:
	mov rdx, rax
	mov rcx, rdi
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov rcx, [r15]
	mov rax, [pDeleteObject]
	mov rax, [rax]
	call rax
	lea rdx, [rsp+70h]
	mov rcx, rdi
	mov rax, [pGetTextMetricsW]
	mov rax, [rax]
	call rax
	mov [rsp+68h], r12
	mov dword ptr [rsp+60h], 2
	movd xmm0, r14d
	mov dword ptr [rsp+58h], 2
	xor eax, eax
	xor r9d, r9d
	cvtdq2ps xmm0, xmm0
	mov [rsp+50h], eax
	mov [rsp+48h], eax
	mov dword ptr [rsp+40h], 1
	mulss xmm0, dword ptr [rbx+18h]
	cvttss2si ecx, xmm0
	movd xmm0, dword ptr [rsp+84h]
	mov [rsp+38h], eax
	mov [rsp+30h], eax
	xor r8d, r8d
	cvtdq2ps xmm0, xmm0
	mov [rsp+28h], r13d
	mov [rsp+20h], ebp
	mulss xmm0, dword ptr [rbx+14h]
	cvttss2si edx, xmm0
	mov rax, [pCreateFontW]
	mov rax, [rax]
	call rax
	mov [r15], rax
	test rax, rax
	je loc_143BBA139
	mov rdx, rax
	mov rcx, rdi
	mov rax, [pSelectObject]
	mov rax, [rax]
	call rax
	mov [rsi], rax
loc_143BBA21B:
	mov al, 1
loc_143BBA21D:
	add rsp, 0C8h
	pop r15
	pop r14
	pop r13
	pop r12
	pop rdi
	pop rsi
	pop rbp
	pop rbx
	ret
sub_143BBA090 ENDP

sub_143BBA520 PROC
	push rdi
	sub rsp, 20h
	mov rdi, rcx
	mov rax, [rdi]
	mov r8d, 7FFh
	movzx ecx, word ptr [rax]
	lea rdx, [rax+2]
	mov eax, 2800h
	add eax, ecx
	mov [rdi], rdx
	cmp ax, r8w
	ja loc_143BBA5F1
	mov eax, 0DBFFh
	mov [rsp+30h], rbx
	mov [rsp+38h], rsi
	cmp cx, ax
	ja loc_143BBA5A9
	movzx esi, word ptr [rdx]
	movzx ebx, cx
	shl ebx, 10h
	jmp loc_143BBA5D9
loc_143BBA5A9:
	movzx ebx, word ptr [rdx]
	movzx esi, cx
	shl ebx, 10h
loc_143BBA5D9:
	add qword ptr [rdi], 2
	or esi, ebx
	mov rbx, [rsp+30h]
	mov eax, esi
	mov rsi, [rsp+38h]
	add rsp, 20h
	pop rdi
	ret
loc_143BBA5F1:
	movzx eax, cx
	add rsp, 20h
	pop rdi
	ret
sub_143BBA520 ENDP

sub_143BBA260 PROC
	sub rsp, 48h
	mov r10, r9
	mov r11, r8
	cmp ecx, 1Ch
	je loc_143BBA38A
	lea eax, [rcx-3Dh]
	test eax, 0FFFFFFFBh
	jne loc_143BBA48E
	dec edx
	je loc_143BBA34F
	sub edx, 3
	je loc_143BBA314
	dec edx
	je loc_143BBA2D9
	dec edx
	jne loc_143BBA48E
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7E20
	add rsp, 48h
	ret
loc_143BBA2D9:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7DB0
	add rsp, 48h
	ret
loc_143BBA314:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7D40
	add rsp, 48h
	ret
loc_143BBA34F:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7E90
	add rsp, 48h
	ret
loc_143BBA38A:
	dec edx
	je loc_143BBA458
	sub edx, 3
	je loc_143BBA41D
	dec edx
	je loc_143BBA3E2
	dec edx
	jne loc_143BBA48E
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7C00
	add rsp, 48h
	ret
loc_143BBA3E2:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7B80
	add rsp, 48h
	ret
loc_143BBA41D:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7B00
	add rsp, 48h
	ret
loc_143BBA458:
	mov eax, [rsp+90h]
	mov r9d, [rsp+78h]
	mov r8d, [rsp+70h]
	mov [rsp+30h], eax
	mov eax, [rsp+88h]
	mov rdx, r10
	mov [rsp+28h], eax
	mov eax, [rsp+80h]
	mov rcx, r11
	mov [rsp+20h], eax
	call sub_143BB7C80
loc_143BBA48E:
	add rsp, 48h
	ret
sub_143BBA260 ENDP

sub_143BB7E20 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+30h]
	mov ebx, [rsp+38h]
	mov r11d, r8d
	sub ebx, r8d
	lea r8d, [r11+3]
	imul eax, [rsp+38h]
	add eax, [rsp+28h]
	and r8d, 0FFFFFFFCh
	add rcx, rax
	sub r8d, r11d
	test r9d, r9d
	je loc_143BB7E85
	mov r10d, ebx
	mov r9d, r9d
	mov ebx, r8d
loc_143BB7E58:
	test r11d, r11d
	je loc_143BB7E7A
	mov r8, r11
loc_143BB7E60:
	movzx eax, byte ptr [rdx]
	inc rcx
	inc rdx
	imul eax, 0FFh
	shr eax, 6
	mov [rcx-1], al
	dec r8
	jne loc_143BB7E60
loc_143BB7E7A:
	add rcx, r10
	add rdx, rbx
	dec r9
	jne loc_143BB7E58
loc_143BB7E85:
	mov rbx, [rsp+8]
	ret
sub_143BB7E20 ENDP

sub_143BB7DB0 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+30h]
	mov ebx, [rsp+38h]
	mov r11d, r8d
	sub ebx, r8d
	lea r8d, [r11+3]
	imul eax, [rsp+38h]
	add eax, [rsp+28h]
	and r8d, 0FFFFFFFCh
	add rcx, rax
	sub r8d, r11d
	test r9d, r9d
	je loc_143BB7E15
	mov r10d, ebx
	mov r9d, r9d
	mov ebx, r8d
loc_143BB7DE8:
	test r11d, r11d
	je loc_143BB7E0A
	mov r8, r11
loc_143BB7DF0:
	movzx eax, byte ptr [rdx]
	inc rcx
	inc rdx
	imul eax, 0FFh
	shr eax, 4
	mov [rcx-1], al
	dec r8
	jne loc_143BB7DF0
loc_143BB7E0A:
	add rcx, r10
	add rdx, rbx
	dec r9
	jne loc_143BB7DE8
loc_143BB7E15:
	mov rbx, [rsp+8]
	ret
sub_143BB7DB0 ENDP

sub_143BB7D40 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+30h]
	mov ebx, [rsp+38h]
	mov r11d, r8d
	sub ebx, r8d
	lea r8d, [r11+3]
	imul eax, [rsp+38h]
	add eax, [rsp+28h]
	and r8d, 0FFFFFFFCh
	add rcx, rax
	sub r8d, r11d
	test r9d, r9d
	je loc_143BB7DA5
	mov r10d, ebx
	mov r9d, r9d
	mov ebx, r8d
loc_143BB7D78:
	test r11d, r11d
	je loc_143BB7D9A
	mov r8, r11
loc_143BB7D80:
	movzx eax, byte ptr [rdx]
	inc rcx
	inc rdx
	imul eax, 0FFh
	shr eax, 2
	mov [rcx-1], al
	dec r8
	jne loc_143BB7D80
loc_143BB7D9A:
	add rcx, r10
	add rdx, rbx
	dec r9
	jne loc_143BB7D78
loc_143BB7DA5:
	mov rbx, [rsp+8]
	ret
sub_143BB7D40 ENDP

sub_143BB7E90 PROC
	push rbx
	mov r11, rcx
	mov ebx, r8d
	mov r8d, [rsp+40h]
	mov eax, ebx
	lea ecx, [rbx+7]
	sub r8d, ebx
	shr eax, 3
	shr ecx, 3
	add ecx, 3
	and ecx, 0FFFFFFFCh
	sub ecx, eax
	mov eax, [rsp+38h]
	imul eax, [rsp+40h]
	add eax, [rsp+30h]
	add r11, rax
	test r9d, r9d
	je loc_143BB7F15
loc_143BB7EC8:
	mov [rsp+10h], rdi
	mov r10d, r8d
	mov r9d, r9d
	mov edi, ecx
loc_143BB7ED5:
	mov cl, 7
	test ebx, ebx
	je loc_143BB7F05
	mov r8, rbx
	xchg ax, ax
loc_143BB7EE0:
	movzx eax, byte ptr [rdx]
	inc r11
	shr al, cl
	add cl, 0FFh
	and al, 1
	neg al
	mov [r11-1], al
	movzx eax, cl
	and cl, 7
	shr rax, 7
	add rdx, rax
	dec r8
	jne loc_143BB7EE0
loc_143BB7F05:
	add r11, r10
	add rdx, rdi
	dec r9
	jne loc_143BB7ED5
	mov rdi, [rsp+10h]
loc_143BB7F15:
	pop rbx
	ret
sub_143BB7E90 ENDP

sub_143BB7C00 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+38h]
	mov r10d, r8d
	mov r11d, eax
	lea ebx, [r10+3]
	shr r11d, 2
	and ebx, 0FFFFFFFCh
	sub r11d, r8d
	sub ebx, r8d
	mov r8d, eax
	mov eax, [rsp+30h]
	shr r8, 2
	imul r8, rax
	mov eax, [rsp+28h]
	add r8, rax
	lea rax, [rcx+r8*4]
	test r9d, r9d
	je loc_143BB7C79
	shl r11, 2
	mov r9d, r9d
loc_143BB7C46:
	test r10d, r10d
	je loc_143BB7C6E
	mov r8, r10
	xchg ax, ax
loc_143BB7C50:
	movzx ecx, byte ptr [rdx]
	add rax, 4
	inc rdx
	imul ecx, 3FC0000h
	or ecx, 0FFFFFFh
	mov [rax-4], ecx
	dec r8
	jne loc_143BB7C50
loc_143BB7C6E:
	add rax, r11
	add rdx, rbx
	dec r9
	jne loc_143BB7C46
loc_143BB7C79:
	mov rbx, [rsp+8]
	ret
sub_143BB7C00 ENDP

sub_143BB7B80 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+38h]
	mov r10d, r8d
	mov r11d, eax
	lea ebx, [r10+3]
	shr r11d, 2
	and ebx, 0FFFFFFFCh
	sub r11d, r8d
	sub ebx, r8d
	mov r8d, eax
	mov eax, [rsp+30h]
	shr r8, 2
	imul r8, rax
	mov eax, [rsp+28h]
	add r8, rax
	lea rax, [rcx+r8*4]
	test r9d, r9d
	je loc_143BB7BF9
	shl r11, 2
	mov r9d, r9d
loc_143BB7BC6:
	test r10d, r10d
	je loc_143BB7BEE
	mov r8, r10
	xchg ax, ax
loc_143BB7BD0:
	movzx ecx, byte ptr [rdx]
	add rax, 4
	inc rdx
	imul ecx, 0FF00000h
	or ecx, 0FFFFFFh
	mov [rax-4], ecx
	dec r8
	jne loc_143BB7BD0
loc_143BB7BEE:
	add rax, r11
	add rdx, rbx
	dec r9
	jne loc_143BB7BC6
loc_143BB7BF9:
	mov rbx, [rsp+8]
	ret
sub_143BB7B80 ENDP

sub_143BB7B00 PROC
	mov [rsp+8], rbx
	mov eax, [rsp+38h]
	mov r10d, r8d
	mov r11d, eax
	lea ebx, [r10+3]
	shr r11d, 2
	and ebx, 0FFFFFFFCh
	sub r11d, r8d
	sub ebx, r8d
	mov r8d, eax
	mov eax, [rsp+30h]
	shr r8, 2
	imul r8, rax
	mov eax, [rsp+28h]
	add r8, rax
	lea rax, [rcx+r8*4]
	test r9d, r9d
	je loc_143BB7B79
	shl r11, 2
	mov r9d, r9d
loc_143BB7B46:
	test r10d, r10d
	je loc_143BB7B6E
	mov r8, r10
	xchg ax, ax
loc_143BB7B50:
	movzx ecx, byte ptr [rdx]
	add rax, 4
	inc rdx
	imul ecx, 3FC00000h
	or ecx, 0FFFFFFh
	mov [rax-4], ecx
	dec r8
	jne loc_143BB7B50
loc_143BB7B6E:
	add rax, r11
	add rdx, rbx
	dec r9
	jne loc_143BB7B46
loc_143BB7B79:
	mov rbx, [rsp+8]
	ret
sub_143BB7B00 ENDP

sub_143BB7C80 PROC
	mov [rsp+8], rbx
	mov [rsp+10h], rsi
	mov [rsp+18h], rdi
	mov r10d, [rsp+38h]
	mov r11, rcx
	mov eax, r8d
	shr eax, 3
	mov ebx, r8d
	mov ecx, r10d
	shr rcx, 2
	lea edi, [rbx+7]
	mov esi, r10d
	shr edi, 3
	shr esi, 2
	add edi, 3
	sub esi, r8d
	and edi, 0FFFFFFFCh
	sub edi, eax
	mov eax, [rsp+30h]
	imul rcx, rax
	mov eax, [rsp+28h]
	add rcx, rax
	lea r8, [r11+rcx*4]
	test r9d, r9d
	je loc_143BB7D22
	mov r11d, esi
	mov r10d, r9d
	shl r11, 2
loc_143BB7CE0:
	mov cl, 7
	test ebx, ebx
	je loc_143BB7D17
	mov r9, rbx
	nop dword ptr [rax+00000000h]
loc_143BB7CF0:
	movzx eax, byte ptr [rdx]
	add r8, 4
	shr eax, cl
	add cl, 0FFh
	and eax, 1
	neg eax
	mov [r8-4], eax
	movzx eax, cl
	and cl, 7
	shr rax, 7
	add rdx, rax
	dec r9
	jne loc_143BB7CF0
loc_143BB7D17:
	add r8, r11
	add rdx, rdi
	dec r10
	jne loc_143BB7CE0
loc_143BB7D22:
	mov rbx, [rsp+8]
	mov rsi, [rsp+10h]
	mov rdi, [rsp+18h]
	ret 
sub_143BB7C80 ENDP

sub_140A5A430 PROC
	push rdi
	sub rsp, 20h
	mov rdi, rcx
	add rcx, 10h
	mov rax, 141795640h
	call rax
	cmp eax, 1
	jne loc_140A5A4E2
	mov [rsp+30h], rbx
	mov [rsp+38h], rsi
	mov rsi, [rdi+8]
	xor edx, edx
	mov rax, [rdi]
	mov rcx, rdi
	call qword ptr [rax]
	mov rax, [rsi]
	mov rdx, rdi
	mov rcx, rsi
	call qword ptr [rax+68h]
	mov rsi, [rsp+38h]
	mov rbx, [rsp+30h]
loc_140A5A4E2:
	add rsp, 20h
	pop rdi
	ret
sub_140A5A430 ENDP

.data
	GXFontBuilderVtable QWORD deleteGXFontBuilder

.code

deleteGXFontBuilder PROC
	mov [rsp+8], rbx
	push rdi
	sub rsp, 20h
	lea rax, GXFontBuilderVtable
	mov ebx, edx
	mov rdi, rcx
	mov [rcx], rax
	call sub_143BB9EF0
	test bl, 1
	je loc_143BB8B8B
	mov rcx, rdi
	lea rax, free
	call rax
loc_143BB8B8B:
	mov rax, rdi
	mov rbx, [rsp+30h]
	add rsp, 20h
	pop rdi
	ret
deleteGXFontBuilder ENDP

initGXFontBuilder PROC
	lea rax, GXFontBuilderVtable
	mov [rcx+8], rdx
	mov [rcx+28h], r8
	mov [rcx], rax
	xor eax, eax
	mov [rcx+30h], r9
	mov [rcx+10h], rax
	mov [rcx+18h], eax
	mov [rcx+20h], rax
	mov rax, rcx
	ret
initGXFontBuilder ENDP

unloadGXFontBuilder PROC
	lea rax, GXFontBuilderVtable
	mov [rcx], rax
	jmp sub_143BB9EF0
unloadGXFontBuilder ENDP

END