			.text
			.global _start 
_start:
			LDR R0, =MAXRESULT	//R0 holds the address of MAXRESULT in the memory
			LDR R1, =MINRESULT	//R1 holds the address of MINRESULT in the memory
			LDR R2, [R0, #8] 	//R2 is a counter for the number of elements in the list
			ADD R3, R0, #12		//R3 is a ptr to the first number
			LDR R4, [R3]		//R4 holds the value of the first number 
			SUB R5, R5, R5		//A R5 register to hold the sum of the values, reset.

			ADD R2, R2, #1 		//Add one to the counter for loop

FINDSUM:	SUBS R2, R2, #1		//loop through by decrementing r2
			BEQ FOUNDSUM		//End loop if equal to zero 
			ADD R5, R5, R4		//Add R4 to the sum R5
			ADD R3, R3, #4		//move R3 to point to next number on the list
			LDR R4, [R3]		//R4 holds value of next num in list
			B FINDSUM			//loop

//foundsum to reset everything
FOUNDSUM:	SUB R6, R6, R6		//Clears the R6 register
			LDR R2, [R0, #8]	//reset the counter R2 to work for next loop
			ADD R3, R0, #12		//R3 to point to first number
			LDR R4, [R3]		//R4 holds the first number of the list

LOOPMAX:	SUBS R2, R2, #1		//loop through by decrementing r2 again
			BEQ UPDATEMAX		//End loop if equal to zero
			ADD R3, R3, #4		//R3 points to the next number on the list	
			LDR R10, [R3]		//Load the value of the next num in a temporary register R10
			ADD R7, R4, R10		//Add the first number to R10, and store in new Register R7
			SUB R8, R5, R7		//Calculate the sum of the other pair (sum - xsum) 
			MUL R9, R8, R7		//Mulitiply both sums i.e. Xsum * (Sum - Xsum)
			CMP R6, R9			//Check if multiplied prod is greater than R6
			BGE LOOPMAX			//If not, branch back to loop 
			MOV R6, R9			//If yes, update the current max
			B LOOPMAX			//LOOP

UPDATEMAX:	STR R6, [R0]		//Store result in memory 
			LDR R2, [R0, #8]	//Reinitializes counter
			ADD R3, R0, #12		//R3 points to the first number 
			LDR R4, [R3]		//R4 holds the first number of the list 

LOOPMIN:	SUBS R2, R2, #1		//Decrement register that counts number of iterations
			BEQ UPDATEMIN		//End loop if equal to zero
			ADD R3, R3, #4		//R3 points to the next number on the list	
			LDR R10, [R3]		//Load the value of the next num in a temporary register R10
			ADD R7, R4, R10		//Add the first number in the list with the following one
			SUB R8, R5, R7		//Calculate the sum of the other pair (sum - xsum) 
			MUL R9, R8, R7		//Mulitiply both sums  i.e. Xsum * (Sum - Xsum)
			CMP R6, R9			//Check if the product is smaller than R6
			BLE LOOPMIN		    //If not, branch back to loop 
			MOV R6, R9			//If yes, update the current min
			B LOOPMIN			//Branch back to loop

UPDATEMIN:	STR R6, [R1]		//Store result in  memory 

END: 		B END

MAXRESULT:	.word	0			
MINRESULT:	.word	0
N:			.word	4 //length of the list
NUMBERS:	.word	1, 2, 3, 4 //list of nums
