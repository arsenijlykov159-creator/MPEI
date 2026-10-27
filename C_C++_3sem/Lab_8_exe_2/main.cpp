#include <iostream>
#include <clocale>
#include <windows.h> // Обязательно для загрузки DLL

// 1. Описываем сигнатуру функции (указатель на функцию), которую мы будем искать в DLL
typedef bool(__cdecl* ReplaceInFilesFunc)(const char*, const char*, const char*, const char*);

int main() {
    setlocale(LC_ALL, "russian");

    std::cout << "--- Запуск программы с ДИНАМИЧЕСКИМ подключением DLL ---" << std::endl;

    // 2. Вручную загружаем библиотеку в память процесса.
    // Укажите имя вашей DLL. Если файлы лежат в разных папках сборки, 
    // проще всего указать относительный путь вроде "L\"..\\x64\\Debug\\Lab_8.dll\"" 
    // или временно скопировать Lab_8.dll прямо в папку к этому новому проекту.
    HMODULE hDll = LoadLibrary(L"Lab_8.dll");

    if (hDll == NULL) {
        std::cerr << "Ошибка: Не удалось загрузить Lab_8.dll! Убедитесь, что файл лежит рядом с .exe" << std::endl;
        return 1;
    }

    std::cout << "Библиотека Lab_8.dll успешно загружена в память." << std::endl;

    // 3. Ищем адрес нашей C-функции внутри загруженной DLL по её текстовому имени
    ReplaceInFilesFunc C_ReplaceInFiles = (ReplaceInFilesFunc)GetProcAddress(hDll, "C_ReplaceInFiles");

    if (C_ReplaceInFiles == NULL) {
        std::cerr << "Ошибка: Не удалось найти функцию C_ReplaceInFiles внутри DLL!" << std::endl;
        FreeLibrary(hDll); // Освобождаем память перед выходом
        return 1;
    }

    std::cout << "Функция найдена. Запускаем обработку строк через файлы..." << std::endl;

    // 4. Вызываем функцию из DLL через указатель, как обычную функцию
    const char* inputFile = "input.txt";
    const char* oldSub = "Arseniy";
    const char* newSub = "fox";
    const char* outputFile = "output.txt";

    bool success = C_ReplaceInFiles(inputFile, oldSub, newSub, outputFile);

    if (success) {
        std::cout << "Замена подстроки успешно выполнена! Проверьте файл " << outputFile << std::endl;
    }
    else {
        std::cerr << "Произошла ошибка при обработке файлов внутри DLL." << std::endl;
    }

    // 5. Обязательно выгружаем библиотеку из памяти, когда закончили работу
    FreeLibrary(hDll);
    std::cout << "Библиотека выгружена из памяти. Работа завершена." << std::endl;

    return 0;
}
