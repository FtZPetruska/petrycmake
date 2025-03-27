# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright 2025 Pierre Wendling

set(TOOLCHAIN_ARGS)
if(CMAKE_TOOLCHAIN_FILE)
  set(TOOLCHAIN_ARGS "--toolchain" "${CMAKE_TOOLCHAIN_FILE}")
endif()

set(PETRYCMAKE_TEST_COMMON_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/common_test_root")
set(PETRYCMAKE_TEST_COMMON_CONFIG_ARGS
  "-D" "petrycmake_DIR=${PROJECT_BINARY_DIR}"
  "-D" "CMAKE_C_COMPILER=${CMAKE_C_COMPILER}"
  "-D" "CMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}"
  ${TOOLCHAIN_ARGS}
  "-Wdev"
  "-Werror=dev"
  "--warn-uninitialized"
  "--fresh"
)

add_test(
  NAME test_find_package
  COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_find_package"
      "${CMAKE_CURRENT_BINARY_DIR}/test_find_package"
    "--build-generator" "${CMAKE_GENERATOR}"
    "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
    "--build-options" "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
)

add_test(
  NAME test_fetch_content
  COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_fetch_content"
      "${CMAKE_CURRENT_BINARY_DIR}/test_fetch_content"
    "--build-generator" "${CMAKE_GENERATOR}"
    "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
    "--build-options"
      "--fresh"
      "-DPETRYCMAKE_REPOSITORY=${PROJECT_SOURCE_DIR}"
    COMMAND_EXPAND_LISTS
)

if(NOT EXISTS "${PROJECT_SOURCE_DIR}/.git")
  set_tests_properties(test_fetch_content
    PROPERTIES
      DISABLED TRUE
  )
endif()

add_subdirectory(test_build_type)
add_subdirectory(test_compiler_warnings)
add_subdirectory(test_sanitiser)
