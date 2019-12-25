			.text
			.global _start

_start:

PUSH_STACK:
			MOV R0, #2 //Load register R0 with 2
			PUSH {R0} //Push value in R0 (2) to the stack
			MOV R0, #3 //Load R0 with 3
			PUSH {R0} //Push value in R0 (3) to the stack
			MOV R0, #4 //Load R0 with 4
			PUSH {R0} //Push value in R0 (4) to the stack

POP_STACK:
			POP {R1-R3} //Pop values from the stack and store in respective registers, R1, R2, R3

END:		B END
