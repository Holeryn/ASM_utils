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

;INC for premission AND Set priority
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

;Macro for signal
%define SIGHUP		 1
%define SIGINT		 2
%define SIGQUIT		 3
%define SIGILL		 4
%define SIGTRAP		 5
%define SIGABRT		 6
%define SIGIOT		 6
%define SIGBUS		 7
%define SIGFPE		 8
%define SIGKILL		 9
%define SIGUSR1		10
%define SIGSEGV		11
%define SIGUSR2		12
%define SIGPIPE		13
%define SIGALRM		14
%define SIGTERM		15
%define SIGSTKFLT	16
%define SIGCHLD		17
%define SIGCONT		18
%define SIGSTOP		19
%define SIGTSTP		20
%define SIGTTIN		21
%define SIGTTOU		22
%define SIGURG		23
%define SIGXCPU		24
%define SIGXFSZ		25
%define SIGVTALRM	26
%define SIGPROF		27
%define SIGWINCH	28
%define SIGIO		29

;UMOUNT OPTION
%define MNT_FORCE	0x00000001	    ; Attempt to forcibily umount
%define MNT_DETACH	0x00000002	    ; Just detach from the tree
%define MNT_EXPIRE	0x00000004	    ; Mark for expiry
%define UMOUNT_NOFOLLOW	0x00000008	; Don't follow symlink on umount
%define UMOUNT_UNUSED	0x80000000	; Flag guaranteed to be unused 

;REBOOT MACROS

;magic 1, magic 2
%define LINUX_REBOOT_MAGIC1     0xfee1dead
%define LINUX_REBOOT_MAGIC2     672274793
%define LINUX_REBOOT_MAGIC2A    85072278
%define LINUX_REBOOT_MAGIC2B    369367448
%define LINUX_REBOOT_MAGIC2C    537993216

;cmd argument
%define LINUX_REBOOT_CMD_CAD_OFF  0
%define LINUX_REBOOT_CMD_CAD_ON   0x89abcdef
%define LINUX_REBOOT_CMD_HALT  0xcdef0123
%define LINUX_REBOOT_CMD_KEXEC        0x45584543
%define LINUX_REBOOT_CMD_POWER_OFF    0x4321fedc
%define LINUX_REBOOT_CMD_RESTART     0x1234567
%define LINUX_REBOOT_CMD_RESTART2   0xa1b2c3d4
%define LINUX_REBOOT_CMD_SW_SUSPEND 0xd000fce1

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
;Return : fd (File descriptor)
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

;MKDIR - Create a directory
;Parameters : 1,Pathname,2 Mode
;Return : mkdir() and mkdirat() return zero on success, or -1 if an error
;occurred (in which case, errno is set appropriately)
%macro MKDIR 2
    mov eax,0x27            ;EAX = 0x27
    mov ebx,%1              ;EBX = Pathname
    mov ecx,%2              ;ECX = Mode
    int 0x80                ;Call System
%endmacro

;RMDIR - Delete a DIrectory - which must be empty
;Parameters : 1,Pathname
;Return :  On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro RMDIR 1
    mov eax,0x28            ;EAX = 0x28
    mov ebx,%1              ;EBX = Pathname
    int 0x80                ;Call System
%endmacro

;dup - duplicare a file descriptor
;Parameters : 1,old_fd
;Return : On success, these system calls return the new file descriptor.  On
;error, -1 is returned, and errno is set appropriately.
%macro DUP 1
    mov eax,0x29            ;EAX = 0x29
    mov ebx,%1              ;EBX = OLD_FD
    int 0x80                ;Call System
%endmacro

;PIP - Create Pipe
;Parameters : 1,*fields
;Return : On success, zero is returned.  On error, -1 is returned, errno is set
;appropriately, and pipefd is left unchanged.
%macro PIP 1
    mov eax,0x2A            ;EAX = 0X2A
    mov ebx,%1              ;EBX = *fields
    int 0x80                ;Call System
%endmacro

