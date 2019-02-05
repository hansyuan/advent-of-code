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
vector <int> getInput(string filename) {

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


/*
	High level logic here. Should be mainly method calls. 
*/
int main() {

	cout << "Hello World" << endl ; 

	vector <int> frequencies ;
	frequencies = getInput("input.txt") ;

	// Just printing out the vector.
	// while (! frequencies.empty()) {
	// 	cout << frequencies.front() << endl ; 
	// 	frequencies.erase( frequencies.begin() ) ;
	// }

	cout << "Finished." << endl ;
	return 0;

}