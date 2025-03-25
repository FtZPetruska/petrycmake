# SPDX-License-Identifier: MIT

if(NOT DEFINED ENV{HOMEBREW_PREFIX})
  message(FATAL_ERROR "Homebrew shellenv must be set")
endif()

find_program(CMAKE_C_COMPILER gcc
  NAMES gcc-14 gcc-15
  REQUIRED
  PATHS
    "$ENV{HOMEBREW_PREFIX}/opt/gcc/bin"
  NO_DEFAULT_PATH
)

find_program(CMAKE_CXX_COMPILER g++
  NAMES g++-14 g++-15
  REQUIRED
  PATHS
    "$ENV{HOMEBREW_PREFIX}/opt/gcc/bin"
  NO_DEFAULT_PATH
)
