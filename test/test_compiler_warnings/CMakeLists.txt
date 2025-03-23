# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_compiler_warnings LANGUAGES C CXX)

find_package(petrycmake)
include(PetryCompilerWarnings)

add_executable(my_program main.cpp foo.c foo.h)

petry_set_target_warnings(my_program)

set_target_properties(my_program
  PROPERTIES
    COMPILE_WARNING_AS_ERROR TRUE
)
