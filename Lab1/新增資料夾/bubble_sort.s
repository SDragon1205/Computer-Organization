.data
N: .word 10
str1: .string "Array: "
str2: .string "Sorted: \n"
str3: .string " "
str4: .string "\n"
data:
  .word 5 # 0x5
  .word 3 # 0x3
  .word 6 # 0x6
  .word 7 # 0x7
  .word 31 # 0x1f
  .word 23 # 0x17
  .word 43 # 0x2c
  .word 12 # 0xc
  .word 45 # 0x2d
  .word 1 # 0x2

.text
main:
        la a1,str1
        jal ra,printstring

        la a1,str4
        li a0,4
        ecall

        jal ra,print

        jal ra,bubblesort

        la a1,str2
        jal ra,printstring

        jal print

        # Exit program
        li       a0, 10
        ecall

printstring:
    li a0,4
    ecall 
    ret


bubblesort:
    # save reg
    addi sp,sp,-8
    sw ra,0(sp)

    li t0,0
    lw t2,N
bubblesort_out:
    bge t0,t2,bubblesort_out_end
    addi t1,t0,-1
bubblesort_in:
    blt t1,zero,bubblesort_in_end
    la t3,data
    slli t6,t1,2
    add t3,t3,t6
    lw t4,0(t3)
    lw t5,4(t3)
    bge t5,t4,bubblesort_in_end

    la a0,data
    mv a1,t1
    jal ra,swap

    addi t1,t1,-1
    j bubblesort_in

bubblesort_in_end:
    addi t0,t0,1
    j bubblesort_out
bubblesort_out_end:
    lw ra,0(sp)
    addi sp,sp,8
    ret

swap:
    addi sp,sp,-24
    sw t0,0(sp)
    sw t1,8(sp)
    sw t2,16(sp)
    slli a1,a1,2
    add t1,a0,a1
    lw t0,0(t1)
    lw t2,4(t1)
    sw t2,0(t1)
    sw t0,4(t1)
    lw t0,0(sp)
    lw t1,8(sp)
    lw t2,16(sp)
    addi sp,sp,24
    ret

print:
    li t0,0
    lw t1,N

print_for:
    bge t0,t1,print_end
    
    la t2,data
    slli t4,t0,2
    add t2,t2,t4

    lb a1,0(t2)
    li a0,1
    ecall 

    la a1,str3
    li a0,4
    ecall 

    # i++
    addi t0,t0,1
    j print_for

print_end:
    la a1,str4
    li a0,4
    ecall 
    ret