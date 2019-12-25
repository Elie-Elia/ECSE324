#include <stdlib.h>

#include "./drivers/inc/ISRs.h"
#include "./drivers/inc/audio.h"
#include "./drivers/inc/HPS_TIM.h"
#include "./drivers/inc/int_setup.h"
#include "./drivers/inc/wavetable.h"
#include "./drivers/inc/pushbuttons.h"
#include "./drivers/inc/ps2_keyboard.h"

// GetSample based on the frequency and the "index"
double getSample(float frequ, int ti) {
	double signali = 0.0;
	int index = ((int)frequ*ti)%48000;
	float diffe  = (frequ*ti)-index;
	if(diffe = 0){
		signali = sine[index];
	}else{
		signali = (1.0 - diffe) * sine[index] + diffe * sine[index + 1]; 
	}
	return signali;
}

//Generate signal for a given simp
double makeSignal(int* note, int t){
	int i;
	double sum = 0.0;
	
	for(i = 8;i>-1;i--){
		//add note if user played it
		if(note[i] == 1){
			sum += getSample(frequencies[i],t);
		}
	}
	return sum;
}

int main() {

	int_setup(1, (int []){199});
	HPS_TIM_config_t hps_tim;
	hps_tim.tim = TIM0; 
	hps_tim.timeout = 20; 
	hps_tim.LD_en = 1; 
	hps_tim.INT_en = 1; 
	hps_tim.enable = 1; 

	HPS_TIM_config_ASM(&hps_tim);
	//keyReleased checks key not pressed, keyPressed checks key pressed 	
	char keyPressed = 1;
	// t is a counter for signal
	int t = 0;

	char value;
	char amplitude = 1;
	double signalSum = 0.0;
	while(1) {
			if(read_slider_switches_ASM()!=0){
				//we check keys
				if(read_ps2_data_ASM(&value)){
					switch(value){
						
						case 0x1B:
						if(keyPressed == 1){
							notesPlayed[1] = 1;
							displayNotes[1] = 'D';
						
						}else{
							notesPlayed[1] = 0;
							keyPressed = 1;
							displayNotes[1] = ' ';
						}break;
						case 0x1C:
						if(keyPressed == 1){
							notesPlayed[0] = 1;
							displayNotes[0] = 'C';
							
						}else{
							notesPlayed[0] = 0;
							keyPressed = 1;
							displayNotes[0] = ' ';
						}break;
						case 0x2B:
						if(keyPressed == 1){
							notesPlayed[3] = 1;
							displayNotes[3] = 'F';
						
						}else{
							notesPlayed[3] = 0;
							keyPressed = 1;
							displayNotes[3] = ' ';
						}break;
						case 0x23:
						if(keyPressed == 1){
							notesPlayed[2] = 1;
							displayNotes[2] = 'E';
						
						}else{
							notesPlayed[2] = 0;
							keyPressed = 1;
							displayNotes[2] = ' ';
						}break;
						case 0x42:
						if(keyPressed == 1){
							notesPlayed[5] = 1;
							displayNotes[5] = 'A';
						
						}else{
							notesPlayed[5] = 0;
							keyPressed = 1;
							displayNotes[5] = ' ';
						}break;
						case 0x3B:
						if(keyPressed == 1){
							notesPlayed[4] = 1;
							displayNotes[4] = 'G';
						
						}else{
							notesPlayed[4] = 0;
							keyPressed = 1;
							displayNotes[4] = ' ';
						}break;
						case 0x4C:
						if(keyPressed == 1){
							notesPlayed[7] = 1;
							displayNotes[7] = 'C';
							
						}else{
							notesPlayed[7] = 0;
							keyPressed = 1;
							displayNotes[7] = ' ';
						}break;
						case 0x4B:
						if(keyPressed == 1){
							notesPlayed[6] = 1;
							displayNotes[6] = 'B';
					
						}else{
							notesPlayed[6] = 0;
							keyPressed = 1;
							displayNotes[6] = ' ';
						}break;
						case 0xF0:
							keyPressed = 0;
							break;
						case 0x43: //increase sound with
						if(keyPressed ==1){
							if(amplitude <10){
								amplitude++;
							}
						}break;
						case 0x2D: //Decrease sound with 'R'
						if(keyPressed == 1){
							if(amplitude !=0){
								amplitude--;
							}
						}
						default:
							keyPressed = 0;
					}
				}
			}
			signalSum = makeSignal(notesPlayed, t); //generate signal at given time based on keys pressed

			signalSum = amplitude * signalSum; //this is volume control
			// Every 20 microseconds this flag set to high
			if(hps_tim0_int_flag == 1) {
				hps_tim0_int_flag = 0;
				audio_write_data_ASM(signalSum, signalSum);
				t++;
			}

			
			signalSum = 0;
			if(t==48000){
				t=0;
			}
		
	}

	return 0;
}
