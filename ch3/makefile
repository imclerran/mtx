# Makefile

# Target executable and object files
TARGET = booter
IMAGE = disk.img
BSO = bs.o
BCO = bc.o

# Default rule: build the booter executable
all: $(TARGET)

# Compile bs.s to bs.o
$(BSO): bs.s
	as86 -o $(BSO) bs.s

# Compile bc.c to bc.o
$(BCO): bc.c
	bcc -c -ansi bc.c

# Link bs.o and bc.o into the booter executable
$(TARGET): $(BSO) $(BCO)
	ld86 -d -o $(TARGET) $(BSO) $(BCO) /usr/lib/bcc/libc.a

# Create the disk image from the booter executable
$(IMAGE): $(TARGET)
	dd if=$(TARGET) of=$(IMAGE) bs=512 count=1 conv=notrunc

# Command to run the image using QEMU
boot: $(IMAGE)
	qemu-system-i386 -drive file=$(IMAGE),format=raw,if=floppy -no-fd-bootchk -boot a

# Clean up generated files
clean:
	rm -f $(BSO) $(BCO) $(TARGET) $(IMAGE)