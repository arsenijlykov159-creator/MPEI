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

	constexpr std::optional<T> dequeue() {
		if (m_data == nullptr) return {};

		auto temp{ *m_data };

		if (m_size == 1) {
			clear();
			return temp;
		}

		--m_size;
		for (Size i{ 0 }; i < m_size; ++i) {
			std::swap(m_data[i], m_data[i + 1]);
		}
		return temp;
	}






	friend std::ostream& operator<<(std::ostream& out, const Queue& q) {
		out << q.m_capacity << ' ' << q.m_size << '\n';

		if (q.m_data == nullptr || q.m_size == 0) {
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