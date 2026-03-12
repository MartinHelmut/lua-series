#include <print>

#include <lua.hpp>

int compute(lua_State *L) {
  // Function arguments are on the stack in reverse order
  lua_Number arg_2 = lua_tonumber(L, -1);
  lua_Number arg_1 = lua_tonumber(L, -2);

  // First return value pushed to the stack
  lua_pushnumber(L, arg_2 + arg_1);

  // A second return value
  lua_pushnumber(L, arg_2 * arg_1);

  // Return number of Lua function return values
  return 2;
}

int main() {

  // Open Lua state
  lua_State *L = luaL_newstate();
  luaL_openlibs(L);

  // Setup function before running the script
  lua_pushcfunction(L, compute);
  lua_setglobal(L, "compute");

  // Load and run file
  if (luaL_dofile(L, "./script.lua") == LUA_OK) {

    // This will be printed after the Lua is done
    std::print("Done\n");

  } else {
    // On error reading the file, an error message
    // will be on top of the stack.
    std::print("Error reading configuration file:\n");
    luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
  }

  lua_close(L);

  return 0;
}
