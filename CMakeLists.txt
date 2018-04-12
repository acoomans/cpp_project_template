cmake_minimum_required(VERSION 3.8.0)
project(myproject LANGUAGES CXX)
set(CMAKE_CXX_STANDARD 11)

include(cmake/boost.cmake)
include(cmake/boost_tests.cmake)
include(cmake/clang_analyzer.cmake)

find_boost(
        1.66.0
        b2dfbd6c717be4a7bb2d88018eaccf75
        unit_test_framework
)

include_directories(src)

set(SOURCE_FILES src/myclass.cpp)

add_executable(myexecutable src/main.cpp ${SOURCE_FILES})
target_link_boost(myexecutable)

add_library(mylib ${SOURCE_FILES})
		
add_boost_test(mylib test/myclass_test.cpp)

add_static_analysis(mylib)