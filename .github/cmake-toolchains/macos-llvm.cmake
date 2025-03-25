# SPDX-License-Identifier: MIT

if(NOT DEFINED ENV{HOMEBREW_PREFIX})
  message(FATAL_ERROR "Homebrew shellenv must be set")
endif()

find_program(CMAKE_C_COMPILER clang
  REQUIRED
  PATHS
    "$ENV{HOMEBREW_PREFIX}/opt/llvm/bin"
  NO_DEFAULT_PATH
)

find_program(CMAKE_CXX_COMPILER clang++
  REQUIRED
  PATHS
    "$ENV{HOMEBREW_PREFIX}/opt/llvm/bin"
  NO_DEFAULT_PATH
)

foreach(LINK_TYPE IN ITEMS "EXE" "MODULE" "SHARED" "STATIC")
  set(CMAKE_${LINK_TYPE}_LINKER_FLAGS_INIT "-L$ENV{HOMEBREW_PREFIX}/opt/llvm/lib/c++ -L$ENV{HOMEBREW_PREFIX}/opt/llvm/lib/unwind -lunwind")
endforeach()
