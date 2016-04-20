# Benjamin Daschel
# CS260 Homework 2 
# Homework 2: IO, addition, subtraction in MIPS assembly
.data

  prompt: .asciiz "Enter number: "
  added: .asciiz "\nSum of numbers: "
  diff: .asciiz "\nDifference of numbers: "
  newline: .asciiz "\n"
.globl main
.text

main:
  # Enter first int
  li $v0, 4
  la $a0, prompt
  syscall

  li $v0, 5 # read int
  syscall
  move $s0, $v0

  # Enter second int
  li $v0, 4
  la $a0, prompt
  syscall

  li $v0, 5 # read int
  syscall
  move $s1, $v0 # save to s1


  li $v0, 4
  la $a0, added
  syscall

  add $a0, $s0, $s1 # add directly into arg1 buffer
  li $v0, 1 # load 1 for print_int
  syscall  # call print service

  li $v0, 4
  la $a0, diff
  syscall

  neg $t0, $s1
  add $a0, $s0, $t0
  li $v0, 1
  syscall

  # exit
  li $v0, 4
  la $a0, newline
  syscall
  li $v0, 10
  syscall
