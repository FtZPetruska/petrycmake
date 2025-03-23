# SPDX-License-Identifier: MIT

find_program(NINJA_EXECUTABLE
  NAMES ninja
  DOC "Required to ensure the Ninja generator is available."
)

foreach(BUILD_CONFIG Debug Release MinSizeRel RelWithDebInfo)
  string(TOLOWER "${BUILD_CONFIG}" CONFIG_NAME)
  add_test(
    NAME "test_single_config_${CONFIG_NAME}"
    COMMAND "${CMAKE_COMMAND}"
    "-S" "${CMAKE_CURRENT_SOURCE_DIR}/test_single_config"
    "-B" "${CMAKE_CURRENT_BINARY_DIR}/test_single_config_${CONFIG_NAME}"
    "-D" "CMAKE_MAKE_PROGRAM=${NINJA_EXECUTABLE}"
    "-G" "Ninja"
    "-D" "DEFAULT_CONFIGURATION=${BUILD_CONFIG}"
    "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
  )

  add_test(
    NAME "test_single_config_preset_${CONFIG_NAME}"
    COMMAND "${CMAKE_COMMAND}"
    "-S" "${CMAKE_CURRENT_SOURCE_DIR}/test_single_config_preset"
    "-B" "${CMAKE_CURRENT_BINARY_DIR}/test_single_config_preset_${CONFIG_NAME}"
    "-D" "CMAKE_MAKE_PROGRAM=${NINJA_EXECUTABLE}"
    "-G" "Ninja"
    "-D" "CMAKE_BUILD_TYPE=${BUILD_CONFIG}"
    "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
  )

  add_test(
    NAME test_multi_config_${CONFIG_NAME}
    COMMAND "${CMAKE_COMMAND}"
    "-S" "${CMAKE_CURRENT_SOURCE_DIR}/test_multi_config"
    "-B" "${CMAKE_CURRENT_BINARY_DIR}/test_multi_config_${CONFIG_NAME}"
    "-D" "CMAKE_MAKE_PROGRAM=${NINJA_EXECUTABLE}"
    "-G" "Ninja Multi-Config"
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
  COMMAND "${CMAKE_COMMAND}"
  "-S" "${CMAKE_CURRENT_SOURCE_DIR}/test_bad_config"
  "-B" "${CMAKE_CURRENT_BINARY_DIR}/test_bad_config"
  "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
  COMMAND_EXPAND_LISTS
)

set_tests_properties(
  test_bad_config
  PROPERTIES
    PASS_REGULAR_EXPRESSION "InvalidBuildType"
    LABELS "PetryBuildType"
)
