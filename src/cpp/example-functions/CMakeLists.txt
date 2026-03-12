cmake_minimum_required(VERSION 3.18)

# Setup a CMake project for C++
project(
  LuaExampleFunctions
  VERSION 1.0
  LANGUAGES CXX)

# Add an executable based on one source file
add_executable(ProgramName main.cpp)

# Let's use C++23
target_compile_features(ProgramName PRIVATE cxx_std_23)

# Try to find the Lua package on the system
find_package(Lua REQUIRED)

# If Lua was found and target is not set up
if(Lua_FOUND AND NOT TARGET Lua::Lua)
  add_library(Lua::Lua INTERFACE IMPORTED)
  set_target_properties(
    Lua::Lua
    PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${LUA_INCLUDE_DIR}"
      INTERFACE_LINK_LIBRARIES "${LUA_LIBRARIES}"
  )
endif()

# Link Lua library to the executable
target_link_libraries(
  ProgramName
  PRIVATE Lua::Lua)
