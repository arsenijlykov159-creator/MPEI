#if !defined(QUEUE_H)
#define QUEUE_H

#include <iostream>
#include <utility>
#include <cassert>
#include <optional>


template <typename T>
class Queue {
public:
	using Data = T*;
	using Size = std::size_t;

private:
	Data m_data{ nullptr };
	Size m_size{};
	Size m_capacity{};

	// выделение памяти в нужном количестве и копирвоание прошлых элементов
	constexpr void alloc(Size new_size, Size old_size = 0) {
		if (!(new_size > old_size)) return;

		auto* temp{ m_data };

		m_data = new (std::nothrow) T[new_size];
		assert(m_data);

		if (old_size == 0) {
			delete[] temp;
			return;
		}

		for (Size i{ 0 }; i < old_size; ++i) {
			m_data[i] = temp[i];
		}

		delete[] temp;
	}

	// удаление памяти
	constexpr void clear() {
		delete[] m_data;
		m_size = 0;
		m_capacity = 0;
	}

public:

	Queue() = default;

	explicit constexpr Queue(Size size) : m_size{ size }, m_capacity{ size } {
		alloc(m_capacity);

		for (Size i{ 0 }; i < m_size; ++i) {
			m_data[i] = {};
		}
	}

	// добавление элемента в конец очереди
	constexpr Queue& enqueue(const T& value) {
		if (m_capacity == 0) {
			++m_capacity;
			alloc(m_capacity);
		}
		if (!(m_capacity >= m_size + 1)) {
			alloc(m_capacity * 2, m_size);
			m_capacity *= 2;
		}

		m_data[m_size] = value;
		++m_size;
		return *this;
	}

	// удаление элемента из начала очереди
	constexpr std::optional<T> dequeue() {
		if (isEmpty()) return {};

		auto temp{ std::move(*m_data) };

		if (m_size == 1) {
			clear();
			return temp;
		}

		--m_size;
		for (Size i{ 0 }; i < m_size; ++i) {
			m_data[i] = std::move(m_data[i + 1]);
		}
		return temp;
	}

	// проверка на пустоту
	constexpr bool isEmpty() const { return (m_size == 0); }

	// получение первого элемента очереди без его удаления
	constexpr std::optional<T> peek() const {
		if (isEmpty()) return {};
		else return *m_data;
	}

	// размер
	constexpr Size size() const { return m_size; }

	

	// вывод
	friend std::ostream& operator<<(std::ostream& out, const Queue& q) {
		out << q.m_capacity << ' ' << q.m_size << '\n';

		if (q.isEmpty()) {
			out << "_____empty_____";
			return out;
		}

		for (Size i{ 0 }; i < q.m_size; ++i) {
			out << q.m_data[i] << ' ';
		}

		return out;
	}

};




#endif