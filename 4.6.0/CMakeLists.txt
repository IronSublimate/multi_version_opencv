cmake_minimum_required(VERSION 3.10)
project(multi_version_opencv_4_6_0)


include(../3rdparty/3rdparty.cmake)
set(ver "4.6.0")
set(THIRD_PARTY_INSTALL_DIR ${CMAKE_BINARY_DIR}/3rdparty/opencv-${ver}/install)

include(../3rdparty/OpencvOptions.cmake)

list(APPEND OPENCV_OPTIONS -DCMAKE_INSTALL_PREFIX=${THIRD_PARTY_INSTALL_DIR})


build_external_project(OpenCV "https://github.com/opencv/opencv.git" ${ver} ${OPENCV_OPTIONS})
find_package(OpenCV ${ver} REQUIRED PATHS ${THIRD_PARTY_INSTALL_DIR} NO_DEFAULT_PATH EXACT)
#if (NOT ${OpenCV_FOUND})
#    build_external_project(OpenCV "https://github.com/opencv/opencv.git" ${ver} ${OPENCV_OPTIONS})
#    find_package(OpenCV REQUIRED PATHS ${THIRD_PARTY_INSTALL_DIR} NO_DEFAULT_PATH)
#endif ()

set(CMAKE_CXX_STANDARD 17)
message(STATUS 1-${OpenCV_VERSION})
set(EXE opencv-${ver})
add_executable(${EXE} main.cpp)
target_include_directories(${EXE} PUBLIC ${OpenCV_INCLUDE_DIRS})
target_link_libraries(${EXE} PUBLIC ${OpenCV_LIBS})



