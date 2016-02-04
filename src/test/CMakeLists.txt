sugar_include(.)

include(GenerateExportHeader)

#add_executable(test_bzip2 ${HUNTER_SANDBOX_TEST_BZIP2_SRCS})
#target_link_libraries(test_bzip2 "${BOOST_LIBS}")

add_executable(test_iostreams "${HUNTER_SANDBOX_TEST_IOSTREAMS_SRCS}")
target_link_libraries(test_iostreams "${BOOST_LIBS}")

#add_executable(test_zlib "${HUNTER_SANDBOX_TEST_ZLIB_SRCS}")
#starget_link_libraries(test_iostreams "${BOOST_LIBS}")

add_executable(test_sdk "${HUNTER_SANDBOX_TEST_SDK_SRCS}")
target_link_libraries(test_sdk sdk)





