#include <iostream>
#include <windows.h>


typedef std::size_t(__cdecl* StrLenPtr)(const char[]);

typedef bool(__cdecl* FilePrintPtr)(const char*, const char[]);

typedef bool(__cdecl* FileGetPtr)(const char*, char[], std::size_t);

typedef void(__cdecl* StrAddPtr)(char[], std::size_t, const char[]);

typedef bool(__cdecl* StrReplacePtr)(char[], std::size_t, const char[], const char[]);

namespace MyType {
    constexpr std::size_t MAX_LENGTH{ 256 };
}


int main(int argc, char* argv[]) {

    setlocale(LC_ALL, "Russian");

    if (argc < 3) {
        std::cerr << "Недостаточно параметров!\n";
        return 1;
    }

    HMODULE hModule = LoadLibrary(TEXT("STRING_DLL.dll"));

    if (hModule == nullptr) {
        std::cout << "Ошибка: Не удалось загрузить STRING_DLL.dll!" << std::endl;
        std::cout << "Код ошибки Windows: " << GetLastError() << std::endl;
        std::cout << "Убедитесь, что .dll файл скопирован в папку с этим .exe" << std::endl;
        return 1;
    }

    StrLenPtr dll_str_len = (StrLenPtr)GetProcAddress(hModule, "str_len");
    FileGetPtr dll_file_get = (FileGetPtr)GetProcAddress(hModule, "file_get");
    FilePrintPtr dll_file_print = (FilePrintPtr)GetProcAddress(hModule, "file_print");
    StrAddPtr dll_str_add = (StrAddPtr)GetProcAddress(hModule, "str_add");
    StrReplacePtr dll_str_replace = (StrReplacePtr)GetProcAddress(hModule, "str_replace");


    if (!dll_str_len || !dll_str_replace) {
        std::cout << "Ошибка: Функции не найдены внутри DLL!" << std::endl;
        FreeLibrary(hModule);
        return 1;
    }


    char mystring[MyType::MAX_LENGTH]{};

    if (!dll_file_get("input_d.txt", mystring, MyType::MAX_LENGTH)) std::cout << "Строка не прочитана!\n";

    dll_str_add(mystring, MyType::MAX_LENGTH, " Nice To meet you!!! ");

    dll_str_replace(mystring, MyType::MAX_LENGTH, "!!! ", "???");

    dll_file_print(argv[2], mystring);


    FreeLibrary(hModule);

    return 0;
}
