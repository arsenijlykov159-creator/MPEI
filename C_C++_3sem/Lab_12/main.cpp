#include <iostream>
#include <utility>
#include <limits>
#include <clocale>
#include <cctype>
#include <fstream>
#include "DLinkedList.h"
#include "Queue.h"


// 1 задание список

template <typename T>
bool isNegativeLessThanAThird(const dList<T>& list) {
	if (list.isEmpty()) return false;

	std::size_t count_negative{};
	auto ptr{ list.front() };

	do {
		if (ptr->data < 0) ++count_negative;
		ptr = ptr->next;
	} while (ptr != list.front());

	return (count_negative * 3 < list.size());
}


void ignoreLine(std::istream& in) {
	in.ignore(std::numeric_limits<std::streamsize>::max(), '\n');
}

template <typename T>
std::pair<T, T> getRange(std::istream& in) {
	while (true) {
		T left{};
		T right{};

		in >> left >> right;
		bool result{ in };
		in.clear();
		ignoreLine(in);

		if (result) return { left, right };
		else std::cerr << "_____Неверный диапозон!_____\n";
	}
}


template <typename T>
void deleteElement(dList<T>& list, const auto& fcn) {
	if (list.isEmpty()) return;

	auto ptr{ list.front() };
	
	do {
		auto temp{ ptr->next };
		if (fcn(static_cast<unsigned char>(ptr->data))) list.erase(ptr);
		ptr = temp;
	} while (ptr != list.back());

	if (fcn(static_cast<unsigned char>(ptr->data))) list.erase(ptr);
}



// 2 задание список

bool hasDigit(const dList<char>& list) {
	if (list.isEmpty()) return false;

	auto ptr{ list.front() };
	do {
		if (std::isdigit(static_cast<unsigned char>(ptr->data))) return true;
		ptr = ptr->next;
	} while (ptr != list.front());

	return false;
}


// 3 задание очередь

template <typename T>
std::pair<Queue<T>, Queue<T>> separateQueue(Queue<T>& q, const auto& fcn) {
	Queue<T> first{};
	Queue<T> second{};

	while (!q.isEmpty()) {
		T element{ q.dequeue().value() };
		if (fcn(element)) first.enqueue(element);
		else second.enqueue(element);
	}

	return { first, second };
}





#include <windows.h>

int main(int argc, char* argv[]) {

	setlocale(LC_ALL, "russian");

	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);

	if (argc < 2) {
		std::cerr << "Недостаточно параметров!\n";
		return 1;
	}

	std::ifstream input_file{ argv[1] };

	if (!input_file) {
		std::cerr << "Входной файл не может быть открыт на запись!\n";
		return 2;
	}

	// 1 задание список

	dList<double> double_data{};
	input_file >> double_data;

	std::pair<double, double> range{ getRange<double>(input_file) };

	auto function_1{ [=](double x) {
		return (x > range.first && x < range.second);
	} };

	if (isNegativeLessThanAThird(double_data)) deleteElement(double_data, function_1);

	std::cout << "Результат 1 задания: " << double_data << '\n';


	// 2 задание список

	dList<char> char_data{};
	input_file >> char_data;

	auto function_2{ [](unsigned char letter) {
		return ((letter >= 192 && letter <= 255) || letter == 168 || letter == 184);
	} };

	if (hasDigit(char_data)) deleteElement(char_data, function_2);

	std::cout << "Результат 2 задания: " << char_data << '\n';


	// 1 задание очередь

	Queue<int> int_queue{};
	input_file >> int_queue;

	auto function_3{ [](int x) {
		return (x % 2 == 0);
	} };

	auto [even, odd] = separateQueue(int_queue, function_3);

	std::cout << "Результат 3 задания:\n    Четные: " << even << "\n    Нечетные: " << odd << '\n';



	// 2 задание очередь

	Queue<double> double_queue{};
	input_file >> double_queue;

	double value{};
	input_file >> value;

	auto function_4{ [=](double x) {
		return (x < value);
	} };

	auto [less, other] = separateQueue(double_queue, function_4);

	std::cout << "Результат 4 задания:\n    Меньше " << value << ": " << less << "\n    Больше или равны: " << other << '\n';

	return 0;
}