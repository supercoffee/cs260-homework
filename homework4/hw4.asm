.data
name: .asciiz "\nBenjamin"

.text
.globl main

main:
  la $a0, name # load address of name into t0
  jal print_r

  exit:
    li $v0, 10
    syscall

print_r:
  # move stack pointer down and save registers
  addi $sp, $sp, -8
  sw $a0, 0($sp)
  sw $ra, 4($sp)
  # load src address from a0
  lb $t0, ($a0)

  # return if loaded character is terminator
  beqz $t0, base_case
  addi $a0, $a0, 1 # increment string pointer by 1 byte
  jal print_r
  addi $a0, $a0, -1 # decrement string pointer to restore it to what
  # the current execution scope should be looking at

  # print a character
  lb $a0, ($a0) # load character from address
  li $v0, 11
  syscall

  base_case:
  # reset registers and prepare to jump into hyperspace
  lw $ra, 4($sp)
  lw $a0, 0($sp)
  addi $sp, $sp, 8
  jr $ra
