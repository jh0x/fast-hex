if(PROJECT_IS_TOP_LEVEL)
    set(CMAKE_INSTALL_INCLUDEDIR
        "include/fast-hex-${PROJECT_VERSION}"
        CACHE STRING
        ""
    )
    set_property(CACHE CMAKE_INSTALL_INCLUDEDIR PROPERTY TYPE PATH)
endif()

include(CMakePackageConfigHelpers)
include(GNUInstallDirs)

# find_package(<package>) call for consumers to find this project
set(package fast-hex)

install(
    DIRECTORY include/ "${PROJECT_BINARY_DIR}/export/"
    DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}"
    COMPONENT fast-hex_Development
)

install(
    TARGETS fast-hex_fast-hex
    EXPORT fast-hexTargets
    RUNTIME #
        COMPONENT fast-hex_Runtime
    LIBRARY #
        COMPONENT fast-hex_Runtime
        NAMELINK_COMPONENT fast-hex_Development
    ARCHIVE #
        COMPONENT fast-hex_Development
    INCLUDES #
    DESTINATION
        "${CMAKE_INSTALL_INCLUDEDIR}"
)

write_basic_package_version_file(
    "${package}ConfigVersion.cmake"
    COMPATIBILITY SameMajorVersion
)

# Allow package maintainers to freely override the path for the configs
set(fast-hex_INSTALL_CMAKEDIR
    "${CMAKE_INSTALL_LIBDIR}/cmake/${package}"
    CACHE STRING
    "CMake package config location relative to the install prefix"
)
set_property(CACHE fast-hex_INSTALL_CMAKEDIR PROPERTY TYPE PATH)
mark_as_advanced(fast-hex_INSTALL_CMAKEDIR)

install(
    FILES cmake/install-config.cmake
    DESTINATION "${fast-hex_INSTALL_CMAKEDIR}"
    RENAME "${package}Config.cmake"
    COMPONENT fast-hex_Development
)

install(
    FILES "${PROJECT_BINARY_DIR}/${package}ConfigVersion.cmake"
    DESTINATION "${fast-hex_INSTALL_CMAKEDIR}"
    COMPONENT fast-hex_Development
)

install(
    EXPORT fast-hexTargets
    NAMESPACE fast-hex::
    DESTINATION "${fast-hex_INSTALL_CMAKEDIR}"
    COMPONENT fast-hex_Development
)

if(PROJECT_IS_TOP_LEVEL)
    include(CPack)
endif()
