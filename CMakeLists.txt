cmake_minimum_required(VERSION 3.0)

### Hunter snapshot that will be used ###
include("cmake/HunterGate.cmake")
HunterGate(
    URL "https://github.com/ruslo/hunter/archive/v0.8.13.tar.gz"
    SHA1 "7103f0ab481523ca93a06c1c55abcd56741d3a97"
    LOCAL
)

###############
##### HS ######
###############
project(hs)

### Import sugar for source collection ###
hunter_add_package(Sugar)
include("${SUGAR_ROOT}/cmake/Sugar")
include(sugar_include)

string(COMPARE EQUAL "${CMAKE_OSX_SYSROOT}" "iphoneos" is_ios)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/Modules/")

option(BUILD_SHARED "Build shared libraries"  ON)

## the following are directories where stuff will be installed to
## (see taglib/CMakeLists.txt)
set(LIB_SUFFIX_TXT "Define suffix of directory name (32/64)")
set(EXEC_INSTALL_PREFIX_TXT "Base directory for executables and libraries")
set(BIN_INSTALL_DIR_TXT "The subdirectory to the binaries prefix (default prefix/bin)")
set(LIB_INSTALL_TXT "The subdirectory relative to the install prefix where libraries will be installed (default is /lib${LIB_SUFFIX}")
set(INCLUDE_INSTALL_DIR_TXT "The subdirectory to the header prefix")

set(LIB_SUFFIX "" CACHE STRING "${LIB_SUFFIX_TXT}")
set(EXEC_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}" CACHE PATH "${EXEC_INSTALL_PREFIX_TXT}" FORCE)
set(BIN_INSTALL_DIR "${EXEC_INSTALL_PREFIX}/bin" CACHE PATH "${BIN_INSTALL_DIR_TXT}" FORCE)
set(LIB_INSTALL_DIR "${EXEC_INSTALL_PREFIX}/lib${LIB_SUFFIX}" CACHE PATH "${LIB_INSTALL_TXT}" FORCE)
set(INCLUDE_INSTALL_DIR "${CMAKE_INSTALL_PREFIX}/include" CACHE PATH "${INCLUDE_INSTALL_DIR_TXT}" FORCE)

# see: http://www.cmake.org/Wiki/CMake_RPATH_handling ("Always full RPATH")
include(AlwaysFullRPATH)
always_full_rpath()

# Testing versioned libs and Framework builds (based on https://github.com/taglib/taglib)

# Library configuration stuff 
set(HS_FRAMEWORK_VERSION "A")
set(HS_LIB_MAJOR_VERSION "1")
set(HS_LIB_MINOR_VERSION "0")
set(HS_LIB_PATCH_VERSION "0")
set(HS_LIB_VERSION_STRING "${HS_LIB_MAJOR_VERSION}.${HS_LIB_MINOR_VERSION}.${HS_LIB_PATCH_VERSION}")

# 1. If the library source code has changed at all since the last update, then increment revision.
# 2. If any interfaces have been added, removed, or changed since the last update, increment current, and set revision to 0.
# 3. If any interfaces have been added since the last public release, then increment age.
# 4. If any interfaces have been removed since the last public release, then set age to 0. 
set(HS_SOVERSION_CURRENT  1)
set(HS_SOVERSION_REVISION 0)
set(HS_SOVERSION_AGE      0)

math(EXPR HS_SOVERSION_MAJOR "${HS_SOVERSION_CURRENT} - ${HS_SOVERSION_AGE}")
math(EXPR HS_SOVERSION_MINOR "${HS_SOVERSION_AGE}")
math(EXPR HS_SOVERSION_PATCH "${HS_SOVERSION_REVISION}")

##################################
##### Build lib and framework ####
##################################

set(HS_SOVERSION ${HS_SOVERSION_MAJOR}.${HS_SOVERSION_MINOR}.${HS_SOVERSION_PATCH})
set(HS_SRCS exa.cpp)
set(HS_PUBLIC_HDRS exa.hpp)
add_library(HS SHARED ${HS_SRCS})

#target_link_libraries(HS ${SOME_LIBS})

# See CMake Framework test
# https://github.com/Kitware/CMake/blob/master/Tests/Framework/CMakeLists.txt

