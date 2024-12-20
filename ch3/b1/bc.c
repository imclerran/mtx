/****************** MTX booter's bc.c file ***********************
 FD contains this booter in Sector 0, MTX kernel begins in Sector 1
 In the MTX kernel: word#1=tsize in clicks, word#2=dsize in bytes
******************************************************************/
typedef unsigned short u16;

int tsize, dsize, ksectors, i, NSEC = 1;

int prints(char *s) { while(*s) putc(*s++); }

int getsector(u16 sector)
{ 
  /* CHS (cyl, head, sector) format
   * cyl=sector/36
   * head=(sector%36)/18
   * sec=(sector%36)/%18
   */
  readfd(sector/36, ((sector)%36)/18, (((sector)%36)%18)); 
}

main()
{
  prints("booting MTX\n\r");
  tsize = * (int *)(512+2);
  dsize = * (int *)(512+4);
  ksectors = ((tsize << 4) + dsize + 511)/512;
  setes(0x1000);
  for (i=1; i<=ksectors+1; i++) {
    getsector(i); inces(); putc('.');
  }
  prints("\n\rready to go?"); getc();
  error();
}
