# SPDX-License-Identifier: MIT

add_test(
  NAME test_find_package
  COMMAND "${CMAKE_COMMAND}"
    "-S" "${CMAKE_CURRENT_SOURCE_DIR}/test_find_package"
    "-B" "${CMAKE_CURRENT_BINARY_DIR}/test_find_package"
    "-D" "petrycmake_DIR=${PROJECT_BINARY_DIR}"
    "--fresh"
)
