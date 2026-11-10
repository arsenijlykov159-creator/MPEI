#include <iostream>
#include <clocale>
#include "String_dll.h"





int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "ru");

	if (argc < 3) {
		std::cerr << "Недостаточно параметров!\n";
		return 1;
	}


	char mystring[MyType::MAX_LENGTH]{};

	file_get(argv[1], mystring, MyType::MAX_LENGTH);

	str_add(mystring, MyType::MAX_LENGTH, " Nice To meet you!!!");

	str_replace(mystring, MyType::MAX_LENGTH, "!!!", "???");

	file_print(argv[2], mystring);

	return 0;
}