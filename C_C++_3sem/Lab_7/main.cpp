#include <iostream>
#include <fstream>
#include <clocale>
#include <limits>
#include <cmath>
#include "Type.h"


//std::size_t twoPow(std::size_t indicator) {
//	std::size_t result{ 1 };
//
//	for (std::size_t i{ 0 }; i < indicator; ++i) {
//		result *= 2;
//	}
//
//	return result;
//}


void ignoreLine(std::istream& in) {
	in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}


BitType getBitValue(std::istream& in) {

	while (true) {
		std::size_t bt{};
		in >> bt;

		bool success{ in && in.peek() == '\n'};
		in.clear();
		ignoreLine(in);

		if (success && (bt <= std::numeric_limits<BitType>::max())) return static_cast<BitType>(bt);
		else std::cerr << "Неверный ввод!\n";
	}

}


std::size_t getShiftCount(std::istream& in) {

	while (true) {
		long long count{};
		in >> count;

		bool success{ in && in.peek() == '\n' };
		in.clear();
		ignoreLine(in);

		if (success && (count >= 0)) return static_cast<std::size_t>(count);
		else std::cerr << "Неверное количество бит для сдвига!\n";
	}

}


BitType rotl(BitType bt, std::size_t rotl_count) {
	const std::size_t total_bit{ sizeof(bt) * 8 };
	std::size_t real_count{ rotl_count % total_bit};

	if (real_count == 0) return bt;

	const BitType first{ static_cast<BitType>(bt << real_count) };
	const BitType second{ static_cast<BitType>(bt >> (total_bit - real_count)) };

	return static_cast<BitType>(first | second);
}



void printFormat(BitType bt, BitType exp) {
	if (bt < exp) {
		std::cout << bt;
		return;
	}
	printFormat((bt / exp), exp);

	std::cout << (bt % exp);
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

	std::cout << "Введи количество бит для сдвига ( >= 0 ): ";

	std::size_t bit_count{ getShiftCount(std::cin) };

	std::cout << bit_count << '\n';

	printFormat(rotl(value, bit_count), 10);
	

	input_file.close();

	return 0;
}