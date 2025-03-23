# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_fetch_content)

if(NOT DEFINED PETRYCMAKE_REPOSITORY)
  message(FATAL_ERROR "PETRYCMAKE_REPOSITORY needs to be set for this test")
endif()

include(FetchContent)

FetchContent_Declare(petrycmake
  GIT_REPOSITORY "${PETRYCMAKE_REPOSITORY}"
  GIT_TAG main
)

FetchContent_MakeAvailable(petrycmake)

find_package(petrycmake
  CONFIG REQUIRED
  HINTS "${petrycmake_BINARY_DIR}"
)

include(PetryCMake)
