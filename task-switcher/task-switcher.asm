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
  sw $t1, 120($t0)
  move $ra, $t1

  la $t0, tcb1
  la $t1, task_1
  sw $t1, 120($t0)

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
    sw $2, 4($t0)
    sw $3, 8($t0)
    sw $4, 12($t0)
    sw $5, 16($t0)
    sw $6, 20($t0)
    sw $7, 24($t0)
    # sw $8, 28($t0) # Skip over t0 since it's in use
    sw $9, 32($t0)
    sw $10, 36($t0)
    sw $11, 40($t0)
    sw $12, 44($t0)
    sw $13, 48($t0)
    sw $14, 52($t0)
    sw $15, 56($t0)
    sw $16, 60($t0)
    sw $17, 64($t0)
    sw $18, 68($t0)
    sw $19, 72($t0)
    sw $20, 76($t0)
    sw $21, 80($t0)
    sw $22, 84($t0)
    sw $23, 88($t0)
    sw $24, 92($t0)
    sw $25, 96($t0)
    # Don't save special registers because it breaks things
    # sw $26, 100($t0)
    # sw $27, 104($t0)
    # sw $28, 108($t0)
    # sw $29, 112($t0)
    # sw $30, 116($t0)
    sw $31, 120($t0)

    # save $t0 because it's no
    lw $t1, ($sp)
    sw $t1, 28($t0)

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
    lw $2, 4($t0)
    lw $3, 8($t0)
    lw $4, 12($t0)
    lw $5, 16($t0)
    lw $6, 20($t0)
    lw $7, 24($t0)
    # lw $8, 28($t0) # skip t0 because it's in use
    lw $9, 32($t0)
    lw $10, 36($t0)
    lw $11, 40($t0)
    lw $12, 44($t0)
    lw $13, 48($t0)
    lw $14, 52($t0)
    lw $15, 56($t0)
    lw $16, 60($t0)
    lw $17, 64($t0)
    lw $18, 68($t0)
    lw $19, 72($t0)
    lw $20, 76($t0)
    lw $21, 80($t0)
    lw $22, 84($t0)
    lw $23, 88($t0)
    lw $24, 92($t0)
    lw $25, 96($t0)
    # Don't restore special registers because it breaks things
    # lw $26, 100($t0)
    # lw $27, 104($t0)
    # lw $28, 108($t0)
    # lw $29, 112($t0)
    # lw $30, 116($t0)
    lw $31, 120($t0)

    # restore $t0
    lw $t0, 28($t0)

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
