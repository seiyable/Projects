/*******************************************
* Title: Flash Cards                       *
* Author: Seiya Kobayashi                  *
* Purpose: To learn the basis of C++       *
* Date: August 24, 2014                    *
*******************************************/

/*
'Flash Cards'
Specification Document
August 22, 2014

Flash Cards is a program that helps user to remember things
by making simple flash-card style quizzes.

Preparation:
	User can add a set of question and answer to the stack of flash cards.
	User can check the list of all the cards.
	User can remove a set of question and answer from the stack of flash cards.

Play Quiz:
	User is asked to answer to the question shown from one to the next.
	If the answer is right, the card will be removed, move on to next quiz.
	If the answer is wrong, the card will be moved to the bottom of the stack, and move on to next quiz.
	The quiz continues untill all the cards are removed from the stack.


<Execution Example>
Command: add
Question of the card: What is the longest river in the world?
Answer of the card: Nile

Command: add
Question of the card: What is the second longest river in the world?
Answer of the card: Amazon

Command: add
Question of the card: What is the third longest river in the world?
Answer of the card: Yangtze

Command: add
Question of the card: What is the fourth longest river in the world?
Answer of the card: Mississippi

Command: list
-------------------------
[0]
Q: What is the longest river in the world?
A: Nile
-------------------------
[1]
Q: What is the second longest river in the world?
A: Amazon
-------------------------
[2]
Q: What is the third longest river in the world?
A: Yangtze
-------------------------
[3]
Q: What is the fourth longest river in the world?
A: Mississippi

Remove a card?[Y/N]: Y
Which number do you want to remove?: 3

Question[0]: What is the longest river in the world?
Question[1]: What is the second longest river in the world?
Question[2]: What is the third longest river in the world?

The card has been removed.

Command: play
{{Remaining 3 Cards}}
Q. What is the third longest river in the world?
A. Mississippi
Too bad! Wrong Answer.

{{Remaining 3 Cards}}
Q. What is the second longest river in the world?
A. Amazon
Hooray! Correct!

{{Remaining 2 Cards}}
Q. What is the longest river in the world?
A. Nile
Hooray! Correct!

{{Remaining 1 Cards}}
Q. What is the third longest river in the world?
A. Yangtze
Hooray! Correct!

{{Remaining 0 Cards}}
You've done all the flash cards.


<Algorithm>
Make a struct "single_card" that holds a set of question and answer.
Make a class "card_stack" that holds an array of single_card.
As its member methods, make add(), list(), remove(), judge(), move_to_bottom() functions.

begining of loop
	Setting Mode:
	in while loop {
		Ask user to call a command.

		in if conditionals {
 			If the command is "play", move to play mode.
 			If other commands entered, call the corresponding function of card_stack class.
		}
	}

	Play Mode:
	in while loop {
		Display number of remaining cards.
		Display question sentence of card on the top of the stack.
		Ask user to enter the answer to the question.
		Calling judge() function,
		in if conditionals {
 			If true returned, call remove() to remove the card from stack.
 			If false returned, call move_to_bottom() to move the card to the bottom of the stack.
		}
		Move on to next quiz.
	}
end of loop
*/

/*~~~~~~~~~~~~~~~~~~~~~~~~~ include headers ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
#include <iostream>
#include <string>
#include <assert.h>

/*~~~~~~~~~~~~~~~~~~~~~~~~~ struct Single_Card ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//single card
struct Single_Card {
	std::string question; //question sentence
	std::string answer; //answer word or sentence
};

/*~~~~~~~~~~~~~~~~~~~~~~~~~ class Card_Stack ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//stack of flash cards
const int STACK_SIZE = 100; //max stack size
class Card_Stack {
	public:
		int count; //number of flash cards
		Single_Card cards[STACK_SIZE]; //array of flash cards

		//constructor
		Card_Stack(){
			count = 0; //initialize the count
		};

		//card_stack(const Card_Stack& _old_stack);
		//use auto generated copy constructor.

		//card_stack operator = (const Card_Stack& _old_stack);
		//use auto generated assignment operator.

		//~card_stack();
		//use auto generated destructor.

		void add(Single_Card _new_card); //add a new card to stack
		void list(Card_Stack& _old_stack); //show all the cards in stack
		void remove(const int _remove_card_number, Card_Stack& _old_stack); //remove a card from stack
		bool judge(const int _question_card_number, const std::string _answer); //check if the answer is correct or not
		void move_to_bottom(const int _move_card_number, Card_Stack& _old_stack); //move the card on the top to bottom
};

/****************************
   add a new card to stack 
****************************/
inline void Card_Stack::add(Single_Card _new_card){
	//assign the new card to stack
	cards[count] = _new_card;

	//increment the counter
	count++;
}

/******************************
   show all the cards in stack
******************************/
inline void Card_Stack::list(Card_Stack& _old_stack){
	//display the list of all the cards in stack
	for(int i = 0; i < count; i++){
		std::cout << "----------------\n";
		std::cout << '[' << i << ']' << '\n';
		std::cout << "Q: " << cards[i].question << '\n';
		std::cout << "A: " << cards[i].answer << '\n';
	}
	std::cout << '\n';

	//ask if user wants to remove some card from stack
	char remove_or_not; //user input
	std::cout << "Remove a card?[Y/N]: ";
	std::cin >> remove_or_not;

	//if user says yes
	if(remove_or_not == 'Y' || remove_or_not == 'y'){
		int remove_card_number; //card number to be removed
		std::cout << "Which number do you want to remove?: ";
		std::cin >> remove_card_number;

		//remove the card from stack
		remove(remove_card_number, _old_stack);
		std::cout << "The card has been removed.";
	}
}

