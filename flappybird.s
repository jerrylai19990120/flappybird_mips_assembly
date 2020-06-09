#####################################################################
#
# CSC258H5S Winter 2020 Assembly Programming Project
# University of Toronto Mississauga
#
# Group members:
# - Student 1: Daniel Wei, 1004274420
# - Student 2: Yihui Lai, 1004191279
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8					     
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
# Which milestone is reached in this submission?
# (See the assignment handout for descriptions of the milestones)
# - Milestone 2, some attempts for milestone 3 and 1 feature
#
# Which approved additional features have been implemented?
# (See the assignment handout for the list of additional features)
# 1. Background change colour with time
# 2. (fill in the feature, if any)
# 3. (fill in the feature, if any)
# ... (add more if necessary)
#
# Any additional information that the TA needs to know:
# - Program sometimes crashes when testing.

#
#####################################################################
.data
	displayAddress:	.word	0x10008000
	#Colors
	birdColour: .word	0xffff00	 # yellow
	backgroundColour: .word	0x00ccff 	 # blue
	darkBlue: .word 0x00008B
	purple: .word 0x6A0DAD
	pipeColour: .word	0x00ff00	 # green	

	
	#game info
	size: .word 4094
	strokeAdd: .word 0xffff0000 # address of if a key is pressed
	contentAdd: .word 0xffff0004 # address of ascii code of which  button pressed
	
	

.text

main:
	lw $t0, displayAddress 
	lw $t1, backgroundColour
	lw $t2, birdColour
	lw $t3, pipeColour
	lw $a0, size
	li $a1, 0

	
# draw the background	
background:
	add $a2, $t0, $a1
	sw $t1, 0($a2)
	addi $a1, $a1, 4
	bge $a1, $a0, draw	# branch to bird
	j background		# keep drawing background
	
draw: # draw the starting level of the game
	li $t9, 0
	#hard oode draw bird
	addi $t7, $t0 1952
	sw $t2 0($t7)
	sw $t2 4($t7)
	sw $t2 8($t7)
	sw $t2 12($t7)
	sw $t2 -128($t7)
	sw $t2 128($t7)
	sw $t2 136($t7)
	sw $t2 -120($t7)
	
	
	addi $t4, $t0, 1536
	addi $t5, $t0, 2688

	#3969
	li $t6,68 # start pos
	
	
	addi $a0 ,$t0, 0	# Initialize beginning 
	addi $a1, $t4, 0 # Initialize end 
	
	jal drawPipe
	
	addi $a0, $t5, 0	# Initialize beginning 
	addi $a1, $t0, 3969 # Initialize end 
	jal drawPipe
	
	j game
	
drawPipe:
	 
	startOutloop:  
  	bge $a0, $a1, endOutloop 
				#Inner loop  
  	add $a2, $a0, $t6      # Initialize beginning  
  	addi $a3, $a2,20      # Initialize end  
	startInloop:  
  	bge $a2, $a3, endInloop 
  	sw $t3,($a2) 
	addi $a2, $a2, 4    # Increment counter  
	b startInloop  
	endInloop:  		#Inner loop  
	addi $a0, $a0, 128    # Increment counter  
  	b startOutloop 
	endOutloop:
	jr $ra	

drawMap:
	startOutloop1:  
  	bge $a0, $a1, endOutloop1 
				#Inner loop  
  	add $a2, $a0, 0     # Initialize beginning  
  	addi $a3, $a2,200      # Initialize end  
	startInloop1:  
  	bge $a2, $a3, endInloop1 
  	sw $t1,($a2) 
	addi $a2, $a2, 4    # Increment counter  
	b startInloop1  
	endInloop1:  		#Inner loop  
	addi $a0, $a0, 128    # Increment counter  
  	b startOutloop1 
	endOutloop1:

	jr $ra	
		
ereasePipe:
	 
	EstartOutloop:  
  	bge $a0, $a1, EendOutloop 
				#Inner loop  
  	add $a2,$a0, $t6       # Initialize beginning  
  	addi $a3, $a2, 20      # Initialize end  
	EstartInloop:  
  	bge $a2, $a3, EendInloop 
  	sw $t1,($a2) 
	addi $a2, $a2, 4    # Increment counter  
	b EstartInloop  
	EendInloop:  		#Inner loop  
	addi $a0, $a0, 128    # Increment counter  
  	b EstartOutloop 
	EendOutloop:
	jr $ra	
game:
	#sleep
	li $v0, 32
	li $a0, 800
	syscall
	

        
        li $a1, 0xffff0000
	lw $a2, ($a1)
	beqz $a2, drop		# drop the bird if no input
	li $a1, 0xffff0004
	lw $a2, ($a1)
	beq $a2, 102, jump	# jump the bird if input f
	
        
        
	
	
