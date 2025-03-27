# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright 2025 Pierre Wendling

if(APPLE)
  message(FATAL_ERROR "Use the macos-* toolchains for Apple platforms")
endif()

find_program(CMAKE_C_COMPILER clang REQUIRED)
find_program(CMAKE_CXX_COMPILER clang++ REQUIRED)
