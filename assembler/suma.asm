global _suma2asm
global _agregar_abb
global _mostrar_abb
extern _printf
extern _malloc
extern _free

section .data
texto db "eax =   %d", 10, 0
textoBx db "ebx =   %d", 10, 0
textoDx db "edx =   %d", 10, 0
moverIzq db "Mover izquierda", 10, 0
dirMemo db "valor en direccion = %d", 10, 0
viewNode db " { %d", 0
closeNode db "}", 0
emptyNode db " {}",0

section .text

_suma2asm:
    push ebp
    mov ebp, esp
    
    sub esp, 4

    mov edx, [ebp + 8]   
 
    add edx, [ebp + 12]
   
    mov esp, ebp
    pop ebp
    
    ret
    
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
    
agregoNodo:
    push edx
    push 12
    call _malloc
    add esp, 4 ;borro el parametro para pedir memoria
    pop edx
    
    call mostrarAX
    mov [eax], edx ;guardo valor
    mov ebx, 0
    mov [eax + 4], ebx;seteo nodo a cero
    mov [eax + 8], ebx;seteo nodo a cero

    jmp finalizar

        
_agregar_abb:
    push ebp ; guardo base point
    mov ebp, esp ; mi nuevo base point es stack point
    ;push ebx ;guardo el registro que voy a usar para el puntero
    
    mov edx, [ebp + 12];valor parametro
    mov ebx, [ebp + 8];puntero nodo
    call mostrarBX
    cmp ebx, 0 ;si es cero, es porque no hay nodo
    je agregoNodo;pedir memoria para nuevo nodo y guardar valor
    ;ebx valor nodo
    ;ebx + 4 puntero nodo izq
    ;ebx + 8 puntero nodo der
	mov eax, ebx ;pongo en eax el nodo acctual para devolverlo en caso de que sea el mismo valor
    ;call mostrarDX
	cmp edx, [ebx];comparo valor parametro con valor nodo
	JE finalizar ; si son iguales tengo q devolver puntero actual
    cmp edx, [ebx];comparo valor parametro con valor nodo
    JG mover_der;IF greater
    jmp mover_izq
 
mover_izq:

    push edx; pusheo valor parametro
    mov eax, [ebx + 4];guardo nodo izq para poder pushearlo
    push eax;pusheo nodo izq
    call mostrarAX
    call _agregar_abb;devuelve el nodo en EAX
    call mostrarAX
    mov ebx, [ebp + 8];puntero nodo actual
    mov ecx, [ebx + 4];obtengo el nodo izq otra vez para ver si era null 
    add esp, 8 ; desapilo
    cmp ecx, 0 ;si es cero, es porque no habia nodo
    je actualizo_izq
    
   ; mov eax,ebx;hago esto para que no pise los nodos de arriba
    
    jmp finalizar
    
mover_der:

    push edx; pusheo valor parametro
    mov eax, [ebx + 8];guardo nodo der para poder pushearlo
    push eax;pusheo nodo der
    call _agregar_abb;devuelve el nodo en EAX
    call mostrarAX
    mov ebx, [ebp + 8];puntero nodo actual
    mov ecx, [ebx + 8];obtengo el nodo izq otra vez para ver si era null
    add esp, 8 ; desapilo
    cmp ecx, 0 ;si es cero, es porque no habia nodo
    je actualizo_der
    ;mov eax,ebx;hago esto para que no pise los nodos de arriba
   
    jmp finalizar

actualizo_izq:
    mov [ebx + 4], eax;agrego nodo nuevo
    jmp finalizar

actualizo_der:
    mov [ebx + 8], eax;agrego nodo nuevo
    jmp finalizar
        
finalizar:
    ;reinicio lo que apile
    ;pop ebx
    mov esp, ebp
    pop ebp
    ret
 
_mostrar_abb:
    push ebp ; guardo base point
    mov ebp, esp ; mi nuevo base point es stack point
    mov ebx, [ebp + 8];puntero nodo
    cmp ebx, 0 ;si es cero, es porque no hay nodo
    je mostrarVacio
    call mostrarInicioNode
    push ebx;guardo nodo actual
    mov eax, [ebx +4];paso por parametro el nodo izq
    push eax
    call _mostrar_abb
    add esp, 4;saco el push de nodo izq
    pop ebx;recupero nodo actual
    mov eax, [ebx +8];paso por parametro el nodo derecho
    push eax
    call _mostrar_abb
    call mostrarFinNode
    jmp finalizar

mostrarVacio:
    push eax
    push ebx
    push edx
    push emptyNode
    call _printf
    add esp, 4
    pop edx
    pop ebx
    pop edx
    jmp finalizar

mostrarInicioNode:
    push eax
    push ebx
    push edx
    mov eax, [ebx]
    push eax
    push viewNode
    call _printf
    add esp, 8
    pop edx
    pop ebx
    pop edx
    ret

mostrarFinNode:
    push eax
    push ebx
    push edx
    push closeNode
    call _printf
    add esp, 4
    pop edx
    pop ebx
    pop edx
    ret
    
