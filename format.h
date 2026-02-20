#pragma once
#include <iostream>
#include <sstream>
#include <iomanip>
#include <string>
#include <type_traits>

// Собственная реализация format для C++17
namespace my {

    // Базовый класс для форматирования
    class Formatter {
    private:
        std::ostringstream stream;
        
    public:
        template<typename T>
        Formatter& operator<<(const T& value) {
            stream << value;
            return *this;
        }
        
        // Специализация для чисел с плавающей точкой с форматированием
        Formatter& format(double value, int precision = 3, bool fixed = true) {
            if (fixed) {
                stream << std::fixed << std::setprecision(precision) << value;
            } else {
                stream << std::setprecision(precision) << value;
            }
            return *this;
        }
        
        // Специализация для целых чисел с выравниванием
        Formatter& format(int value, int width = 0, char fill = ' ') {
            if (width > 0) {
                stream << std::setw(width) << std::setfill(fill) << value;
            } else {
                stream << value;
            }
            return *this;
        }
        
        // Специализация для строк с выравниванием
        Formatter& format(const std::string& value, int width = 0, char fill = ' ') {
            if (width > 0) {
                stream << std::setw(width) << std::setfill(fill) << value;
            } else {
                stream << value;
            }
            return *this;
        }
        
        // Получение результата
        std::string str() const {
            return stream.str();
        }
        
        // Очистка форматтера
        void clear() {
            stream.str("");
            stream.clear();
        }
    };

    // Упрощенный аналог std::format для базового использования
    template<typename... Args>
    std::string format(const std::string& fmt, Args&&... args) {
        std::ostringstream result;
        size_t pos = 0;
        size_t arg_index = 0;
        
        // Распаковка аргументов для подстановки в фигурные скобки {}
        ([&]{
            size_t open_brace = fmt.find('{', pos);
            if (open_brace != std::string::npos) {
                // Добавляем текст до {
                result << fmt.substr(pos, open_brace - pos);
                
                size_t close_brace = fmt.find('}', open_brace + 1);
                if (close_brace != std::string::npos) {
                    // Проверяем содержимое между скобками
                    std::string between = fmt.substr(open_brace + 1, close_brace - open_brace - 1);
                    
                    // Проверка на форматирование чисел с плавающей точкой
                    if (!between.empty() && between.find(':') != std::string::npos) {
                        // Формат типа {:.3f}
                        size_t colon_pos = between.find(':');
                        std::string format_spec = between.substr(colon_pos + 1);
                        
                        if (!format_spec.empty() && format_spec.back() == 'f') {
                            // Убираем 'f' в конце
                            format_spec.pop_back();
                            
                            // Проверяем наличие точки для точности
                            if (!format_spec.empty() && format_spec[0] == '.') {
                                int precision = std::stoi(format_spec.substr(1));
                                if constexpr (std::is_floating_point_v<std::decay_t<decltype(args)>>) {
                                    result << std::fixed << std::setprecision(precision) << args;
                                } else {
                                    result << args;
                                }
                            } else {
                                result << args;
                            }
                        } else {
                            result << args;
                        }
                    } else {
                        // Обычная подстановка без форматирования
                        result << args;
                    }
                    
                    pos = close_brace + 1;
                    arg_index++;
                }
            }
        }(), ...);
        
        // Добавляем оставшийся текст
        if (pos < fmt.length()) {
            result << fmt.substr(pos);
        }
        
        return result.str();
    }
    
    // Перегрузка для одного аргумента (для обратной совместимости)
    template<typename T>
    std::string format(const std::string& fmt, const T& arg) {
        return format(fmt, arg);
    }
    
    // Вспомогательная функция для форматирования чисел с фиксированной точностью
    inline std::string fixed(double value, int precision = 3) {
        std::ostringstream oss;
        oss << std::fixed << std::setprecision(precision) << value;
        return oss.str();
    }
    
    // Вспомогательная функция для научной нотации
    inline std::string scientific(double value, int precision = 3) {
        std::ostringstream oss;
        oss << std::scientific << std::setprecision(precision) << value;
        return oss.str();
    }
}

// Глобальный объект форматтера для удобства использования
static my::Formatter fmt;