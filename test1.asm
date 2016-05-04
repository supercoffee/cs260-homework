.data

src: .asciiz "Hello world!"
dest: .space 20
newline: .asciiz "\n"

.text
.globl main

main:
  # print source just to make sure program works
  la $a0, src
  li $v0, 4
  syscall
  la $a0, newline
  syscall

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
  move $t0, $a2 # copy n into counter to preserve original
  move $t1, $a1 # current source
  move $t2, $a0 # current destination
  strncpy_loop:
    beqz $t0, strncpy_exit # return when counter = 0

    lb $t4, 0($t1)
    sb $t4, 0($t2)

    addi $t1, $t1, 1 # move source pointer by 1
    addi $t2, $t2, 1 # move destination pointer by 1
    addi $t0, $t0, -1 # decrement counter
  j strncpy_loop

  strncpy_exit:
    sb $zero, 0($t2) # append zero byte to destination
    jr $ra
