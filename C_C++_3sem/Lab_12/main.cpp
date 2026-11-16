#include <iostream>
#include "DLinkedList.h"





int main() {

	dList<double> myList{};
	
	std::cin >> myList;

	std::cout << myList << '\n';

	return 0;
}