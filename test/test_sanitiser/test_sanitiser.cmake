# SPDX-License-Identifier: MIT

include(PetrySanitiser)

add_executable(main
  "${CMAKE_CURRENT_LIST_DIR}/main.cpp"
)

petry_set_target_sanitiser(main)

get_target_property(COMPILE_FLAGS main COMPILE_OPTIONS)

if(NOT COMPILE_FLAGS MATCHES "address")
  message(FATAL_ERROR "Target compile flags should include asan: \"${COMPILE_FLAGS}\"")
endif()
