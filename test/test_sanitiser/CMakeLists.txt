# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright 2025 Pierre Wendling

include(CheckCCompilerFlag)

if(NOT DEFINED HAVE_ASAN)
  message(CHECK_START "Checking for Asan")

  set(CMAKE_REQUIRED_QUIET TRUE)
  if(MSVC)
    check_c_compiler_flag("/sanitize=address" HAVE_ASAN)
  else()
    set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=address")
    check_c_compiler_flag("-fsanitize=address" HAVE_ASAN)
  endif()

  if(HAVE_ASAN)
    message(CHECK_PASS "found, enabling test_sanitiser")
  else()
    message(CHECK_FAIL "not found, disabling test_sanitiser")
  endif()
endif()

add_test(
  NAME test_sanitiser
  COMMAND "${CMAKE_CTEST_COMMAND}"
    "--build-and-test"
      "${PETRYCMAKE_TEST_COMMON_ROOT}"
      "${CMAKE_CURRENT_BINARY_DIR}/test_sanitiser"
    "--build-generator" "${CMAKE_GENERATOR}"
    "--build-makeprogram" "${CMAKE_MAKE_PROGRAM}"
    "--build-options"
    "-D" "PETRYCMAKE_TEST_SCRIPT=${CMAKE_CURRENT_SOURCE_DIR}/test_sanitiser.cmake"
      "${PETRYCMAKE_TEST_COMMON_CONFIG_ARGS}"
    COMMAND_EXPAND_LISTS
)

set_tests_properties(test_sanitiser
  PROPERTIES
    LABELS PetrySanitiser
    DISABLED $<NOT:$<BOOL:${HAVE_ASAN}>>
)
