#include <print>

#include <lua.hpp>

int on_error(lua_State *L) {
  // Get error message from top of the stack and remove it.
  const char *err = lua_tostring(L, -1);
  lua_remove(L, -1);

  // Push the traceback on top of the stack
  luaL_traceback(L, L, err, 1);

  return 1;
}

int main() {
  // Open Lua state
  lua_State *L = luaL_newstate();

  // Load and run file
  if (luaL_dofile(L, "./script.lua") == LUA_OK) {

    // === Call Lua function ===

    // Get the global some_fn function on top of the stack
    lua_getglobal(L, "some_fn");

    // Check if there is a function on top of the stack
    if (lua_isfunction(L, -1)) {
      // Push both function arguments on the stack
      lua_pushnumber(L, 13);
      lua_pushnumber(L, 23);

      constexpr int arguments_count = 2;
      constexpr int returnvalues_count = 2;

      // Protected call, returns a status int
      int status = lua_pcall(L, arguments_count, returnvalues_count, 0);

      // If everything was good:
      if (status == LUA_OK) {
        // Read the first return value
        lua_Number result1 = lua_tonumber(L, -2);

        // Read the second return value
        bool result2 = lua_toboolean(L, -1);

        std::print("result1 = {}\n", result1);
        std::print("result2 = {}\n", result2);
      }
    }

    // === Protected call with message handler ===

    // Get top of the stack to restore later
    const int top_index = lua_gettop(L);

    // Push message handler on top of the stack
    lua_pushcfunction(L, on_error);

    // Get message handler index for `lua_pcall`
    const int handler_index = lua_gettop(L);

    // Get the global some_fn function on top of the stack
    lua_getglobal(L, "some_fn");

    // Check if there is a function on top of the stack
    if (lua_isfunction(L, -1)) {
      // Push wrong arguments that will invoke an error
      lua_pushnumber(L, 13);
      lua_pushliteral(L, "23");

      constexpr int arguments_count = 2;
      constexpr int returnvalues_count = 2;

      // Protected call, returns a status int
      int status =
          lua_pcall(L, arguments_count, returnvalues_count, handler_index);

      // An error occured!
      if (status == LUA_ERRRUN) {
        // Get the error message from the top of the stack
        const char *err = lua_tostring(L, -1);

        std::print("Error = {}\n", err);

        // After the error is handled, pop it from the stack.
        lua_pop(L, 1);
      }
    }

    // Restore stack when done
    lua_settop(L, top_index);

  } else {
    // On error reading the file, an error message
    // will be on top of the stack.
    std::print("Error reading configuration file:\n");
    luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
  }

  lua_close(L);

  return 0;
}
