/*******************************************
* Title: Bitmap Manipulator                *
* Author: Seiya Kobayashi                  *
* Purpose: To learn the basis of C++       *
* Date: August 14, 2014                    *
*******************************************/

/*
'Bitmap Manipulator'
Specification Document
August 14, 2014

Bitmap Manipulator is a program that displays a bitmap
and gives a few functions to control each bit pixel.

At the beginning,
User is required to set up a bitmap by assigning its width and height.

After the bitmap created,
User can set a bit with set_bit() function.
User can clear a bit with clear_bit() function.
User can check a bit with check_bit() function.
User can reset all the bits by calling reset() function.
User can draw a line with draw_line() function.
User can quit the program by calling exit() function.

<Execution Example>
Set the size of bitmap. Width(1~20): 10, Height(1~20): 6
10 x 6 bitmap has been created.
..........
..........
..........
..........
..........
..........

>Command: set  X: 0  Y: 3
..........
..........
..........
X.........
..........
..........

>Command: line  X_1: 2  Y_1: 5  X_2: 7  Y_1: 5
..........
..........
..........
X.........
..........
..XXXXXX..

>Command: check  X: 4  Y: 5
Result: TRUE

>Command: reset
..........
..........
..........
..........
..........
..........

>Command: exit



<Algorithm>
begining of loop
	Ask user to set the size of bitmap.
	Display initial state of the bitmap.

	Move to bitmap manipulation mode.
	in while loop {
		1) Ask user to call a command.

		in if conditionals {
			2) Based on the command, call the corresponding function.
			3) Rewrite some values of the bitmap.
			4) Show the result on console window.
			5) Continue the while loop. *except for when exit() called
		}
	}
end of loop



<System of Bitmap>
A char-type variable has 8 bits.
[........]

By changing the value of each bit, it can show various patterns.
[.X..XX.X]

To give it larger width, make it array.
[.X..XX.X][XXX.XXXX][XX.....X]

To give it height, make it two-dimentional array.
[.X..XX.X][XXX.XXXX][XX.....X]
[.X..XX.X][XXX.XXXX][XX.....X]
[.X..XX.X][XXX.XXXX][XX.....X]
[.X..XX.X][XXX.XXXX][XX.....X]

*/




#include <iostream>
#include <string>
#include <assert.h>

int width, height; //size of bitmap
const int WIDTH_MIN = 1, WIDTH_MAX = 20, HEIGHT_MIN = 1, HEIGHT_MAX = 20;

char bitmap[WIDTH_MAX][HEIGHT_MAX]; //bitmap array
const char ON = 'X'; //if bit value is 1, this char will be displayed
const char OFF = '.'; //if bit value is 0, this char will be displayed