;Times - Get Process TImes
;Patameters : *buf
;Return :     times() returns the number of clock ticks that have elapsed since an
;arbitrary point in the past.  The return value may overflow the
;possible range of type clock_t.  On error, (clock_t) -1 is returned,
;and errno is set appropriately.
%macro TIMES 1
    mov eax,0x2B            ;EAX = 0x2B
    mov ebx,%1              ;EBX = *buf
    int 0x80                ;Call System
%endmacro

;times() Stores the current process time in the struct tms
;that buf points to. The sctruct tms is as defined in <sys/time.h> :
;IN C STYLE
;struct tms {
;               clock_t tms_utime;  /* user time */
;               clock_t tms_stime;  /* system time */
;               clock_t tms_cutime; /* user time of children */
;               clock_t tms_cstime; /* system time of children */
;           };
;The tms_utime field contains the CPU time spent executing instruc‐
;tions of the calling process.  The tms_stime field contains the CPU
;time spent executing inside the kernel while performing tasks on
;behalf of the calling process.
;The tms_cutime field contains the sum of the tms_utime and tms_cutime
;values for all waited-for terminated children.  The tms_cstime field
;contains the sum of the tms_stime and tms_cstime values for all
;waited-for terminated children.

;BRK - Change Data Segment SIZE
;Parameters : 1, addr
;Return : On success, brk() returns zero.  On error, -1 is returned, and errno
;is set to ENOMEM.
%macro BRK 1
    mov eax,0x2D            ;EAX = 0x2D
    mov ebx,%1              ;EBX = brk
    int 0x80                ;Call System
%endmacro

;!!!!!!!!!!!!!!!!!!
;sys_setgid16 to do
;sys_getgid16 to do
;!!!!!!!!!!!!!!!!!!

;SIGNAL - ANSI C Signal Handling
;Parameters : 1,sig,2 handler
;Return :signal() returns the previous value of the signal handler, or SIG_ERR
;on error.  In the event of an error, errno is set to indicate the
;cause.
%macro SIGNAL 2
    mov eax,0x30            ;EAX = 0x30
    mov ebx,%1              ;EBX = SIG
    mov ecx,%2              ;ECX = handler
    int 0x80                ;Call System
%endmacro

;!!!!!!!!!!!!!!!!!!!
;sys_geteuid16 to do
;sys_getegid16 to do
;!!!!!!!!!!!!!!!!!!!

;ACCT - SWITCH PROCESS ACCOUNTING ON OR OFF
;Parameters : 1,filename
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro ACCT 1
    mov eax,0x33            ;EAX = 0x33
    mov ebx,%1              ;EBX = name
    int 0x80                ;Call System
%endmacro

;UMOUNT - unmount filesystem
;Parameters : 1,name,2 flags
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro UMOUNT 2
    mov eax,0x34            ;EAX = 0x34
    mov ebx,%1              ;EBX = name
    mov ecx,%2              ;ECX = flags
    int 0x80                ;Call System
%endmacro

;LOCTL - Control Device
;Parameters : 1,fd,2,cmd,arg
;Return :Usually, on success zero is returned.  A few ioctl() requests use the
;return value as an output parameter and return a nonnegative value on
;success.  On error, -1 is returned, and errno is set appropriately.
%macro LOCTL 3
    mov eax,0x36            ;EAX = 0x36
    mov ebx,%1              ;EBX = fd
    mov ecx,%2              ;ECX = CMD
    mov edx,%3              ;EDX = arg
    int 0x80                ;Call System
%endmacro

;FCNTL - Manipulate File Descriptor
;PARAMETERS : 1,fd,2,cmd,3,arg
;Return : For a successful call, the return value depends on the operation:
;F_DUPFD  The new file descriptor.
;      F_GETFD  Value of file descriptor flags.
;      F_GETFL  Value of file status flags.
;      F_GETLEASE
;                Type of lease held on file descriptor.
;     F_GETOWN Value of file descriptor owner.
;     F_GETSIG Value of signal sent when read or write becomes possible, or
;               zero for traditional SIGIO behavior.
;     F_GETPIPE_SZ, F_SETPIPE_SZ
;               The pipe capacity.
;     F_GET_SEALS
;               A bit mask identifying the seals that have been set for the
;               inode referred to by fd.
;      All other commands
;               Zero.
;      On error, -1 is returned, and errno is set appropriately.
%macro FCNTL 3
    mov eax,0x37            ;EAX = 0x37
    mov ebx,%1              ;EBX = fd
    mov ecx,%2              ;ECX = CMD
    mov edx,%3              ;EDX = arg
    int 0x80                ;Call System
