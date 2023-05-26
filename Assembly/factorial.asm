.globl main

.text

main:

    ##
    ## a0 = fact(a0)
    li  a0, 5
    jal ra, fact
    
    li	a7, 1
    ecall

    li  a7, 93
    li	a0, 0
    ecall

fact:

    addi    sp, sp, -8             ## gestione dello stack
    addi    s0, a0, -1
    sw      ra, 4(sp)
    sw      a0, 0(sp)

    bge	    s0, zero, loop          ## if n >= 1
    li      a0, 1                   ## caso base della ricorsione
    addi    sp, sp, 8
    jr	    ra

    loop:
            addi    a0, a0, -1
            jal     ra, fact
            mv      s1, a0          ## punto di ritorno

            lw      a0, 0(sp)
            lw      ra, 4(sp)
            addi    sp, sp, 8
            mul     a0, a0, s1

    jr    ra 
