#include <print>

#include <lua.hpp>

int main() {
  // Open Lua state
  lua_State *L = luaL_newstate();

  // Load and run file
  if (luaL_dofile(L, "./config.lua") == LUA_OK) {

    // === Number ===

    // Get global variable "width" onto the top
    // of the stack.
    lua_getglobal(L, "width");

    // Check if the current value on the top of
    // the stack (-1) is a number.
    if (lua_isnumber(L, -1)) {
      // lua_Number == double
      lua_Number width = lua_tonumber(L, -1);

      std::print("width = {}\n", width);
    }

    // === Integer ===

    lua_getglobal(L, "height");
    if (lua_isinteger(L, -1)) {
      // lua_Integer == long long
      lua_Integer height = lua_tointeger(L, -1);
      std::print("height = {}\n", height);
    }

    // === Boolean ===

    lua_getglobal(L, "isResizable");
    if (lua_isboolean(L, -1)) {
      int isResizable = lua_toboolean(L, -1);
      std::print("isResizable = {}\n", static_cast<bool>(isResizable));
    }

    // === String ===

    lua_getglobal(L, "name");
    if (lua_isstring(L, -1)) {
      const char *name = lua_tostring(L, -1);
      std::print("name = '{}'\n", name);
    }

    // === Table ===

    // Get a table from global on the stack
    lua_getglobal(L, "labels");

    // Check if a table is on top of the stack
    if (lua_istable(L, -1)) {
      // Get one field from that table on top of the stack at `-1`
      lua_getfield(L, -1, "hello");
      const char *hello = lua_tostring(L, -1);

      // The previous field is now on top of the stack at `-1`
      // Get another field from the table at `-2` onto the stack
      lua_getfield(L, -2, "reader");
      const char *reader = lua_tostring(L, -1);

      std::print("From table 'labels' = '{}, {}!'\n", hello, reader);
    }

    // === Array ===

    // Get an array from global on the stack
    lua_getglobal(L, "numbers");

    // Arrays are also tables in Lua
    if (lua_istable(L, -1)) {
      // Get the first index from the array
      // on top of the stack at `-1`
      lua_geti(L, -1, 1);
      lua_Number first = lua_tonumber(L, -1);

      // The previous index is now on top of the stack at `-1`
      // Get the next index from the array at `-2` onto the stack
      lua_geti(L, -2, 2);
      lua_Number second = lua_tonumber(L, -1);

      // And so on ...
      lua_geti(L, -3, 3);
      lua_Number third = lua_tonumber(L, -1);

      std::print("Numbers = [{}, {}, {}]'\n", first, second, third);
    }

  } else {
    // On error reading the file, an error message
    // will be on top of the stack.
    std::print("Error reading configuration file:\n");
    luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
  }

  lua_close(L);

  return 0;
}
