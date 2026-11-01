#if !defined(MATRIX_H)
#define MATRIX_H

#include <iostream>
#include <cassert>
#include <algorithm>
#include <utility>
#include <numeric>


class Matrix {
public:
	using Size = std::size_t;
	using Data = int*;

private:
	Data m_data{};
	Size m_rows{};
	Size m_columns{};
	Size m_capacity{};

	void clear() {
		delete[] m_data;
		m_data = nullptr;
		m_rows = 0;
		m_columns = 0;
		m_capacity = 0;
	}

public:

	explicit Matrix(Size rows = 0, Size columns = 0);

	Matrix(const Matrix& matrix, int value = 0);

	Matrix(Matrix&& other_data) noexcept;

	explicit Matrix(int value);

	operator double() const {
		if (m_rows * m_columns == 0) return 0.0;

		int sum{};

		for (Size i{ 0 }; i < m_rows * m_columns; ++i) sum += m_data[i];

		std::cout << "Вызвано преобразование из Matrix в double!\n";
		return static_cast<double>(sum) / (m_rows * m_columns);
	}

	friend std::istream& operator>>(std::istream& in, Matrix& matrix);

	friend std::ostream& operator<<(std::ostream& out, const Matrix& matrix);

	~Matrix();



	



	Data operator[](Size index) const {
		assert(index < m_rows && "Такой строки в матрице нет");

		return &(m_data[index * m_columns]);
	}

	friend Matrix operator+(const Matrix& m1, const Matrix& m2);

};



#endif