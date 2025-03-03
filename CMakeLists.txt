cmake_minimum_required(VERSION 3.21)
project(Framer LANGUAGES CXX)

add_library(framer 
    "src/DemoClass.cpp"
)

set_target_properties(framer
    PROPERTIES
    CMAKE_CXX_STANDARD 20
    CMAKE_CXX_STANDARD_REQUIRED ON
    CMAKE_CXX_EXTENSIONS OFF
    CMAKE_CXX_VISIBILITY_PRESET hidden
    CMAKE_VISIBILITY_INLINES_HIDDEN YES
)

# Packages
find_package(OpenCV REQUIRED core dnn)

target_link_libraries(framer PRIVATE ${OpenCV_LIBS})
target_compile_definitions(framer PRIVATE FRAMER_EXPORT)
if(BUILD_SHARED_LIBS)
    target_compile_definitions(framer PUBLIC FRAMER_SHARED)
endif()
target_include_directories(framer PRIVATE ${OpenCV_INCLUDE_DIRS} "${CMAKE_CURRENT_SOURCE_DIR}/include" "${CMAKE_CURRENT_SOURCE_DIR}/src/include")

include(GNUInstallDirs)
target_include_directories(framer PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

install(TARGETS framer
    EXPORT FramerTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(DIRECTORY include/ DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

# For find_package
install(EXPORT FramerTargets
    FILE FramerTargets.cmake
    NAMESPACE Framer::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)

# Generating FramerConfig.cmake from a template
include(CMakePackageConfigHelpers)

configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/FramerConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/FramerConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)

install(FILES "${CMAKE_CURRENT_BINARY_DIR}/FramerConfig.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)