.data
name: .asciiz "Benjamin"

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
  lb $a0, ($a0)

  # print a character
  li $v0, 11
  syscall

  # reset registers and prepare to jump into hyperspace
  lw $ra, 4($sp)
  lw $a0, 0($sp)
  addi $sp, $sp, 8
  jr $ra

  # load contents of src into register
  # if contents == 0: stop recursion
  # else increment src address
  # save current src address to stack
  # subtract stack pointer
  # call print_r

  # load address back from stack
  # load contents into register
  # print character
  # return to previous call
