# SPDX-License-Identifier: MIT

add_test(
  NAME test_compiler_warnings
  COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${PETRYCMAKE_TEST_COMMON_ROOT}"
      "${CMAKE_CURRENT_BINARY_DIR}/test_compiler_warnings"
    "--build-generator" "${CMAKE_GENERATOR}"
    "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
    "--build-options"
      "-D" "PETRYCMAKE_TEST_SCRIPT=${CMAKE_CURRENT_SOURCE_DIR}/test_compiler_warnings.cmake"
      "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
)

set_tests_properties(test_compiler_warnings
  PROPERTIES
    LABELS PetryCompilerWarnings
    PASS_REGULAR_EXPRESSION "(C4245|sign-conversion)"
    FAIL_REGULAR_EXPRESSION "(unknown option|warning: command-line option|unknown-warning-option)"
)
