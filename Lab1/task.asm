global _main

extern _puts			; use C function to print ans
extern _atoi
default rel             ; MacOs linker

section .data
first           dq 12
second          dq 12
equal_message 	db 	"Variables are equal", 0
first_message 	db 	"First variable is greater", 0
second_message 	db 	"Second variable is greater", 0

section .text
_main:
push rbx                        ; MacOs align stack
mov rax, [first]	                    ; store first number from ram
mov rbx, [second]                ; store second number from ram
cmp ax, bx                      ; compare numbers
je  both_equal			
jg  first_greater
jmp second_greater

first_greater:
lea rdi, [first_message]
call _puts
jmp exit_programm

second_greater:
lea rdi, [second_message]
call _puts
jmp exit_programm

both_equal:
lea  rdi, [equal_message]      	; First argument is address of message
call  _puts
jmp exit_programm

exit_programm:
mov rax, 0x2000001
mov rdi, 0
syscall
pop rbx
