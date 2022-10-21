run: task_exec
	./task_exec
task_exec: task.o
	ld -L /Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -lSystem -o task_exec task.o
task.o:
	nasm -f macho64 -g -F DWARF task.asm
clean:
	rm task.o task_exec
