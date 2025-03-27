# SPDX-License-Identifier: MIT
# SPDX-FileCopyrightText: Copyright 2025 Pierre Wendling

include_guard()

set(PETRYCMAKE_INTERNAL_AVAILABLE_BUILD_CONFIGS
  "Debug"
  "Release"
  "RelWithDebInfo"
  "MinSizeRel"
)

function(petry_internal_set_default_build_type_multi CONFIGURATION)
  set(AVAILABLE_CONFIGS ${PETRYCMAKE_INTERNAL_AVAILABLE_BUILD_CONFIGS})
  list(REMOVE_ITEM AVAILABLE_CONFIGS "${CONFIGURATION}")
  list(PREPEND AVAILABLE_CONFIGS "${CONFIGURATION}")
  set(CMAKE_CONFIGURATION_TYPES "${AVAILABLE_CONFIGS}"
    CACHE INTERNAL "Available build configurations"
  )
  set(CMAKE_DEFAULT_BUILD_TYPE "${CONFIGURATION}"
    CACHE INTERNAL "Default build configuration for Ninja Multi-Config"
  )
endfunction()

function(petry_internal_set_default_build_type_single CONFIGURATION)
  if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE "${CONFIGURATION}"
      CACHE STRING "Build configuration"
      FORCE
    )
    set_property(
      CACHE CMAKE_BUILD_TYPE
      PROPERTY STRINGS
      "${PETRYCMAKE_INTERNAL_AVAILABLE_BUILD_CONFIGS}"
    )
  endif()
endfunction()

function(petry_set_default_build_type CONFIGURATION)
  if(NOT CONFIGURATION IN_LIST PETRYCMAKE_INTERNAL_AVAILABLE_BUILD_CONFIGS)
    message(FATAL_ERROR "The provided configuration \"${CONFIGURATION}\" does not exist.")
  endif()

  get_property(IS_MULTI_CONFIG GLOBAL PROPERTY GENERATOR_IS_MULTI_CONFIG)
  if(IS_MULTI_CONFIG)
    petry_internal_set_default_build_type_multi("${CONFIGURATION}")
  else()
    petry_internal_set_default_build_type_single("${CONFIGURATION}")
  endif()
endfunction()
