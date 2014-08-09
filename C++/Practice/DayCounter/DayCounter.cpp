/*******************************************
* Title: Day Counter                       *
* Author: Seiya Kobayashi                  *
* Purpose: To learn the basis of C++       *
* Date: August 8, 2014                     *
*******************************************/

/*
'Day Counter'
Priparatory Specification Document
August 8, 2014

Day Counter is a program that counts how many
days there are between arbitrary two days that 
user entered.

First, user is asked to enter the start day
of the duration.
Next, user is asked to enter the end day of the
duration.

The end day must be after the start day.
If user input earlier day to the start day,
error comment will appear and pronpt user to enter
it again.

Year, month, and day is asked to input separately.
Formats for them are year(yyyy), month(mm), day(dd).
If user input it in other format or invalid number,
error comment will appear and pronpt user to enter it again.

<Execution Example>
Enter the start day of the duration.
year(yyyy): 2013
month(mm): 04
day(dd): 17
Enter the end day of the duration.
year(yyyy): 2014
month(mm): 11
day(dd): 09
The number of the days in the duration is 524.

<Algorithm>
beginning of loop
	display a message to ask user to input start day
	read year, month, day of start day
	display a message to ask user to input end day
	read year, month, day of end day

	1) calc how many days are there
	from the start day
	to the last day of its year

	2) calc how many days are there 
	from the first day of the next year of start day
	to the last day of the previous year of end day

	3) calc how many days are there
	from the first day of the end-day's year
	to the end day

	display total of 1) ~ 3)

end of loop
*/

//----------------------------------------------------------

#include <iostream>
#include <string>
#include <assert.h>

int start_year; //the year of the start day
int start_month; //the month of the start day
int start_day; //the day of the start day

int end_year; //the year of the end day
int end_month; //the month of the end day
int end_day; //the day of the end day

int main(){
	//prototype declaration
	void input_year(int& _year); 
	void input_month(int& _month); 
	void input_day(int _year, int _month, int& _day); 

	//display introduction message
	std::cout << "This program counts how many days are there between two days you entered.\n";
	std::cout << "Enter the start day of the duration.\n";

	//let user enter the year of the start day
	input_year(start_year);
	//let user enter the month of the start day
	input_month(start_month);
	//let user enter the day of the start day
	input_day(start_year, start_month, start_day);

	//display following message
	std::cout << "\nEnter the end day of the duration.\n";

	//let user enter the data of end day until it becomes valid
	while(true){
		//let user enter the year of the end day
		input_year(end_year);
		//let user enter the month of the end day
		input_month(end_month);
		//let user enter the day of the end day
		input_day(end_year, end_month, end_day);

		if(end_year < start_year){
			std::cout << "\nEnd day must be after the start day.\n";
			std::cout << "Enter the end day of the duration.\n";
			continue;
		} else if(end_year == start_year){
			if(end_month < start_month){
				std::cout << "End day must be after the start day.\n";
				std::cout << "Enter the end day of the duration.\n";
				continue;
			} else if(end_month == start_month){
				if(end_day <= start_day){
					std::cout << "End day must be after the start day.\n";
					std::cout << "Enter the end day of the duration.\n";
					continue;					
				} else if(end_day > start_day) break;
			} else if(end_month > start_month) break;
		} else if(end_year > start_year) break;
	}


	//prototype declaration
	int get_number_of_days_in_the_month(int _year, int _month);

	/*
	1) calc how many days are there
	from the start day
	to the last day of its year
	*/
	int sum_1 = 0; //sum for this part
	for (int i = start_month; i <= 12; i++){
		if(i == start_month){
			//if it is start month, count the rest of the month after the start day
			sum_1 += get_number_of_days_in_the_month(start_year, i) - start_day;
		} else if (i > start_month) {
			//else, add the number of days of the month
			sum_1 += get_number_of_days_in_the_month(start_year, i);
		}
	}

	/*
	2) calc how many days are there 
	from the first day of the next year of start day
	to the last day of the previous year of end day
	*/
	int sum_2 = 0; //sum for this part
	for (int i = start_year + 1; i < end_year; i++){
		bool judge_leap(int _year);
		if(judge_leap(i)){
			//if it is a leap year, add 366 days
			sum_2 += 366;
		} else {
			//if it is a NOT leap year, add 365 days
			sum_2 += 365;
		}
	}

	/*
	3) calc how many days are there
	from the first day of the end-day's year
	to the end day
	*/
	int sum_3 = 0; //sum for this part
	for (int i = 1; i <= end_month; i++){
		if(i == end_month){
			//if it is end month, count up only the number from 1st to the end day
			sum_3 += end_day;
		} else if(i < end_month) {
			//else, add the number of days of the month
			sum_3 += get_number_of_days_in_the_month(end_year, i);
		}
	}

	/*
	4) if start day and end day is in a same year, calc in different way
	*/
	int sum_4 = 0;
	if(start_year == end_year){
		sum_1 = 0;
		sum_2 = 0;
		sum_3 = 0;

		if(start_month == end_month){
			sum_4 = end_day - start_day;
		} else if(start_month < end_month) {
			for (int i = start_month; i <= end_month; i++){
				if(i == start_month){
					//if it is start month, count the rest of the month after the start day
					sum_4 += get_number_of_days_in_the_month(start_year, i) - start_day;
				} else if (i > start_month && i < end_month) {
					//else, add the number of days of the month
					sum_4 += get_number_of_days_in_the_month(start_year, i);
				} else if (i == end_month){
					//if it is end month, count up only the number from 1st to the end day
					sum_4 += end_day;
				}
			}
		}
	}

	//display the result to user
	std::cout << "\nThe total days from " << start_year << '/' << start_month << '/' << start_day;
	std::cout << " to " << end_year << '/' << end_month << '/' << end_day << " is: " << sum_1 + sum_2 + sum_3 + sum_4 << " days.\n";

	return(0);
}


