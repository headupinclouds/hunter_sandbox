### Boost


#build.py --toolchain android-ndk-r10e-api-16-armeabi-v7a-neon-clang-35 --verbose --fwd HUNTER_CONFIGURATION_TYPES=Release ANDROID=TRUE --clear

# This works with above compilation
#hunter_config(Boost VERSION 1.58.0-p0 CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)

# This doesn't work with above compilation
hunter_config(Boost VERSION 1.58.0-p1 CMAKE_ARGS IOSTREAMS_NO_BZIP2=1)


