# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(petrycmake_common_test
  LANGUAGES C CXX
)

find_package(petrycmake CONFIG REQUIRED)

if(NOT DEFINED PETRYCMAKE_TEST_SCRIPT)
  message(FATAL_ERROR "PETRYCMAKE_TEST_SCRIPT needs to be defined")
endif()

include("${PETRYCMAKE_TEST_SCRIPT}")
