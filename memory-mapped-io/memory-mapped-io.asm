.data
buffer: .space 256

# Borrowed from http://www.cs.uwm.edu/classes/cs315/Bacon/Lecture/HTML/ch14s03.html

ISO_LF              =   10  # Line feed (newline)
CONS_RECEIVER_CONTROL           =   0xffff0000
CONS_RECEIVER_READY_MASK        =   0x00000001
CONS_RECEIVER_DATA              =   0xffff0004
CONS_XMIT_CONTROL               =   0xffff0008
CONS_XMIT_DATA                  =   0xffff000c

.text
main:

  # Spin-wait for key to be pressed
  key_wait:
    lw      $t0, CONS_RECEIVER_CONTROL
    andi    $t0, $t0, CONS_RECEIVER_READY_MASK  # Isolate ready bit
    beqz    $t0, key_wait

  output_wait:
    lw $t0, CONS_XMIT_CONTROL
    andi $t0, $t0, CONS_RECEIVER_READY_MASK
    beqz $t0, output_wait

  lbu $t0, CONS_RECEIVER_DATA
  sb $t0, CONS_XMIT_DATA

  li $t1, ISO_LF
  beq $t0, $t1, quit
  b main

  quit:
    jr      $ra
