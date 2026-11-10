#include "String_dll.h"
#include <iostream>
#include <fstream>
#include <string>
#include <filesystem>




extern "C" {

    std::size_t __cdecl str_len(const char str[]) {
        if (!str) return 0;

        std::size_t length{};
        for (const char* ptr{ str }; *ptr != '\0'; ++ptr) {
            ++length;
        }

        return length;
    }


    bool __cdecl file_print(const char* filename, const char data_str[]) {
        if (!data_str || !filename) return false;

        std::ofstream output_file{ filename };
        if (!output_file) return false;

        for (const char* ptr{ data_str }; *ptr != '\0'; ++ptr) {
            output_file << *ptr;
        }

        return true;
    }


    bool __cdecl file_get(const char* filename, char buffer[], std::size_t max_capacity) {
        if (!filename || !buffer || max_capacity == 0) return false;

        std::ifstream input_file{ filename };
        if (!input_file) return false;

        std::string input_string{};
        std::getline(input_file >> std::ws, input_string);
        std::size_t str_size{ input_string.size() };

        std::size_t copy_size{ (str_size < max_capacity - 1) ? str_size : max_capacity - 1 };

        for (std::size_t i{ 0 }; i < copy_size; ++i) {
            buffer[i] = input_string[i];
        }

        buffer[copy_size] = '\0';
        return true;
    }


    void __cdecl str_add(char buffer[], std::size_t max_capacity, const char new_str[]) {
        if (!buffer || !new_str || max_capacity == 0) return;

        std::size_t current_len{ str_len(buffer) };
        std::size_t new_str_len{ str_len(new_str) };

        for (std::size_t i{ 0 }; i < new_str_len; ++i) {
            if (current_len + i >= max_capacity - 1) break;

            buffer[current_len + i] = new_str[i];
        }

        std::size_t final_len{ (current_len + new_str_len < max_capacity) ? (current_len + new_str_len) : (max_capacity - 1) };
        buffer[final_len] = '\0';
    }


    bool __cdecl str_replace(char buffer[], std::size_t max_capacity, const char oldsub[], const char newsub[]) {
        if (!buffer || !oldsub || !newsub || max_capacity == 0) return false;

        std::size_t current_len{ str_len(buffer) };
        std::size_t oldsub_length{ str_len(oldsub) };
        if (current_len < oldsub_length || oldsub_length == 0) return false;

        char temp_str[MyType::MAX_LENGTH]{};
        bool isSubInStr{ false };

        for (std::size_t i{ 0 }; i < current_len; ++i) {
            if (buffer[i] != oldsub[0]) {
                char elem[2]{ buffer[i], '\0' };
                str_add(temp_str, MyType::MAX_LENGTH, elem);
                continue;
            }

            std::size_t count{};
            for (std::size_t j{ 0 }; j < oldsub_length && i + j < current_len; ++j) {
                if (buffer[i + j] == oldsub[j]) ++count;
            }

            if (count == oldsub_length) {
                str_add(temp_str, MyType::MAX_LENGTH, newsub);
                i += oldsub_length - 1;
                isSubInStr = true;
            }
            else {
                for (std::size_t k{ 0 }; k < count && i + k < current_len; ++k) {
                    char elem[2]{ buffer[i + k], '\0' };
                    str_add(temp_str, MyType::MAX_LENGTH, elem);
                }

                i += count - 1;
            }
        }

        std::size_t temp_len{ str_len(temp_str) };
        std::size_t copy_size{ (temp_len < max_capacity - 1) ? temp_len : max_capacity - 1 };

        for (std::size_t i = 0; i < copy_size; ++i) {
            buffer[i] = temp_str[i];
        }

        buffer[copy_size] = '\0';
        return isSubInStr;
    }

}