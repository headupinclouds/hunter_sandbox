#ifndef sdk_h_
#define sdk_h_

#include "mysdk_export.h"

#define SDK_EXTERN_C_BEGIN extern "C" {
#define SDK_EXTERN_C_END }

class SomeClass
{
public:
    SomeClass(int x) : x(x) {}
    int operator()() { return x*x; }
protected:
    int x = 0;
};

int some_func();

SDK_EXTERN_C_BEGIN

int MYSDK_EXPORT sdk_run();

SDK_EXTERN_C_END

#endif // sdk_h_
