.data

  source: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  dest: .space 20
  newline: .asciiz "\n"

.text
  .globl main

  # register usage
  # $t0: loop counter
  # $t1: source address
  # $t2: destination address
  # $t3: value to copy

  main:
    li $t0, 0       # init counter in t0
    la $t1, source  # load address of source array to register
    la $t2, dest    # load destination array address

    loop:
      beq $t0, 10, exit # branch if counter > 9
      lw $t3, ($t1)     # load value from src array into register
      andi $v0, $t3, 1  # and by 1 to see if it's odd
      beqz $v0, copy    # copy if number is even
      b loop_control    # otherwise continue loop

    copy:
      sw $t3, ($t2) # perform copy of value from register to dest

      # ========= printing junk
      li $v0, 1
      lw $a0, ($t2)
      syscall
      li $v0, 4
      la $a0, newline
      syscall
      # ========== End printing junk

      add $t2, $t2, 4   # increment destination address

    loop_control:
      addi $t0, $t0, 1  # add to counter
      add $t1, $t1, 4   # increment source address
      b loop            # jump to top of loop

  exit:
    li $v0 10 # exit
    syscall
