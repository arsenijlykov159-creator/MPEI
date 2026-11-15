#include <iostream>
#include "DLinkedList.h"





int main() {

	dList<double> myList{};

	myList.push_front(5);
	myList.push_front(10);
	myList.push_back(100);
	myList.push_front(101);
	myList.push_back(102);

	std::cout << myList << '\n';

	myList.erase(myList.front()->next->next->next->next->next);


	std::cout << myList << '\n';


	return 0;
}