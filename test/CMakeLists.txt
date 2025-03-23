# SPDX-License-Identifier: MIT

set(PETRYCMAKE_TEST_COMMON_CONFIG_ARGS
  "-D" "petrycmake_DIR=${PROJECT_BINARY_DIR}"
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
  NAME test_compiler_warnings
  COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_compiler_warnings"
      "${CMAKE_CURRENT_BINARY_DIR}/test_compiler_warnings"
    "--build-generator" "${CMAKE_GENERATOR}"
    "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
    "--build-options" "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
)

set_tests_properties(test_compiler_warnings
  PROPERTIES
    LABELS PetryCompilerWarnings
)

add_subdirectory(test_build_type)
