

#include <stdio.h>
#include <stdlib.h>

int main() {
		int a[5]={2,20,3,4,5};
		int min_val=a[0];
		int i; 
		for(i= 0; i<5;i++){
			if(a[i]<min_val){
			min_val = a[i];
			 
		}
}

		return min_val; 
}