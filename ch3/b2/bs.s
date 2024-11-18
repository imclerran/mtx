!========================= bs.s file ============================
.globl	_main,_prints,_NSEC                      ! IMPORT from C
.globl	_getc,_putc,_readfd,_setes,_inces,_error ! EXPORT to C
	BOOTSEG  =  0x9800  ! booter segment
	OSSEG    =  0x1000  ! MTX kernel segment
	SSP      =  32*1024 ! booter stack size = 32KB
	BSECTORS =  2       ! number of sectors to load initially
	! Boot SECTOR loaded at (0000:7C00). reload booter to segment 0x9800

start:
	mov  ax, #BOOTSEG   ! set ES to 0x9800
	mov  es, ax
	! call BIOS INT13 to load BSECTORS to (segment,offset)=(0x9800,0)
	xor  dx, dx         ! dh=head=0, dl=drive=0
	xor  cx, cx         ! ch=cyl-0,  cl=sector=0
	incb cl             ! sector=1 (BIOS counts sector from 1)
	xor  bx, bx         ! (ES,BX) = real address = (0x9800,0)
	movb ah, #2         ! ah=READ
	movb al, #BSECTORS  ! al=number of sectors to load
	int  0x13           ! call BIOS disk I/O function
	! far jump to (0x9800, next) to continue execution there
	jmpi next, BOOTSEG  ! CS=BOOTSEG, IP=next

next:
	mov  ax, cs         ! Set CPU segment registers to 0x9800
	mov  ds, ax         ! we know ES=CS=9x9800. Let DS=CS
	mov  ss, ax         ! let SS = CS
	mov  sp, #SSP       ! SP = SS + 32 KB
	call _main          ! call main() in C
	jmpi 0, OSSEG	    ! jump to execute OS kernel at (OSSEG,0)

!======================= I/O functions ==========================
	!-----------------------------------
	! char getc(): return an input char
	!-----------------------------------
_getc:
	xorb ah, ah         ! clear ah
	int  0x16		    ! call BIOS to get a char in AX
	ret

	!-----------------------------------
	! putc(char c): print a char
	!-----------------------------------
_putc:
	push bp
	mov  bp, sp
	movb al, 4[bp]      ! aL = char
	movb ah, #14        ! aH = 14
	int  0x10           ! call BIOS to display the char
	pop  bp
	ret

	!-----------------------------------
	! readfd(cyl,head,sector): load _NSEC sectors to (ES,0)
	!-----------------------------------
_readfd:
	push bp
	mov  bp, sp         ! bp = stack frame pointer
	movb dl, #0x00      ! drive=0 = FD0
	movb dh, 6[bp]      ! head
	movb cl, 8[bp]      ! sector
	incb cl             ! inc sector by 1 to suit BIOS
	movb ch, 4[bp]      ! cyl
	mov  bx, 10[bp]		! buf: offset in ES segment
	movb ah, #0x02      ! READ
	movb al, _NSEC      ! read _NSEC sectors to (ES,BX)
	int  0x13           ! call BIOS to read disk sectors
	jb   _error         ! error if CarryBit is set
	pop  bp
	ret

	!-----------------------------------
	! setes(segment): set ES to a segment
	!-----------------------------------
_setes:
	push bp
	mov  bp, sp
	mov  ax, 4[bp]
	mov  es, ax
	pop  bp
	ret

	!-----------------------------------
	! inces(): increment ES by _NSEC sectors (in 16-byte clicks)
	!-----------------------------------
_inces:
	mov  bx, _NSEC      ! get _NSEC in BX
	shl  bx, #5         ! multiply by 2**5 = 32
	mov  ax, es         ! current ES
	add  ax, bx         ! add (_NSEC*0x20)
	mov  es, ax         ! update ES
	ret

	!-----------------------------------
	! error() and reboot
	!-----------------------------------
_error:
	push #msg
	call _prints
	int 0x19            ! reboot
msg:	.asciz  "Error\n\n\r"