%endmacro


;SETPGID - set Process Group
;Required : 1,fd,2,cmd,3,arg
;Return : On success, setpgid() and setpgrp() return zero.  On error, -1 is
;returned, and errno is set appropriately.
;The POSIX.1 getpgrp() always returns the PGID of the caller.
;getpgid(), and the BSD-specific getpgrp() return a process group on
;success.  On error, -1 is returned, and errno is set appropriately.
%macro SETPGID 3
    mov eax,0x39            ;EAX = 0x39
    mov ebx,%1              ;EBX = fd
    mov ecx,%2              ;ECX = cmd
    mov edx,%3              ;EDX = arg
    int 0x80                ;Call System
%endmacro

;UNAME - Get Name And Information About Current Kernel
;Required : 1,buf
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro UNAME 1
    mov eax,0x3b            ;EAX = 0x3B
    mov ebx,%1              ;EBX = buf
    int 0x80                ;CAll system
%endmacro

;UNMASK - Set File Mode Creation mASK
;Required : 1,User
;Return : This system call always succeeds and the previous value of the mask
;is returned.
%macro UNMASK 1
    mov eax,0x3C            ;EAX = 0x03C
    mov ebx,%1              ;EBX = User
    int 0x80                ;Call System
%endmacro

;CHROOT - Change Root Directory
;Required : 1, filename (path)
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro CHROOT 1
    mov eax,0x3D            ;EAX = 0x3D
    mov ebx,%1              ;EBX = Filename
    int 0x80                ;Call System
%endmacro

;Get File Name Statistics
;Required : 1,dev,2,ubuf
;Return : On success, zero is returned and the ustat structure pointed to by
;ubuf will be filled in.  On error, -1 is returned, and errno is set
;appropriately.
%macro USTAT 2
    mov eax,0x3E            ;EAX = 0x3E
    mov ebx,%1              ;EBX = DEV
    mov ecx,%2              ;ECX = UBUF
    int 0x80                ;Call System
%endmacro

;DUP2 - Duplicate a file descriptor
;Required : 1,old_fd,2,new_fd
;Return : On success, these system calls return the new file descriptor.  On
;error, -1 is returned, and errno is set appropriately
%macro DUP2 2
    mov eax,0x3F            ;EAX = 0x3F
    mov ebx,%1              ;EBX = old_fd
    mov ecx,%2              ;ECX = new_fd
    int 0x80                ;Call System
%endmacro

;GETPPID - Get Process Identification
;Required : VOID
;Return : getppid() returns the process ID of the parent of the calling
;process.  This will be either the ID of the process that created this
;process using fork(), or, if that process has already terminated, the
;ID of the process to which this process has been reparented (either
;init(1) or a "subreaper" process defined via the prctl(2)
;PR_SET_CHILD_SUBREAPER operation).
%macro GETPPID 0
    mov eax,0x40            ;EAX = 0x40
    int 0x80                ;Call System
%endmacro

;GETPGRP - Set/Get Process Group
;Required : void
;Return :  The POSIX.1 getpgrp() always returns the PGID of the caller.
%macro GETPGRP 0
    mov eax,0x41            ;EAX = 0x41
    int 0x80                ;Call System
%endmacro

;SETSID - Create a session and sets the process group ID
;Required : void
;Return : On success, the (new) session ID of the calling process is returned.
;On error, (pid_t) -1 is returned, and errno is set to indicate the
;error.
%macro SETSID 0
    mov eax,0x42            ;EAX = 0x42
    int 0x80                ;Call System
