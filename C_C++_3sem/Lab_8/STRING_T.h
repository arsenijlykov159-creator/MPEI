#pragma once

#include <iostream>
#include <fstream>
#include <utility>
#include <string>
#include <optional>
#include <filesystem>

#ifdef STRING_T_EXPORTS
#define STRING_T_API __declspec(dllexport)
#else
#define STRING_T_API __declspec(dllimport)
#endif


namespace MyType {
	class STRING_T_API STRING_T {
	public:
		using Size = std::size_t;
		using Data = char*;
		constexpr static Size MAX_LENGTH{ 256 };

	private:
		char* m_data{ nullptr };
		Size m_size{};
		Size m_capacity{};

		Size strlen(const char str[]) {
			if (!str) return 0;

			Size length{};
			for (const char* ptr{ str }; *ptr != '\0'; ++ptr) ++length;

			return length;
		}

		void strcopy(const STRING_T& str) {
			if (!str.m_data || this == &str) return;

			if (m_capacity < str.m_size + 1) m_capacity = str.m_size + 1;
			Data new_data{ new (std::nothrow) char[m_capacity] };
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
		STRING_T() = default;
		explicit STRING_T(const char str[]) : m_size{ strlen(str) }, m_capacity{ strlen(str) + 1 } {
			if (!str) return;

			m_data = new (std::nothrow) char[m_capacity];

			for (Size i{ 0 }; i < m_size; ++i) {
				m_data[i] = str[i];
			}

			m_data[m_size] = '\0';
		}
		explicit STRING_T(Size size) : m_capacity{ size + 1 } { m_data = new (std::nothrow) char[m_capacity]; }

		Size size() const { return m_size; }

		bool print(const char* filename) const;

		bool get(const char* filename);

		void addToStr(const char new_str[]);

		bool replaceSubStr(const char oldsub[], const char newsub[]);

		~STRING_T() {
			delete[] m_data;
			m_data = nullptr;
			m_size = 0;
			m_capacity = 0;
		}

	};
}


extern "C" __declspec(dllexport) bool __cdecl C_ReplaceInFiles(const char* input_file, const char* oldsub, const char* newsub, const char* output_file) {
	MyType::STRING_T str;
	if (!str.get(input_file)) return false;
	str.replaceSubStr(oldsub, newsub);
	return str.print(output_file);
}
