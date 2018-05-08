global _agregar_abb
extern _printf


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
    
        
    