# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4.1)

# Add shared files
file(
        GLOB photoapp_sources
        ../../shared/support-lib/jni/*.cpp
        ../../shared/generated-src/jni/*.cpp
        ../../shared/src/*.cpp
)

# Provide include files
include_directories(
        ../../shared/support-lib/
        ../../shared/support-lib/jni/
        ../../shared/src/
        ../../shared/generated-src/cpp/
        ../../shared/generated-src/jni/
)

# Create library from the shared files
add_library(
        photoapplib
        SHARED
        ${photoapp_sources}
)

# Link library
target_link_libraries(photoapplib)