%endmacro

;SIGACTION - Examine and change a signal action
;Required : 1,signum,2,asigation act,3,oldact
;Return : sigaction() returns 0 on success; on error, -1 is returned, and errno
;is set to indicate the error.
%macro SIGACTION 3
    mov eax,0x43            ;EAX = 0x43
    mov ebx,%1              ;EBX = signum
    mov ecx,%2              ;EDX = act
    mov edx,%3              ;EDX = OLD ACT
    int 0x80                ;Call System
%endmacro

;Sigation structure
;struct sigaction {
;               void     (*sa_handler)(int);
;               void     (*sa_sigaction)(int, siginfo_t *, void *);
;               sigset_t   sa_mask;
;               int        sa_flags;
;               void     (*sa_restorer)(void);
;           };

;SGETMASK - manipulation of signal mask (obsolete)
;Required : void
;Return :  sgetmask() always successfully returns the signal mask.  ssetmask()
;always succeeds, and returns the previous signal mask.
%macro SGETMASK 0
    mov eax,0x44            ;EAX = 0x44
    int 0x80                ;Call System
%endmacro

;SSETMASK - manipulation of signal mask (obsolete)
;Required : 1,newmask
;Return : sgetmask() always successfully returns the signal mask.  ssetmask()
;always succeeds, and returns the previous signal mask.
%macro SSETMASK 1
    mov eax,0x45            ;EAX = 0x45
    mov ebx,%1              ;EBX = newmask
    int 0x80                ;Call System
%endmacro

;sys_setreuid16 TO DO
;sys_setregid16 TO DO

;SIGSUSPEND - Wait for a signal
;Required : 1,history 0,2 history 1,2 mask
;Return : sigsuspend() always returns -1, with errno set to indicate the error
;(normally, EINTR).
%macro SIGSUSPEND 3
    mov eax,0x48            ;EAX = 0x48
    mov ebx,%1              ;EBX = history 0
    mov ecx,%2              ;ECX = history 1
    mov edx,%3              ;EDX = mask
    int 0x80                ;Call System
%endmacro

;SIGPENDING - examine pending signals
;Required : 1,set
;Return : sigpending() returns 0 on success and -1 on error.  In the event of
;an error, errno is set to indicate the cause.
%macro SIGPENDING 1
    mov eax,0x49            ;EAX = 0x49
    mov ebx,%1              ;EBX = set
    int 0x80                ;Call System
%endmacro

;SETHOSTNAME - Set hostname
;Required : 1,name,2,len
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro SETHOSTNAME 2
    mov eax,0x4A            ;EAX = 0x4A
    mov ebx,%1              ;EBX = name
    mov ecx,%2              ;ECX = len
    int 0x80                ;Call System 
%endmacro

;SETRLIMIT - Set resource limits
;Required : resource, rlim
;Return : On success, these system calls return 0.  On error, -1 is returned,
;and errno is set appropriately.
%macro SETRLIMIT 2
    mov eax,0x4B            ;EAX = 0x4B
    mov ebx,%1              ;EBX = resource
    mov ecx,%2              ;ECX = rlim
    int 0x80                ;Call System
%endmacro

;sys_old_getrlimit TO DO


;GETRUSAGE - Get Resource Usage
;Required : 1,who,2,usage
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro GETRUSAGE 2
    mov eax,0x4D            ;EAX = 0x4c
    mov ebx,%1              ;Ebx = Who
    mov ecx,%2              ;ECX = Usage
    int 0x80                ;Call System
%endmacro

;usage structure :

;  struct rusage {
;      struct timeval ru_utime; /* user CPU time used */
;      struct timeval ru_stime; /* system CPU time used */
;      long   ru_maxrss;        /* maximum resident set size */
;      long   ru_ixrss;         /* integral shared memory size */
;      long   ru_idrss;         /* integral unshared data size */
;      long   ru_isrss;         /* integral unshared stack size */
;      long   ru_minflt;        /* page reclaims (soft page faults) */
;      long   ru_majflt;        /* page faults (hard page faults) */
;      long   ru_nswap;         /* swaps */
;      long   ru_inblock;       /* block input operations */
;      long   ru_oublock;       /* block output operations */
;      long   ru_msgsnd;        /* IPC messages sent */
;      long   ru_msgrcv;        /* IPC messages received */
;      long   ru_nsignals;      /* signals received */
;      long   ru_nvcsw;         /* voluntary context switches */
;      long   ru_nivcsw;        /* involuntary context switches */
;  };

