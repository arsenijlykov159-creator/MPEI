#pragma once

#include <cstddef>

#ifdef STRING_DLL_EXPORTS
#define STRING_DLL_API __declspec(dllexport)
#else
#define STRING_DLL_API __declspec(dllimport)
#endif


namespace MyType {
    constexpr std::size_t MAX_LENGTH{ 256 };
}

extern "C" {

    STRING_DLL_API std::size_t __cdecl str_len(const char str[]);

    STRING_DLL_API bool __cdecl file_print(const char* filename, const char data_str[]);

    STRING_DLL_API bool __cdecl file_get(const char* filename, char buffer[], std::size_t max_capacity);

    STRING_DLL_API void __cdecl str_add(char buffer[], std::size_t max_capacity, const char new_str[]);

    STRING_DLL_API bool __cdecl str_replace(char buffer[], std::size_t max_capacity, const char oldsub[], const char newsub[]);

}
