global _agregar_abb
global _mostrar_abb
global _borrar_abb
extern _printf
extern _free
extern _crear_subnodo_izq
extern _crear_subnodo_der

section .data
vistaNodo db "{%d:%d", 0
cierraNodo db "}", 0

section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    
    ret




;agregar_abb(struct nodo* nodo, int valor)
;struct nodo
;0  valor
;4  cantidad
;8  puntero nodo izq
;12 puntero nodo der

_agregar_abb:
    push ebp
    mov ebp, esp    
    mov eax, [ebp + 8]      ;EAX puntero al nodo
    mov ebx, [ebp + 12]     ;EBX valor
    mov ecx, [eax]
    cmp ebx, ecx
    jb agregar_nodo_izquierdo
    jg agregar_nodo_derecho
    inc [eax + 4]    
    pop ebp 
    ret

agregar_nodo_izquierdo:
    push ebx
    push eax      
    call _crear_subnodo_izq
    add esp, 8              ;borramos los parametros de la pila
    ;asumo que lo que me devuelve la funcion de C viene en EAX
    pop ebp
    ret
    
agregar_nodo_derecho:
    push ebx
    push eax     
    call _crear_subnodo_der
    pop ebp
    ret
    

_mostrar_abb:
    push ebp
    mov ebp, esp    
    mov eax, [ebp + 8]      ;EAX puntero al nodo
    mov ebx, [eax]          ;EBX valor
    mov ecx, [eax + 4]      ;ECX cantidad
    cmp eax, 0
    jne imprime_nodo
    pop ebp
    ret

imprime_nodo:
    push ecx
    push ebx
    push vistaNodo
    call _printf
    add esp, 12
    push [eax + 12]         ;obtengo el puntero izq
    call _mostrar_abb
    add esp, 4
    push [eax + 16]         ;obtengo el puntero der
    call _mostrar_abb
    add esp, 4
    pop ebp
    ret
    

_borrar_abb:
    push ebp
    mov ebp, esp    
    mov eax, [ebp + 8]      ;EAX puntero al nodo
    cmp eax, 0
    jne borra_nodo
    pop ebp
    ret

borra_nodo:
    push [eax + 12]         ;obtengo el puntero izq
    call _borrar_abb
    add esp, 4
    push [eax + 16]         ;obtengo el puntero der
    call _borrar_abb
    add esp, 4
    push eax
    call _free    
    add esp, 4
    pop ebp
    ret
    
    
    
    