#include <iostream>
#include <fstream>
#include <clocale>
#include <limits>
#include <cmath>
#include "Type.h"
#include "Check.h"


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

		while (in.peek() == ' ') in.get();

		bool success{ in && in.peek() == '\n'};
		in.clear();
		ignoreLine(in);

		if (success && (bt <= std::numeric_limits<BitType>::max())) return static_cast<BitType>(bt);
		else std::cerr << "Неверный ввод!\n";
	}

}


BitType getShiftCount(std::istream& in) {

	while (true) {
		long long count{};
		in >> count;

		while (in.peek() == ' ') in.get();

		bool success{ in && in.peek() == '\n' };
		in.clear();
		ignoreLine(in);

		if (success && (count >= 0)) return static_cast<BitType>(count);
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
		std::cout << static_cast<std::size_t>(bt);
		return;
	}
	printFormat(static_cast<BitType>(bt / exp), exp);

	std::cout << static_cast<std::size_t>(bt % exp);
}


int main() {

	setlocale(LC_ALL, "russian");
	
#if !defined(SHORT_T)
	std::cout << "Введи значение типа " << typeid(BitType).name() << " (от " << std::numeric_limits<BitType>::min() << " до " << std::numeric_limits<BitType>::max() << "): ";
#else 
	std::cout << "Введи значение типа " << typeid(BitType).name() << " (ровно один символ): ";
#endif

	BitType value{ getBitValue(std::cin) };

	std::cout << "Введи количество бит для сдвига ( >= 0 ): ";

	BitType bit_count{ getShiftCount(std::cin) };

	std::cout << "\nВы ввели:\nНачальное число (bin - dec - hex): ";
	printFormat(value, 2);
	std::cout << " - ";
	printFormat(value, 10);
	std::cout << " - "; 
	printFormat(value, 16);
	std::cout << '\n';

	std::cout << "Сдвинуть биты на: " << bit_count << "\n\n";

	BitType result{ rotl(value, bit_count) };

	std::cout << "Результат (bin - dec - hex): ";
	printFormat(result, 2);
	std::cout << " - ";
	printFormat(result, 10);
	std::cout << " - ";
	printFormat(result, 16);
	std::cout << '\n';
	

	check(value, *rotl);

	std::cout << "\n_____Все провекри пройдены!_____\n";

	return 0;
}