#if !defined(TYPE_H)
#define TYPE_H

#include <cstdint>

#define SHORT_T
//#define INT_T
//#define LONG_T
//#define LONG_LONG_T



#if defined(SHORT_T)
using BitType = std::uint8_t;
#elif defined(INT_T)
using BitType = std::uint16_t;
#elif defined(LONG_T)
using BitType = std::uint32_t;
#elif defined(LONG_LONG_T)
using BitType = std::uint64_t;
#endif



#endif