;GETTIMEOFDAY - get time
;Required : 1,*tv,2,*tz
;Return : gettimeofday() and settimeofday() return 0 for success, or -1 for
;failure (in which case errno is set appropriately).
%macro GETTIMEOFDAY 2
    mov eax,0x4E                ;Eax = 4E
    mov ebx,%1                  ;Ebx = tv
    mov ecx,%2                  ;Ecx = tz
    int 0x80                    ;Call System
%endmacro

;Tv struct (time val):
;struct timeval {
;              time_t      tv_sec;     /* seconds */
;              suseconds_t tv_usec;    /* microseconds */
;   };

;Tz struct (Time Zone):
;struct timezone {
;   int tz_minuteswest;     /* minutes west of Greenwich */
;   int tz_dsttime;         /* type of DST correction */
;};

;SETTIMEOFDAY - Set Time
;Required : 1,tv,2,tz
;Return : gettimeofday() and settimeofday() return 0 for success, or -1 for
;failure (in which case errno is set appropriately).
%macro SETTIMEOFDAY 2
    mov eax,0x4F                ;Eax = 0x4E
    mov ebx,%1                  ;Ebx = tv
    mov ecx,%2                  ;Ecx = tz
    int 0x80                    ;Call System
%endmacro

;The tv struct is the same of 0x4E and also the tz struct is the same of 0x4E

;GETGROUPS TO DO
;SetGroups TO DO
;OLD_SELECT TO DO

;SYMLINK - MAKE A NEW NAME FOR A FILE
;Required : 1,target, 2 ,linkpath
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro SYMLINK 2
    mov eax,0x53            ;Eax = 0x53
    mov ebx,%1              ;EBX = target
    mov ecx,%2              ;Ecx = Linkpath
    int 0x80                ;Call System
%endmacro

;LSTAT - get file status
;Required : 1,pathname, 2,statbuf
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro LSTAT 2
    mov eax,0x54            ;EAX = 0x54
    mov ebx,%1              ;EBX = pathname
    mov ecx,%2              ;Ecx = statbuf
    int 0x80                ;Call System
%endmacro


;stat structure :
; struct stat {
;               dev_t     st_dev;         /* ID of device containing file */
;               ino_t     st_ino;         /* Inode number */
;               mode_t    st_mode;        /* File type and mode */
;               nlink_t   st_nlink;       /* Number of hard links */
;               uid_t     st_uid;         /* User ID of owner */
;               gid_t     st_gid;         /* Group ID of owner */
;               dev_t     st_rdev;        /* Device ID (if special file) */
;               off_t     st_size;        /* Total size, in bytes */
;               blksize_t st_blksize;     /* Block size for filesystem I/O */
;               blkcnt_t  st_blocks;      /* Number of 512B blocks allocated */
;
;               /* Since Linux 2.6, the kernel supports nanosecond
;                  precision for the following timestamp fields.
;                  For the details before Linux 2.6, see NOTES. */
;
;               struct timespec st_atim;  /* Time of last access */
;               struct timespec st_mtim;  /* Time of last modification */
;               struct timespec st_ctim;  /* Time of last status change */
;
;           #define st_atime st_atim.tv_sec      /* Backward compatibility */
;           #define st_mtime st_mtim.tv_sec
;           #define st_ctime st_ctim.tv_sec
;};


