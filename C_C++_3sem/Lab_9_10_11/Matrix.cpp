#include "Matrix.h"


Matrix::Matrix(Size rows, Size columns) : m_rows{ rows }, m_columns{ columns }, m_capacity{ m_rows * m_columns } {
	if (m_capacity > 0) m_data = new (std::nothrow) int[m_capacity];

	std::cout << "Вызван конструктор умолчания/создания матрицы по размерам!\n";
}

Matrix::Matrix(const Matrix& matrix, int value) : m_rows{ matrix.m_rows }, m_columns{ matrix.m_columns }, m_capacity{ m_rows * m_columns } {
	m_data = new (std::nothrow) int[m_capacity];
	if (!m_data) return;

	for (Size i{ 0 }; i < m_rows; ++i) {
		for (Size j{ 0 }; j < m_columns; ++j) {
			(*this)[i][j] = matrix[i][j] + value;
		}
	}

	std::cout << "Вызван конструктор копирования!\n";
}

Matrix::Matrix(Matrix&& other_data) noexcept : m_rows{ other_data.m_rows }, m_columns{ other_data.m_columns }, m_capacity{ m_capacity > other_data.m_capacity ? m_capacity : other_data.m_capacity } {
	m_data = other_data.m_data;
	other_data.m_data = nullptr;

	std::cout << "Вызван конструктор перемещения!\n";
}

Matrix::Matrix(int value) : m_rows{ 1 }, m_columns{ 1 }, m_capacity{ 1 } {
	m_data = new (std::nothrow) int[1];
	if (!m_data) return;
	*m_data = value;

	std::cout << "Вызван конструктор с одним параметром int!\n";
}

Matrix::~Matrix() {
	clear();

	std::cout << "Вызван деструктор!\n";
}

Matrix::operator double() const {
	if (m_rows * m_columns == 0) return 0.0;

	int sum{};

	for (Size i{ 0 }; i < m_rows * m_columns; ++i) sum += m_data[i];

	std::cout << "Вызвано преобразование из Matrix в double!\n";
	return static_cast<double>(sum) / (m_rows * m_columns);
}



std::istream& operator>>(std::istream& in, Matrix& matrix) {
	if (matrix.m_rows <= 0 || matrix.m_columns <= 0) {
		in.setstate(std::ios_base::failbit);
		return in;
	}

	for (Matrix::Size i{ 0 }; i < matrix.m_rows; ++i) {
		for (Matrix::Size j{ 0 }; j < matrix.m_columns; ++j) {
			in >> matrix[i][j];
		}
	}

	if (!in) matrix.clear();

	return in;
}

std::ostream& operator<<(std::ostream& out, const Matrix& matrix) {
	std::cout << matrix.m_rows << " - " << matrix.m_columns << " | " << matrix.m_capacity << '\n';
	if (!matrix.m_data) return out;

	for (Matrix::Size i{ 0 }; i < matrix.m_rows; ++i) {
		for (Matrix::Size j{ 0 }; j < matrix.m_columns; ++j) {
			out << matrix[i][j] << ' ';
		}
		out << '\n';
	}
	return out;
}


Matrix& Matrix::operator=(const Matrix& m) {
	if (this == &m) return *this;

	Matrix::Data temp{ new (std::nothrow) int[m.m_capacity] };
	if (!temp) return *this;

	for (Size i{ 0 }; i < m.m_rows * m.m_columns; ++i) {
		temp[i] = m.m_data[i];
	}

	delete[] m_data;
	m_data = temp;
	temp = nullptr;
	m_rows = m.m_rows;
	m_columns = m.m_columns;
	m_capacity = m.m_capacity;

	std::cout << "Вызван operator=(const Matrix&)\n";

	return *this;
}

Matrix& Matrix::operator=(Matrix&& m) noexcept {
	if (this == &m) return *this;

	delete[] m_data;
	m_data = m.m_data;
	m_rows = m.m_rows;
	m_columns = m.m_columns;
	m_capacity = m.m_capacity;

	m.m_data = nullptr;
	m.m_rows = 0;
	m.m_columns = 0;
	m.m_capacity = 0;

	std::cout << "Вызван operator=(Matrix&&)\n";
	return *this;
}

bool operator==(const Matrix& m1, const Matrix& m2) {
	if (!m1.m_data || !m2.m_data) return false;
	if (m1.m_rows != m2.m_rows || m1.m_columns != m2.m_columns || m1.m_capacity != m2.m_capacity) return false;

	for (Matrix::Size i{ 0 }; i < m1.m_rows * m1.m_columns; ++i) {
		if (m1.m_data[i] != m2.m_data[i]) return false;
	}

	return true;
}

Matrix& Matrix::operator+=(const Matrix& m) {
	assert(m_rows == m.m_rows && m_columns == m.m_columns && "Matrix::operator+=");
	if (!m.m_data) return *this;

	for (Size i{ 0 }; i < m_rows * m_columns; ++i) {
		m_data[i] += m.m_data[i];
	}

	return *this;
}
