#if !defined(STRING_H)
#define STRING_H

#include <iostream>
#include <fstream>
#include <utility>
#include <string>
#include <filesystem>

class STRING {
public:
	using Size = std::size_t;
	using Data = char*;
	constexpr static Size MAX_LENGTH{ 256 };

private:
	char* m_data{ nullptr };
	Size m_size{};

	Size strlen(const char str[]) {
		if (!str) return 0;

		Size length{};
		for (const char* ptr{ str }; *ptr != '\0'; ++ptr) ++length;

		return length;
	}

public:
	STRING() = default;

	explicit STRING(const char str[]) : m_size{ strlen(str) } {
		if (!str) return;

		Size str_length{ strlen(str) };
		m_data = new (std::nothrow) char[str_length + 1];

		for (Size i{ 0 }; i < str_length; ++i) {
			m_data[i] = str[i];
		}

		m_data[str_length] = '\0';
	}

	Size size() const { return m_size; }

	bool print(const char* filename) const;

	bool get(const char* filename);

	void addToStr(const char new_str[]);

	bool replaceSubStr(const char oldsub[], const char newsub[]);

	~STRING() {
		delete[] m_data;
		m_data = nullptr;
		m_size = 0;
	}

};




#endif