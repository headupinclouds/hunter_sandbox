# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED LIB_SUGAR_CMAKE_)
  return()
else()
  set(LIB_SUGAR_CMAKE_ 1)
endif()

include(sugar_include)

sugar_include(lib_boost_test)
sugar_include(liba)
sugar_include(libb)
sugar_include(libsdk)

