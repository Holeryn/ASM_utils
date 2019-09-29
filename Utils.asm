%define SUCCESS_EXIT    0
%define FALIED_EXIT     1

%define STDIN   0
%define STDOUT  1
%define SYSERR  2

;Values of file flags
%define O_RDONLY    0
%define O_WRONLY    1
%define O_RDWR      2

;Option of file
%define O_CLOEXEC       0x400000
%define O_CREAT		    00000100
%define O_DIRECTORY     00200000

;Valuse of PID Options
;meaning wait for any child process whose process group ID is
;equal to the absolute value of pid.
%define WEAITNG_ABSOULTE_PID    -2

;meaning wait for any child process
%define WEATING_ALL -1

;meaning wait for any child process whose process group ID is
;equal to that of the calling process.
%define WEAITING_ANY_EQUAL_PID  0

;meaning wait for the child whose process ID is equal to the
;value of pid.
%define WEAITING_EQUAL_PID  1

;exit - terminate a program
;params : 1 ,int error code
%macro EXIT 1
    mov     eax,0x01    ;EAX = sys_exit
    mov     ecx,%1      ;ECX = error code
    int     0x80        ;call system
%endmacro

;fork - Create a child process
;params : 1 , strcut pt_regs *
%macro FORK 1
    mov     eax,0x02    ;EAX = sys_fork
    int     0x80 %1     ;call system
%endmacro

;read - Read a value from a file descriptor
;params : 1, fd = file descriptor, 2 = *buffer, 3 = counter
%macro  READ 3
    mov     eax,0x03    ;EAX = sys_read
    mov     ebx,%1      ;EBX = File Descriptor
    mov     ecx,%2      ;ECX = *buffer
    mov     edx,%3      ;EDX = counter
    int     0x80        ;Call system
%endmacro

;write - Write a value fora a file descriptor
;params : 1, fd = File Descriptor, 2 = *buffer, 3 = counter
%macro WRITE 3
    mov     eax,0x04    ;EAX = sys_write
    mov     ebx,%1      ;EBX = File Descripto
    mov     ecx,%2      ;ECX = *buffer
    mov     edx,%3      ;EDX = counter
    int     0x80        ;Call system
%endmacro

;open - Opean and possibily create a file
;params : 1, filename, 2 flags, 3 mode7
;EAX : RETURN FD
%macro OPEN 3
    mov     eax,0x05    ;EAX = sys_open
    mov     ebx,%1      ;EBX = filename
    mov     ecx,%2      ;ECX = flag
    mov     edx,%3      ;EDX = mode
    int     0x80        ;CALL SYSTEM
%endmacro

;close - close a file descriptor
;params : 1, fd (File Descriptor)
%macro CLOSE 1
    mov     eax,0x06    ;EAX = sys_close
    mov     ebx,%1      ;ebx = File Descriptor
    int     0x80        ;CALL SYSTEM
%endmacro

;waitpid - Wait for state change in a child of the calling process
;params : 1 , pid  ,2 , option
%macro WAITPID 2
    mov     eax,0x07        ;EAX = 0x07
    mov     ebx,%1          ;EBX = PID
    mov     ecx,%2          ;ECX = Option
    int     0x80            ;CALL SYSTEM
%endmacro

;creat - Open and possibly create a file
;Params : 1, pathname, 2, mode
%macro CREAT 2
    mov     eax,0x08        ;EAX = 0x08
    mov     ebx,%1          ;ebx = Pathname
    mov     ecx,%2          ;ecx = Mode
    int     0x80            ;CALL SYSTEM
%endmacro

;link - creates a hard link to an existing File
;Params : 1, old_name, 2, new_name
%macro LINK 2
    mov     eax,0x09        ;EAX = 0X09
    mov     ebx,%1          ;EBX = old_name
    mov     ecx,%2          ;ECX = new_name
    int     0x80            ;Call System
%endmacro
