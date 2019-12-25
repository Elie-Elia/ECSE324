			.text
			.equ HEX_3_to_0, 0xFF200020
			.equ HEX_5_to_4, 0xFF200030
			.global  HEX_write_ASM
			/*This subroutine will display a value between 0-F to which HEX display is passed as the parameter*/
HEX_write_ASM: 
			LDR R2, =HEX_5_to_4	
			LDR R6, =HEX_3_to_0
			LDR R7, [R6]
			MOV R4, #0
			LDR R8, [R2]
			MOV R3, #0
CHECK_HEX0:
			//Check if Hex0 is the register we want to write to
			CMP	R0, #0x00000001
			BEQ WRITE_HEX0
CHECK_HEX1:
			//Check if Hex1 is the register we want to write to
			CMP	R0, #0x00000002
			BEQ WRITE_HEX1
CHECK_HEX2:
			//Check if Hex2 is the register we want to write to
			CMP R0, #0x00000004
			BEQ WRITE_HEX2
CHECK_HEX3:
			//Check if Hex3 is the register we want to write to
			CMP R0, #0x00000008
			BEQ WRITE_HEX3
CHECK_HEX4:
			//Check if Hex4 is the register we want to write to
			CMP R0, #0x00000010
			BEQ WRITE_HEX4
CHECK_HEX5:
			//Check if Hex5 is the register we want to write to
			CMP R0, #0x00000020
			BEQ WRITE_HEX5
			BNE END

WRITE_HEX0: //Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0 
			MOVEQ R3, #0x00003f 
			CMP R1, #1 
			MOVEQ R3, #0x000006
			CMP R1, #2 
			MOVEQ R3, #0x00005b
			CMP R1, #3 
			MOVEQ R3, #0x00004f
			CMP R1, #4 
			MOVEQ R3,#0x000066
			CMP R1, #5 
			MOVEQ R3, #0x00006d
			CMP R1, #6 
			MOVEQ R3, #0x00007d
			CMP R1, #7 
			MOVEQ R3, #0x000007
			CMP R1, #8 
			MOVEQ R3, #0x00007f
			CMP R1, #9 
			MOVEQ R3, #0x000067
			CMP R1, #10 //A
			MOVEQ R3, #0x000077
			CMP R1, #11 //B
			MOVEQ R3, #0x00007c
			CMP R1, #12 //C 
			MOVEQ R3, #0x000039
			CMP R1, #13 //D
			MOVEQ R3, #0x00005e
			CMP R1, #14 //E 
			MOVEQ R3, #0x000079
			CMP R1, #15 //F
			MOVEQ R3, #0x000071
			STRB R3, [R6]
			B CHECK_HEX1
WRITE_HEX1:
			//Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0
			MOVEQ R3, #0x00003f 
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10 
			MOVEQ R3, #0x000077
			CMP R1, #11 
			MOVEQ R3, #0x00007c
			CMP R1, #12 
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#1]
			B CHECK_HEX2
WRITE_HEX2:
			//Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0
			MOVEQ R3, #0x00003f
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10
			MOVEQ R3, #0x000077
			CMP R1, #11
			MOVEQ R3, #0x00007c
			CMP R1, #12
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#2]
			B CHECK_HEX3
WRITE_HEX3:
			//Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0
			MOVEQ R3, #0x00003f
			CMP R1, #1
			MOVEQ R3, #0x000006
			CMP R1, #2
			MOVEQ R3, #0x00005b
			CMP R1, #3
			MOVEQ R3, #0x00004f
			CMP R1, #4
			MOVEQ R3,#0x000066
			CMP R1, #5
			MOVEQ R3, #0x00006d
			CMP R1, #6
			MOVEQ R3, #0x00007d
			CMP R1, #7
			MOVEQ R3, #0x000007
			CMP R1, #8
			MOVEQ R3, #0x00007f
			CMP R1, #9
			MOVEQ R3, #0x000067
			CMP R1, #10
			MOVEQ R3, #0x000077
			CMP R1, #11
			MOVEQ R3, #0x00007c
			CMP R1, #12
			MOVEQ R3, #0x000039
			CMP R1, #13
			MOVEQ R3, #0x00005e
			CMP R1, #14
			MOVEQ R3, #0x000079
			CMP R1, #15
			MOVEQ R3, #0x000071
			STRB R3, [R6,#3]
			B CHECK_HEX4
WRITE_HEX4:
			//Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0
			MOVEQ R4, #0x0000003f
			CMP R1, #1
			MOVEQ R4, #0x00000006
			CMP R1, #2
			MOVEQ R4, #0x0000005b
			CMP R1, #3
			MOVEQ R4, #0x0000004f
			CMP R1, #4
			MOVEQ R4, #0x00000066
			CMP R1, #5
			MOVEQ R4, #0x0000006d
			CMP R1, #6
			MOVEQ R4, #0x0000007d
			CMP R1, #7
			MOVEQ R4, #0x00000007
			CMP R1, #8
			MOVEQ R4, #0x0000007f
			CMP R1, #9
			MOVEQ R4, #0x00000067
			CMP R1, #10
			MOVEQ R4, #0x00000077
			CMP R1, #11
			MOVEQ R4, #0x0000007c
			CMP R1, #12
			MOVEQ R4, #0x00000039
			CMP R1, #13
			MOVEQ R4, #0x0000005e
			CMP R1, #14
			MOVEQ R4, #0x00000079
			CMP R1, #15
			MOVEQ R4, #0x00000071
			STRB R4, [R2]
			B CHECK_HEX5
WRITE_HEX5:
			//Check what to write to the register. The checks are in order from 1 to F
			CMP R1, #0
			MOVEQ R4, #0x00003f
			CMP R1, #1
			MOVEQ R4, #0x000006
			CMP R1, #2
			MOVEQ R4, #0x00005b
			CMP R1, #3
			MOVEQ R4, #0x00004f
			CMP R1, #4
			MOVEQ R4,#0x000066
			CMP R1, #5
			MOVEQ R4, #0x00006d
			CMP R1, #6
			MOVEQ R4, #0x00007d
			CMP R1, #7
			MOVEQ R4, #0x000007
			CMP R1, #8
			MOVEQ R4, #0x00007f
			CMP R1, #9
			MOVEQ R4, #0x000067
			CMP R1, #10
			MOVEQ R4, #0x000077
			CMP R1, #11
			MOVEQ R4, #0x00007c
			CMP R1, #12
			MOVEQ R4, #0x000039
			CMP R1, #13
			MOVEQ R4, #0x00005e
			CMP R1, #14
			MOVEQ R4, #0x000079
			CMP R1, #15
			MOVEQ R4, #0x000071
			STRB R4, [R2,#1]
			B END
END:		BX LR
