### Boost


#build.py --toolchain android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35 --verbose --fwd HUNTER_CONFIGURATION_TYPES=Release ANDROID=TRUE --clear

# This works with above compilation
#hunter_config(Boost VERSION 1.58.0-p0 CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)

# This doesn't work with above compilation
hunter_config(Boost VERSION 1.58.0-p1 CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)

set(OPENCV_CMAKE_ARGS
  BUILD_ANDROID_EXAMPLES=OFF 
  BUILD_DOCS=OFF 
  BUILD_EXAMPLES=OFF 
  BUILD_PERF_TESTS=OFF 
  BUILD_TESTS=OFF 
  BUILD_opencv_apps=OFF 
  INSTALL_PYTHON_EXAMPLES=OFF  
  BUILD_WITH_STATIC_CRT=OFF 
  BUILD_ZLIB=OFF 
  BUILD_TIFF=OFF 
  BUILD_JPEG=OFF
  WITH_JPEG=OFF 
  BUILD_PNG=OFF
  )

hunter_config(OpenCV VERSION ${HUNTER_OpenCV_VERSION} CMAKE_ARGS "${OPENCV_CMAKE_ARGS}")




