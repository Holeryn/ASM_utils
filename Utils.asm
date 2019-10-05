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

;Mode of chmod
%define S_ISUID 04000   ;Set User ID
%define S_ISGID 02000   ;Set-group-ID
%define S_ISVTX 01000   ;Sticky bit
%define S_IRUSR 00400   ;Read By Owner
%define S_IWUSR 00200   ;Write By Owner
%define S_IXUSR 00100   ;Execute/search by owner 
%define S_IRGRP 00040   ;Read By Group
%define S_IXGRP 00010   ;EXECUTE/SEARCH by Group
%define S_IROTH 00004   ;Read By Others
%define S_IWOTH 00002   ;Write By Others
%define S_IXOTH 00001   ;EXECUTE / SEARCH by Others 

;Valuse of PID Options
;meaning wait for any child process whose process group ID is
;equal to the absolute value of pid.
;Returns : On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
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
    mov     ebx,%1      ;EBX = File Descripton
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
    mov     eax,0x09        ;EAX = 0x09
    mov     ebx,%1          ;EBX = old_name
    mov     ecx,%2          ;ECX = new_name
    int     0x80            ;Call System
%endmacro

;unlink - delete a name and possibly the file it refers to
;Params : 1, pathname
;On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro UNLINK 1
    mov     eax,0x0A        ;EAX = 0x0A
    mov     ebx,%1          ;EBX = pathname
    int     0x80            ;Call System
%endmacro

;execve - Executes the program referred to by pathname
;Params : 1, pathname , 2 argv[], 3 envp[]
;Return :  On success, execve() does not return, on error -1 is returned, and errno is set appropriately.
%macro EXECVE 3
    mov     eax,0x0B        ;EAX = 0x0B
    mov     ebx,%1          ;EBX = Pathname
    mov     ecx,%2          ;ECX = argv[]
    mov     edx,%3          ;EDX = envp[]
    int     0x80            ;Call System
%endmacro

;chdir -  changes the current working directory of the calling process to the directory specified in path.
;Params : 1, path
;Return : On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro CHDIR 1
    mov     eax,0x0C        ;EAX = 0x0C
    mov     ebx,%1          ;EBX = Path
    int     0x80            ;Call System
%endmacro

;time - get time in seconds
;Params : 1, tloc
%macro TIME 1
    mov     eax,0x0D        ;EAX = 0x0D
    mov     ebx,%1          ;EBX = TLOC
    int     0x80            ;Call System
%endmacro

;The system call mknod creates a filesystem node (file, device
;special file, or named pipe) named pathname, with attributes
;specified by mode and dev.
;params : 1,pathname, 2 mode, 3 dev
;Return : mknod() and mknodat() return zero on success, or -1 if an error
;occurred (in which case, errno is set appropriately).
%macro MKNOD 3
    mov     eax,0x0E        ;EAX = 0x0E
    mov     ebx,%1          ;EBX = Pathname
    mov     ecx,%2          ;ECX = Mode
    mov     edx,%3          ;EDX = Dev
    int     0x80            ;Call System
%endmacro


;Chdmod Chanfge a files mode bits
;params :  1, pathname , mode
;Return : On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro CHMOD 2
    mov eax,0x0F            ;EAX = 0x0F
    mov ebx,%1              ;EBX = Pathname
    mov ecx,%2              ;ECX = Mode
    int 0x80                ;Call System
%endmacro

;chown - change ownership of a file
;Parameters : 1,pathname, 2 owner ,3 group
;Return :On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro CHOWN 3
    mov eax,0x10            ;EAX = 0x10
    mov ebx,%1              ;EBX = Pathname
    mov ecx,%2              ;ECX = Owner
    mov edx,%3              ;EDX = Group
    int 0x80                ;Call System
%endmacro

;Stat - Get File Status
;Parameters : 1,pathname, 2 statbuf
;Returns : On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro STAT 2
    mov eax,0x12            ;EAX = 0x12
    mov ebx,%1              ;EBX = Pathname
    mov ecx,%2              ;ECX = StatBuf
    int 0x80                ;Call System
%endmacro

;LSEEK - Read Write FIle Offset
;Parameters - 1, fd(File Descriptor), 2 offset, 3 whence
;Return : Upon successful completion, lseek() returns the resulting offset
;location as measured in bytes from the beginning of the file.  On
;error, the value (off_t) -1 is returned and errno is set to indicate
;the error.
%macro LSEEK 3
    mov eax,0x13            ;EAX = 0x13
    mov ebx,%1              ;EBX = File Descriptor
    mov ecx,%2              ;ECX = Offset
    mov edx,%3              ;EDX = whence
    int 0x80                ;Call System
%endmacro

;GETPID - Get Process Identification
;Paramaters - void
;Returns : The process ID (PID) of the calling process
%macro GETPID 0
    mov eax,0x14            ;EAX = 0x14
    int 0x80                ;Call System
%endmacro

;MOUNT - Mount FileSystem
;Parameters : 1, source, 2, target,3 fylesystemtype,4, mountflags,5, data
;Returns :  On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro MOUNT 5
    mov eax,0x15           ;EAX = 0x15
    mov ebx,%1             ;EBX = SOURCE
    mov ecx,%2             ;ECX = TARGET
    mov edx,%3             ;EDX = FYLESYSTEMTYPE
    mov esi,%4             ;ESI = MOUNTFLAGS
    mov edi,%5             ;EDI = DATA
    int 0x80               ;CALL SYSTEM
%endmacro

;OLD MOUNT - Remove The attachment of the file system mounted target
;Parameters : 1, name
;Returns :  On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro OLD_MOUNT 1
    mov eax,0x16           ;EAX = 0x16
    mov ebx,%1             ;EBX = name
    int 0x80               ;Call System
%endmacro
