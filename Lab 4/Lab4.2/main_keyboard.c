#include <stdio.h>

#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/vga.h"
#include "./drivers/inc/ps2_keyboard.h"
int main(){
	VGA_clear_charbuff_ASM();//START BY CLEARING THE CHARACTER BUFFER
	int ycoord=0;
	int xcoord=0;
	while(1){
		char input; //CREATE A CHARACTER TO STORE THE INPUT FROM THE USER
		if(read_PS2_data_ASM(&input)){ // TAKE INPUT
			VGA_write_byte_ASM(xcoord,ycoord,input); //WRITE THE BYTES TO THE SCREEN
			xcoord+=3; //SKIPPING TO WRITE THE NEXT CHARACTER 
			//80x60
			if(xcoord>=80) { // WE FINISHED THE ROW TAKE THE NEXT ONE
				xcoord=0; //BRING BACK X TO 0
				ycoord++;
			}
			if(ycoord>=60){ //THE CURRENT SCREEN IS FULL CLEAR THE DISPLAY AND COME BACK TO (0,0)
				VGA_clear_charbuff_ASM();
				xcoord = 0;
				ycoord = 0;
				}
		}
	}
	return 0;
}
