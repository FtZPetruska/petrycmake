# SPDX-License-Identifier: MIT

if(APPLE)
  message(FATAL_ERROR "Use the macos-* toolchains for Apple platforms")
endif()

find_program(CMAKE_C_COMPILER gcc REQUIRED)
find_program(CMAKE_CXX_COMPILER g++ REQUIRED)
