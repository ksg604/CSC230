#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "main.h"
#include "lcd_drv.h"



void reverse_string(char* string) 

{
	char temp;
	int i = 0;
	int length = strlen(string) - 1;
	int j = length;

	for(i = 0; i < j; i++)
	{
		if(j == length/2)
		{

			break;

		}

		temp = string[j];
		string[j] = string[i];
		string[i] = temp;
		j = j - 1;
	}

}

void copy_strings(char* dest, char* source)
{

	while(*source)
	{
		//Copy characters from source into dest 
		*dest = *source;
		dest++;
		source++;

	}
	//Concatenate null terminator to the end of the dest.
	*dest = '\0';
}



int main (void) 
{

	char line1[] = "Kevin San Gabriel";
	char line2[] = "UVic: Computer Sci";
	
	//Reverse of lines 1 and 2.
	char line3[19];
	char line4[19];

	copy_strings(line3,line1);
	copy_strings(line4,line2);
	
	reverse_string(line3);
	reverse_string(line4);

	lcd_init();	
	lcd_blank(38); //Clear lcd


	int i = 0;
	
	while(i < 3)
	{

		lcd_xy(0,0);
		lcd_puts(line1);
		lcd_xy(0,1);
		lcd_puts(line2);

		_delay_ms(1000);
		lcd_blank(38);

		lcd_xy(1,0);
		lcd_puts(line2);
		lcd_xy(1,1);
		lcd_puts(line3);
	
		_delay_ms(1000);
		lcd_blank(38);
	
		lcd_xy(0,0);
		lcd_puts(line3);
		lcd_xy(0,1);
		lcd_puts(line4);

		_delay_ms(1000);
		lcd_blank(38);

		lcd_xy(0,0);
		lcd_puts(line4);
		lcd_xy(0,1);
		lcd_puts(line1);

		_delay_ms(2000);
		lcd_blank(38);

		i = i + 1;

	}
	

	//Infinite loop
		while(1)
	{			
		lcd_xy(0,0);
		lcd_puts("******************");
		lcd_xy(0,1);
		lcd_puts("******************");

		_delay_ms(1000);
		lcd_blank(38);

		lcd_xy(0,0);
		lcd_puts("..................");
		lcd_xy(0,1);
		lcd_puts("..................");
		
		_delay_ms(1000);
		lcd_blank(38);
	}


}
