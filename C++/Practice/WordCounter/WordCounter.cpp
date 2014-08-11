/*******************************************
* Title: Word Counter                      *
* Author: Seiya Kobayashi                  *
* Purpose: To learn the basis of C++       *
* Date: August 10, 2014                    *
*******************************************/

/*
'Word Counter'
Specification Document
August 10, 2014

Word Counter is a program that counts how many
word in a sentence(s) entered by user.

A word starts with the letters shown below:
a-z, A-Z, 0-9

A word ends one letter before the letters shown below:
'.', ',', ' ', ':', ';', '!', '?', '(', ')', '/', '\0', '\n', '\t'

The maximum number of charactors is 1000 letters.

<Execution Example>
Enter a sentence in which you want to know how many words are:
Sed ut perspiciatis unde omnis iste natus error sit voluptatem 
accusantium doloremque laudantium, totam rem aperiam, eaque ipsa 
quae ab illo inventore veritatis et quasi architecto beatae vitae 
dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit 
aspernatur aut odit aut fugit, sed quia consequuntur magni dolores 
eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, 
qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, 
sed quia non numquam eius modi tempora incidunt ut labore et dolore 
magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, 
quis nostrum exercitationem ullam corporis suscipit laboriosam, 
nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure 
reprehenderit qui in ea voluptate velit esse quam nihil molestiae 
consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?

Result: 129 words

<Algorithm>
begining of loop
	Display a massage to ask user to enter a sentence(s).
	Read the sentence(s).

	Using std::string::at function, check all the letters in the sentence(s) with for loop.
	If it detects any valid letters for a word, turn a boolean true.
	And then if it detects any letters indicating the end of a word when the boolean is true,
	increment the word counter.

	For debugging use, make a function showing what is detected as a word.
	(This function will be commented out when the debugging is done.)

	Display the result to user.

end of loop
*/

#include <iostream>
#include <string>
#include <assert.h>

int word_counter = 0; //number of words, which will be displayed as a result at the end
char input_string[1000]; //string variable holding the sentence(s) input from user

int main(){
	//prototype declaration
	bool isLetterForWord(char _c);
	bool isLetterForEndOfWord(char _c);

	std::cout << "Enter a sentence in which you want to know how many words are:\n";
	std::cin.getline(input_string, sizeof(input_string));

	//check each letters in the string
	bool detecting_word = false; //it's going to be true while word is being detected.
	int index_of_beginning_of_the_word = 0; //for debug use, storing the index of the 1st letter of last word
	for(int i = 0; i < sizeof(input_string); i++){
		char c = input_string[i]; //storing a letter at the index

		if(isLetterForWord(c)){
			//for debug use
			if(detecting_word == false){
				index_of_beginning_of_the_word = i;
			}

			//when it detects a valid letter for a word, make the boolean true
			detecting_word = true;

		} else if (isLetterForEndOfWord(c)){
			//when it detects a letter of the end of a word, 

			if(detecting_word){
				//increment the counter, only while it's detecting a word
				word_counter++;

				//for debug use
				std::cout << "Word detected: ";
				for(int j = index_of_beginning_of_the_word; j < i; j++){
					std::cout << input_string[j];
				}
				std::cout << '\n';
			}

			detecting_word = false; //change the flag because the word is at the end

		} else {
			//when it detects the other letters, do nothing
			//(while detecting a word, consider the word is continueing)
			//(while not detecting a word, consider a word has not been started yet)
		}
	}

	//if the string ends with letter for a word, count the last word
	if(detecting_word){
		word_counter++;
	}

	std::cout << "Result: " << word_counter << " words.\n";
	return(0);
}

bool isLetterForWord(char _c){
	if((_c >= '0' && _c <= '9') || (_c >= 'a' && _c <= 'z') || (_c >= 'A' && _c <= 'Z')){
		return(true);
	} else {
		return(false);
	}
}

bool isLetterForEndOfWord(char _c){
	switch(_c){
		case '.':
		case ',':
		case ' ':
		case ':':
		case ';':
		case '!':
		case '?':
		case '(':
		case ')':
		case '/':
		case '\0':
		case '\n':
		case '\t':
			return(true);
		default:
			return(false);
	}
}

