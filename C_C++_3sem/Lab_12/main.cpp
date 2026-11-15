#include <iostream>
#include "DLinkedList.h"





int main() {

	dList<double> myList{};

	myList.push_front(5);
	myList.push_front(10);

	std::cout << myList << '\n';

	myList.~dList();

	std::cout << myList << '\n';


	return 0;
}