/*~~~~~~~~~~~~~~~~~~~~~~~~~ main() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
int main(){
	//prototype declaration
	bool check_input(const int _min, const int _max, int _input);
	void display_bitmap();
	void set_bit(int _x, int _y);
	void clear_bit(int _x, int _y);
	void check_bit(int _x, int _y);

	/*-----------------------------------------
	Ask user to set the size of bit map
	-----------------------------------------*/
	std::cout << "Set the size of bitmap.\n";
	//input width
	while(true){
		std::cout << "Width(1~20): ";
		std::cin >> width;
		// check the input value
		if(check_input(WIDTH_MIN, WIDTH_MAX, width)) break;
		else continue; //if it's invalid, start over the while loop.
	}
	//input height
	while(true){
		std::cout << "Height(1~20): ";
		std::cin >> height;
		// check the input value
		if(check_input(HEIGHT_MIN, HEIGHT_MAX, height)) break;
		else continue; //if it's invalid, start over the while loop.
	}

	/*-----------------------------------------
	Display initial state of the bitmap.
	-----------------------------------------*/
	std::cout << width << " x " << height << " bitmap has been created.\n";
	display_bitmap();

	/*-----------------------------------------
	Move to bitmap manipulation mode.
	-----------------------------------------*/
	while(true){
		//Ask user to call a command.
		std::string input_command; //string variable storing command input by user
		std::cout << ">Command: ";
		std::cin >> input_command;

		/*-----------------------------------------
		Set function
		-----------------------------------------*/
		if(input_command == "set"){
			int set_x; //x coord for setting a bit
			int set_y; //y coord for setting a bit

			//ask user to enter X coord value
			while(true){
				std::cout << "X: ";
				std::cin >> set_x;
				//check the input value
				if(check_input(0, width-1, set_x)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			//ask user to enter Y coord value
			while(true){
				std::cout << "Y: ";
				std::cin >> set_y;
				//check the input value
				if(check_input(0, height-1, set_y)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			set_bit(set_x, set_y); //set a bit to the position
			display_bitmap(); //display the current state of bitmap
			continue; //start over this while loop

		}

		/*-----------------------------------------
		Clear function
		-----------------------------------------*/
		else if(input_command == "clear"){
			int clear_x; //x coord for clearing a bit
			int clear_y; //y coord for clearing a bit

			//ask user to enter X coord value
			while(true){
				std::cout << "X: ";
				std::cin >> clear_x;
				//check the input value
				if(check_input(0, width-1, clear_x)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			//ask user to enter Y coord value
			while(true){
				std::cout << "Y: ";
				std::cin >> clear_y;
				//check the input value
				if(check_input(0, height-1, clear_y)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			clear_bit(clear_x, clear_y); //clear a bit at the position
			display_bitmap(); //display the current state of bitmap
			continue; //start over this while loop

		}

		/*-----------------------------------------
		Check function
		-----------------------------------------*/
		else if(input_command == "check"){
			int check_x; //x coord for checking a bit
			int check_y; //y coord for checking a bit

			//ask user to enter X coord value
			while(true){
				std::cout << "X: ";
				std::cin >> check_x;
				//check the input value
				if(check_input(0, width-1, check_x)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			//ask user to enter Y coord value
			while(true){
				std::cout << "Y: ";
				std::cin >> check_y;
				//check the input value
				if(check_input(0, height-1, check_y)) break;
				else continue; //if it's invalid, start over the while loop.
			}

			check_bit(check_x, check_y); //check a bit at the position
			continue; //start over this while loop

		}

		/*-----------------------------------------
		If other words entered
		-----------------------------------------*/
		 else {
			std::cout << "The command name is invalid.\nAvailable commands are 'set', 'clear', 'check', 'line', 'reset', 'exit'.\n";
			std::cout << '\n';
			continue; //start over this while loop
		}
	}

	return(0);
}


/*~~~~~~~~~~~~~~~~~~~~~~~~~ check_input() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
//A function that checks if user input is valid.
//
bool inline check_input(const int _min, const int _max, int _input){
		if(_input < _min || _input > _max){
			//if it's invalid, show error message
			std::cout << "The input value is invalid. Please enter again.\n";
			return(false);
		} else {
			return(true);
		}
}


/*~~~~~~~~~~~~~~~~~~~~~~~~~ display_bitmap() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
//A function that displays current state of bitmap
//
void display_bitmap(){
	int x; //current x byte
	int y; //current y coord
	int bit; //bit value of the current position

	//vertical orientation
	for(y = 0; y < height; y++){

		//horizontal orientation, except for the last byte
		for(x = 0; x < width/8; x++){

			//display bit value one by one.
			//beginning from the bit at far left(0x80: 1000 0000),
			//slide the position of 1 to right in every loop(bit >> 1),
			//until the bit goes to far right(bit > 0: 0000 0001)
			for(bit = 0x80; bit > 0; bit = (bit >> 1)){
				//make sure the values are valid
				assert((x >= 0) && (x < (width/8)));
				assert((y >= 0) && (y < height));

				//using bit masking(logical multiplication),
				//check the value of each item in the bitmap array
				if((bitmap[x][y] & bit) != 0) std::cout << ON; //if the bit is 1, display the char of ON
				else std::cout << OFF; //if the bit is 0, display the char of OFF
			}
		}

		//horizontal orientation, last byte
		bit = 0x80; //set the bit at far left(0x80: 1000 0000)
		for(int i = 0; i < width%8; i++){
			//make sure the values are valid
			int element_number_x = sizeof(bitmap) /  sizeof(bitmap[0]);
			assert((width/8 <= element_number_x));
			assert((y >= 0) && (y < height));

			//using bit masking(logical multiplication),
			//check the value of each item in the bitmap array
			if((bitmap[width/8][y] & bit) != 0) std::cout << ON; //if the bit is 1, display the char of ON
			else std::cout << OFF; //if the bit is 0, display the char of OFF

			bit = (bit >> 1); //slide the position of 1 to right in every loop(bit >> 1),
		}

		std::cout << '\n'; //move to next line
	}

	std::cout << '\n'; //put a blank line
}


/*~~~~~~~~~~~~~~~~~~~~~~~~~ set_bit() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
//A function that set a bit to arbitrary position
//
void inline set_bit(int _x, int _y){
	//make sure the values are valid
	assert((_x >= 0) && (_x < width));
	assert((_y >= 0) && (_y < height));

	int bit = 0x80; //set the bit at far left(0x80: 1000 0000)
	bit = (bit >> (_x)%8); //slide the position of 1 to right

	//set a bit using logical addition
	bitmap[(_x)/8][_y] |= bit;
}


/*~~~~~~~~~~~~~~~~~~~~~~~~~ clear_bit() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
//A function that clears a bit at arbitrary position
//
void inline clear_bit(int _x, int _y){
	//make sure the values are valid
	assert((_x >= 0) && (_x < width));
	assert((_y >= 0) && (_y < height));

	int bit = 0x80; //set the bit at far left(0x80: 1000 0000)
	bit = (bit >> (_x)%8); //slide the position of 1 to right

	//clear a bit using logical multiplication and complement
	bitmap[(_x)/8][_y] &= ~bit;
}


/*~~~~~~~~~~~~~~~~~~~~~~~~~ check_bit() *~~~~~~~~~~~~~~~~~~~~~~~~~*/
//A function that checks a bit at arbitrary position
//
void inline check_bit(int _x, int _y){
	//make sure the values are valid
	assert((_x >= 0) && (_x < width));
	assert((_y >= 0) && (_y < height));

	int bit = 0x80; //set the bit at far left(0x80: 1000 0000)
	bit = (bit >> (_x)%8); //slide the position of 1 to right

	//clear a bit using logical multiplication and complement
	if((bitmap[(_x)/8][_y] & bit) != 0) std::cout << "The bit is ON.\n";
	else std::cout << "The bit is OFF.\n";
}

