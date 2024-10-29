
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"

.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos

arrayNotSorted: .word marianna, markos, maria, marios

.text

            li   a0, 4
            li   a1, 4
            blt  a0, a1, recCheck
            
            #jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
            lbu t0, 0(a0)
            lbu t1, 0(a1)
            sub t2, t0, t1
            addi a0, a0, 1
            addi a1, a1, 1
            j str_ge
            jr   ra
 
# ----------------------------------------------------------------------------
# recCheck(array, size)
# if size == 0 or size == 1
#     return 1
# if str_ge(array[1], array[0])      # if first two items in ascending order,
#     return recCheck(&(array[1]), size-1)  # check from 2nd element onwards
# else
#     return 0

recCheck:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
#---------
            add a2, a0, zero
            add a3, a1, zero
            lw a0, 4(a2)
            lw a1, 0(a2)
            
            j str_ge
            jr   ra
