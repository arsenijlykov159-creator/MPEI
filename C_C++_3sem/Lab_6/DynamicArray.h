#if !defined(DYNAMICARRAY_H)
#define DYNAMICARRAY_H


#include <iostream>
#include <optional>
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

		int next_elem{};

		do {
			next_elem = ifile.get();
		} while (next_elem == ' ');

		ifile.unget();

		return (next_elem == '\n' || next_elem == 'r' || next_elem == -1);
	}

	void copy(double* new_da) {
		st count{ m_size };

		for (st i{ 0 }; i < count; ++i) { m_data[i] = new_da[i]; }
	}

public:

	DynamicArray() = default;

	void clear() {
		delete[] m_data;
		m_data = nullptr;
		m_rows = m_columns = m_size = m_capacity = 0;
	}

	bool getFromFile(std::ifstream& ifile);

	constexpr bool set(st i, st j, double element) {
		if (!(i < m_rows && j < m_columns)) return false;

		m_data[i * m_columns + j] = element;
		return true;
	}

	std::optional<double> get(st i, st j) const { 
		if (!(i < m_rows && j < m_columns)) return {};

		return m_data[i * m_columns + j]; 
	}

	void print() const;

};


#endif