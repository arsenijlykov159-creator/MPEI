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
		if (!m_data) return;
	}
	else {
		auto temp{ m_data };
		m_data = new (std::nothrow) char[m_size + new_str_len + 1];
		if (!m_data) return;
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