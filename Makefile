all:
	nasm -f elf64 prova.asm -o prova.o
	ld prova.o -o prova