;READLINK - READ VALUE OF A SYMBOLIC LINK
;Required : 1,pathname,2,buf,3,bufsize
;Return : On success, these calls return the number of bytes placed in buf.
;(If the returned value equals bufsiz, then truncation may have
;occurred.)  On error, -1 is returned and errno is set to indicate the
;error.
%macro READLINK 3
    mov eax,0x55                ;EAX = 0x55
    mov ebx,%1                  ;EBX = Pathname
    mov ecx,%2                  ;ECX = buf
    mov edx,%3                  ;EDX = bufsize
    int 0x80                    ;Call System
%endmacro


;USELIB - Load shared library
;Required : 1,library
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro USELIB 1
    mov eax,0x56                ;EAX = 0x56
    mov ebx,%1                  ;EBX = library
    int 0x80                    ;Call System
%endmacro


;SWAPON - Start swapping to file/device
;Required : 1,path,2,swapflag
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro SWAPON  2
    mov eax,0x57                ;EAX = 0x57
    mov ebx,%1                  ;EBX = Path
    mov ecx,%2                  ;ECX = SwapFlag
    int 0x80                    ;Call System
%endmacro


;REBOOT - reboot or enable/disable Ctrl-Alt-Del
;Required : 1,magic,2,magic2,3,cmd,4,*arg
;Return : For the values of cmd that stop or restart the system, a successful
;call to reboot() does not return.  For the other cmd values, zero is
;returned on success.  In all cases, -1 is returned on failure, and
;errno is set appropriately.
%macro REBOOT 4
    mov eax,0x58                ;EAX = 0x58
    mov ebx,%1                  ;EBX = magic
    mov ecx,%2                  ;ECX = magic2
    mov edx,%3                  ;EDX = cmd
    mov esi,%4                  ;ESI = arg
    int 0x80                    ;Call System
%endmacro

;sys_old_readdir TO DO
;sys_old_mmap TO DO
;sys_old_readdir TO DO
;sys_old_mmap TO DO

;MUNMAP - unmap files or devices into memory
;Required : 1,addr,2, length
;Return : On success, mmap() returns a pointer to the mapped area.  On error,
;On success, mmap() returns a pointer to the mapped area.  On error,
;the value MAP_FAILED (that is, (void *) -1) is returned, and errno is
;set to indicate the cause of the error;
;On success, munmap() returns 0.  On failure, it returns -1, and errno
;is set to indicate the cause of the error (probably to EINVAL).
%macro MUNMAP 2
    mov eax,0x5B                ;EAX = 0x5B
    mov ebx,%1                  ;EBX = addr
    mov ecx,%2                  ;ECX = length
    int 0x80                    ;Call System
%endmacro

;---------------------------------------------------------------------------------------------------
;With ftruncate(), the file must be open for writing; with truncate(),
;the file must be writable.

;TRUNCATE - Truncate a file to a specified length
;Required : 1,path,2,length
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro TRUNCATE 2
    mov eax,0x5C                ;EAX = 0x5C
    mov ebx,%1                  ;EBX = path
    mov ecx,%2                  ;ECX = lenght
    int 0x80                    ;Call System
%endmacro

;FTRUNCATE - trucnate a file to a specified lenght
;Required : 1, path,2 ,length
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro FTRUNCATE 2
    mov eax,0x5D                ;EAX = 0x5D
    mov ebx,%1                  ;EBX = path
    mov ecx,%2                  ;ECX = length
    int 0x80                    ;Call System
%endmacro
;---------------------------------------------------------------------------------------------------

;FCHMOD - change permissions of a file
;Required : 1,fd,2,mode
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro FCHMOD 2
    mov eax,0x5E                ;EAX = 0x5E
    mov ebx,%1                  ;EBX = fd
    mov ecx,%2                  ;ECX = mode
    int 0x80                    ;Call System
%endmacro

;sys_fchown16 TO DO

;GETPRIORITY - get program scheduling priority
;Required : 1,which,2,who
;Return : On success, getpriority() returns the calling thread's nice value,
;which may be a negative number.  On error, it returns -1 and sets
;errno to indicate the cause of the error.  Since a successful call to
;getpriority() can legitimately return the value -1, it is necessary
;to clear the external variable errno prior to the call, then check it
;afterward to determine if -1 is an error or a legitimate value.
;setpriority() returns 0 on success.  On error, it returns -1 and sets
;errno to indicate the cause of the error.
%macro GETPRIORITY 2
    mov eax,0x60                ;EAX = 0x60
    mov ebx,%1                  ;EBX = which
    mov ecx,%2                  ;ECX = Who
    int 0x80                    ;Call System
