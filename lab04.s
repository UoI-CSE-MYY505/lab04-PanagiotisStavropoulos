
.globl str_ge, recCheck

.data

maria:    .string "Maria"
markos:   .string "Markos"
marios:   .string "Marios"
marianna: .string "Marianna"
.align 4  # make sure the string arrays are aligned to words (easier to see in ripes memory view)

# These are string arrays
# The labels below are replaced by the respective addresses
arraySorted:    .word maria, marianna, marios, markos, naveen

arrayNotSorted: .word marianna, markos, maria

.text

            la   a0, arrayNotSorted
            li   a1, 4
            jal  recCheck

            li   a7, 10
            ecall

str_ge:
#---------
# Write the subroutine code here
#  You may move jr ra   if you wish.
    lbu t0, 0(a0)
    lbu t1, 0(a1)
    beq t1, zero, returntrue
    beq t0, zero, returntrue
    blt t0, t1, returnfalse
    addi a0, a0, 1
    addi a1, a1, 1
    beq t0, t1 , str_ge

returntrue:
    li a0,1
    jr ra
    
returnfalse:
    li a0, 0
    jr ra

    

#---------
 
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
    add a2, zero, a0
    add a3, zero, a1
    j rec
rec:
    slti t0, a3, 2
    beq t0, zero, check
    li a0, 1
    jr ra
    
check:
    addi sp, sp, -4
    sw ra, 0(sp)
    lw a1, 0(a2)
    lw a0, 4(a2)
    jal str_ge
    beq a0, zero, exit
    addi a2, a2, 4
    addi a3, a3, -1
    jal rec
    
exit:
    lw ra, 0(sp)
    addi sp, sp, 4
    jr ra
#---------
