# SPDX-License-Identifier: MIT

cmake_minimum_required(VERSION 3.31)
project(test_bad_config)

find_package(petrycmake CONFIG REQUIRED)

include(PetryBuildType)

petry_set_default_build_type(InvalidBuildType)
