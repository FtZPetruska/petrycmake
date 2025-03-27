# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright 2025 Pierre Wendling

include(PetryBuildType)

get_property(IS_MULTI_CONFIG
  GLOBAL
  PROPERTY GENERATOR_IS_MULTI_CONFIG
)

if(IS_MULTI_CONFIG)
  message(FATAL_ERROR "Cannot run single-config test on a multi-config generator")
endif()

set(INITIAL_CONFIG "${CMAKE_BUILD_TYPE}")
if(INITIAL_CONFIG STREQUAL Release)
  petry_set_default_build_type(Debug)
else()
  petry_set_default_build_type(Release)
endif()

if(NOT INITIAL_CONFIG STREQUAL CMAKE_BUILD_TYPE)
  message(FATAL_ERROR "Default configuration has been changed to \"${CMAKE_BUILD_TYPE}\", expected to remain \"${INITIAL_CONFIG}\"")
endif()
