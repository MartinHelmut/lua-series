cmake_minimum_required(VERSION 3.18)

# Setup a CMake project for C++
project(
  LuaWithGitSubmodules
  VERSION 1.0
  LANGUAGES CXX)

# Add an executable based on one source file
add_executable(ProgramName main.cpp)

# Setup Lua library target with include directories
add_library(Lua::Lua INTERFACE IMPORTED)
target_include_directories(
  Lua::Lua
  INTERFACE "lua")

# Link Lua library to the executable
target_link_libraries(
  ProgramName
  PRIVATE Lua::Lua)
