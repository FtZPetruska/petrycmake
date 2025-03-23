# SPDX-License-Identifier: MIT

include_guard()

function(petry_internal_check_warnings)
  if(MSVC)
    set(CANDIDATE_WARNINGS
      "/W4"
      "/w14242"
      "/w14254"
      "/w14263"
      "/w14265"
      "/w14287"
      "/we4289"
      "/w14296"
      "/w14311"
      "/w14545"
      "/w14546"
      "/w14547"
      "/w14549"
      "/w14555"
      "/w14619"
      "/w14640"
      "/w14826"
      "/w14905"
      "/w14906"
      "/w14928"
      "/permissive-"
    )
    set(CXX_ONLY_WARNINGS)
  else()
    set(CANDIDATE_WARNINGS
      "-Wall"
      "-Wextra"
      "-Wextra-semi"
      "-Wshadow"
      "-Wnon-virtual-dtor"
      "-Wold-style-cast"
      "-Wcast-align"
      "-Wunused"
      "-Woverloaded-virtual"
      "-Wpedantic"
      "-Wconversion"
      "-Wsign-conversion"
      "-Wnull-dereference"
      "-Wdouble-promotion"
      "-Wformat=2"
      "-Wimplicit-fallthrough"
      "-Wmisleading-indentation"
      "-Wduplicated-cond"
      "-Wduplicated-branches"
      "-Wlogical-op"
      "-Wuseless-cast"
    )
    set(CXX_ONLY_WARNINGS
      "-Wextra-semi"
      "-Wnon-virtual-dtor"
      "-Wold-style-cast"
      "-Woverloaded-virtual"
    )
  endif()

  include(CheckCXXCompilerFlag)

  foreach(WARNING IN LISTS CANDIDATE_WARNINGS)
    string(TOUPPER "HAVE${WARNING}" FORMATTED_WARNING)
    string(MAKE_C_IDENTIFIER "${FORMATTED_WARNING}" IS_WARNING_SUPPORTED)
    check_cxx_compiler_flag("${WARNING}" "${IS_WARNING_SUPPORTED}")
    
    if(${IS_WARNING_SUPPORTED})
      list(FIND CXX_ONLY_WARNINGS "${WARNING}" WARNING_IDX)
      if(WARNING_IDX EQUAL -1)
        list(APPEND SUPPORTED_WARNINGS "${WARNING}")
      else()
        list(APPEND SUPPORTED_WARNINGS $<$<COMPILE_LANGUAGE:CXX>:${WARNING}>)
      endif()
    endif()
  endforeach()
  
  set(PETRYCMAKE_COMPILER_WARNINGS "${SUPPORTED_WARNINGS}"
    CACHE INTERNAL "Supported compiler warnings"
  )
endfunction()

function(petry_set_target_warnings TARGET_NAME)
  if(NOT DEFINED CACHE{PETRYCMAKE_COMPILER_WARNINGS})
    petry_internal_check_warnings()
  endif()
  target_compile_options("${TARGET_NAME}"
    PRIVATE
    ${PETRYCMAKE_COMPILER_WARNINGS}  
  )
endfunction()
