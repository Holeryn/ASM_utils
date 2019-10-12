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

;INC for premission
%define LOW_PRIORITY    19  ;LOW PRIORITY
%define HIGH_PRIORITY   -20 ;High Priority 

;KILL MACROS  
%define SEND_TO_ALL_PROCESS_ID                  0
%define SEND_TO_ALL_PERMISSION_CALLING_PROCESS  -1
%define SEND_TO_ALL_PROCESS_INTO_GROUP          -2

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

;SETUID - Set the UID
;Parmaters : 1, UID
;Returns :  On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro SETUID 1
    mov eax,0x17            ;EAX = 0x17
    mov ebx,%1              ;EBX = UID
    int 0x80                ;Call System
%endmacro

;GETUID - Return the current UID
;Parameters : void
;Return : The UID, On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro GETUID 0
    mov eax,0x18            ;EAX = 0x18
    int 0x80                ;Call System
%endmacro

;STIME - SET TIME
;Parameters : 1, POINTER TO THE TIME
;RETURN : On success, zero is returned.  On error, -1 is returned, and errno is set appropriately.
%macro STIME 1
    mov eax,0x19            ;EAX = 0x19
    mov ebx,%1              ;EBX = Pointer Time
    int 0x80                ;Call System
%endmacro

;PTRACE - Process Trace
;Parameters : 1, request,2 pid, 3 addr, 4, data
;Return : On success, the PTRACE_PEEK* requests return the requested data (but
;see NOTES), the PTRACE_SECCOMP_GET_FILTER request returns the number
;of instructions in the BPF program, and other requests return zero.
;On error, all requests return -1, and errno is set appropriately.
;Since the value returned by a successful PTRACE_PEEK* request may be
;-1, the caller must clear errno before the call, and then check it
;afterward to determine whether or not an error occurred.
%macro PTRACE 4
    mov eax,0x1A            ;EAX = 0x1A
    mov ebx,%1              ;Ebx = Request
    mov ecx,%2              ;Ecx = PID
    mov edx,%3              ;EDX = ADDR
    mov esi,%4              ;ESI = data
    int 0x80                ;Call SYstem
%endmacro

;ALARM - Set an alarm clock for delivery of a signal
;Parameters : 1,seconds
;Return : alarm() returns the number of seconds remaining until any previously
;scheduled alarm was due to be delivered, or zero if there was no
;previously scheduled alarm.
%macro ALARM 1
    mov eax,0x1B            ;EAX = 0x1B
    mov ebx,%1              ;EBX = seconds
    int 0x80                ;Call System
%endmacro

;FSTAT - Get File Status
;Parametrs : 1,File Descriptor,2, statbuf
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro FSTAT 2
    mov eax,0x1C            ;EAX = 0x1C
    mov ebx,%1              ;EBX = FIle Descriptor
    mov ecx,%2              ;ECX = StatBuf
    int 0x80                ;Call System
%endmacro

;PAUSE - WAIT FOR A SIGNAL
;Parameters : VOID
;Return : pause() returns only when a signal was caught and the signal-catching
;function returned.  In this case, pause() returns -1, and errno is
;set to EINTR.
%macro PAUSE 0
    mov eax,0x1D            ;EAX = 0x1D
    int 0x80                ;Call System
%endmacro

;Utime - Change file last access and modification times
;Parameters : 1,FileName,2 times
;Return :On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately. 
%macro UTIME 2
    mov eax,0x1E            ;EAX = 0x1E
    mov ebx,%1              ;EBX = FIleName
    mov ecx,%2              ;ECX = Times
    int 0x80                ;Call System
%endmacro

;ACCESS - chech user's permission for a file
;Parameters : 1,Pathname,2 mode
;Retrun : On success (all requested permissions granted, or mode is F_OK and
;the file exists), zero is returned.  On error (at least one bit in
;mode asked for a permission that is denied, or mode is F_OK and the
;file does not exist, or some other error occurred), -1 is returned,
;and errno is set appropriately.
%macro ACCESS 2
    mov eax,0x21            ;EAX = 0x21
    mov ebx,%1              ;Ebx = FileName
    mov ecx,%2              ;Ecx = Mode
    int 0x80                ;Call System
%endmacro

;NICE - CHANGE PROCESS PRORITY
;Parameters :1, inc 
;Return : On success, the new nice value is returned (but see NOTES below).  On
;error, -1 is returned, and errno is set appropriately.
;A successful call can legitimately return -1.  To detect an error,
;set errno to 0 before the call, and check whether it is nonzero after
;nice() returns -1.
%macro NICE 1
    mov eax,0x22            ;EAX = 0x22
    mov ebx,%1              ;EBX = inc
    int 0x80                ;Call System
%endmacro

;SYNCFS - Commit FileSystem Caches to disk
;Parameters : 1, fd
;Return : syncfs() returns 0 on success; on error, it returns -1 and sets errno
;to indicate the error.
%macro SYNCFS 1
    mov eax,0x24            ;EAX = 0x24
    mov ebx,%1              ;EBX = File Descriptor
    int 0x80                ;Call System
%endmacro

;KILL - Send A Signal To A Process
;Parameters : 1, pid , 2 ,sig
;Return :On success (at least one signal was sent), zero is returned.  On
;error, -1 is returned, and errno is set appropriately.
%macro KILL 2
    mov eax,0x25            ;EAX = 0x25
    mov ebx,%1              ;EBX = PID
    mov ecx,%2              ;ECX = SIG
    int 0x80                ;Call System
%endmacro

;RENAME - change the name or location of a file
;Parameters : 1,oldpath,2 newpath
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro RENAME 2
    mov eax,0x26            ;EAX = 0x26
    mov ebx,%1              ;EBX = OLDPATH
    mov ecx,%2              ;ECX = NEWPATH
    int 0x80                ;Call System
%endmacro
