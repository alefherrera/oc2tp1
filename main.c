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

// FUNCIONES EN ASSEMBLER
struct nodo_abb* agregar_abb(struct nodo_abb *arbol, int val);
void borrar_abb(struct nodo_abb *a);
void mostrar_abb(struct nodo_abb *a);


struct nodo_abb* crear_nodo(int val);
struct nodo_abb* crear_subnodo(struct nodo_abb** puntero, int val);
struct nodo_abb* crear_subnodo_izq(struct nodo_abb* padre, int val);
struct nodo_abb* crear_subnodo_der(struct nodo_abb* padre, int val);


struct nodo_abb *root;

/*
 *
 */
int main(int argc, char** argv) {

    printf("INICIO\r\n" );
    //iterar por los parametros recibidos

    root = crear_nodo(3);
    agregar_abb(root, 2);
    agregar_abb(root, 4);
    agregar_abb(root, 6);
    agregar_abb(root, 7);
    agregar_abb(root, 8);
    mostrar_abb(root);

    printf("\r\n");
    // borrar_abb(nodoABorrar);
    // mostrar_abb(root);
    return (EXIT_SUCCESS);
}

/*
struct nodo_abb* agregar_abb(struct nodo_abb* arbol, int val) {
    int valor = arbol->valor;
    if (val == valor) {
        arbol->cantidad++;
        return arbol;
    } else if (val < valor) {
        return crear_subnodo_izq(arbol, val);
    } else {
        return crear_subnodo_der(arbol, val);
    }
    return arbol;
}
 */

struct nodo_abb* crear_subnodo_izq(struct nodo_abb* padre, int val) {
    return crear_subnodo(&padre->izq, val);
}

struct nodo_abb* crear_subnodo_der(struct nodo_abb* padre, int val) {
    return crear_subnodo(&padre->der, val);
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

/*
void mostrar_abb(struct nodo_abb* a) {
    if (a != NULL) {
        printf("{%d:%d", a->valor, a->cantidad);
        mostrar_abb(a->izq);
        mostrar_abb(a->der);
        printf("}");
    }
}
 */

/*
void borrar_abb(struct nodo_abb* a) {
    if (a != NULL) {
        borrar_abb(a->izq);
        borrar_abb(a->der);
        free(a);
    }
}
 */
