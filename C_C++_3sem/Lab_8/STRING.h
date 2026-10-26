#if !defined(STRING_H)
#define STRING_H

#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>

namespace STR {

	constexpr int MAX_LENGTH{ 256 };

	enum class Status {
		NULLPTR,
		OK,
		ERROR,
		MAX_RESULT,
	};


	bool strlen(const char str[], std::size_t* length);

	bool strPrint(const char* filename, const char str[]);

	bool strGet(const char* filename, char str[]);

}


#endif