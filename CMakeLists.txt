cmake_minimum_required(VERSION 3.8.0)
project(myproject LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 11)

include(cmake/boost_tests.cmake)
include(cmake/clang_analyzer.cmake)

include_directories(src)

set(SOURCE_FILES src/myclass.cpp)

add_executable(myexecutable src/main.cpp ${SOURCE_FILES})
add_library(mylib ${SOURCE_FILES})
		
add_boost_test(test/myclass_test.cpp mylib)

add_clang_static_analysis(mylib)