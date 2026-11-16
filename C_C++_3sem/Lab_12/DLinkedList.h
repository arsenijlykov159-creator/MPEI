#if !defined(DLINKEDLIST_H)
#define DLINKEDLIST_H

#include <iostream>
#include <string>
#include <sstream>


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

	// удаление всего списка
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

	// есть ли такой узел в списке
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

	// конструктор копирования
	dList(const dList& dl) {
		if (dl.isEmpty()) return;
		if (dl.m_data.first == dl.m_data.last) {
			push_back(dl.m_data.first->data);
			return;
		}

		Node* ptr{ dl.m_data.first };

		Node* new_node{ nullptr };
		Node* old_node{ new (std::nothrow) Node};
		if (old_node == nullptr) return;
		old_node->data = ptr->data;

		m_data.first = old_node;

		ptr = ptr->next;
		do {
			new_node = new (std::nothrow) Node{ .previous = old_node, .next = nullptr, .data = ptr->data };
			if (new_node == nullptr) {
				old_node->next = m_data.first;
				m_data.last = old_node;
				this->clear();
				m_data = {};
				return;
			}

			old_node->next = new_node;

			old_node = new_node;
			ptr = ptr->next;
		} while (ptr != dl.m_data.first);

		new_node->next = m_data.first;
		m_data.first->previous = new_node;
		m_data.last = new_node;
	}

	// оператор присваивания копированием
	constexpr dList& operator=(const dList& dl) {
		if (dl.isEmpty() || this == &dl) return *this;

		dList temp{ dl };
		std::swap(m_data, temp.m_data);
		return *this;
	}

	// длина списка
	constexpr std::size_t size() const {
		if (isEmpty()) return 0;

		Node* ptr{ m_data.first };
		std::size_t size{ 0 };

		do {
			ptr = ptr->next;
			++size;
		} while (ptr != m_data.first);

		return size;
	}


	// получение указателя на начальный элемент
	constexpr Node* front() const { return m_data.first; }
	// получение указателя на конечный элемент
	constexpr Node* back() const { return m_data.last; }

	// пуст ли список
	constexpr bool isEmpty() const { return (m_data.first == nullptr); }

	// добавление в начало
	constexpr dList& push_front(const T& element) {
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
	// добавление в конец
	constexpr dList& push_back(const T& element) {
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
	// добавление после произвольного элемента
	constexpr dList& insert(Node* ptr, const T& value) {
		if (!isInList(ptr)) return *this;

		if (ptr == m_data.last) return push_back(value);

		Node* new_node{ new (std::nothrow) Node{ .previous = ptr, .next = ptr->next, .data = value } };
		if (new_node == nullptr) return *this;

		ptr->next->previous = new_node;
		ptr->next = new_node;
		return *this;
	}

	// удаление из начала
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
	// удаление с конца
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
	// удаление произвольного элемента
	constexpr dList& erase(Node* ptr) {
		if (isEmpty()) return *this;
		if (!isInList(ptr)) return *this;

		if (ptr == m_data.first) return pop_front();
		if (ptr == m_data.last) return pop_back();

		ptr->previous->next = ptr->next;
		ptr->next->previous = ptr->previous;
		delete ptr;

		return *this;
	}



	// ввод
	friend std::istream& operator>>(std::istream& in, dList& dl) {
		std::string sstream{};
		std::getline(in >> std::ws, sstream);
		std::stringstream ss{ sstream };

		if (in) dl.clear();
		else {
			in.setstate(std::ios_base::failbit);
			return in;
		}

		T element{};

		while (ss >> element) {
			dl.push_back(element);
		}

		ss >> std::ws;
		if (!ss.eof()) {
			dl.clear();
			in.setstate(std::ios_base::failbit);
		}
		return in;
	}
	
	// вывод
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

	// равенство двух списков
	friend constexpr bool operator==(const dList& dl1, const dList& dl2) {
		if (dl1.size() != dl2.size()) return false;
		if (dl1.isEmpty()) return true;

		Node* ptr_1{ dl1.m_data.first };
		Node* ptr_2{ dl2.m_data.first };

		do {
			if (ptr_1->data != ptr_2->data) return false;
			ptr_1 = ptr_1->next;
			ptr_2 = ptr_2->next;
		} while (ptr_1 != dl1.m_data.first);

		return true;
	}
};




#endif