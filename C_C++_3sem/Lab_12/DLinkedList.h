#if !defined(DLINKEDLIST_H)
#define DLINKEDLIST_H

#include <iostream>


template <typename T>
class dList {
public:

	struct Node {
		Node* previous{ nullptr };
		Node* next{ nullptr };
		T data{};
	};

	struct Data {
		Node* first{ nullptr };
		Node* last{ nullptr };
	};


private:
	Data m_data{};

	constexpr void clear() {
		if (isEmpty()) return;

		Node* ptr{ m_data.first };
		Node* ptr_next{};

		do {
			ptr_next = ptr->next;
			delete ptr;
			ptr = ptr_next;
		} while (ptr != m_data.first);

		m_data.first = nullptr;
		m_data.last = nullptr;
	}

	constexpr bool isInList(Node* ptr) const {
		if (isEmpty() || !ptr) return false;

		Node* current_ptr{ m_data.first };

		do {
			if (current_ptr == ptr) return true;
			current_ptr = current_ptr->next;
		} while (current_ptr != m_data.first);

		return false;
	}


public:

	dList() = default;
	~dList() {
		clear();
	}


	constexpr Node* front() const { return m_data.first; }
	constexpr Node* back() const { return m_data.last; }


	constexpr bool isEmpty() const { return (m_data.first == nullptr); }

	constexpr dList& push_front(T element) {
		Node* new_first{ new (std::nothrow) Node{ .previous = m_data.last, .next = m_data.first, .data = element } };
		if (new_first == nullptr) return *this;

		if (isEmpty()) {
			m_data.first = new_first;
			m_data.last = new_first;
			m_data.first->next = m_data.first;
			m_data.first->previous = m_data.first;
			m_data.last->next = m_data.first;
			m_data.last->previous = m_data.first;
		}
		else {
			m_data.first->previous = new_first;
			m_data.last->next = new_first;
			m_data.first = new_first;
		}

		return *this;
	}
	constexpr dList& push_back(T element) {
		Node* new_last{ new (std::nothrow) Node{ .previous = m_data.last, .next = m_data.first, .data = element } };
		if (!new_last) return *this;

		if (isEmpty()) {
			m_data.first = new_last;
			m_data.last = new_last;
			m_data.first->next = m_data.first;
			m_data.first->previous = m_data.first;
			m_data.last->next = m_data.first;
			m_data.last->previous = m_data.first;
		}
		else {
			m_data.last->next = new_last;
			m_data.first->previous = new_last;
			m_data.last = new_last;
		}

		return *this;
	}

	constexpr dList& insert(Node* ptr, T value) {
		if (!isInList(ptr)) return *this;

		if (ptr == m_data.last) return push_back(value);

		Node* new_node{ new (std::nothrow) Node{ .previous = ptr, .next = ptr->next, .data = value } };
		if (new_node == nullptr) return *this;

		bool isSingle{ m_data.first == m_data.last };

		ptr->next->previous = new_node;
		ptr->next = new_node;

		if (isSingle) m_data.last = new_node;
		return *this;
	}

	constexpr dList& pop_front() {
		if (isEmpty()) return *this;

		if (m_data.first == m_data.last) clear();
		else {
			m_data.first = m_data.first->next;
			m_data.last->next = m_data.first;

			delete m_data.first->previous;
			m_data.first->previous = m_data.last;
		}

		return *this;
	}
	constexpr dList& pop_back() {
		if (isEmpty()) return *this;

		if (m_data.first == m_data.last) clear();
		else {
			m_data.last = m_data.last->previous;
			m_data.last->next = m_data.first;

			delete m_data.first->previous;
			m_data.first->previous = m_data.last;
		}

		return *this;
	}


	

	friend std::ostream& operator<<(std::ostream& out, const dList& dl) {
		if (dl.isEmpty()) {
			out << "_____empty_____\n";
			return out;
		}

		Node* ptr{ dl.m_data.first };
		
		do {
			out << ptr->data << ' ';
			ptr = ptr->next;
		} while (ptr != dl.m_data.first);

		return out;
	}

};




#endif