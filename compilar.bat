nasm -o main.obj -f win32 .\assembler\main.asm
gcc -Wall -m32 -o programa.exe .\main.obj .\main.c
.\programa.exe < input.txt
