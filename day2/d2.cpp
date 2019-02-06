/*
	Developed on Sublime with little or no extensions, after implementing
	the solution in Haskell before. 
*/

#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>
using namespace std;



/* 
	Gets the input strings from each line of the file. 
	Returns a list of strings in a vector.
 */
vector <string> getInput (string filename) {

	string tempString ;
	ifstream inputFile ; 
	vector <string> inputStrings ;

	inputFile.open (filename) ;

	while (inputFile >> tempString) {
		inputStrings.push_back (tempString);
	}

	return inputStrings; 

}


/*
	Determine the number of times each letter occurs in a string. 
*/ 
unordered_map <char, int> countLetters (string inputString) {

	unordered_map <char, int> letterCounts; 

	for (char c: inputString) {
		
		auto keyPtr = letterCounts.find (c); 

		// Insert letters not in dict
		if (keyPtr == letterCounts.end ()){
			letterCounts.insert ({c, 1});
			// cout << "Insert: " << c << endl;
		}

		// Increment counts whose letters are already keys
		else {
			letterCounts[c]++;
			// cout << "Incremented: " << c << ":: " << letterCounts[c] << endl;
		}
	}

	return letterCounts;

}


/*
	Changes a list of input strings into a list of dicts of (char, int) 
*/
vector <unordered_map <char, int>> listOfLetterCounts (vector<string> listOfStrings) {
	
	vector <unordered_map <char, int>> letterCounts;

	for (string str: listOfStrings) {
		letterCounts.push_back(countLetters(str));
	}

	return letterCounts;
}


/*
	Comment
*/
int main () {

	vector<string> stringInputs = getInput ("input.txt");
	vector<unordered_map <char, int>> letterCounts = listOfLetterCounts (stringInputs); 


	// unordered_map <char, int> dicts = 

	

	// Check string reading worked 
	// for (auto strPtr = stringInputs.begin(); strPtr != stringInputs.end(); strPtr++) {
		// cout << *strPtr << endl ; 
	// }

	return 0;
}