drop:
#erease bird
	sw $t1 0($t7)
	sw $t1 4($t7)
	sw $t1 8($t7)
	sw $t1 12($t7)
	sw $t1 -128($t7)
	sw $t1 128($t7)
	sw $t1 136($t7)
	sw $t1 -120($t7)

	#erease pipe
	addi $a0, $t0, 0
	move $a1, $t4
	jal ereasePipe
	
	move $a0, $t5
	addi $a1, $t0, 3969
	jal ereasePipe

	#DRAWMAP
	
	
	jal loadColor
	addi $a0, $t0, 0	# Initialize beginning 
	addi $a1, $t0, 3969 
	jal drawMap
	
	#draw bird
	sw $t2 128($t7)
	sw $t2 132($t7)
	sw $t2 136($t7)
	sw $t2 140($t7)
	sw $t2 0($t7)
	sw $t2 256($t7)
	sw $t2 264($t7)
	sw $t2 8($t7)
	addi $t7,$t7,128
	# redraw pipe
	
	addi $t6, $t6, -4
	
	move $a0, $t0
	move $a1, $t4
	jal drawPipe
	
	move $a0, $t5
	addi $a1, $t0, 3969
	jal drawPipe
	
	bge $t7,$t5, Reinitialize
	ble $t6, 0, new
	j game

loadColor:
	beq $t9,0, loadPurple
	beq $t9,1, loadDark
	beq $t9,2, loadBlue
	load:
	move $t1, $a1
	jr $ra
loadPurple:
	lw $a1, purple
	li $t9,1
	j load
loadDark:
	lw $a1, darkBlue
	li $t9,2
	j load
loadBlue:
	lw $a1, backgroundColour
	li $t9,0
	j load
jump:
#erease bird
	sw $t1 0($t7)
	sw $t1 4($t7)
	sw $t1 8($t7)
	sw $t1 12($t7)
	sw $t1 -128($t7)
	sw $t1 128($t7)
	sw $t1 136($t7)
	sw $t1 -120($t7)
	
	#erease pipe
	addi $a0, $t0, 0
	move $a1, $t4
	jal ereasePipe
	
	move $a0, $t5
	addi $a1, $t0, 3969
	jal ereasePipe
	
	jal loadColor
	addi $a0, $t0, 0	
	addi $a1, $t0, 3969 
	jal drawMap
	
	#draw
	sw $t2 -128($t7)
	sw $t2 -124($t7)
	sw $t2 -120($t7)
	sw $t2 -116($t7)
	sw $t2 -256($t7)
	sw $t2 0($t7)
	sw $t2 8($t7)
	sw $t2 -248($t7)
	addi $t7,$t7,-128

	# redraw pipe
	addi $t6, $t6, -4
	
	move $a0, $t0
	move $a1, $t4
	jal drawPipe
	
	move $a0, $t5
	addi $a1, $t0, 3969
	jal drawPipe
	
	ble $t7,$t4, Reinitialize
	ble $t6, 0, new
	j game

new:
	# erease
	addi $a0, $t0, 0
	move $a1, $t4
	jal ereasePipe
	
	move $a0, $t5
	addi $a1, $t0, 3969
	jal ereasePipe
	
	
	li $t6, 68  # change position of pipe
	
	addi $a0 ,$t0, 0	
	addi $a1, $t4, 0 
	
	jal drawPipe
	
	addi $a0, $t5, 0	
	addi $a1, $t0, 3969 
	jal drawPipe
	
	j Reinitialize

	
Reinitialize:
        add $a1, $zero, $zero
        addi $t5, $zero, 4094
End_background:
        add $t6, $t0, $a1
	sw $t1, 0($t6)
	addi $a1, $a1, 4
	bge $a1, $t5, Bye_text	
	j End_background	

Bye_text:
        sw $t2, 1444($t0)
        sw $t2, 1572($t0)
        sw $t2, 1700($t0)
        sw $t2, 1828($t0)
        sw $t2, 1832($t0)
        sw $t2, 1836($t0)
        sw $t2, 1840($t0)
        sw $t2, 1956($t0)
	sw $t2, 2084($t0)
	sw $t2, 2212($t0)
	sw $t2, 2340($t0)
	sw $t2, 2344($t0)
	sw $t2, 2348($t0)
	sw $t2, 2352($t0)
	sw $t2, 2224($t0)
	sw $t2, 2096($t0)
	sw $t2, 1968($t0)
	sw $t2, 1852($t0)
	sw $t2, 1864($t0)
	sw $t2, 1980($t0)
	sw $t2, 2108($t0)
	sw $t2, 2236($t0)
	sw $t2, 2240($t0)
	sw $t2, 2244($t0)
	sw $t2, 1992($t0)
	sw $t2, 2120($t0)
	sw $t2, 2248($t0)
	sw $t2, 2376($t0)
	sw $t2, 2504($t0)
	sw $t2, 2500($t0)
	sw $t2, 2496($t0)
	sw $t2, 2492($t0)
	
	sw $t2, 1876($t0)
	sw $t2, 2004($t0)
	sw $t2, 2132($t0)
	sw $t2, 2260($t0)
	sw $t2, 2388($t0)
	sw $t2, 1880($t0)
	sw $t2, 1884($t0)
	sw $t2, 1888($t0)
	sw $t2, 2136($t0)
	sw $t2, 2140($t0)
	sw $t2, 2144($t0)
	sw $t2, 2392($t0)
	sw $t2, 2396($t0)
	sw $t2, 2400($t0)
	
	sw $t2, 1768($t0)
	sw $t2, 1772($t0)
	sw $t2, 1896($t0)
	sw $t2, 1900($t0)
	sw $t2, 2024($t0)
	sw $t2, 2028($t0)
	sw $t2, 2152($t0)
	sw $t2, 2156($t0)
	sw $t2, 2280($t0)
	sw $t2, 2284($t0)
	
	sw $t2, 2536($t0)
	sw $t2, 2540($t0)
	sw $t2, 2664($t0)
	sw $t2, 2668($t0)
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall
    
