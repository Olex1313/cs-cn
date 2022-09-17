global _main

extern _puts			; use C function to print ans

section .data
first_numeral 	dd 	10
second_numeral 	dd 	10
equal_message 	db 	"Variables are equal", 0
first_message 	db 	"First variable is greater", 0
second_message 	db 	"Second variable is greater", 0

section .text
_main:
lea rax, [rel first_numeral]	; store first number from ram
lea rbx, [rel second_numeral] 	; store second number from ram
cmp rax, rbx			; compare numbers
je  both_equal			
jg  first_greater
jmp second_greater

first_greater:
push rbx
lea rdi, [rel first_message]
call _puts
pop rbx
jmp exit_programm

second_greater:
push rbx
lea rdi, [rel second_message]
call _puts
pop rbx
jmp exit_programm

both_equal:
push rbx
lea  rdi, [rel equal_message]      	; First argument is address of message
call  _puts
pop rbx
jmp exit_programm

exit_programm:
mov rax, 0x2000001
mov rdi, 0
syscall

