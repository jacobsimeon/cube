cmake_minimum_required(VERSION 3.12)

project(Cube)
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_OSX_ARCHITECTURES arm64)

set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_SYSROOT "/Applications/Xcode.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk")

set(MOLTENVK_PATH /Users/morrisj/Source/llmv/VulkanSDK/current/MoltenVK/MoltenVK.xcframework/ios-arm64/libMoltenVK.a)
set(MOLTENVK_INCLUDE_PATH /Users/morrisj/Source/llmv/VulkanSDK/current/MoltenVK/include)

# Add the directory containing the header files to the include path
include_directories(include ${MOLTENVK_INCLUDE_PATH})

# Create a new shared library called MyLibrary that includes the C++ source files
# MySource1.cpp and MySource2.cpp, and the header files in the include directory
add_library(Cube STATIC cube.cpp)

# Specify the header files for the library

message(${MOLTENVK_PATH})
target_link_libraries(Cube PRIVATE ${MOLTENVK_PATH} "-framework Foundation -framework CoreGraphics -framework UIKit -framework Metal -framework QuartzCore -framework IOSurface")
target_include_directories(Cube PUBLIC include)
