#include <iostream>
#include <fstream>
#include <clocale>
#include <limits>
#include "Type.h"


void ignoreLine(std::istream& in) {
	in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}


BitType getBitValue(std::istream& in) {

	while (true) {
		BitType bt{};
		in >> bt;

		bool success{ in && in.peek() == '\n'};
		in.clear();
		ignoreLine(in);

		if (success) return bt;
		else std::cerr << "Неверный ввод!\n";
	}

}


int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 2) {
		std::cerr << "Недостаточно входных параметров!\n";
		return 1;
	}

	std::ifstream input_file{ argv[1], std::ios::in };

	if (!input_file.is_open()) {
		std::cerr << "Невозможно открыть входной файл!\n";
		return 2;
	}

#if !defined(SHORT_T)
	std::cout << "Введи значение типа " << typeid(BitType).name() << " (от " << std::numeric_limits<BitType>::min() << " до " << std::numeric_limits<BitType>::max() << "): ";
#else 
	std::cout << "Введи значение типа " << typeid(BitType).name() << " (ровно один символ): ";
#endif

	BitType value{ getBitValue(std::cin) };

	std::cout << value << '\n';



	input_file.close();

	return 0;
}