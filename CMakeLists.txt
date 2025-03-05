cmake_minimum_required(VERSION 3.21)
project(Framer VERSION 0.1.0 LANGUAGES CXX)

message(STATUS "${PROJECT_NAME} ${PROJECT_VERSION}")

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

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")

include(dependencies)

include(GenerateExportHeader)
generate_export_header(framer)

target_include_directories(framer PRIVATE "${CMAKE_CURRENT_SOURCE_DIR}/src" ${CMAKE_CURRENT_BINARY_DIR})
include(GNUInstallDirs)
target_include_directories(framer 
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

install(TARGETS framer
    EXPORT FramerTargets
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    INCLUDES DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
)

install(DIRECTORY include/ DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")

# For find_package
install(EXPORT FramerTargets
    FILE FramerTargets.cmake
    NAMESPACE Framer::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)

# Generating FramerConfig.cmake from a template
include(CMakePackageConfigHelpers)
# FramerConfig.cmake
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/FramerConfig.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/FramerConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)

# FramerConfigVersion.cmake
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/FramerConfigVersion.cmake"
    VERSION ${PROJECT_VERSION}
    COMPATIBILITY SameMajorVersion
)

install(FILES 
    "${CMAKE_CURRENT_BINARY_DIR}/FramerConfig.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/FramerConfigVersion.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/Framer"
)
