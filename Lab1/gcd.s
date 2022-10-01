# This example shows an implementation of the mathematical
# factorial function (! function).

.data
argument: .word 4 # Number to find the factorial value of
brgument: .word 8 # Number to find the factorial value of
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
        lw       a0, argument   # Load argument from static data
        lw       a1, brgument   # Load argument from static data
        jal      ra, gcd_re       # Jump-and-link to the 'fact' label

        # Print the result to console
        mv       a2, a0
        lw       a0, argument   # Load argument from static data
        lw       a1, brgument   # Load argument from static data
				jal      ra, print

        # Exit program
        li       a0, 10
				li       a1, 10
        ecall

gcd_re:
				addi     sp, sp, -8
				sw       ra, 0(sp)
				jal      ra, gcd
				ret

gcd:

        bne      a1, zero, gcd2
				lw       ra, 0(sp)
				addi     sp, sp, 8

				ret

gcd2:
        jal      ra, papa_re
				add      t0, zero, a0
				add      a0, zero, a1
				add      a1, zero, t0
        jal      a3, gcd       #return

				ret

papa_re:
				addi     sp, sp, -8
				sw       ra, 0(sp)
				jal      ra, papa
				ret

papa:
        sub      t0, a0, a1
        bge      t0, zero, subb
				lw       ra, 0(sp)
				addi     sp, sp, 8

				ret

subb:
				sub			 a0, a0, a1
				jal      a4, papa

				ret


# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
print:
        mv       t0, a0
        mv       t1, a1
				mv		   t2, a2

        la       a1, str1
        li       a0, 4
        ecall

        mv       a1, t0
        li       a0, 1
        ecall

        la       a1, str2
        li       a0, 4
        ecall

        mv       a1, t1
        li       a0, 1
        ecall

        la       a1, str3
        li       a0, 4
        ecall


        mv       a1, t2
        li       a0, 1
        ecall

				ret