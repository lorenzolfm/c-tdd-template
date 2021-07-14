#include "CppUTest/TestHarness.h"

extern "C"
{
#include "hello.h"
	/*
	 * Add your c-only include files here
	 */
}

TEST_GROUP(MyCode)
{
    void setup()
    {
    }

    void teardown()
    {
    }
};

TEST(MyCode, test1)
{
    CHECK_EQUAL(teste(), 10);
}
