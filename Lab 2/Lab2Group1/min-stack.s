			.text
			.global _start

_start:
			LDR R0, =INPUT //Load memory address of input into R0
			BL DOMIN //Branch and load address of next instruction into link register

END:		B END

DOMIN:
			PUSH {R1-R3,LR} //Save current processor state of R1, R2, R3
			MOV R2, #3 //Load R2 with the value 3 (number of input elements) to act as our counter 
			MOV R1, R0 //Move contents of R0 into R1
			LDR R0, [R0] //Load R0 with the data contents of R0
LOOP:
			LDR R3, [R1] //Load the data contents of R1 into R3
			CMP R3, R0 //Compare the values of R3 and R0
			MOVLE R0, R3 //If comparison value is less than or equal to 0, move contents of R3 into R0
			ADD R1, R1, #4 //Increment contents of R1 by 4 to point to next element in list
			SUBS R2, R2, #1 //Decrement counter for loop
			BNE LOOP //Branch if loop has not reached zero
			POP {R1-R3, LR} //Pop values to R1, R2, R3 from link register
			BX LR //Return previous processor state

INPUT:
			.word 3, 2, 69 //input list of elements


