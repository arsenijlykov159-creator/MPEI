#include "STRING_T.h"
#include <iostream>


int main()
{
	MyType::STRING_T mystring{};
	
	mystring.get("input.txt");

	mystring.print("output.txt");

	return 0;
}