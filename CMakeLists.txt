cmake_minimum_required(VERSION 3.14)

include(cmake/prelude.cmake)

project(
    fast-hex
    VERSION 0.1.0
    DESCRIPTION "Hex encode/decode"
    HOMEPAGE_URL "https://github.com/jh0x/fast-hex"
    LANGUAGES CXX
)

include(cmake/project-is-top-level.cmake)
include(cmake/variables.cmake)

# ---- Declare library ----

add_library(fast-hex_fast-hex source/fast-hex.cpp)
add_library(fast-hex::fast-hex ALIAS fast-hex_fast-hex)

include(GenerateExportHeader)
generate_export_header(
    fast-hex_fast-hex
    BASE_NAME fast-hex
    EXPORT_FILE_NAME export/fast-hex/fast-hex_export.hpp
    CUSTOM_CONTENT_FROM_VARIABLE pragma_suppress_c4251
)

if(NOT BUILD_SHARED_LIBS)
    target_compile_definitions(fast-hex_fast-hex PUBLIC FAST_HEX_STATIC_DEFINE)
endif()

set_target_properties(
    fast-hex_fast-hex
    PROPERTIES
        CXX_VISIBILITY_PRESET hidden
        VISIBILITY_INLINES_HIDDEN YES
        VERSION "${PROJECT_VERSION}"
        SOVERSION "${PROJECT_VERSION_MAJOR}"
        EXPORT_NAME fast-hex
        OUTPUT_NAME fast-hex
)

target_include_directories(
    fast-hex_fast-hex
    ${warning_guard}
    PUBLIC "\$<BUILD_INTERFACE:${PROJECT_SOURCE_DIR}/include>"
)

target_include_directories(
    fast-hex_fast-hex
    SYSTEM
    PUBLIC "\$<BUILD_INTERFACE:${PROJECT_BINARY_DIR}/export>"
)

target_compile_features(fast-hex_fast-hex PUBLIC cxx_std_17)

# ---- Install rules ----

if(NOT CMAKE_SKIP_INSTALL_RULES)
    include(cmake/install-rules.cmake)
endif()

# ---- Developer mode ----

if(NOT fast-hex_DEVELOPER_MODE)
    return()
elseif(NOT PROJECT_IS_TOP_LEVEL)
    message(
        AUTHOR_WARNING
        "Developer mode is intended for developers of fast-hex"
    )
endif()

include(cmake/dev-mode.cmake)
