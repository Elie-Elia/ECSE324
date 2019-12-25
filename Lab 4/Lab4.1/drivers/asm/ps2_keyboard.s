				.text
				.global read_PS2_data_ASM
				.equ PS2_DATA, 0xFF200100

read_PS2_data_ASM:
				LDR R4, =PS2_DATA
				LDR R4, [R4]
				TST R4, #32768 //TESTING R4 WITH THE 15TH BIT REGISTER
				BNE STORE_ARG	//IF IT IS TRUE STORE INPUT OF USER
				MOV R0, #0
				BX LR
STORE_ARG:		STRB R4, [R0]	
				MOV R0, #1
				BX LR		
				
				.end
