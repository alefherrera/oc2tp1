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
    int valor;
    int cantidad;
    struct nodo_abb *izq;
    struct nodo_abb *der;
};

struct nodo_abb* agregar_abb(struct nodo_abb *arbol, int val);
struct nodo_abb* crear_nodo(int val);
struct nodo_abb* crear_subnodo(struct nodo_abb** puntero, int val);
void borrar_abb(struct nodo_abb *a);
void mostrar_abb(struct nodo_abb *a);

struct nodo_abb *root;

/*
 * 
 */
int main(int argc, char** argv) {
    root = crear_nodo(3);
    agregar_abb(root, 2);
    struct nodo_abb* nodoABorrar = agregar_abb(root, 4);
    agregar_abb(root, 6);
    agregar_abb(root, 7);
    agregar_abb(root, 8);

    mostrar_abb(root);
    printf("\r\n");
    // borrar_abb(nodoABorrar);
    // mostrar_abb(root);
    return (EXIT_SUCCESS);
}

struct nodo_abb* agregar_abb(struct nodo_abb* arbol, int val) {
    int valor = arbol->valor;
    if (val == valor) {
        arbol->cantidad++;
        return arbol;
    } else if (val < valor) {
        return crear_subnodo(&arbol->izq, val);
    } else {
        return crear_subnodo(&arbol->der, val);
    }
    return arbol;
}

struct nodo_abb* crear_subnodo(struct nodo_abb** puntero, int val) {
    if (*puntero == NULL) {
        *puntero = crear_nodo(val);
        return *puntero;
    } else {
        return agregar_abb(*puntero, val);
    }
}

struct nodo_abb* crear_nodo(int val) {
    struct nodo_abb* ret = malloc(sizeof (struct nodo_abb));
    ret->valor = val;
    ret->cantidad = 1;
    ret->der = NULL;
    ret->izq = NULL;
    return ret;
}

void mostrar_abb(struct nodo_abb* a) {
    if (a != NULL) {
        printf("{");
        printf("%d:%d", a->valor, a->cantidad);
        mostrar_abb(a->izq);
        mostrar_abb(a->der);
        printf("}");
    }
}

void borrar_abb(struct nodo_abb* a) {
    if (a != NULL) {
        borrar_abb(a->izq);
        borrar_abb(a->der);
        free(a);
    }
}
