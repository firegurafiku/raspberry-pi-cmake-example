cmake_minimum_required(VERSION 3.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/..")

set(CMAKE_AUTOMOC ON)
find_package(RpiQt4 REQUIRED QtCore QtGui)

add_executable(calculator
    main.cpp
    calculator.h
    button.h
    calculator.pro
    button.cpp
    calculator.cpp)

target_link_libraries(calculator Qt4::QtCore Qt4::QtGui)

