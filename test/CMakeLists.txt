add_subdirectory(source)

if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_subdirectory(fuzz)
else()
    message(STATUS "Fuzz subdirectory not included (requires Clang compiler)")
endif()

if(ENABLE_BENCHMARK)
    add_subdirectory(benchmark)
endif()
