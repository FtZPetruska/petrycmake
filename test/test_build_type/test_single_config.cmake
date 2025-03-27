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

if(NOT DEFAULT_CONFIGURATION)
  message(FATAL_ERROR "DEFAULT_CONFIGURATION must be set for this test")
endif()

unset(CMAKE_BUILD_TYPE CACHE)
petry_set_default_build_type("${DEFAULT_CONFIGURATION}")

if(NOT DEFAULT_CONFIGURATION STREQUAL CMAKE_BUILD_TYPE)
  message(FATAL_ERROR "Default configuration is \"${CMAKE_BUILD_TYPE}\", expected \"${DEFAULT_CONFIGURATION}\"")
endif()
