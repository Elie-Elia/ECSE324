#include <stdio.h>
#include "./drivers/inc/audio.h"

//NUMBERS OF 1S AND 2S TO WRITE 48000/(2*100)*/
int main() {
	int COUNT = 0;
	while(1) {
		while(COUNT<240) {
			if(audio(0x00FFFFFF)) {
				//WHILE THE COUNTER NOT 240 THEN WRITE 1
				COUNT++;
			}
		}
		COUNT = 0;
		while(COUNT<240) {
			//WHILE THE COUNTER NOT 240 THEN WRITE 0
			if(audio(0x00000000)) {
				COUNT++;
			}
		}
		COUNT = 0; 
	}
	return 0;
}
