# Apple Frameworks: https://cmake.org/cmake/help/latest/manual/cmake-buildsystem.7.html#id20

cmake_minimum_required(VERSION 3.12)

project(Cube)

set(CMAKE_VERBOSE_MAKEFILE ON)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_OSX_ARCHITECTURES arm64)
set(CMAKE_SYSTEM_NAME iOS)
set(CMAKE_OSX_SYSROOT "/Applications/Xcode_14.2.app/Contents/Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS.sdk")

set(MOLTENVK_PATH /Users/rexj/Development/VulkanSDK-1.3.236.0/MoltenVK/MoltenVK.xcframework/ios-arm64/libMoltenVK.a )
set(MOLTENVK_INCLUDE_PATH /Users/rexj/Development/VulkanSDK-1.3.236.0/MoltenVK/include )

include_directories(include ${MOLTENVK_INCLUDE_PATH})

add_library(Cubey STATIC cube.cpp)

# Use IMPORTED for pre-built external libraries
add_library(MoltenVK STATIC IMPORTED) 
set_target_properties(MoltenVK PROPERTIES IMPORTED_LOCATION ${MOLTENVK_PATH})

# This does not bind static libraries together
target_link_libraries(Cubey 
	PRIVATE  MoltenVK
	-framework Foundation 
	-framework CoreGraphics 
	-framework UIKit 
	-framework Metal 
	-framework QuartzCore 
	-framework IOSurface
	)

## Looks like we can skip this, presumably because we're currently adding include when we build the xcframework
#target_include_directories(Cube PUBLIC include)

# Use libtool to do that. This will result in two references to (for example) `_vkCmdDraw`, but it still works
#
#     000000000001d0e4 T _vkCmdDraw
#                      U _vkCmdDraw
#
add_custom_command(TARGET Cubey POST_BUILD COMMAND libtool -static -o libCube.a $<TARGET_FILE:MoltenVK> $<TARGET_FILE:Cubey>)

# If we want to to get rid of the undefined symbol above, we can use clang to rebuild the library. Not sure which is the right choice
# Reference: https://stackoverflow.com/a/68407916

#add_custom_command(TARGET Cubey POST_BUILD COMMAND xcrun -sdk iphoneos clang -arch arm64 -r -o libcube.o -Wl,-all_load libCubey.a /Users/rexj/Development/VulkanSDK-1.3.236.0/MoltenVK/MoltenVK.xcframework/ios-arm64/libMoltenVK.a)
#add_custom_command(TARGET Cubey POST_BUILD COMMAND ar cr libcube.a libcube.o)


## OTHER USEFUL REF
#https://stackoverflow.com/questions/50022318/using-cmake-to-build-a-static-library-of-static-libraries
#https://cristianadam.eu/20190501/bundling-together-static-libraries-with-cmake/

