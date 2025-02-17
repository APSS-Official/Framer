cmake_minimum_required(VERSION 3.16)

project(Framer LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_INCLUDE_CURRENT_DIR ON)
set(CMAKE_CXX_VISIBILITY_PRESET hidden)
set(CMAKE_VISIBILITY_INLINES_HIDDEN YES)

# Packages
find_package(OpenCV REQUIRED core dnn)

add_library(framer "src/DemoClass.cpp")
target_compile_definitions(framer PRIVATE FRAMER_EXPORT)

target_include_directories(framer PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    $<INSTALL_INTERFACE:include>
    ${OpenCV_INCLUDE_DIRS}
)
target_link_libraries(framer PRIVATE ${OpenCV_LIBS})

if(BUILD_SHARED_LIBS)
    target_compile_definitions(framer PUBLIC FRAMER_SHARED)
endif()

include(GNUInstallDirs)
install(TARGETS framer
    EXPORT FramerTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# For find_package
install (EXPORT FramerTargets
    FILE FramerTargets.cmake
    NAMESPACE Frammer::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Framer
)

# Generating FramerConfig.cmake from a template
include(CMakePackageConfigHelpers)
configure_package_config_file(
    cmake/FramerConfig.cmake.in
    ${CMAKE_BINARY_DIR}/FramerConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Framer
)

install(FILES ${CMAKE_BINARY_DIR}/FramerConfig.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/Framer
)