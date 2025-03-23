# SPDX-License-Identifier: MIT

find_program(NINJA_EXECUTABLE
  NAMES ninja
  DOC "Required to ensure the Ninja generator is available."
)

foreach(BUILD_CONFIG Debug Release MinSizeRel RelWithDebInfo)
  string(TOLOWER "${BUILD_CONFIG}" CONFIG_NAME)
  add_test(
    NAME "test_single_config_${CONFIG_NAME}"
    COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_single_config"
      "${CMAKE_CURRENT_BINARY_DIR}/test_single_config_${CONFIG_NAME}"
    "--build-generator" "Ninja"
    "--build-makeprogram" "${NINJA_EXECUTABLE}"
    "--build-options" 
      "-D" "DEFAULT_CONFIGURATION=${BUILD_CONFIG}"
      "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
  )

  add_test(
    NAME "test_single_config_preset_${CONFIG_NAME}"
    COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_single_config_preset"
      "${CMAKE_CURRENT_BINARY_DIR}/test_single_config_preset_${CONFIG_NAME}"
    "--build-generator" "Ninja"
    "--build-makeprogram" "${NINJA_EXECUTABLE}"
    "--build-options"
      "-D" "CMAKE_BUILD_TYPE=${BUILD_CONFIG}"
      "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
  )

  add_test(
    NAME test_multi_config_${CONFIG_NAME}
    COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${CMAKE_CURRENT_SOURCE_DIR}/test_multi_config"
      "${CMAKE_CURRENT_BINARY_DIR}/test_multi_config_${CONFIG_NAME}"
    "--build-generator" "Ninja Multi-Config"
    "--build-makeprogram" "${NINJA_EXECUTABLE}"
    "--build-options"
      "-D" "DEFAULT_CONFIGURATION=${BUILD_CONFIG}"
      ${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}
    COMMAND_EXPAND_LISTS
  )

  set_tests_properties(
      "test_single_config_${CONFIG_NAME}"
      "test_single_config_preset_${CONFIG_NAME}"
      "test_multi_config_${CONFIG_NAME}"
    PROPERTIES
      DISABLED $<NOT:$<BOOL:${NINJA_EXECUTABLE}>>
      LABELS "PetryBuildType"
  )
endforeach()

add_test(
  NAME test_bad_config
  COMMAND "${CMAKE_CTEST_COMMAND}"
  "--build-and-test"
    "${CMAKE_CURRENT_SOURCE_DIR}/test_bad_config"
    "${CMAKE_CURRENT_BINARY_DIR}/test_bad_config"
  "--build-generator" "${CMAKE_GENERATOR}"
  "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
  "--build-options" "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
  COMMAND_EXPAND_LISTS
)

set_tests_properties(
  test_bad_config
  PROPERTIES
    PASS_REGULAR_EXPRESSION "InvalidBuildType"
    LABELS "PetryBuildType"
)
