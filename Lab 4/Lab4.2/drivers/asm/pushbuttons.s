			.text
			.equ PB_BASE, 0xFF200050
			.equ PB_EDGECAPTURE, 0xFF20005C
			.global read_PB_data_ASM, read_PB_edgecap_ASM, PB_edgecap_is_pressed_ASM, PB_clear_edgecp_ASM, enable_PB_INT_ASM, PB_data_is_pressed_ASM

read_PB_data_ASM:
			LDR R1, =PB_BASE			//load the address of PB_BASE
			LDR R0, [R1]				//load the data stored inside PB_BASE
			BX LR

read_PB_edgecap_ASM:
			LDR R2, =PB_EDGECAPTURE		//load the address of PB_EDGECAPTURE
			LDR R0, [R2]				//load the data stored inside PB_EDGECAPTURE
			BX LR

PB_data_is_pressed_ASM:
			PUSH {LR}
			LDR R1, =PB_BASE // R1 contains base address of pushbutton parallel port
			LDR R2, [R1] // R2 contains buttons within pushbutton parallel port that are on
			AND R3, R2, R0 // R0 contains whose pressed status you wish to check
			CMP R3, R0
			MOVGE R0, #1 // return true if button is pressed
			MOVLT R0, #0 // return false if button is not pressed
			POP {LR}
			BX LR

PB_edgecap_is_pressed_ASM:
			LDR R3, =PB_EDGECAPTURE		//load the address of PB_EDGECAPTURE
			LDR R3, [R3]				//load the data stored inside PB_EDGECAPTURE
			TST R0, R3					//compare with the input button
			BNE STORE_1					//if it equals the input button, output 1(true)
			BEQ STORE_0					//if not, output 0 (false)

STORE_1:	MOV R0, #1
			B DONE
STORE_0:	MOV R0, #0
DONE:		BX LR


PB_clear_edgecp_ASM:
			LDR R5, =PB_EDGECAPTURE		//load the address of PB_EDGECAPTURE
			STR R0, [R5]				//store a value into the address
			BX LR

enable_PB_INT_ASM:
			LDR R8, =0xFF200058
			AND R7, R0, #0xF
			STR R7, [R8]
			BX LR

disable_PB_INT_ASM:
			LDR R9, =0xFF200058
			LDR R6, [R9]
			BIC R6, R6, R0
			STR R6, [R9]
			BX LR
			.end


