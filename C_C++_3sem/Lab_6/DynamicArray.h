#if !defined(DYNAMICARRAY_H)
#define DYNAMICARRAY_H


#include <iostream>
#include <optional>
#include <fstream>
#include <vector>
#include <new>


class DynamicArray {
public:
	using Size = std::size_t;
	using Data_ptr = double*;

private:
	Data_ptr m_data{};
	Size m_rows{};
	Size m_columns{};
	Size m_size{};
	Size m_capacity{};

	bool isNewLine(std::istream& ifile) {
		if (!ifile) return false;

		int next_elem{};

		do {
			next_elem = ifile.get();
		} while (next_elem == ' ');

		ifile.unget();

		return (next_elem == '\n' || next_elem == 'r' || next_elem == -1);
	}

	void copy(double* new_da) {
		Size count{ m_size };

		for (Size i{ 0 }; i < count; ++i) { m_data[i] = new_da[i]; }
	}

public:

	DynamicArray() = default;

	constexpr Size rows() const { return m_rows; }
	constexpr Size columns() const { return m_columns; }
	constexpr Size size() const { return m_size; }

	constexpr Data_ptr dataPtr() const { return m_data; }
	constexpr Data_ptr getRow(DynamicArray::Size i) const {
		if (!(i < m_rows)) return nullptr;

		return &(m_data[i * m_columns]);
	}

	void clear() {
		delete[] m_data;
		m_data = nullptr;
		m_rows = m_columns = m_size = m_capacity = 0;
	}

	bool getFromFile(std::ifstream& ifile);


	constexpr bool set(Size i, Size j, double element) {
		if (!(i < m_rows && j < m_columns)) return false;

		m_data[i * m_columns + j] = element;
		return true;
	}

	std::optional<double> get(Size i, Size j) const {
		if (!(i < m_rows && j < m_columns)) return {};

		return m_data[i * m_columns + j]; 
	}

	friend std::istream& operator>>(std::istream& in, DynamicArray& da);
	friend std::ostream& operator<<(std::ostream& out, const DynamicArray& da);

};


#endif