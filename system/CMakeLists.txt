cmake_minimum_required(VERSION 3.10)
project(multi_version_opencv_system)
find_package(OpenCV REQUIRED)
message(STATUS 1-${OpenCV_VERSION})

set(EXE opencv-system)
add_executable(${EXE} main.cpp)
target_include_directories(${EXE} PUBLIC ${OpenCV_INCLUDE_DIRS})
target_link_libraries(${EXE} PUBLIC ${OpenCV_LIBS})
