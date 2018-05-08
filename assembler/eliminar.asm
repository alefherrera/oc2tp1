global _borrar_abb
extern _free
extern _printf

section .data
texto db "eax =   %d", 10, 0
textoBx db "ebx =   %d", 10, 0
textoDx db "edx =   %d", 10, 0

section .text

mostrarAX:

    push edx
    push eax
    push texto
    call _printf
    add esp, 4
    pop eax
    pop edx
    ret

mostrarBX:
    push eax
    push edx
    push ebx
    push textoBx
    call _printf
    add esp, 4
    pop ebx
    pop edx
    pop eax
    ret
mostrarDX:
    push eax
    push edx
    push textoDx
    call _printf
    add esp, 4
    pop edx
    pop eax
    ret	
_borrar_abb: 
	push ebp ; guardo base point
    mov ebp, esp ; mi nuevo base point es stack point

	mov ebx, [ebp + 8];puntero nodo

	cmp ebx, 0 ;si es cero, es porque no hay nodo
	JE TERMINAR
	

	MOV eax, [ebx+4];nodo izq
	
	PUSH eax 			;pusheo nodo izq
	CALL _borrar_abb
	mov ebx, [ebp + 8];puntero nodo actual
	
	mov eax, 0
	mov [ebx + 4], eax;pongo el nodo hijo a null
	;mov edx, [ebx + 4]
	;call mostrarDX
	add esp, 4; desapilo
	

	MOV eax, [ebx+8]	;nodo der
	PUSH eax 			;pusheo nodo der
	
	CALL _borrar_abb

	mov ebx, [ebp + 8];puntero nodo actual

	mov eax, 0
	mov [ebx + 8], eax;pongo el nodo hijo a null
	mov edx, [ebx + 8]
	
	add esp, 4; desapilo


	push ebp	;apilo por las dudas de no perder registros
	push eax
	PUSH ebx			;pusheo nodo para hacer el free

	CALL _free			;free de C
	pop ebx				;desapilo
	pop eax
	pop ebp
	JMP TERMINAR

TERMINAR:
	 MOV ESP, EBP
	 POP EBP
	 RET