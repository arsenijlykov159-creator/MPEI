#include "STRING.h"



namespace STR {

	bool strlen(const char str[], std::size_t* length) {
		if (!str || !length) return false;

		std::size_t len{ 0 };
		for (const char* ptr{ str }; *ptr != '\0'; ++ptr) ++len;

		*length = len;
		return true;
	}

	bool strPrint(const char* filename, const char str[]) {
		if (!str || !filename || !std::filesystem::exists(filename)) return false;

		std::ofstream output_file{ filename };

		for (const char* ptr{ str }; *ptr != '\0'; ++ptr) output_file << *ptr;

		return true;
	}

	bool strGet(const char* filename, char str[]) {
		if (!str || !filename || !std::filesystem::exists(filename)) return false;

		std::ifstream input_file{ filename };
		if (!input_file) return false;

		return !!input_file.getline(str, STR::MAX_LENGTH);
	}

}