message("LIB_INSTALL_DIR: ${LIB_INSTALL_DIR}")

set_target_properties(HS PROPERTIES
  FRAMEWORK FALSE
  VERSION ${HS_SOVERSION}
  SOVERSION ${HS_SOVERSION_MAJOR}
  FRAMEWORK_VERSION ${HS_FRAMEWORK_VERSION}
  INSTALL_RPATH ${LIB_INSTALL_DIR}
  INSTALL_NAME_DIR @rpath
  PUBLIC_HEADER "${HS_PUBLIC_HDRS}" 
  PRIVATE_HEADER ""
  RESOURCE ""
  LINK_INTERFACE_LIBRARIES ""
  XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "iPhone Developer" # Needed by web-ios
  )

install(TARGETS HS
  FRAMEWORK DESTINATION ${FRAMEWORK_INSTALL_DIR}
  LIBRARY DESTINATION ${LIB_INSTALL_DIR}
  ARCHIVE DESTINATION ${LIB_INSTALL_DIR}
  RUNTIME DESTINATION ${BIN_INSTALL_DIR}

  # These are ignored on the Mac... and things are automatically placed in
  # their appropriate Framework sub-folder at build time. (And then the built
  # framework is copied recursively when it is installed.)
  # But they are required to be present so that installing a framework on other
  # other platforms will install the pieces of the framework without having to
  # duplicate install rules for the pieces of the framework.
  PUBLIC_HEADER DESTINATION ${INCLUDE_INSTALL_DIR}/HS
  PRIVATE_HEADER DESTINATION ${CMAKE_INSTALL_PREFIX}/share/HS/PrivateHeaders
  RESOURCE DESTINATION ${CMAKE_INSTALL_PREFIX}/share/HS/Resources
)

### ZLIB
hunter_add_package(ZLIB)
find_package(ZLIB CONFIG REQUIRED)

### BOOST
##
## IOSTREAM_NO_BZIP2=1 is ignored for ANDROID toolchain 
## Since the testb.cpp example can build with bzip2_compressor()
## But the same example doesn't seem to build with the zlib_comressor we want
##
## NOTE: setting in cmake/Hunter/config.cmake  
##
## hunter_config(Boost VERSION ${HUNTER_Boost_VERSION} CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)

# hunter_add_package(Boost COMPONENTS filesystem system serialization iostreams)
# find_package(Boost CONFIG REQUIRED filesystem system serialization iostreams)
# set(EXTRA_LIBS Boost::filesystem Boost::system Boost::serialization Boost::iostreams)

hunter_add_package(Boost COMPONENTS iostreams)
find_package(Boost CONFIG REQUIRED iostreams)
set(EXTRA_LIBS Boost::iostreams)

hunter_add_package(OpenCV)
find_package(OpenCV REQUIRED)
list(APPEND EXTRA_LIBS ${OpenCV_LIBS})

list(APPEND EXTRA_LIBS ZLIB::zlib)

# Needed on ANDROID (maybe all non APPLE)
#add_definitions(-DBOOST_IOSTREAMS_NO_LIB=1)

# get_cmake_property(_variableNames VARIABLES)
# foreach (_variableName ${_variableNames})
#     message(STATUS "VARIABLE: ${_variableName}=${${_variableName}}")
# endforeach()

### BZIP2
# if(NOT is_ios)
#   hunter_add_package(BZip2)
#   find_package(BZip2 CONFIG REQUIRED)
#   list(APPEND EXTRA_LIBS BZip2::bz2)

#   ### test_bzip2  : see IOSTREAMS_NO_BZIP2=1 so this shouldn't work???
#   add_executable(test_bzip2 test_bzip2.cpp)
#   target_link_libraries(test_bzip2 HS ${EXTRA_LIBS})
# endif()

Message("EXTRA_LIBS : ${EXTRA_LIBS}")

### test_zlib
#add_executable(test_zlib test_zlib.cpp)
#target_link_libraries(test_zlib HS ${EXTRA_LIBS})

### test_iostreams
add_executable(test_iostreams test_iostreams.cpp)
target_link_libraries(test_iostreams HS ${EXTRA_LIBS})





