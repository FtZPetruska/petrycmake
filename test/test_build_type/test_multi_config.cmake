# SPDX-License-Identifier: MIT

include(PetryBuildType)

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

petry_set_default_build_type("${DEFAULT_CONFIGURATION}")

list(GET CMAKE_CONFIGURATION_TYPES 0 ACTUAL_DEFAULT_CONFIGURATION)

if(NOT DEFAULT_CONFIGURATION STREQUAL ACTUAL_DEFAULT_CONFIGURATION)
  message(FATAL_ERROR "Default configuration is \"${ACTUAL_DEFAULT_CONFIGURATION}\", expected \"${DEFAULT_CONFIGURATION}\"")
endif()
