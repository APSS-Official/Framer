message(STATUS "Setting up dependencies")

# find_package(fmt 11.1 REQUIRED)
find_package(OpenCV 4.10 REQUIRED core dnn)

target_include_directories(framer PRIVATE ${OpenCV_INCLUDE_DIRS})
target_link_libraries(framer PRIVATE opencv_core opencv_dnn)

include(FetchContent)
set(FetchContent_QUIET OFF)
FetchContent_Declare(
	fmt
	GIT_REPOSITORY https://github.com/fmtlib/fmt.git
	GIT_PROGRESS ON
)
#FetchContent_MakeAvailable(fmt)
#target_include_directories(framer PRIVATE ${fmt_INCLUDES})
#target_link_libraries(framer PRIVATE fmt::fmt)