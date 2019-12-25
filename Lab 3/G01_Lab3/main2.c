#include <stdio.h>

#include "./drivers/inc/slider_switches.h"
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/pushbuttons.h"

int main() {
	/*FLOOD HEX5 AND HEX4*/
	HEX_flood_ASM(HEX5|HEX4);
	/*Clear registers before starting*/
	HEX_clear_ASM(HEX3|HEX2|HEX0|HEX1);

	while(1){
		/*Number to eventually display on the screen*/
		int number = read_slider_switches_ASM();
		/*If the number is greater then 512 this means we selected slider no 9  which clear the registers 1 to 4*/
		if(number>=512){
			HEX_clear_ASM(HEX2|HEX1|HEX3|HEX0);
			continue;
			/* go back to the beginning of the loop*/
		}
			/*Go HEX display by display in a switch statement*/
			HEX_t value;
			switch(read_PB_data_ASM()){

				case 0x00000008:// means write value to Hex3
					value = HEX3;
					HEX_write_ASM(value,number);
					break;
				case 0x00000004:// means write value to Hex2
					value = HEX2;
					HEX_write_ASM(value,number);
					break;
				case 0x00000002:// means write value to Hex1
					value = HEX1;
					HEX_write_ASM(value,number);
					break;			
				case 0x00000001: // means write value to Hex0
					value = HEX0;
					HEX_write_ASM(value,number);
					break;
			
		}
	}
	return 0;
}
