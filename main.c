/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* 
 * File:   main.c
 * Author: Ale
 *
 * Created on 6 de mayo de 2018, 18:47
 */

#include <stdio.h>
#include <stdlib.h>

struct nodo_abb {
    struct nodo_abb *izq;
    struct nodo_abb *der;
    int valor;
    int cantidad;
};

struct nodo_abb* agregar_abb(struct nodo_abb **arbol, int val);
void borrar_abb(struct nodo_abb *a);
void mostrar_abb(struct nodo_abb *a);

struct nodo_abb *root;

/*
 * 
 */
int main(int argc, char** argv) {
    agregar_abb(root, 3);
    agregar_abb(root, 2);
    struct nodo_abb* nodoABorrar = agregar_abb(&root, 4);
    agregar_abb(root, 6);
    agregar_abb(root, 7);
    agregar_abb(root, 8);
    
    mostrar_abb(root);
    printf("\r\n");
    borrar_abb(nodoABorrar);
    mostrar_abb(root);
    return (EXIT_SUCCESS);
}

struct nodo_abb* agregar_abb(struct nodo_abb* arbol, int val) {
    
    if (arbol == NULL) {
        arbol = malloc(sizeof (struct nodo_abb));
        arbol->valor = val;
        arbol->cantidad = 1;
        arbol->der = NULL;
        arbol->izq = NULL;
        return arbol;
    } else {
        int valor = arbol->valor;
        if (val == valor) {
            arbol->cantidad++;
            return arbol;
        } else if (val < valor) {
            return agregar_abb(arbol->izq, val);
            
        } else {
            return agregar_abb(arbol->der, val);
        }
    }
}

void mostrar_abb(struct nodo_abb *a) {
    if (a != NULL) {
        printf("{");
        printf("%d:%d", a->valor, a->cantidad);
        mostrar_abb(a->izq);
        mostrar_abb(a->der);
        printf("}");
    }
}

void borrar_abb(struct nodo_abb *a) {
    if (a != NULL) {
        borrar_abb(a->izq);
        a->izq = NULL;
        borrar_abb(a->der);
        a->der = NULL;
        free(a);
        a = NULL;
    }
}