
#include <stdio.h>
#include "./drivers/inc/HEX_displays.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/pushbuttons.h"

//his main method puts together our assembly and header files and initialised the logic to use them.

int main(){
	//We create an integer to hold the value of each digit
	int digit0 = 0, digit2=0, digit1=0, digit5=0,digit4=0,digit3=0;
	
	//We create a HPS_TIM_t struct to initialise our main timer
	//We give it a timeout of 10ms and set all other fields to 0 because we do not want our timer to start before we press the button
	HPS_TIM_config_t timer0;
	timer0.tim = TIM0;
	timer0.LD_en = 0;
	timer0.timeout = 10000;	
	timer0.INT_en = 0;
	timer0.enable = 0;
	HPS_TIM_config_ASM(&timer0);
	
	/*Setting our HPS_TIM_config_t struct poll which is used to poll the edgecapture registers*/
	/*We give it a value of 5ms to poll the edgecapture registers*/
	HPS_TIM_config_t poller;
	poller.tim = TIM1;
	poller.LD_en = 1;
	poller.timeout = 5000;	
	poller.INT_en = 1;
	poller.enable = 1;
	HPS_TIM_config_ASM(&poller);

	while(1){
		// begin by polling the button every 5ms
		if(HPS_TIM_read_INT_ASM(poller.tim)){
			HPS_TIM_clear_INT_ASM(poller.tim);
				//Take input from the button press
				int buttonPress = read_PB_edgecap_ASM();
				//If a button is pressed we have to figure out which one it is
				if(buttonPress >=1){
					if(PB_edgecap_is_pressed_ASM(PB0)){
						//if the buton pressed is the button 0 then start the first timer 
						timer0.LD_en = 1;
						timer0.INT_en = 1;
						timer0.enable = 1;
						HPS_TIM_config_ASM(&timer0); // reload configurations
					}
					if(PB_edgecap_is_pressed_ASM(PB2)){
					//if the button pressed is the button 2 then stop the timer and reset the digit counts 
						timer0.LD_en = 0;
						timer0.INT_en = 0;
						timer0.enable = 0;
						HPS_TIM_config_ASM(&timer0); //reload configurations
						if(HPS_TIM_read_INT_ASM(timer0.tim) == 0){
							HEX_flood_ASM(HEX0|HEX1|HEX2|HEX3|HEX4|HEX5);				
						}
						digit0 = 0, digit1=0, digit2=0, digit3=0, digit4=0, digit5=0;
					}
					if(PB_edgecap_is_pressed_ASM(PB1)){
					//if the button pressed is the button 1 then pause the timer
						timer0.LD_en = 0;
						timer0.INT_en = 0;
						timer0.enable = 0;
						HPS_TIM_config_ASM(&timer0);
					}
					PB_clear_edgecp_ASM(15);
				}
			}	
				if(HPS_TIM_read_INT_ASM(timer0.tim)){
					HPS_TIM_clear_INT_ASM(timer0.tim);
					if(++digit0 == 10){ //REFRESH THE VALUES ON THE SCREEN DEPENDING ON THE DIGIT COUNT
						digit0 = 0;
						if(++digit1==10){
							digit1=0;
							if(++digit2==10){
								digit2=0;
								if(++digit3==6){
									digit3=0;
									if(++digit4==10){
										digit4 = 0;
										if(++digit5==6){
											digit5=0;
										}
									}
								}
							}
						}
					}
					HEX_write_ASM(HEX5,digit5);
					HEX_write_ASM(HEX4,digit4);
					HEX_write_ASM(HEX3,digit3);
					HEX_write_ASM(HEX2,digit2);
					HEX_write_ASM(HEX1,digit1);
					HEX_write_ASM(HEX0,digit0);
				}
			}
	return 0;
}