%endmacro

;SETPRIORITY - SET program scheduling priority
;Required : 1,which,2,who,3,prio
;Return : On success, getpriority() returns the calling thread's nice value,
;which may be a negative number.  On error, it returns -1 and sets
;errno to indicate the cause of the error.  Since a successful call to
;getpriority() can legitimately return the value -1, it is necessary
;to clear the external variable errno prior to the call, then check it
;afterward to determine if -1 is an error or a legitimate value.
;setpriority() returns 0 on success.  On error, it returns -1 and sets
;errno to indicate the cause of the error.
%macro SETPRIORITY 2
    mov eax,0x61                ;EAX = 0x61
    mov ebx,%1                  ;EBX = which
    mov ecx,%2                  ;ECX = Who
    mov edx,%3                  ;EDX = prio
    int 0x80                    ;Call System
%endmacro

;STATFS - get filesystem statistics
;Requires : 1,path,2,struct statfs buf
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro STATFS 2
    mov eax,0x63                ;EAX = 0x62
    mov ebx,%1                  ;EBX = path
    mov ecx,%2                  ;buf struct
    int 0x80                    ;Call System
%endmacro

;statfs structure :
;           struct statfs {
;               __fsword_t f_type;    /* Type of filesystem (see below) */
;               __fsword_t f_bsize;   /* Optimal transfer block size */
;               fsblkcnt_t f_blocks;  /* Total data blocks in filesystem */
;               fsblkcnt_t f_bfree;   /* Free blocks in filesystem */
;               fsblkcnt_t f_bavail;  /* Free blocks available to
;                                        unprivileged user */
;               fsfilcnt_t f_files;   /* Total file nodes in filesystem */
;               fsfilcnt_t f_ffree;   /* Free file nodes in filesystem */
;               fsid_t     f_fsid;    /* Filesystem ID */
;               __fsword_t f_namelen; /* Maximum length of filenames */
;               __fsword_t f_frsize;  /* Fragment size (since Linux 2.6) */
;               __fsword_t f_flags;   /* Mount flags of filesystem
;                                        (since Linux 2.6.36) */
;               __fsword_t f_spare[xxx];
;                               /* Padding bytes reserved for future use */
;           };

;FSTATFS : Get FIleSystem Statistics
;Requires : 1,fd,2,struct statfs buf (The sam structire of STATFS)
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro FSTATFS 2
    mov eax,0x64                ;EAX = 0x64
    mov ebx,%1                  ;ebx = fd
    mov ecx,%2                  ;ecx = buf
    int 0x80                    ;Call System
%endmacro

;IOPERM : Set port input/output pemission
;Required : 1, from,2 num, 3, turn_on
;Return : On success, zero is returned.  On error, -1 is returned, and errno is
;set appropriately.
%macro IOPERM 3
    mov eax,0x65                ;EAX = 0x65
    mov ebx,%1                  ;EBX = from
    mov ecx,%2                  ;ECX = num
    mov edx,%3                  ;EDX = turn_on
    int 0x80                    ;Call System
%endmacro

;SOCKETCALL - Socket system calls
;Required : call, args
;Return : VOID
%macro SOCKETCALL 2
    mov eax,0x66                ;EAX = 0x66
    mov ebx,%1                  ;EBX = call
    mov ecx,%2                  ;ECX = args
    int 0x80                    ;Call System
%endmacro


;SYSLOG - Read and/or clear kernel message rig buffer; set console log level
;Required: call,args
;Return : int
%macro SYSLOG 2
    mov eax,0x67                ;EAX = 0x67
    mov ebx,%1                  ;EBX = call
    mov ecx,%2                  ;ECX = args
    int 0x80                    ;Call System
%endmacro
