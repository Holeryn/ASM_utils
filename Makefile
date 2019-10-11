#for 8086 architecture
all: prova.asm
	nasm -f elf64 prova.asm -o prova.o
	ld prova.o -o prova
#for 80386 architeture
i386: prova.asm
	nasm -f elf prova.asm
	ld -m elf_i386 -o prova prova.o
