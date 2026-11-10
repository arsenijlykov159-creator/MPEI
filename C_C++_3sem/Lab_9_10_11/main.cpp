#include <iostream>
#include <clocale>
#include <Windows.h>
#include "Matrix.h"
#include <cstddef>


void foo(const Matrix& x) {
	std::cout << x << '\n';
}

void goo(double d) {
	std::cout << d << '\n';
}



int main() {

	setlocale(LC_ALL, "Russian");

	Matrix a1{ 4, 5 };
	std::cout << a1 << '\n';

	Matrix a2{};
	std::cout << a2 << '\n';

	Matrix a3{ 2, 3 };
	std::cout << "¬ведите матрицу с размерами 2 на 3:\n";
	std::cin >> a3;

	Matrix a3_copy{ a3 };
	std::cout << a3_copy << '\n';

	Matrix a3_copy_2{ a3, 5 };
	std::cout << a3_copy_2 << '\n';

	Matrix a4{ std::move(Matrix{ 3, 4 }) };
	std::cout << a4 << '\n';

	foo(static_cast<Matrix>(5));

	goo(static_cast<double>(a4));







	Matrix a5{};
	a5 = a4;
	std::cout << a5 << '\n';

	Matrix a6{};
	a6 = Matrix{ 2, 2 };
	std::cout << a6 << '\n';

	std::cout << (a5 < a6) << '\n';
	std::cout << (a5 == a6) << '\n';
	std::cout << (a5 > a6) << "\n\n";

	a6[0][0] = 10;
	a6[1][1] = 15;

	std::cout << a6 << '\n';

	a6 += 5;
	std::cout << a6 << '\n';

	std::cout << a6 + a6 << '\n';
	std::cout << a6 - a6 << '\n';

	return 0;
}