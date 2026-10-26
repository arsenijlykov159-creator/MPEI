#include <iostream>
#include <clocale>
#include "STRING.h"






int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		std::cerr << "Слишком мало входных параметров!\n";
		return 1;
	}

	char string[STR::MAX_LENGTH];

	if (!STR::strGet(argv[1], string)) {
		std::cerr << "No!\n";
		return 2;
	}

	if (!STR::strPrint(argv[2], string)) std::cerr << "Error!\n";



	return 0;
}