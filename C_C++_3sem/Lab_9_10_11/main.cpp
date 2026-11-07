#include <iostream>
#include <clocale>
#include <Windows.h>
#include "Matrix.h"
#include <cstddef>





void foo(double) {
	return;
}




int main() {

	setlocale(LC_ALL, "Russian");

	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	
	
	Matrix m1{3, 3};

	std::cin >> m1;

	Matrix m2{};

	std::cin >> m2;

	m1 += m2;

	std::cout << m1 << '\n';


	return 0;
}