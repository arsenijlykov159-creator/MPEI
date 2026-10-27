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
	m_capacity = str_size + 1;
	m_data = new (std::nothrow) char[m_capacity];

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
	Data temp_ptr{};

	if (m_capacity < m_size + new_str_len + 1) {
		m_capacity = m_size + new_str_len + 1;
		temp_ptr = new (std::nothrow) char[m_capacity];

		for (Size i{ 0 }; i < m_size; ++i) {
			temp_ptr[i] = m_data[i];
		}
	}
	else {
		temp_ptr = m_data;
	}

	for (Size i{ 0 }; i < new_str_len; ++i) {
		temp_ptr[i + m_size] = new_str[i];
	}

	m_size += new_str_len;
	temp_ptr[m_size] = '\0';
	if (m_data != temp_ptr) {
		delete[] m_data;
		m_data = temp_ptr;
	}
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

		for (Size j{ 0 }; j < oldsub_length && i + j < m_size; ++j) {
			if (m_data[i + j] == oldsub[j]) ++count;
		}

		if (count == oldsub_length) {
			new_str.addToStr(newsub);
			i += oldsub_length - 1;

			isSubInStr = 1;
		}
		else {
			for (Size k{ 0 }; k < count && i + k < m_size; ++k) {
				char elem[2]{ m_data[i + k], '\0'};
				new_str.addToStr(elem);
			}

			i += count - 1;
		}
	}

	strcopy(new_str);

	return isSubInStr;
}