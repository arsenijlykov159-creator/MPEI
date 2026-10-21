#if !defined(CHECK_H)
#define CHECK_H

#include <iostream>
#include <cassert>
#include "Type.h"


void check(BitType bt, BitType(*fcn)(BitType, std::size_t)) {

	switch (sizeof(bt) * 8) {
	case 8:
        assert(fcn(0, 3) == 0);
        assert(fcn(255, 5) == 255);
        assert(fcn(1, 1) == 2);
        assert(fcn(128, 1) == 1);
        assert(fcn(147, 4) == 57);
        assert(fcn(45, 0) == 45);
        assert(fcn(45, 8) == 45);
        assert(fcn(45, 11) == 105);
        return;
    case 16:
        assert(fcn(0, 5) == 0);
        assert(fcn(65535, 9) == 65535);
        assert(fcn(1, 1) == 2);
        assert(fcn(32768, 1) == 1);
        assert(fcn(43690, 1) == 21845);
        assert(fcn(53247, 4) == 65532);
        assert(fcn(12345, 0) == 12345);
        assert(fcn(12345, 16) == 12345);
        assert(fcn(12345, 18) == 49380);
        return;
    case 32:
        assert(fcn(0, 10) == 0);
        assert(fcn(4294967295, 15) == 4294967295);
        assert(fcn(1, 1) == 2);
        assert(fcn(2147483648, 1) == 1);
        assert(fcn(2863311530, 1) == 1431655765);
        assert(fcn(4026531903, 4) == 1023);
        assert(fcn(123456789, 0) == 123456789);
        assert(fcn(123456789, 32) == 123456789);
        assert(fcn(1, 35) == 8);
        return;
    case 64:
        assert(fcn(0, 20) == 0);
        assert(fcn(18446744073709551615ULL, 42) == 18446744073709551615ULL);
        assert(fcn(1, 1) == 2);
        assert(fcn(9223372036854775808ULL, 1) == 1);
        assert(fcn(12297829382473034410ULL, 1) == 6148914691236517205ULL);
        assert(fcn(17293822569102704640ULL, 4) == 15);
        assert(fcn(123456789012345ULL, 0) == 123456789012345ULL);
        assert(fcn(123456789012345ULL, 64) == 123456789012345ULL);
        assert(fcn(1, 67) == 8);
        return;
    }
}


#endif