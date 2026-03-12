# Lua with C++

This folder contains a set of examples from my article [C++ and Lua](https://martin-fieber.de/blog/cpp-and-lua) as part of the [Lua series](https://martin-fieber.de/series/lua).

## Examples

| Folder                     | Contents                                            |
| -------------------------- | --------------------------------------------------- |
| `cmake_find_package/`      | Include Lua in a project via CMake `find_package`   |
| `cmake_external_project/`  | Include Lua in a project via CMake external project |
| `cmake_git_submodule/`     | Include Lua in a project via Git submodule          |
| `example-read-config/`     | All about reading data from Lua                     |
| `example-functions/`       | Calling Lua functions from C++                      |
| `example-cpp-to-lua/`      | Calling a C++ from Lua                              |
| `example-custom-module`    | Define a custom Lua module from C++                 |
| `example-override-builtin` | Override built-in Lua functions                     |

## Setup

Every example is set up the same, using CMake to build. Setting any example folder as current working directory, run the following command to create the CMake build configuration.

```shell
cmake -B build
```

The next command will build the executable into the folder `build`.

```shell
cmake --build build
```
