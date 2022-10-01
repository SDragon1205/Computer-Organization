# This example shows an implementation of the mathematical
# factorial function (! function).

.data
argument: .word 7 # Number to find the factorial value of
str1: .string "th number in the Fibonacci sequence is "

.text
main:
        lw       a0, argument   # Load argument from static data
        jal      ra, fibonacci       # Jump-and-link to the 'fact' label

        # Print the result to console
        mv       a1, a0
        lw       a0, argument
        jal      ra, printResult

        # Exit program
        li       a0, 10
        ecall

fibonacci:
        addi     sp, sp, -24
			  sw       ra, 0(sp)
        sw       a0, 8(sp)
        addi     t0, a0, -1
        addi     t1, zero, 2
        bge      t0, t1, nfibonacci
				
				addi     t1, zero, 0
				sw       t1, 8(sp)
				addi     t1, zero, 1
				sw       t1, 16(sp)
			  add      a0, zero, zero
        jalr     x0, x1, 0

nfibonacci:
        addi     a0, a0, -1
        jal      ra, fibonacci

        lw       ra, 0(sp)
        lw       t0, 8(sp)
        lw       t1, 16(sp)
        lw       a0, 16(sp)
        addi     sp, sp, 24

        add      a0, a0, t0
			  sw       t1, 8(sp)
        sw       a0, 16(sp)
        ret


# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
        mv       t0, a0
        mv       t1, a1

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        ret
