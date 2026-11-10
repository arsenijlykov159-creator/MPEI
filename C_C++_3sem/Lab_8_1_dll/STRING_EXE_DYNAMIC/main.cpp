#include <iostream>
#include <windows.h> // Обязательно для функций LoadLibrary и GetProcAddress

// Указатель на std::size_t str_len(const char str[])
typedef std::size_t(__cdecl* StrLenPtr)(const char[]);

// Указатель на bool file_print(const char* filename, const char data_str[])
typedef bool(__cdecl* FilePrintPtr)(const char*, const char[]);

// Указатель на bool file_get(const char* filename, char buffer[], std::size_t max_capacity)
typedef bool(__cdecl* FileGetPtr)(const char*, char[], std::size_t);

// Указатель на void str_add(char buffer[], std::size_t max_capacity, const char new_str[])
typedef void(__cdecl* StrAddPtr)(char[], std::size_t, const char[]);

// Указатель на bool str_replace(char buffer[], std::size_t max_capacity, const char oldsub[], const char newsub[])
typedef bool(__cdecl* StrReplacePtr)(char[], std::size_t, const char[], const char[]);

namespace MyType {
    constexpr std::size_t MAX_LENGTH{ 256 };
}


int main(int argc, char* argv[]) {
    // Устанавливаем корректную кодировку для вывода в консоль
    setlocale(LC_ALL, "Russian");

    if (argc < 3) {
        std::cerr << "Недостаточно параметров!\n";
        return 1;
    }

    // 2. Загружаем DLL в память процесса
    // Если DLL лежит в той же папке, что и .exe, пишем просто имя файла.
    HMODULE hModule = LoadLibrary(TEXT("STRING_DLL.dll"));

    if (hModule == nullptr) {
        std::cout << "Ошибка: Не удалось загрузить STRING_DLL.dll!" << std::endl;
        std::cout << "Код ошибки Windows: " << GetLastError() << std::endl;
        std::cout << "Убедитесь, что .dll файл скопирован в папку с этим .exe" << std::endl;
        return 1;
    }

    // 3. Получаем адреса функций по их С-именам (из блока extern "C")
    StrLenPtr dll_str_len = (StrLenPtr)GetProcAddress(hModule, "str_len");
    FileGetPtr dll_file_get = (FileGetPtr)GetProcAddress(hModule, "file_get");
    FilePrintPtr dll_file_print = (FilePrintPtr)GetProcAddress(hModule, "file_print");
    StrAddPtr dll_str_add = (StrAddPtr)GetProcAddress(hModule, "str_add");
    StrReplacePtr dll_str_replace = (StrReplacePtr)GetProcAddress(hModule, "str_replace");

    // Проверяем, успешно ли нашлись функции внутри DLL
    if (!dll_str_len || !dll_str_replace) {
        std::cout << "Ошибка: Функции не найдены внутри DLL!" << std::endl;
        FreeLibrary(hModule); // Освобождаем память перед выходом
        return 1;
    }

    char mystring[MyType::MAX_LENGTH]{};

    if (!dll_file_get("input_d.txt", mystring, MyType::MAX_LENGTH)) std::cout << "Строка не прочитана!\n";

    //dll_file_print(argv[2], mystring);

    dll_str_add(mystring, MyType::MAX_LENGTH, " Nice To meet you!!!");

    dll_str_replace(mystring, MyType::MAX_LENGTH, "!!!", "???");

    dll_file_print(argv[2], mystring);

    // 5. Обязательно выгружаем DLL из памяти по окончании работы
    FreeLibrary(hModule);

    return 0;
}
