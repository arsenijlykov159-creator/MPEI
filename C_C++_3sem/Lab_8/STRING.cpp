#include "STRING.h"



bool STRING::print(const char* filename) const {
	if (!m_data || !filename || !std::filesystem::exists(filename)) return false;

	std::ofstream output_file{ filename };

	for (const char* ptr{ m_data }; *ptr != '\0'; ++ptr) output_file << *ptr;

	return true;
}


bool STRING::get(const char* filename) {
	if (!filename || !std::filesystem::exists(filename)) return false;
	
	std::ifstream input_file{ filename };
	if (!input_file) return false;
	
	std::string input_string{};
	std::getline(input_file >> std::ws, input_string);
	Size str_size{ input_string.size() };

	delete[] m_data;
	m_data = new (std::nothrow) char[str_size + 1];

	for (Size i{ 0 }; i < str_size; ++i) {
		m_data[i] = input_string[i];
	}

	m_data[str_size] = '\0';
	m_size = str_size;

	return true;
}


void STRING::addToStr(const char new_str[]) {
	if (!new_str) return;
	
	Size new_str_len{ strlen(new_str) };
	
	if (!m_data) {
		m_data = new (std::nothrow) char[new_str_len + 1];
		/*if (!m_data) {
			delete[] m_data;
			return;
		}*/
	}
	else {
		auto temp{ m_data };
		m_data = new (std::nothrow) char[m_size + new_str_len + 1];
		/*if (!m_data) {
			delete[] m_data;
			return;
		}*/
		for (Size i{ 0 }; i < m_size; ++i) {
			m_data[i] = temp[i];
		}
		delete[] temp;
	}
	

	for (Size i{ 0 }; i < new_str_len; ++i) {
		m_data[i + m_size] = new_str[i];
	}

	m_data[m_size + new_str_len] = '\0';
	m_size += new_str_len;
}


bool STRING::replaceSubStr(const char oldsub[], const char newsub[]) {
	if (!m_data || !oldsub || !newsub) return 0;
	if (m_size < strlen(oldsub)) return 0;


	STRING new_str{ MAX_LENGTH };
	Size oldsub_length{ strlen(oldsub) };

	bool isSubInStr{};

	for (Size i{ 0 }; i < m_size; ++i) {

		if (m_data[i] != oldsub[0]) {
			char elem[2]{ m_data[i], '\0'};
			new_str.addToStr(elem);
			continue;
		}

		Size count{};

		for (Size j{ 0 }; j < oldsub_length/* && i + j < m_size*/; ++j) {
			if (m_data[i + j] == oldsub[j]) ++count;
		}

		if (count == oldsub_length) {
			new_str.addToStr(newsub);
			i += oldsub_length - 1;

			isSubInStr = 1;
		}
		else {
			for (Size k{ 0 }; k < count/* && i + k < m_size*/; ++k) {
				char elem[2]{ m_data[i + k], '\0'};
				new_str.addToStr(elem);
			}

			i += count - 1;
		}

		/*for (Size it{ 0 }; it < new_str.m_size; ++it) std::cout << new_str.m_data[it] << ' ';
		std::cout << new_str.m_size << ' ' << i << '\n';*/
	}

	new_str[new_str.m_size] = '\0';
	strcopy(new_str);

	return isSubInStr;
}