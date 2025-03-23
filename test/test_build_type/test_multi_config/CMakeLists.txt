# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_multi_config)

get_property(IS_MULTI_CONFIG
  GLOBAL
  PROPERTY GENERATOR_IS_MULTI_CONFIG
)

if(NOT IS_MULTI_CONFIG)
  message(FATAL_ERROR "Cannot run multi-config test on a single-config generator")
endif()

if(NOT DEFAULT_CONFIGURATION)
  message(FATAL_ERROR "DEFAULT_CONFIGURATION must be set for this test")
endif()

find_package(petrycmake CONFIG REQUIRED)
include(PetryBuildType)

petry_set_default_build_type("${DEFAULT_CONFIGURATION}")

list(GET CMAKE_CONFIGURATION_TYPES 0 ACTUAL_DEFAULT_CONFIGURATION)

if(NOT DEFAULT_CONFIGURATION STREQUAL ACTUAL_DEFAULT_CONFIGURATION)
  message(FATAL_ERROR "Default configuration is \"${ACTUAL_DEFAULT_CONFIGURATION}\", expected \"${DEFAULT_CONFIGURATION}\"")
endif()
