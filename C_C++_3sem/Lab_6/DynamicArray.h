#if !defined(DYNAMICARRAY_H)
#define DYNAMICARRAY_H


#include <iostream>
#include <fstream>
#include <vector>
#include <new>

class DynamicArray {
public:
	using st = std::size_t;
	using Data = double*;

private:
	Data m_data{};
	st m_rows{};
	st m_columns{};
	st m_size{};
	st m_capacity{};

	bool isNewLine(std::ifstream& ifile) {
		if (!ifile.is_open()) return false;

		int next_elem{ ifile.peek() };

		return (next_elem == '\n' || next_elem == 'r' || next_elem == -1);
	}

public:

	DynamicArray() = default;

	bool getFromFile(std::ifstream& ifile);

	constexpr bool set(st i, st j, double element) {
		if (!(i < m_rows && j < m_columns)) return false;

		m_data[i * m_columns + j] = element;
	}

	constexpr double get(st i, st j) const { return m_data[i * m_columns + j]; }

	friend void printMatrix(const DynamicArray& da);

};


#endif