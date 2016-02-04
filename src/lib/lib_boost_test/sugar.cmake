# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED LIB_LIB_BOOST_TEST_SUGAR_CMAKE_)
  return()
else()
  set(LIB_LIB_BOOST_TEST_SUGAR_CMAKE_ 1)
endif()

include(sugar_files)

sugar_files(
    HUNTER_SANDBOX_LIB_BOOST_SRCS
    boost.cpp
    boost.h
)
