set(BOOST_LIBS
  Boost::filesystem 
  Boost::system 
  Boost::serialization 
  Boost::iostreams
  )

include_directories(lib)

add_subdirectory(lib)
add_subdirectory(test)
