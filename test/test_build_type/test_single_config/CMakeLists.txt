# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_single_config)

get_property(IS_MULTI_CONFIG
  GLOBAL
  PROPERTY GENERATOR_IS_MULTI_CONFIG
)

if(IS_MULTI_CONFIG)
  message(FATAL_ERROR "Cannot run single-config test on a multi-config generator")
endif()

if(NOT DEFAULT_CONFIGURATION)
  message(FATAL_ERROR "DEFAULT_CONFIGURATION must be set for this test")
endif()

find_package(petrycmake CONFIG REQUIRED)
include(PetryBuildType)

unset(CMAKE_BUILD_TYPE CACHE)
petry_set_default_build_type("${DEFAULT_CONFIGURATION}")

if(NOT DEFAULT_CONFIGURATION STREQUAL CMAKE_BUILD_TYPE)
  message(FATAL_ERROR "Default configuration is \"${CMAKE_BUILD_TYPE}\", expected \"${DEFAULT_CONFIGURATION}\"")
endif()
