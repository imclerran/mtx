# compiler, assembler, linker
CC = bcc
AS = as86
LD = ld86
CFLAGS = -c -ansi

# target executable
TARGET = tcs

# object files
OBJS = tc.o ts.o

# default target
all: $(TARGET)

# rule for linking the final executable
$(TARGET): $(OBJS)
	$(LD) /usr/lib/bcc/crt0.o $(OBJS) /usr/lib/bcc/libc.a -o $(TARGET)

# rule for compiling C source files to object files
tc.o: tc.c
	$(CC) $(CFLAGS) tc.c

# rule for assembling the assembly file
ts.o: ts.s
	$(AS) ts.s -o ts.o

# clean up object files and executable
clean:
	rm -f $(OBJS) $(TARGET)

