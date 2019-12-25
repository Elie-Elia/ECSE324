			.text
			.global MIN_2

MIN_2:
			CMP R0, R1 //Compare values in registers R0, R1
			BXLE LR //Branch on index less than or equal to value of comparison, and branches to link register
			MOV R0, R1 //Otherwise, new min in R1 is moved into R0
			BX LR //Return by branching to link register
			.end


