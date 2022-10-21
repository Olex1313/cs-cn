.data
A: .float -200112.13
S: .float 0.0
B: .float 1.00
C: .float 0.5
head1: .asciiz "equal\n"
head2: .asciiz "left bigger than right\n"
head4: .asciiz "left smaller than right\n"
head3: .asciiz "A<B,try again\n"
	.text
lwc1 $f1, A
lwc1 $f2, B
lwc1 $f4, S
lwc1 $f3, C
c.lt.s $f1,$f2
bc1t AisLessThanB
back:
add.s $f5, $f1, $f3 
add.s $f4, $f5, $f2 

c.eq.s $f1, $f4
bc1t EQUAL
c.lt.s $f4, $f1
bc1t SisLessThanA
c.lt.s $f1, $f4
bc1t SisGreaterThanA
j print_h

EQUAL:
	la $a0, head1
	j print_h
AisLessThanB:
	la $a0, head3
	li $v0, 4
	syscall
	j back
SisLessThanA:
	la $a0, head4
	j print_h
SisGreaterThanA:
	la $a0, head2
	j print_h	
print_h:
	li $v0, 4
	syscall