.data
argument: .word 10 # Number to find the factorial value of
str1: .string "Array: 5 3 6 7 31 23 43 12 45 1"
str2: .string " Sorted: "

.text
main:
        lw       a0, argument   # Load argument from static data
				addi     sp, sp, -96
				addi     a1, zero, 5
				addi     a2, zero, 3
				addi     a3, zero, 6
				addi     a4, zero, 7
				addi     a5, zero, 31
				addi     a6, zero, 23
				addi     a7, zero, 43
				addi     s2, zero, 12
				addi     s3, zero, 45
				addi     s4, zero, 1
        jal      ra, bubble       # Jump-and-link to the 'fact' label

        # Print the result to console
        jal      ra, printResult
				addi		 sp, sp, 96

        # Exit program
        li       a0, 10
        ecall

bubble:
				sw			 ra, 80(sp)
				jal			 ra, sort11
				jal			 ra, sort22
				jal			 ra, sort33
				jal			 ra, sort44
				jal			 ra, sort55
				jal			 ra, sort66
				jal			 ra, sort77
				jal			 ra, sort88
				jal			 ra, sort99
				lw			 ra, 80(sp)
				ret
sort11:
				sw			 ra, 88(sp)
				jal			 ra, sort1
sort22:
				sw			 ra, 88(sp)
				jal			 ra, sort2
sort33:
				sw			 ra, 88(sp)
				jal			 ra, sort3
sort44:
				sw			 ra, 88(sp)
				jal			 ra, sort4
sort55:
				sw			 ra, 88(sp)
				jal			 ra, sort5
sort66:
				sw			 ra, 88(sp)
				jal			 ra, sort6
sort77:
				sw			 ra, 88(sp)
				jal			 ra, sort7
sort88:
				sw			 ra, 88(sp)
				jal			 ra, sort8
sort99:
				sw			 ra, 88(sp)
				jal			 ra, sort9
sort1:
        bge      s2, s1, rett
				add			 t0, s2, zero
				add			 s2, s1, zero
				add			 s1, t0, zero
				sw		   t0, 16(sp)
				ret
sort2:
        bge      s3, s2, rett
				add			 t0, s3, zero
				add			 s3, s2, zero
				add			 s2, t0, zero
				sw		   t0, 16(sp)
				jal			 ra, sort1
sort3:
				lw			 t0, 16(sp)
				lw		   t1, 24(sp)
        bge      t1, t0, rett
				sw			 t1, 16(sp)
				sw		   t0, 24(sp)
				jal			 a4, sort2
sort4:
				lw			 t0, 24(sp)
				lw		   t1, 32(sp)
        bge      t1, t0, rett
				sw			 t1, 24(sp)
				sw		   t0, 32(sp)
				jal			 ra, sort3
sort5:
				lw			 t0, 32(sp)
				lw		   t1, 40(sp)
        bge      t1, t0, rett
				sw			 t1, 32(sp)
				sw		   t0, 40(sp)
				jal			 ra, sort4
sort6:
				lw			 t0, 40(sp)
				lw		   t1, 48(sp)
        bge      t1, t0, rett
				sw			 t1, 40(sp)
				sw		   t0, 48(sp)
				jal			 ra, sort5
sort7:
				lw			 t0, 48(sp)
				lw		   t1, 56(sp)
        bge      t1, t0, rett
				sw			 t1, 48(sp)
				sw		   t0, 56(sp)
				jal			 ra, sort6
sort8:
				lw			 t0, 56(sp)
				lw		   t1, 64(sp)
        bge      t1, t0, rett
				sw			 t1, 56(sp)
				sw		   t0, 64(sp)
				jal			 ra, sort7
sort9:
				lw			 t0, 64(sp)
				lw		   t1, 72(sp)
        bge      t1, t0, rett
				sw			 t1, 64(sp)
				sw		   t0, 72(sp)
				jal			 ra, sort8

rett:
				lw			 ra, 88(sp)
				ret

# expects:
# a0: Value which factorial number was computed from
# a1: Factorial result
printResult:
				la       a1, str1
        li       a0, 4
        ecall

        la       a1, str2
        li       a0, 4
        ecall

				lw       t0, 0(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 8(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 16(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 24(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 32(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 40(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 48(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 56(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 64(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				lw       t0, 72(sp)
        mv       a1, t0
        li       a0, 1
        ecall

				ret