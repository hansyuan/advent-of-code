// C++ Solution for Day 1 Advent of Code.

#include <iostream>
#include <fstream>
#include <vector>
using namespace std;


/** 
	Reads in the file one int at a time.
	Input: Filename 
	Output: [int]
*/
vector <int> getInput (string filename) {

	int 			tempInt ;
	ifstream 		inputFile ; 
	vector <int> 	inputInts ;

	inputFile.open(filename) ; 

	while (inputFile >> tempInt) {
		inputInts.push_back(tempInt) ;
	}
	inputFile.close();

	return inputInts ;
}


/** 
	Sums up the ints in the list. 
	Input: [int]
	Output: sum as int
*/
int sum (vector <int> inputList) {

	int total = 0 ;

	for (auto intPtr = inputList.begin(); intPtr != inputList.end(); intPtr++ ) {
		total += * intPtr ;
	}

	return total ;

}


/**
	Finds the first repeated sum. 
*/
int repeatedSum (vector <int> inputList) {

	vector <int> seenInts ;
	int total = 0 ;

	while(true) {

		// Continually add to the total. 
		for (auto intPtr = inputList.begin(); intPtr != inputList.end(); intPtr++ ){
			total += * intPtr ;

			// Check if this total was seen before. If so, return it.
			for (auto intPtr = seenInts.begin(); intPtr != seenInts.end(); intPtr++) {
				if (*intPtr == total){
					return total ;
				}
			}

			seenInts.push_back(total) ;
		}
	}
	

	return total ;

}


/*
	High level logic here. Should be mainly method calls. 
*/
int main() {

	cout << "Hello Day 1" << endl ; 

	vector <int> frequencies ;
	int total = 0 ;
	int repeatedInt = 0 ;

	frequencies = getInput("input.txt") ;

	total = sum(frequencies) ;
	cout << total << endl;

	repeatedInt = repeatedSum(frequencies);
	cout << repeatedInt << endl ;


	// Just printing out the vector.
	// while (! frequencies.empty()) {
	// 	cout << frequencies.front() << endl ; 
	// 	frequencies.erase( frequencies.begin() ) ;
	// }

	cout << "Finished." << endl ;
	return 0;

}