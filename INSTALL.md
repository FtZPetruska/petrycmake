# How to install and use PetryCMake

The main requirements to use the modules are:

- A recent version of CMake
- A recent C/C++ compiler

## Configure and Install

As it is a CMake project, you can run the following commands from the root of the project to install the modules:

```
cmake -S . -B build
cmake --install build
```

You may customise the install location by setting in the first command:

- `CMAKE_INSTALL_PREFIX` to the location where you want the files to be installed.
- `PETRYCMAKE_INSTALL_CMAKEDIR` to the location where you want the CMake package to be installed relative to the prefix (defaults to `share/petrycmake`).

## Using the Modules

The modules can typically be made available by simply running `find_package` as such:

```cmake
find_package(petrycmake CONFIG)
```

For CMake to actually find the package, you may need to set either of the following variables:

- `CMAKE_PREFIX_PATH` to the path you set as `CMAKE_INSTALL_PREFIX` previously
- `petrycmake_DIR` to either the full `CMAKE_INSTALL_PREFIX/PETRYCMAKE_INSTALL_CMAKEDIR`, or to the `build` directory

You may also use CMake's FetchContent to make sure the package is available:

```cmake
include(FetchContent)
FetchContent_Declare(petrycmake
  GIT_REPOSITORY "https://github.com/FtZPetruska/petrycmake"
  GIT_TAG main
)
FetchContent_MakeAvailable(petrycmake)

find_package(petrycmake
  CONFIG REQUIRED
  HINTS "${petrycmake_BINARY_DIR}"
)
```

CMake's scopes being what they are, using FetchContent's `FIND_PACKAGE_ARGS` option will not do what you want and subsequent calls to `find_package` will **NOT** update your `CMAKE_MODULE_PATH`.

Once you have found the package, one way or the other, you can simply include the `PetryCMake` module to recursively include all the others:

```cmake
include(PetryCMake)
```

Alternatively, you can include modules individually:

```cmake
include(PetryBuildType)
```
