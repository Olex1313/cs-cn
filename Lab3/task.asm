global _main

extern _puts			; use C function to print ans
default rel             ; MacOs linker

section .data
A           dq 200205.10
B           dq 11.20
ONE         dw 1.00

AequalS 	db 	"Variables are equal", 0
ALess 	    db 	"A < S", 0
SLess 	    db 	"S < A", 0

section .text
_main:
push rbx
finit
fld qword [ONE]
fdiv qword [A] 
fsin
fsub qword [B]
fcom qword [A]
jl s_less
jmp a_less
je both_equal


a_less:
lea rdi, [ALess]
call _puts
jmp exit_programm

s_less:
lea rdi, [SLess]
call _puts
jmp exit_programm

both_equal:
lea  rdi, [AequalS]      	; First argument is address of message
call  _puts
jmp exit_programm

exit_programm:
mov rax, 0x2000001
mov rdi, 0
syscall
pop rbx
