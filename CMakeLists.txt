# SPDX-License-Identifier: MIT

# TODO: Once ready for release, lower the version to the actual minimum requirement
cmake_minimum_required(VERSION 3.31)
project(petrycmake
  VERSION 0.0.1
  DESCRIPTION "A collection of CMake Modules for C/C++ development"
  LANGUAGES C CXX
)

include(GNUInstallDirs)
include(CMakePackageConfigHelpers)

option(BUILD_TESTING "Build tests" ${PROJECT_IS_TOP_LEVEL})

set(PETRYCMAKE_INSTALL_CMAKEDIR "${CMAKE_INSTALL_DATADIR}/petrycmake"
  CACHE STRING "Install directory for the CMake package, relative to the install prefix."
)

file(GLOB
  PETRYCMAKE_MODULES
  CONFIGURE_DEPENDS
  "${CMAKE_CURRENT_SOURCE_DIR}/Modules/*.cmake"
)

configure_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/LICENSE.txt"
  "${CMAKE_CURRENT_BINARY_DIR}/copyright"
  COPYONLY
)

if(BUILD_TESTING)
  enable_testing()
  add_subdirectory(test)
endif()

install(DIRECTORY
  "${CMAKE_CURRENT_SOURCE_DIR}/Modules"
  DESTINATION "${PETRYCMAKE_INSTALL_CMAKEDIR}"
)

write_basic_package_version_file(
  "${CMAKE_CURRENT_BINARY_DIR}/petrycmakeConfigVersion.cmake"
  COMPATIBILITY SameMajorVersion
)

set(PETRYCMAKE_MODULE_PATH "\${CMAKE_CURRENT_LIST_DIR}/Modules")
configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/petrycmakeConfig.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/install-config/petrycmakeConfig.cmake"
  INSTALL_DESTINATION "${PETRYCMAKE_INSTALL_CMAKEDIR}"
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
)

install(FILES
  "${CMAKE_CURRENT_BINARY_DIR}/install-config/petrycmakeConfig.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/petrycmakeConfigVersion.cmake"
  "${CMAKE_CURRENT_BINARY_DIR}/copyright"
  DESTINATION "${PETRYCMAKE_INSTALL_CMAKEDIR}"
)

set(PETRYCMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/Modules")
configure_package_config_file(
  "${CMAKE_CURRENT_SOURCE_DIR}/cmake/petrycmakeConfig.cmake.in"
  "${CMAKE_CURRENT_BINARY_DIR}/petrycmakeConfig.cmake"
  INSTALL_DESTINATION "${PETRYCMAKE_INSTALL_CMAKEDIR}"
  NO_CHECK_REQUIRED_COMPONENTS_MACRO
  INSTALL_PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
)
