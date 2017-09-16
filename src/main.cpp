#include "myclass.h"

#include <iostream>

int main (int argc, char *argv[]) {
    Myclass<int> c { 1, 2, 3 };
    std::cout << c << std::endl;
};