#include <iostream>
#include <clocale>
#include "STRING.h"






int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		std::cerr << "Слишком мало входных параметров!\n";
		return 1;
	}

	STRING string{};

	string.get(argv[1]);

	string.replaceSubStr("!!!", "ooo");

	string.print(argv[2]);

	return 0;
}