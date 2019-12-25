#include <stdio.h>

#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"
#include "./drivers/inc/vga.h"



void test_char(){
	int x,y;
	char c = 70;
	
	for(y=0;y<=59;y++){
		for(x=0;x<=79;x++){
			VGA_write_char_ASM(x,y,c++);
		}
	}
}

void test_byte(){
	int x,y;
	char c =0;
	for(y=0;y<=59;y++){
		for(x=0;x<=79;x+=3){
			VGA_write_byte_ASM(x,y,c++);
		}
	}
}

void test_pixel(){
	int x,y;
	unsigned short colour = 0;
	
	for(y=0;y<=239;y++)
		for(x=0;x<=319;x++)
			VGA_draw_point_ASM(x,y,colour++);
}

 int main() {

	while(1) {
		//CHECK IF THE BUTTON PB0 IS PRESSED									
		if(PB_data_is_pressed_ASM(PB0)){
			if (read_slider_switches_ASM() != 0) {
				//IF ANY SLIDER IS UP WE RUN TEST BYTE
				//TEST BYTE RUNS VGA_WRITE AND CHANGES THE HEX VALUES
				test_byte(); 
			}else
					test_char();
				//IF  NO SLIDERS ARE UP  THEN RUN TEST CHAR
		//CHECK IF THE BUTTON PB3 IS PRESSED
	}
		if(PB_data_is_pressed_ASM(PB3))
			VGA_clear_pixelbuff_ASM();  // PIXEL BUFFER IS CLEARED
		
			
		//CHECK IF THE BUTTON PB2 IS PRESSED
		if(PB_data_is_pressed_ASM(PB2))
			VGA_clear_charbuff_ASM(); //CHARACTER BUFFER IS CLEARED
		
		//CHECK IF THE BUTTON PB1 IS PRESSED
		if(PB_data_is_pressed_ASM(PB1))
			test_pixel(); //CHANGE THE COLORS OF THE PIXELS WITH TEST PIXELS
	}
	return 0;
}