/*
A function that ask user to input year data again and again until the input becomes valid;
*/
void input_year(int& _year){
	while(true){
		std::cout << "year(yyyy): ";
		std::cin >> _year;

		if(_year < 0 || _year > 9999){
			std::cout << "Year must be in between 0 ~ 9999\n";
			continue;
		} else {
			break;
		}
	}
}

/*
A function that ask user to input month data again and again until the input becomes valid;
*/
void input_month(int& _month){
	while(true){
		std::cout << "month(mm): ";
		std::cin >> _month;

		if(_month < 0 || _month > 12){
			std::cout << "Month must be in between 1 ~ 12\n";
			continue;
		} else {
			break;
		}
	}
}

/*
A function that ask user to input day data again and again until the input becomes valid;
*/
void input_day(int _year, int _month, int& _day){
	while(true){
		std::cout << "day(dd): ";
		std::cin >> _day;

		switch(_month){
			case 1:
			case 3:
			case 5:
			case 7:
			case 8:
			case 10:
			case 12:
				if(_day < 0 || _day > 31){
					std::cout << "Day must be in between 1 ~ 31\n";
					continue;
				} else {
					break;
				}

			case 4:
			case 6:
			case 9:
			case 11:
				if(_day < 0 || _day > 30){
					std::cout << "Day must be in between 1 ~ 30\n";
					continue;
				} else {
					break;
				}

			case 2:
				bool judge_leap(int _year);
				if(judge_leap(_year)){
					//if the year is a leap year, the day must be in between 1 ~ 29
					if(_day < 0 || _day > 29){
						std::cout << "Day must be in between 1 ~ 29\n";
						continue;
					} else {
						break;
					}
				} else {
					//if the year is NOT a leap year, the day must be in between 1 ~ 28
					if(_day < 0 || _day > 28){
						std::cout << "Day must be in between 1 ~ 28\n";
						continue;
					} else {
						break;
					}
				}
		}
		break;
	}
}

/*
A function that judges whether the year is a leap year or not
*/
bool judge_leap(int _year){
	bool bissextile;

	//if a year is divisible by the number 4, it is a leap year
	if(_year % 4 == 0) {
		bissextile = true;

		//but if the year is divisible by the number 100, it is not a leap Year
		if(_year % 100 == 0){
			bissextile = false;

			//unless it is divisible by the number 400
			if(_year % 400 == 0){
				bissextile = true;
			}
		}
	} else {
		bissextile = false;
	}

	return(bissextile);
}

/*
A function that return the number of days in the given month
*/
int get_number_of_days_in_the_month(int _year, int _month){
	switch(_month){
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			break;

		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
			break;

		case 2:
			bool judge_leap(int _year);
			if(judge_leap(_year)){
				return(29);
			} else {
				return(28);
			}
			break;
	}
	return(0);
}
