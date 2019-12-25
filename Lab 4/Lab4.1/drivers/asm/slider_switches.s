							.text
							.equ SW_BASE, 0xFF200040
							.global read_slider_switches_ASM

read_slider_switches_ASM:	
							LDR R2, =SW_BASE
							LDR R0, [R2]
							BX LR
							.end
