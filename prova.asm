%include "Utils.asm"

segment .text
name db "file2.text",0


segment .bss
buffer resb 1
fd resw 1
time resb 1

segment .code
    global _start

_start:
    READ STDIN,buffer,10

    WRITE STDOUT,buffer,10

    CREAT name,O_CREAT

    TIME time

    WRITE STDOUT,time,100
    
    EXIT SUCCESS_EXIT
