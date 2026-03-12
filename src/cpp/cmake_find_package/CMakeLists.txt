cmake_minimum_required(VERSION 3.18)

# Setup a CMake project for C++
project(
  LuaWithCMakeFindPackage
  VERSION 1.0
  LANGUAGES CXX)

# Add an executable based on one source file
add_executable(ProgramName main.cpp)

# Try to find the Lua package on the system
find_package(Lua)

# If Lua was found and target is not set up
if(Lua_FOUND AND NOT TARGET Lua::Lua)
  # Setup Lua library target
  add_library(Lua::Lua INTERFACE IMPORTED)

  # Set include directories
  target_include_directories(
    Lua::Lua
    INTERFACE "${LUA_INCLUDE_DIR}")
endif()

# Link Lua library to the executable
target_link_libraries(
  ProgramName
  PRIVATE Lua::Lua)
