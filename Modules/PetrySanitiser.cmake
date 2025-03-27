# SPDX-License-Identifier: MIT

include_guard()

function(petry_internal_check_sanitisers_msvc)
  include(CheckCCompilerFlag)

  foreach(SANITISER IN ITEMS "address" "undefined")
    string(TOUPPER "HAVE_SANITISER_${SANITISER}" IS_FLAG_SUPPORTED)
    check_c_compiler_flag("/fsanitize=${SANITISER}" "${IS_FLAG_SUPPORTED}")
    if(${IS_FLAG_SUPPORTED})
      list(APPEND SUPPORTED_SANITISERS "/fsanitize=${SANITISER}")
    endif()
  endforeach()

  set(PETRYCMAKE_INTERNAL_SANITISERS_COMPILE_OPTIONS "${SUPPORTED_SANITISERS}"
    CACHE INTERNAL "Compiler flags to enable sanitisers"
  )
  set(PETRYCMAKE_INTERNAL_SANITISERS_LINK_OPTIONS ""
    CACHE INTERNAL "Link flags to enable sanitisers"
  )
endfunction()

function(petry_internal_check_sanitisers_gnu)
  include(CheckCSourceCompiles)

  set(EXTRA_FLAGS
    "-fno-omit-frame-pointer"
    "-fno-optimize-sibling-calls"
  )
  if(CMAKE_C_COMPILER_ID MATCHES "GNU")
    list(APPEND EXTRA_FLAGS "-fno-ipa-icf")
  endif()
  list(JOIN EXTRA_FLAGS " " FORMATTED_EXTRA_FLAGS)

  foreach(SANITISER IN ITEMS "address" "undefined")
    string(TOUPPER "HAVE_SANITISER_${SANITISER}" IS_FLAG_SUPPORTED)
    set(CMAKE_REQUIRED_FLAGS "-fsanitize=${SANITISER} ${FORMATTED_EXTRA_FLAGS}")
    set(CMAKE_REQUIRED_LINK_OPTIONS "-fsanitize=${SANITISER}" "${EXTRA_FLAGS}")
    check_c_source_compiles("int main(){}" "${IS_FLAG_SUPPORTED}")
    if(${IS_FLAG_SUPPORTED})
      list(APPEND SUPPORTED_SANITISERS "${SANITISER}")
    endif()
  endforeach()

  if(SUPPORTED_SANITISERS)
    list(JOIN SUPPORTED_SANITISERS "," SANITISERS_LIST)
    set(PETRYCMAKE_INTERNAL_SANITISERS_COMPILE_OPTIONS "-fsanitize=${SANITISERS_LIST};${EXTRA_FLAGS}"
      CACHE INTERNAL "Compiler flags to enable sanitisers."
    )
    set(PETRYCMAKE_INTERNAL_SANITISERS_LINK_OPTIONS "-fsanitize=${SANITISERS_LIST};${EXTRA_FLAGS}"
      CACHE INTERNAL "Compiler flags to enable sanitisers."
    )
  endif()
endfunction()

function(petry_internal_check_sanitisers)
  if(MSVC)
    petry_internal_check_sanitisers_msvc()
  else()
    petry_internal_check_sanitisers_gnu()
  endif()
  set(PETRYCMAKE_SANITISERS_CHECKED TRUE
    CACHE INTERNAL "Sanitisers have been checked"
  )
endfunction()

function(petry_set_target_sanitiser TARGET_NAME)
  if(NOT PETRYCMAKE_SANITISERS_CHECKED)
    petry_internal_check_sanitisers()
  endif()

  target_compile_options("${TARGET_NAME}"
    PRIVATE
    ${PETRYCMAKE_INTERNAL_SANITISERS_COMPILE_OPTIONS}
  )
  target_link_options("${TARGET_NAME}"
    PRIVATE
    ${PETRYCMAKE_INTERNAL_SANITISERS_LINK_OPTIONS}
  )
  if(MSVC)
    set_target_properties("${TARGET_NAME}"
      PROPERTIES
        MSVC_DEBUG_INFORMATION_FORMAT "$<$<CONFIG:Debug,RelWithDebInfo>:ProgramDatabase>"
    )
  endif()
endfunction()
