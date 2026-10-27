#if !defined(STRING_H)
#define STRING_H

#include <iostream>
#include <fstream>
#include <utility>
#include <string>
#include <optional>
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

	void strcopy(const STRING& str) {
		if (!str.m_data || m_data == str.m_data) return;

		Data new_data{ new (std::nothrow) char[str.m_size + 1] };	
		if (!new_data) return;

		for (Size i{ 0 }; i < str.m_size; ++i) {
			new_data[i] = str.m_data[i];
		}

		new_data[str.m_size] = '\0';
		delete[] m_data;
		m_data = new_data;
		m_size = str.m_size;
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
	explicit STRING(Size size) { m_data = new (std::nothrow) char[size + 1]; }

	Size size() const { return m_size; }
	std::optional<char> operator[](Size index) {
		if (!(index < m_size)) return {};

		return m_data[index];
	}

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