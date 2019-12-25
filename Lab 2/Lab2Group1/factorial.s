			.text
			.global _start

_start:
			MOV R0, #7 //Set R0 with 7 (our factorial input)
			BL FACT //Branch to factorial loop

END:		B END

FACT:
			PUSH {R1, LR} //Preserve contents of R1 by pushing it into stack
			CMP R0, #0 //Compare value of R0 to 0
			MOVEQ R0, #1 //If the result of comparison is equal to zero, set R0 to one 
			BEQ DONE //Done -> Base case has been hit n=0
			MOV R1, R0 //Move contents of R0 into R1
			SUB R0, R0, #1 //Decrement the number by one (n-1)
			BL FACT //Loop back to the Factorial loop
			MUL R0, R0, R1 //Multiply R0 and R1 and store in R0

DONE:
			POP {R1, LR} //Return back to previous processor state (original contents of R1) by popping from stack
			BX LR //Return 








