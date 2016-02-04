# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED TEST_SUGAR_CMAKE_)
  return()
else()
  set(TEST_SUGAR_CMAKE_ 1)
endif()

include(sugar_include)

sugar_include(test_sdk)
sugar_include(test_bzip2)
sugar_include(test_iostreams)
sugar_include(test_zlib)

