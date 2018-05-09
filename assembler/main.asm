global _agregar_abb
extern _printf
extern _crear_subnodo

section .data


section .text
global CMAIN
CMAIN:
    ;write your code here
    xor eax, eax
    
    ret


;agregar_abb(struct nodo* nodo, int valor)

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
    push ebx
    push eax+8        
    call _crear_subnodo
    
agregar_nodo_derecho:
    push ebx
    push eax
    push ebx
    push eax+12        
    call _crear_subnodo
    