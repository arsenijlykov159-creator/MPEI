#include <iostream>
#include <fstream>
#include <clocale>




int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	if (argc < 3) {
		std::cerr << "Недостаточно параметров!\n";
		return 1;
	}

	std::ifstream ifile{ argv[1], std::ios::in };



	ifile.close();

	return 0;
}