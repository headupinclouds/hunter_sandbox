sugar_include(.)

set(API_LIB_TYPE SHARED)

### A
add_library(a STATIC "${HUNTER_SANDBOX_LIBA_SRCS}")

### B
add_library(b STATIC "${HUNTER_SANDBOX_LIBB_SRCS}")

### boost_test
add_library(boost_test STATIC "${HUNTER_SANDBOX_LIB_BOOST_SRCS}")
target_link_libraries(boost_test
  PRIVATE
  "${BOOST_LIBS}"
  )

### sdk
add_library(mysdk ${API_LIB_TYPE} ${HUNTER_SANDBOX_LIBSDK_SRCS})

### Generate the export header
include(GenerateExportHeader)
generate_export_header(mysdk EXPORT_FILE_NAME ${CMAKE_BINARY_DIR}/lib/libsdk/sdk_export.h)
target_include_directories(mysdk PUBLIC ${CMAKE_BINARY_DIR}/lib/libsdk)

if(NOT is_ios)
  set_target_properties(mysdk PROPERTIES
    VERSION "${hunter_sandbox_VERSION}"
    SOVERSION "${hunter_sandbox_VERSION_MAJOR}"
    )
endif()

target_link_libraries(mysdk
  PRIVATE
  a
  b
  boost_test
  "${BOOST_LIBS}"
  )

###################
##### install #####
###################

set(generated_dir "${CMAKE_CURRENT_BINARY_DIR}/generated")
set(include_install_dir "include")
set(config_install_dir "share/${CMAKE_PROJECT_NAME}")
set(version_config "${generated_dir}/${CMAKE_PROJECT_NAME}ConfigVersion.cmake")
set(project_config "${generated_dir}/${CMAKE_PROJECT_NAME}Config.cmake")
set(targets_export_name "${CMAKE_PROJECT_NAME}Targets")
set(namespace "${CMAKE_PROJECT_NAME}::")

include(CMakePackageConfigHelpers)
write_basic_package_version_file("${version_config}" VERSION "${hunter_sandbox_VERSION}" COMPATIBILITY SameMajorVersion)

# Note: variable 'targets_export_name' used
configure_file("${CMAKE_SOURCE_DIR}/cmake/Config.cmake.in" "${project_config}" @ONLY)

install(
  TARGETS mysdk
  EXPORT "${targets_export_name}"
  LIBRARY DESTINATION "lib"
  ARCHIVE DESTINATION "lib"
  RUNTIME DESTINATION "bin"
  INCLUDES DESTINATION "${include_install_dir}"
  )

install(
  FILES
  "${HUNTER_SANDBOX_LIBSDK_PUBLIC_HDRS}"  
  DESTINATION "${include_install_dir}/${CMAKE_PROJECT_NAME}"
  )
