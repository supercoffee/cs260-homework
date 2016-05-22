.data

tcb0: .byte 128
tcb1: .byte 128
tid: .word 1

task_0_message: .asciiz "Doing shit: (task 0)\n"
task_1_message: .asciiz "Doing shit: (task 1)\n"

.text
.globl main
main:
  la $t0, tcb0
  la $t1, task_0
  sw $t1, ($t0)

  la $t0, tcb1
  la $t1, task_1
  sw $t1, ($t0)
  #call task switcher
  jal task_switcher


task_switcher:
  # push t0 onto stack
  # load address of current TCB into t0
  #
  # save registers to current TCB
  # restore registers from other task
  # set current task ID
  # jump to ra


task_0:
  # print important message
  la $a0, task_0_message
  li $v0, 4
  syscall
  jal task_switcher
  la $a0, task_0_message
  li $v0, 4
  syscall


task_1:
  # print important message
  la $a0, task_1_message
  li $v0, 4
  syscall

  jal task_switcher

  la $a0, task_1_message
  li $v0, 4
  syscall
