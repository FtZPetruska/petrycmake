# SPDX-License-Identifier: MIT

include(PetryCompilerWarnings)

add_executable(my_program 
  "${CMAKE_CURRENT_LIST_DIR}/main.cpp" 
  "${CMAKE_CURRENT_LIST_DIR}/foo.c" 
  "${CMAKE_CURRENT_LIST_DIR}/foo.h"
)

petry_set_target_warnings(my_program)
