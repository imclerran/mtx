!------ getbp.s file ------
	.globl _getbp  ! OR .global _getbp
_getbp: mov ax,bp
	ret

