#include <iostream>
#include <clocale>
#include <windows.h>
#include "STRING_T.h"

using namespace MyType;

//typedef bool(__cdecl* replaceSubStr)(const char*, const char*, const char*, const char*);
typedef STRING_T* (*CreateClassFunc)();

int main() {
    setlocale(LC_ALL, "russian");

    HMODULE hDll = LoadLibrary(L"Lab_8.dll");

    if (hDll == NULL) {
        std::cerr << "Не удалось загрузить динамическую библиотеку!\n";
        return 1;
    }

    std::cout << "Функция найдена. Запускаем обработку строк через файлы..." << std::endl;

    MyType::STRING_T mystr{};

    mystr.get("input.txt");

    bool success{ mystr.replaceSubStr("Arseniy", "fox") };

    mystr.print("output.txt");

    if (success) {
        std::cout << "Замена подстроки успешно выполнена! Проверьте файл output.txt\n";
    }
    else {
        std::cerr << "Произошла ошибка при обработке файлов внутри DLL.\n";
    }

    FreeLibrary(hDll);

    return 0;
}
