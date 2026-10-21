#include <iostream>
#include "Type.h"


void ignoreLine(std::istream& in) {
	in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}


BitType getBitValue(std::istream& in) {

	while (true) {
		long long bt{};
		in >> bt;

		while (in.peek() == ' ') in.get();

		bool success{ in && in.peek() == '\n' };
		in.clear();
		ignoreLine(in);

		if (success && (bt <= std::numeric_limits<BitType>::max()) && (bt >= 0)) return static_cast<BitType>(bt);
		else std::cerr << "Неверный ввод!\n";
	}

}


BitType rotl(BitType bt, std::size_t rotl_count) {
	const std::size_t total_bit{ sizeof(bt) << 3 };
	std::size_t real_count{ rotl_count & (total_bit - 1) };

	if (real_count == 0) return bt;

	const BitType first{ static_cast<BitType>(bt << real_count) };
	const BitType second{ static_cast<BitType>(bt >> (total_bit - real_count)) };

	return static_cast<BitType>(first | second);
}