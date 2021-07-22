EXTERN bLoadGameProperties:QWORD
EXTERN IsTitleModeString:QWORD

.data
	createContainer QWORD 14001B520h
	initDLFileInputStream QWORD 14179D780h
	pDebugMem QWORD 144786A08h
	_theGameProperties QWORD 144766570h
.code

tLoadGameProperties PROC
	mov rax, 14476656Dh
	mov byte ptr [rax], 1
	mov rdx, 14282A138h
	mov rcx, [_theGameProperties]
	mov rcx, [rcx]
	call sub_1409E3890
	jmp [bLoadGameProperties]
tLoadGameProperties ENDP

sub_1409E3890 PROC
	push rbp
	push rsi
	push rdi
	push r14
	push r15
	lea rbp, [rsp-37h]
	sub rsp, 100h
	mov qword ptr [rbp-51h], -2
	mov [rsp+148h], rbx
	mov rsi, r8
	mov rbx, rdx
	mov rdi, rcx
	lea rax, [rbp-41h]
	mov [rsp+38h], rax
	lea rcx, [rbp-41h]
	call createContainer
	mov byte ptr [rbp-19h], 1
	mov r15, 142755E98h
	mov [rbp-49h], r15
	mov r14, 142755ED8h
	mov [rbp-49h], r14
	mov rdx, rbx
	lea rcx, [rbp-49h]
	mov rax, 140ED6840h
	call rax
	lea rdx, [rbp-41h]
	cmp qword ptr [rbp-29h], 8
	cmovnb rdx, [rbp-41h]
	mov byte ptr [rsp+20h], 0
	xor r9d, r9d
	mov r8, [pDebugMem]
	mov r8, [r8]
	lea rcx, [rsp+40h]
	mov rax, 141785110h
	call rax
	mov [rbp-49h], r14
	mov [rbp-49h], r15
	lea rax, [rbp-41h]
	mov [rsp+38h], rax
	cmp qword ptr [rbp-29h], 8
	jb loc_1409E3953
	mov rcx, [rbp-21h]
	mov rax, [rcx]
	mov rdx, [rbp-41h]
	call qword ptr [rax+68h]
loc_1409E3953:
	mov qword ptr [rbp-29h], 7
	xor r14d, r14d
	mov [rbp-31h], r14
	mov word ptr [rbp-41h], r14w
	xor r8d, r8d
	lea rdx, [rsp+40h]
	lea rcx, [rbp-69h]
	call initDLFileInputStream
	mov rax, 144913F8Ah
	movzx eax, byte ptr [rax]
	mov [rsp+30h], al
	mov r9b, 1
	lea r8, [rsp+30h]
	lea rdx, [rbp-69h]
	mov rcx, rdi
	mov rax, 14178BAE0h
	call rax
	movzx esi, al
	lea rcx, [rsp+40h]
	mov rax, 141785960h
	call rax
	;mov [rsp+20h], rax
	;mov r9, r14
	;mov r8, 14287D070h
	;mov rdx, [rdi+10h]
	;lea rcx, [rbp-49h]
	lea rcx, [rbp-69h]
	mov rax, 14179D7F0h
	call rax
	lea rcx, [rsp+40h]
	mov rax, 1417851D0h
	call rax
	movzx eax, dil
	mov rcx, [rbp+27h]
	mov rbx, [rsp+148h]
	add rsp, 100h
	pop r15
	pop r14
	pop rdi
	pop rsi
	pop rbp
	ret
sub_1409E3890 ENDP

.data
	gameIsTitleModeValueRead DWORD 0
	pHeapAlloc QWORD 144914558h
	putStringInContainer QWORD 140003C40h
	parseGamePropertiesValue QWORD 14178CDF0h
	gameIsTitleMode BYTE 0
.code

getGamePropertiesValueGameIsTitleMode PROC
	push rdi
	sub rsp, 70h
	mov qword ptr [rsp+28h], 0FFFFFFFFFFFFFFFEh
	mov [rsp+80h], rbx
	mov eax, [gameIsTitleModeValueRead]
	test al, 1
	jne getValue
	mov rbx, pHeapAlloc
	mov rbx, [rbx]
	test rbx, rbx
	jne allocok
	mov rax, 14177AD20h
	call rax
	mov rbx, pHeapAlloc
	mov rbx, [rbx]
	mov [rbx], rax
	mov rbx, rax
allocok:
	mov rax, [rbx]
	xor r8d, r8d
	lea rdx, [rsp+20h]
	mov rcx, rbx
	call qword ptr [rax+18h]
	mov ecx, [rax]
	shr ecx, 5
	test cl, 1
	jne containerok
	mov r8, 1439E1800h
	mov edx, 3Eh
	xor ecx, ecx
	mov rax, 141769E10h
	call rax
containerok:
	xor edi, edi
	mov [rsp+40h], rdi
	mov [rsp+48h], rdi
	mov [rsp+50h], rbx
	mov qword ptr [rsp+48h], 7
	mov [rsp+40h], rdi
	mov word ptr [rsp+30h], di
	lea r8d, [rdi+10h]
	lea rdx, [IsTitleModeString]
	lea rcx, [rsp+30h]
	call putStringInContainer
	mov byte ptr [rsp+58h], 1
	xor r8d, r8d
	lea rdx, [rsp+30h]
	mov rcx, [_theGameProperties]
	mov rcx, [rcx]
	call parseGamePropertiesValue
	mov [gameIsTitleMode], al
	cmp qword ptr [rsp+48h], 8
	jb stringshort
	mov rcx, [rsp+50h]
	mov r8, [rcx]
	mov rdx, [rsp+30h]
	call qword ptr [r8+68h]
	movzx eax, [gameIsTitleMode]
stringshort:
	mov qword ptr [rsp+48h], 7
	mov [rsp+40h], rdi
	mov word ptr [rsp+30h], di
	jmp epilogue
getValue:
	movzx eax, [gameIsTitleMode]
epilogue:
	mov rbx, [rsp+80h]
	add rsp, 70h
	pop rdi
	ret
getGamePropertiesValueGameIsTitleMode ENDP


END