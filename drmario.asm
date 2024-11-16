################# CSC258 Assembly Final Project ###################
# This file contains our implementation of Dr Mario.
#
# Student 1: Matthew Frieri, 1010328307
#
# We assert that the code submitted here is entirely our own 
# creation, and will indicate otherwise when it is not.
#
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       1
# - Unit height in pixels:      1
# - Display width in pixels:    32
# - Display height in pixels:   32
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

.data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL: .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD: .word 0xffff0000

##############################################################################
# Mutable Data
##############################################################################

##############################################################################
# Code
##############################################################################
.text
.globl main
    

    
draw_horz_line:
# $a0 = X pos
# $a1 = Y pos
# $a2 = color
# $a3 = length

    beq $a3 $zero main      # Break when done
    jal draw_pixel          # Draw a pixel
    addi $a0 $a0 1          # Increment the X pos
    addi $a3 $a3 -1         # Decrease the length by 1
    
    j draw_horz_line        # Back to top


draw_vert_line:
# $a0 = X pos
# $a1 = Y pos
# $a2 = color
# $a3 = length

    beq $a3 $zero main      # Break when done
    jal draw_pixel          # Draw a pixel
    addi $a1 $a1 1          # Increment the Y pos
    addi $a3 $a3 -1         # Decrease the length by 1
    
    j draw_vert_line        # Back to top


draw_pixel:
# $a0 = X pos
# $a1 = Y pos
# $a2 = color
# $v0 = return address

    lw $t0 ADDR_DSPL    # Load the root display address
    
    sll $t1 $a0 2       # Multiply the X pos by 4 (shift left 2)
    add $t0 $t0 $t1     # Add the X pos to the root
    
    sll $t1 $a1 2       # Multiply the Y pos by 4 (shift left 2)
    sll $t1 $t1 5       # Multiply the Y pos by 32 (shift left 5)
    add $t0 $t0 $t1     # Add the Y pos to the root
    
    sw $a2 0($t0)       # Draw the pixel
    jr $ra              # Return to function call
    
    
# Run the game.
main:
    li $a0 2
    li $a1 2
    li $a2 0xff0000
    li $a3 12
    
    j draw_vert_line
    # j draw_horz_line
    # Initialize the game

game_loop:
    # 1a. Check if key has been pressed
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (capsules)
	# 3. Draw the screen
	# 4. Sleep

    # 5. Go back to Step 1
    j game_loop
