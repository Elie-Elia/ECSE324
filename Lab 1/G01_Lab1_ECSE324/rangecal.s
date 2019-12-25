			.text
			.global _start

_start:
			LDR R4, =RESULT //R4 points to the result location in memory
			LDR R2, [R4, #4] //R2 holds the number of elements in the list
			ADD R3, R4, #8 //R3 points to the first number in the list
			LDR R0, [R3] //R0 holds our current max = first element at start of list
			LDR R5, [R3] //R5 will hold our current min = first element at start of list

LOOP: 			SUBS R2, R2, #1 //decrement the loop counter
			BEQ DONE //End loop if counter has reached zero
			ADD R3, R3, #4 //R3 points to the next number in the list
			LDR R1, [R3] //R1 holds the value of the next number in the list

			CMP R0, R1 //Compare the current max (R0) with the next element in list 
			BGE MIN //Branch on greater than or equal to check if it is the min element
			MOV R0, R1 //If it is the new max, swap with current max
MIN: 		
			CMP R5, R1 //Compare the current min (R5) with the next element in the list
			BLE LOOP //Branch on less than or equal back to loop
			MOV R5, R1 //If it is the new min, swap with current min

			B LOOP //Branch back to the loop

DONE:			SUBS R0, R0, R5 //Subtract minimum element from maximum element to find the range
			STR R0, [R4] //Store the result to the memory location

END:			B END //Infinite loop

RESULT:			.word	0
N:			.word	7
NUMBERS:		.word 	4, 3, 2, 0
			.word   9, 5, 1
