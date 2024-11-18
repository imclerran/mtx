# Boot MTX from FD sectors

Booter 1 is a simple booter for booting MTX from a FD (floppy disk). The layout of the disk image is shown below. It containsa a booter in sector 0, followed by the MTX kernel image in consecutive sectors.


| S0     | S1, S2 ... | unused sectors |
|--------|------------|----------------|
| booter | MTX Kernel | .............. |
