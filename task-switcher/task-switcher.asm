.data

tcb0: .space 128
tcb1: .space 128
tid: .word 0

task_0_message: .asciiz "Doing shit: (task 0)\n"
task_1_message: .asciiz "Doing shit: (task 1)\n"

.text
.globl main

main:
  la $t0, tcb0
  la $t1, task_0
  sw $t1, ($t0)
  move $ra, $t1

  la $t0, tcb1
  la $t1, task_1
  sw $t1, ($t0)

  #call task switcher
  j task_switcher


task_switcher:
  addi $sp, $sp, -4
  sw $t0, ($sp)
  # load address of current TCB into t0
  lw $t0, tid
  bnez $t0, save_1   # otherwise load 0

  la $t0, tcb0 # Load address of current TCB into t0
  j save_reg

  save_1:
  la $t0, tcb1

  save_reg: # save registers to current TCB
  sw $ra, ($t0)

  # load next task control block and set TID
  lw $t0, tid
  la $t1, tid # load address of TID to t1
  beqz $t0, load_1
  li $t0, 0 # set next task to 0
  sw $t0, ($t1)
  la $t0, tcb0
  j restore_reg
  load_1:
  li $t0, 1
  sw $t0, ($t1)
  la $t0, tcb1

  # restore registers from other task
  restore_reg:
  lw $ra, ($t0)

  # restore stack
  addi $sp, $sp, 4

  # jump to ra
  j $ra


task_0:
  # print important message
  la $a0, task_0_message
  li $v0, 4
  syscall

  jal task_switcher

  la $a0, task_0_message
  li $v0, 4
  syscall

  jal task_switcher

  j task_0


task_1:
  # print important message
  la $a0, task_1_message
  li $v0, 4
  syscall

  jal task_switcher

  la $a0, task_1_message
  li $v0, 4
  syscall

  jal task_switcher

  j task_1
