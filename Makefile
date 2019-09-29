all:
        nasm -f elf64 prova.asm -o prova.o
        ld prova.o -o prova
i386:
        nasm -f elf prova.asm
        ld -m elf_i386 -o prova prova.o
