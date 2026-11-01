#include <iostream>
#include <clocale>
#include "Matrix.h"
#include <cstddef>





void foo(double) {
	return;
}




int main() {

	setlocale(LC_ALL, "russian");
	
	/*Matrix m_1{};
	std::cout << m_1 << '\n';

	Matrix m_2{ 5 };
	std::cout << m_2 << '\n';

	Matrix m_3(2, 3);
	std::cout << m_3 << '\n';
	m_3 = { {1, 2, 3}, {4, 5, 6} };

	Matrix m_4{ m_2 };
	std::cout << m_4 << '\n';

	Matrix m_5{ m_2, 10 };
	std::cout << m_5 << '\n';

	Matrix m_6{}


	foo(m_5);*/

	Matrix m_7{ 2, 3 };
	std::cin >> m_7;
	
	Matrix m_8{ 2, 3 };
	std::cin >> m_8;

	std::cout << m_7 + m_8 << '\n';


	return 0;
}