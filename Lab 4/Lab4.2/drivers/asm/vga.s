	.text
	.equ VGA_PIXEL_BUF_BASE, 0xC8000000
	.equ VGA_CHAR_BUF_BASE, 0xC9000000
	.global VGA_clear_charbuff_ASM
	.global VGA_clear_pixelbuff_ASM
	.global VGA_write_char_ASM
	.global VGA_write_byte_ASM
	.global VGA_draw_point_ASM
		
VGA_clear_pixelbuff_ASM:
	push {r4-r5}	
	mov r2,#0
	ldr r3,=VGA_PIXEL_BUF_BASE
	mov r0,#0
PIXEL_LOOPX:
	mov r1,#0
	add r4,r3,r0,lsl #1
PIXEL_LOOPY:
	add r5,r4,r1,lsl #10
	strh r2,[r5]
	add r1,r1,#1
	cmp r1,#240
	blt PIXEL_LOOPY
	add r0,r0,#1
	cmp r0,#320
	blt PIXEL_LOOPX
	pop {r4-r5}
	bx lr
VGA_draw_point_ASM:
	ldr r3,=319
	ldr r3,=VGA_PIXEL_BUF_BASE
	add r3,r3,r0,lsl #1
	add r3,r3,r1,lsl #10
	strh r2,[r3]
	bx lr
VGA_clear_charbuff_ASM:
	push {r4-r5}	
	mov r2,#0
	ldr r3,=VGA_CHAR_BUF_BASE
	mov r0,#0
CHAR_LOOPX:
	mov r1,#0
	add r4,r3,r0,lsl #1
CHAR_LOOPY:
	add r5,r4,r1,lsl #7
	strh r2,[r5]
	add r1,r1,#1
	cmp r1,#60
	blt CHAR_LOOPY
	add r0,r0,#1
	cmp r0,#80
	blt CHAR_LOOPX
	pop {r4-r5}
	bx lr
VGA_write_char_ASM:
	ldr r3,=VGA_CHAR_BUF_BASE
	add r3,r3,r0
	add r3,r3,r1,lsl #7
	strb r2,[r3]
	bx lr
VGA_write_byte_ASM:
	ldr r3,=79
	mov r5,#0
	mov r6,#0
	mov r7,#0
	push {r5-r7}
	ldr r3,=VGA_CHAR_BUF_BASE
	add r3,r3,r0
	add r3,r3,r1,lsl #7
	and r5,r2,#0xf0
	and r6,r2,#0x0f
	lsr r5,r5,#4
	ldr r4,=HEX_ASCII
	add r7,r4,r6
	add r4,r4,r5
	ldrb r4,[r4]
	strb r4,[r3]
	ldrb r7,[r7]
	strb r7,[r3,#1] 
	pop {r5-r7}
	bx lr

HEX_ASCII:
	.byte 0x30, 0x31, 0x32, 0x33, 0x34, 0x35, 0x36, 0x37, 0x38, 0x39, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46
	.end
	
