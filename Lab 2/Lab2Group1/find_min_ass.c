extern int MIN_2(int x, int y); 

#include <stdio.h>
#include <stdlib.h>

int main() {
		int a[5]={6,20,3,4,5}; //Initialize an array of integers
		int min_val; //Variable min_val initialized to store the minimum value found in array
		int i; //Variable i to act as counter for loop
		for(i= 0; i<5;i++){
			min_val = MIN_2(a[i], min_val);	//call assembly subroutine to find the minimum between two numbers
		}
		return min_val; //Return the minimum value
}
