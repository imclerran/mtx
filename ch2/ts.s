!---------------------- ts.s file ----------------------
        .global _h               ! IMPORT _h from C
        .global _getbp,_mysum,_g ! EXPORT global symbols to C

_getbp:                          ! int getbp() function
        mov ax,bp
        ret

_mysum:                          ! int mysum(int x, int y)
        push bp
        mov  bp,sp
        mov  ax,4[bp]
        add  ax,6[bp]
        add  ax,_h
        mov  sp,bp
        pop  bp
        ret

_g:     .word 1234               ! global _g defined here