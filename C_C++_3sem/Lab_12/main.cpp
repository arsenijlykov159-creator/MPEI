#include <iostream>
#include "Queue.h"





int main() {

	Queue<double> q{};

	std::cout << q << '\n';

	q.enqueue(5);
	std::cout << q << '\n';
	q.enqueue(6);
	std::cout << q << '\n';
	q.enqueue(7);
	std::cout << q << '\n';
	q.enqueue(8);
	std::cout << q << '\n';
	q.enqueue(9);
	std::cout << q << '\n';

	std::cout << q.dequeue().value() << '\n';
	std::cout << q << '\n';
	std::cout << q.dequeue().value() << '\n';
	std::cout << q << '\n';
	std::cout << q.dequeue().value() << '\n';
	std::cout << q << '\n';
	std::cout << q.dequeue().value() << '\n';
	std::cout << q << '\n';
	std::cout << q.dequeue().value() << '\n';
	std::cout << q << '\n';

	return 0;
}