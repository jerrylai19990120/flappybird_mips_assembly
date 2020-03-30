# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	displayAddress:	.word	0x10008000
.text
	lw $t0, displayAddress	# $t0 stores the base address for display
	li $t1, 0x00ffff	# $t1 stores the light blue colour code
	li $t2, 0xffff00	# $t2 stores the yellow colour code
	li $t3, 0x00ff00	# $t3 stores the green colour code
	
	add $t4, $zero, $zero   
	addi $t5, $zero, 4094
	
background:
        add $t6, $t0, $t4 
	sw $t1, 0($t6)
	addi $t4, $t4, 4
	bge $t4, $t5, bird
	j background
	
bird:
      sw $t2 1952($t0)
      sw $t2 1956($t0)
      sw $t2 1960($t0)
      sw $t2 1964($t0)
      sw $t2 1824($t0)
      sw $t2 1832($t0)
      sw $t2 2080($t0)
      sw $t2 2088($t0)
     
upper_column:
      sw $t3, 68($t0)
      sw $t3, 72($t0)
      sw $t3, 76($t0)
      sw $t3, 80($t0)
      sw $t3, 84($t0)
      
      sw $t3, 196($t0)
      sw $t3, 200($t0)
      sw $t3, 204($t0)
      sw $t3, 208($t0)
      sw $t3, 212($t0)
      
      sw $t3, 324($t0)
      sw $t3, 328($t0)
      sw $t3, 332($t0)
      sw $t3, 336($t0)
      sw $t3, 340($t0)
      
      sw $t3, 452($t0)
      sw $t3, 456($t0)
      sw $t3, 460($t0)
      sw $t3, 464($t0)
      sw $t3, 468($t0)
      
      sw $t3, 580($t0)
      sw $t3, 584($t0)
      sw $t3, 588($t0)
      sw $t3, 592($t0)
      sw $t3, 596($t0)
      
      sw $t3, 708($t0)
      sw $t3, 712($t0)
      sw $t3, 716($t0)
      sw $t3, 720($t0)
      sw $t3, 724($t0)
      
      sw $t3, 836($t0)
      sw $t3, 840($t0)
      sw $t3, 844($t0)
      sw $t3, 848($t0)
      sw $t3, 852($t0)
      
      sw $t3, 964($t0)
      sw $t3, 968($t0)
      sw $t3, 972($t0)
      sw $t3, 976($t0)
      sw $t3, 980($t0)
      
      sw $t3, 1092($t0)
      sw $t3, 1096($t0)
      sw $t3, 1100($t0)
      sw $t3, 1104($t0)
      sw $t3, 1108($t0)
      
      sw $t3, 1220($t0)
      sw $t3, 1224($t0)
      sw $t3, 1228($t0)
      sw $t3, 1232($t0)
      sw $t3, 1236($t0)
     
      
lower_column:

      sw $t3, 3012($t0)
      sw $t3, 3016($t0)
      sw $t3, 3020($t0)
      sw $t3, 3024($t0)
      sw $t3, 3028($t0)

      sw $t3, 3140($t0)
      sw $t3, 3144($t0)
      sw $t3, 3148($t0)
      sw $t3, 3152($t0)
      sw $t3, 3156($t0)

      sw $t3, 3268($t0)
      sw $t3, 3272($t0)
      sw $t3, 3276($t0)
      sw $t3, 3280($t0)
      sw $t3, 3284($t0)

      sw $t3, 3396($t0)
      sw $t3, 3400($t0)
      sw $t3, 3404($t0)
      sw $t3, 3408($t0)
      sw $t3, 3412($t0)
      
      sw $t3, 3524($t0)
      sw $t3, 3528($t0)
      sw $t3, 3532($t0)
      sw $t3, 3536($t0)
      sw $t3, 3540($t0)
      
      sw $t3, 3652($t0)
      sw $t3, 3656($t0)
      sw $t3, 3660($t0)
      sw $t3, 3664($t0)
      sw $t3, 3668($t0)
      
      sw $t3, 3780($t0)
      sw $t3, 3784($t0)
      sw $t3, 3788($t0)
      sw $t3, 3792($t0)
      sw $t3, 3796($t0)
      
      sw $t3, 3908($t0)
      sw $t3, 3912($t0)
      sw $t3, 3916($t0)
      sw $t3, 3920($t0)
      sw $t3, 3924($t0)
      
      sw $t3, 4036($t0)
      sw $t3, 4040($t0)
      sw $t3, 4044($t0)
      sw $t3, 4048($t0)
      sw $t3, 4052($t0)
	
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall