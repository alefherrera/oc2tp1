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
    printf("Hello, World!");
    struct nodo_abb *a = agregar_abb(&root, 1);
    struct nodo_abb *b = agregar_abb(&root, 2);
    struct nodo_abb *c = agregar_abb(&root, 3);
    return (EXIT_SUCCESS);
}

struct nodo_abb* agregar_abb(struct nodo_abb** arbol, int val) {
    if ((*arbol) == NULL) {
        (*arbol) = malloc(sizeof (struct nodo_abb));
        (*arbol)->valor = val;
        (*arbol)->cantidad = 1;
        (*arbol)->der = NULL;
        (*arbol)->izq = NULL;
        return arbol;
    } else {
        int valor = (*arbol)->valor;
        if (val == valor) {
            (*arbol)->cantidad++;
            return arbol;
        } else if (val < valor) {
            return agregar_abb(&(*arbol)->izq, val);
        } else {
            return agregar_abb(&(*arbol)->der, val);
        }
    }
}