cmake_minimum_required(VERSION 3.18)

# Setup a CMake project for C++
project(
  LuaWithCMakeExternalProject
  VERSION 1.0
  LANGUAGES CXX)

# Add an executable based on one source file
add_executable(ProgramName main.cpp)

# Include the fetch content module
include(FetchContent)

# Fetch Lua from git mirror
FetchContent_Declare(
  lua
  GIT_REPOSITORY "https://github.com/lua/lua.git"
  GIT_TAG v5.5.0
)

# Make content available
FetchContent_MakeAvailable(lua)

# Setup Lua library target with include directories
add_library(Lua::Lua INTERFACE IMPORTED)
target_include_directories(
  Lua::Lua
  INTERFACE "${lua_SOURCE_DIR}")

# Link Lua library to the executable
target_link_libraries(
  ProgramName
  PRIVATE Lua::Lua)
