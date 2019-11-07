%include "Utils.asm"

segment .text
name    db "file2.text",0
name2   db "FILERENAMED.text",0
text    db "JUST TRUNCED!",0


segment .bss
buffer resb 1
fd resw 1
time resb 1
PID resd 1

segment .code
    global _start

_start:
    READ STDIN,buffer,10

    WRITE STDOUT,buffer,10

    CREAT name,O_CREAT
    mov [fd],eax

    WRITE fd,text,100
    TRUNCATE name,8

    TIME time

    WRITE STDOUT,time,100

    GETPID

    mov [PID],eax

    WRITE STDOUT,PID,100

    STIME 9999999

    KILL PID,1

    RENAME name,name2

    PAUSE

    EXIT SUCCESS_EXIT
