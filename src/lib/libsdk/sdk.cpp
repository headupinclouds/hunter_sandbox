#include "libsdk/sdk.hpp"
#include "liba/exa.hpp"
#include "libb/exb.hpp"
#include "lib_boost_test/boost.h"

int some_func()
{
    return SomeClass(2)();
}

int sdk_run()
{
    funca(1, 2);
    funcb(1, 2);
    pack();
    unpack();
}
