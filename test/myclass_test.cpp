#define BOOST_TEST_DYN_LINK
#define BOOST_TEST_MODULE "MyclassTest"
#include <boost/test/unit_test.hpp>

#include <myclass.h>

BOOST_AUTO_TEST_CASE(mytest) {
	BOOST_CHECK(true);
}