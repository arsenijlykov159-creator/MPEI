#include <iostream>
#include <fstream>
#include <clocale>
#include <limits>
#include <cmath>
#include "Type.h"
#include "Check.h"
#include <bit>



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
	

	std::cout << "Введи значение типа " << typeid(BitType).name() << " (от " << std::numeric_limits<BitType>::min() << " до " << static_cast<std::size_t>(std::numeric_limits<BitType>::max()) << "): ";

	BitType value{ getBitValue(std::cin) };

	std::cout << "Введи количество бит для сдвига ( >= 0 ): ";

	BitType bit_count{ getBitValue(std::cin) };

	std::cout << "\nВы ввели:\nНачальное число (bin - dec - hex): ";
	printFormat(value, 2);
	std::cout << " - " << static_cast<std::size_t>(value) << " - ";
	printFormat(value, 16);
	std::cout << '\n';

	std::cout << "Сдвинуть биты на: " << bit_count << "\n\n";

	BitType result{ rotl(value, bit_count) };

	std::cout << "Результат (bin - dec - hex): ";
	printFormat(result, 2);
	std::cout << " - " << static_cast<std::size_t>(result) << " - ";
	printFormat(result, 16);
	std::cout << '\n';
	

	check(value, *rotl);

	std::cout << "\n_____Все проверки пройдены!_____\n";

	return 0;
}