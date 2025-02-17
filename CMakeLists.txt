cmake_minimum_required(VERSION 3.16)

project(Framer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(OpenCV REQUIRED core dnn)

message(STATUS "OpenCV Include Directories: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "OpenCV Libraries: ${OpenCV_LIBS}")

add_executable(Framer "src/DemoClass.h" "src/DemoClass.cpp")

target_include_directories(Framer PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(Framer PRIVATE ${OpenCV_LIBS})

include(GNUInstallDirs)
install(TARGETS Framer
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
 
