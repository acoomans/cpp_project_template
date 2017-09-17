#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MODULE "MyclassTest"
#include <boost/test/unit_test.hpp>

#include <iostream>

#include <myclass.h>

BOOST_AUTO_TEST_CASE(mytest) {
    Myclass<int> c { 1, 2, 3 };

	BOOST_CHECK(c[0] == 1);
    BOOST_CHECK(c[1] == 2);
    BOOST_CHECK(c[2] == 3);

    BOOST_CHECK(c.size() == 3);
}

BOOST_AUTO_TEST_CASE(forloop) {
    Myclass<int> c { 1, 2, 3 };

    for (auto i : c) {
        BOOST_CHECK(i);
    }
}

BOOST_AUTO_TEST_CASE(cout) {
    Myclass<int> c { 1, 2, 3 };

    std::cout << c << std::endl;
}