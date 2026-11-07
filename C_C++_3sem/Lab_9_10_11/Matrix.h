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

	explicit operator double() const;

	friend std::istream& operator>>(std::istream& in, Matrix& matrix);

	friend std::ostream& operator<<(std::ostream& out, const Matrix& matrix);

	~Matrix();



	
	Matrix& operator=(const Matrix& m);

	Matrix& operator=(Matrix&& m) noexcept;

	friend bool operator==(const Matrix& m1, const Matrix& m2);

	const int* operator[](Size index) const {
		assert((index < m_rows) && m_data && "Matrix::operator[]");

		return m_data + (index * m_columns);
	}
	
	Data operator[](Size index) {
		return const_cast<Data>(std::as_const(*this)[index]);
	}

	Matrix& operator+=(const Matrix& m);

};



#endif