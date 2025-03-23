# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_single_config_preset)

get_property(IS_MULTI_CONFIG
  GLOBAL
  PROPERTY GENERATOR_IS_MULTI_CONFIG
)

if(IS_MULTI_CONFIG)
  message(FATAL_ERROR "Cannot run single-config test on a multi-config generator")
endif()

find_package(petrycmake CONFIG REQUIRED)
include(PetryBuildType)

set(INITIAL_CONFIG "${CMAKE_BUILD_TYPE}")
if(INITIAL_CONFIG STREQUAL Release)
  petry_set_default_build_type(Debug)
else()
  petry_set_default_build_type(Release)
endif()

if(NOT INITIAL_CONFIG STREQUAL CMAKE_BUILD_TYPE)
  message(FATAL_ERROR "Default configuration has been changed to \"${CMAKE_BUILD_TYPE}\", expected to remain \"${INITIAL_CONFIG}\"")
endif()
