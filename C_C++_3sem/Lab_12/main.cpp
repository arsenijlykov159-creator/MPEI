#include <iostream>
#include "DLinkedList.h"





int main() {

	dList<double> myList{};
	std::cout << myList.size() << '\n';
	myList.push_front(5);
	std::cout << myList.size() << '\n';
	myList.push_front(10);
	std::cout << myList.size() << '\n';
	myList.push_back(100);
	std::cout << myList.size() << '\n';
	myList.push_front(101);
	std::cout << myList.size() << '\n';
	myList.push_back(102);
	std::cout << myList.size() << '\n';

	myList.pop_back();
	std::cout << myList.size() << '\n';
	myList.pop_front();
	std::cout << myList.size() << '\n';
	myList.pop_back();
	std::cout << myList.size() << '\n';
	myList.pop_front();
	std::cout << myList.size() << '\n';
	myList.pop_back();
	std::cout << myList.size() << '\n';

	return 0;
}