# This file generated automatically by:
#   generate_sugar_files.py
# see wiki for more info:
#   https://github.com/ruslo/sugar/wiki/Collecting-sources

if(DEFINED LIB_LIBSDK_SUGAR_CMAKE_)
  return()
else()
  set(LIB_LIBSDK_SUGAR_CMAKE_ 1)
endif()

sugar_files(
    HUNTER_SANDBOX_LIBSDK_PUBLIC_HDRS
    sdk.hpp
)

sugar_files(
    HUNTER_SANDBOX_LIBSDK_SRCS
    sdk.cpp
    "${HUNTER_SANDBOX_LIBSDK_PUBLIC_HDRS}"
)
