			.text
			.equ PB_EDGECAPTURE, 0xFF20005C
			.equ PB_BASE, 0xFF200050
			.equ PB_INT_EDGECAPTURE, 0xFF200058
			.global read_PB_data_ASM, read_PB_edgecap_ASM, PB_clear_edgecp_ASM,PB_edgecap_is_pressed_ASM, enable_PB_INT_ASM, disable_PB_INT_ASM
			.global PB_data_is_pressed_ASM

read_PB_data_ASM: //Read push button data from PB_BASE into R2 and store it in the return register R0
			LDR R2, =PB_BASE			
			LDR R0, [R2]	
			BX LR //Return

read_PB_edgecap_ASM: //READ THE EDGECAPTURE DATA FROM PB_EDGECAPTURE INTO R2  
			LDR R2, =PB_EDGECAPTURE  
			LDR R0, [R2] //LOAD THE RETURN VALUE INTO REGISTER R0
			BX LR
PB_edgecap_is_pressed_ASM:
			LDR R2, =PB_EDGECAPTURE
			LDR R2, [R2]
			TST R0, R2
			BEQ RETURN_0
RETURN_2:	MOV R0, #2 //put a value different then 0 for the detection of a capture edge
			BX LR
RETURN_0:	MOV R0, #0 //put a value of 0 for no edgecapture
			BX LR

PB_data_is_pressed_ASM:
			LDR R3, =PB_BASE	
			LDR R3, [R3]			
			TST R3, R0				//CHECK IF THE PUSHBUTTON IS 1 IN MEMORY
			MOVEQ R0, #0			//IF NOT STORE 0 IN R0
			BXEQ LR					// RETURN
			MOV R0, #1				//IF YES STORE 1 IN R0
			BX LR					//RETURN

PB_clear_edgecp_ASM:
			LDR R3, =PB_EDGECAPTURE
			STR R0, [R3] //STORE THE EDGE CAPTURE MEMORY INTO THE RETURN REGISTER R0
			BX LR

enable_PB_INT_ASM:
			LDR R2, =PB_INT_EDGECAPTURE	
			STR R0, [R2] //STORE INTO INETERUPT EDGE CAPTURE MEMORY FROM R0
			BX LR

disable_PB_INT_ASM:
			LDR R1, =PB_INT_EDGECAPTURE		//LOAD THE INTERUPT REGISTER INTO R1
			STR R0,[R1]						//STORE INTO INETERUPT EDGE CAPTURE MEMORY FROM R0
			BX LR
			.end


