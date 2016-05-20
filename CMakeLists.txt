# Copyright (c) 2015, David Hirvonen, Ruslan Baratov
# All rights reserved.

cmake_minimum_required(VERSION 3.0)

### Hunter snapshot that will be used ###
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.14.22.tar.gz"
    SHA1 "1e7fc8f338281e1083691ec062cced647b84d5fe"
    LOCAL
)
project(hunter_sandbox VERSION 0.1.0)

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_LIST_DIR}/cmake/modules")

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

set(is_android ${ANDROID}) # syntax compatibility
string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" is_ios)
string(COMPARE EQUAL "${CMAKE_SYSTEM_NAME}" "Linux" is_linux)
string(COMPARE EQUAL "${CMAKE_GENERATOR}" "Xcode" is_xcode)

# See: cmake/Hunter/config.cmake
# First call to 'hunter_add_package' will contains read of Hunter/config.cmake
# Next variables will be used:
#   * is_ios
#   * is_linux
hunter_add_package(Sugar)
include("${SUGAR_ROOT}/cmake/Sugar")
include(sugar_include)

if(is_xcode)
  option(GATHERER_DISABLE_DSYM "Disable generation of dSYM information" ON)
  if(GATHERER_DISABLE_DSYM)
    set(CMAKE_XCODE_ATTRIBUTE_DEBUG_INFORMATION_FORMAT "dwarf")
  endif()
  set(CMAKE_CONFIGURATION_TYPES "Debug;Release;MinSizeRel;RelWithDebInfo" CACHE STRING "Configuration types")
  set(CMAKE_XCODE_ATTRIBUTE_ENABLE_BITCODE NO)
endif()

## #################################################################
## Dependencies - boost
## #################################################################

hunter_add_package(Boost COMPONENTS filesystem system serialization iostreams)
find_package(Boost CONFIG REQUIRED filesystem system serialization iostreams )
include_directories(${Boost_INCLUDE_DIRS}) 
message("Boost_INCLUDE_DIRS =  ${Boost_INCLUDE_DIRS}; Boost_LIBRARIES =  ${Boost_LIBRARIES}")

## #################################################################
## Project
## #################################################################

add_subdirectory(src)