/****************************
   remove a card from stack 
****************************/
//copy all the cards in existing stack except for the card to be removed
inline void Card_Stack::remove(const int _remove_card_number, Card_Stack& _old_stack){
	Card_Stack new_stack; //new stack

	int new_stack_index = 0; //index for new stack
	for(int i = 0; i < count; i++){
		if(i != _remove_card_number){
			Single_Card new_card; //new card

			//set question and answer to new card for new stack
			new_card.question = cards[i].question;
			new_card.answer = cards[i].answer;

			//add the card to new stack
			new_stack.add(new_card);

			//increment new stack's index
			new_stack_index++;

		} else {
			//if index of old stack equals to the card number to be removed,
			//do nothing and skip
		}
	}

	//update the stack
	_old_stack = new_stack;
}

/**********************************
   judge if the answer is correct
**********************************/
inline bool Card_Stack::judge(const int _question_card_number, const std::string _answer){
	if(_answer == cards[_question_card_number].answer){
		return(true);
	} else {
		return(false);
	}
}

/****************************
   move a card to bottom 
****************************/
//add the card to new stack,
//and then copy all the rest of cards in old stack,
//except for the card to be moved to bottom, to new stack
inline void Card_Stack::move_to_bottom(const int _move_card_number, Card_Stack& _old_stack){
	Card_Stack new_stack; //new stack
	//at first, add the card to new stack(this is going to be at the bottom)
	Single_Card bottom_card;
	//set question and answer to new card for new stack
	bottom_card.question = cards[_move_card_number].question;
	bottom_card.answer = cards[_move_card_number].answer;

	//add the card to new stack
	new_stack.add(bottom_card);


	//and then copy all the rest of cards in old stack to new stack(same as remove function)
	int new_stack_index = 0; //index for new stack
	for(int i = 0; i < count; i++){
		if(i != _move_card_number){
			Single_Card new_card; //new card

			//set question and answer to new card for new stack
			new_card.question = cards[i].question;
			new_card.answer = cards[i].answer;

			//add the card to new stack
			new_stack.add(new_card);

			//increment new stack's index
			new_stack_index++;

		} else {
			//if index of old stack equals to the card number to be removed,
			//do nothing and skip
		}
	}

	//update the stack
	_old_stack = new_stack;
}



/*~~~~~~~~~~~~~~~~~~~~~~~~~ main() ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
Card_Stack stack; //stack of flash cards to be used
int main(){
	void play(); //prototype declaration

	while(true){
		std::cout << "<Setting Mode>\n";

		//ask user to enter a command
		std::string input_command; //user input for command
		std::cout << "Command: ";
		std::cin >> input_command;
		//remove EOL letter ('\n') in the I/O buffer
		std::cin.ignore(); 

		/*-----------------------------------------
		Add function
		-----------------------------------------*/
		if(input_command == "add"){
			Single_Card new_card; //new card to be added to the stack

			//ask user to enter question sentence of a new card
			std::cout << "Question of the card:\n";
			std::getline(std::cin, new_card.question);

			//ask user to enter the answer of a new card
			std::cout << "Answer of the card:\n";
			std::getline(std::cin, new_card.answer);

			std::cout << '\n';

			//add the card to stack
			stack.add(new_card); 
			continue; //start over this while loop
		}

		/*-----------------------------------------
		List function
		-----------------------------------------*/
		if(input_command == "list"){
			//call list function
			stack.list(stack);
			std::cout << '\n';
			continue; //start over this while loop
		}

		/*-----------------------------------------
		Play function
		-----------------------------------------*/
		if(input_command == "play"){
			//move to play mode
			std::cout << '\n';
			play();
			std::cout << '\n';
			continue; //start over this while loop
		}

		/*-----------------------------------------
		If other words entered
		-----------------------------------------*/
		 else {
			std::cout << "The command name is invalid.\n";
			std::cout << "Available commands are 'add', 'list', 'play'.\n";
			std::cout << '\n';
			continue; //start over this while loop
		}
	}

	return(0);
}

/*~~~~~~~~~~~~~~~~~~~~~~~~~ play() ~~~~~~~~~~~~~~~~~~~~~~~~~~*/
//play mode
void play(){
	std::cout << "<Play Mode>\n";
	while(stack.count > 0){
		std::cout << "{{Remaining " << stack.count << " Cards}}\n";

		std::string user_answer; //user input as the answer to quiz
		std::cout << "Q. " << stack.cards[stack.count-1].question << '\n';
		std::cout << "A. ";
		std::getline(std::cin, user_answer);

		//if the answer is right
		if(stack.judge(stack.count-1, user_answer)){
			//remove the card from stack
			stack.remove(stack.count-1, stack);
			std::cout << "Hooray!!!!!! Correct!!!!!!\n";
			std::cout << '\n';

		//if the answer is wrong
		} else {
			//move the card to the bottom of the stack
			stack.move_to_bottom(stack.count-1, stack);
			std::cout << "Too Bad! Wrong Answer.\n";
			std::cout << '\n';
		}
	}

	std::cout << "{{Remaining 0 Cards}}\n";
	std::cout << "You've done all the flash cards.\n";

}
