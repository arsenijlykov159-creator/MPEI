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

	void clear() {
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


public:

	dList() = default;

	~dList() {
		clear();
	}

	bool isEmpty() const { return (m_data.first == nullptr); }

	dList& push_front(T element) {
		Node* new_first{ new (std::nothrow) Node{ .previous = m_data.last, .next = m_data.first, .data = element } };

		if (!m_data.first) {
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