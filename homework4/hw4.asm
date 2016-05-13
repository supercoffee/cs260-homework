.data
name: .asciiz "\nBenjamin"

.text
.globl main

main:
  la $t0, name # load address of name into t0
  addi $sp, $sp, -4 # push address onto stack
  sw $t0, 0($sp)
  jal print_r

  exit:
    li $v0, 10
    syscall

print_r:
  # arg @ sp +16
  # move stack pointer down and save registers
  addi $sp, $sp, -16
  sw $ra, 4($sp) # save return address to stack
  sw $s0, 8($sp)
  sw $s1, 12($sp)

  lw $s0, 16($sp) # load string address from stack
  lb $s1, ($s0) # load byte from address into register

  beqz $s1, base_case # return if loaded character is terminator
  addi $s0, $s0, 1 # increment string pointer by 1 byte
  sw $s0, 0($sp)
  jal print_r

  # print a character
  move $a0, $s1 # load character from address again
  li $v0, 11
  syscall

  base_case:
  # reset registers and prepare to jump into hyperspace
  lw $ra, 4($sp)
  lw $s0, 8($sp)
  lw $s1, 12($sp)
  addi $sp, $sp, 16
  jr $ra
