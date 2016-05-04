# By Benjamin Daschel
.data
src: .asciiz "Hello world!"
dest: .space 20
newline: .asciiz "\n"

.text
.globl main

main:
  # perform copy of "Hello"
  la $a0, dest
  la $a1, src
  li $a2, 5
  jal strncpy

  # print destination after copy
  la $a0, dest
  li $v0, 4
  syscall
  la $a0, newline
  syscall

  # perform copy of "Hello world!"
  la $a0, dest
  la $a1, src
  li $a2, 12
  jal strncpy

  # print destination after copy
  la $a0, dest
  li $v0, 4
  syscall
  la $a0, newline
  syscall

  # Bye-Bye
  li $v0, 10
  syscall

strncpy:
  # a0: dest
  # a1: src
  # a2: n bytes to copy

  # t0: counter
  # t1: source or destination address
  # t2: temp register
  move $t0, $zero # init counter to 0

  strncpy_loop:
    beq $t0, $a2, strncpy_exit # return when counter = n
    move $t1, $a1 # copy source address into register
    add $t1, $t1, $t0 # add counter to source address (offset)
    lb $t2, 0($t1) # load byte from source into temp register

    move $t1, $a0 # copy destination address to temp register
    add $t1, $t1, $t0 # add counter to destination address
    sb $t2, 0($t1) # store byte from temp to destination
    addi $t0, $t0, 1 # increment counter
  j strncpy_loop

  strncpy_exit:
    move $t1, $a0
    add $t1, $t1, $t0
    sb $zero, 0($t1) # append zero byte to destination
    jr $ra
