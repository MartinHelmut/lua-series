#include <print>

#include <lua.hpp>

// === Setup built-in function override ===

// Hold reference to built-in `type` function
static int type_ref;

int lua_type(lua_State *L) {
  // When `type` is called the function argument
  // is on top of the stack at -1.
  if (lua_isuserdata(L, -1)) {
    // From the passed argument, get the meta field `__name`.
    if (luaL_getmetafield(L, -1, "__name") != LUA_TNIL) {
      // Now the fields value is on top of the stack at -1.
      const std::string name = lua_tostring(L, -1);
      if (!name.empty()) {
        // Push the name as return argument to the `type` call.
        lua_pushlstring(L, name.c_str(), name.size());
        return 1;
      }
    }
  }

  // If it's not user data, get built-in `type` function.
  lua_rawgeti(L, LUA_REGISTRYINDEX, type_ref);

  // Call the built-in `type` function with the
  // passed argument pushed.
  lua_pushvalue(L, -1);
  lua_call(L, -1, -1);

  return 1;
}

void setup_type_override(lua_State *L) {
  // Get global function `type` on top of the stack.
  if (lua_getglobal(L, "type") != LUA_TNIL) {
    // Get a referece to the type function from the registry.
    type_ref = luaL_ref(L, LUA_REGISTRYINDEX);

    // Register custom `type` override
    lua_register(L, "type", lua_type);
  }
}

// === Setup Example GameData module ===

struct GameData {
  int state{0};
};

int GameData_new(lua_State *L) {
  auto *game_data =
      static_cast<GameData *>(lua_newuserdata(L, sizeof(GameData)));
  luaL_setmetatable(L, "GameData");
  return 1;
}

const luaL_Reg game_data_lib[] = {
    {"new", GameData_new},
    {nullptr, nullptr},
};

int open_GameData(lua_State *L) {
  luaL_newmetatable(L, "GameData");
  luaL_newlib(L, game_data_lib);
  return 1;
}

// === Main ===

int main() {
  lua_State *L = luaL_newstate();
  luaL_openlibs(L);

  // Set up type override
  setup_type_override(L);

  // Example custom module
  luaL_requiref(L, "GameData", open_GameData, 0);

  if (luaL_dofile(L, "./script.lua") == LUA_OK) {
    std::print("Done\n");
  } else {
    std::print("Error reading configuration file:\n");
    luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
  }

  lua_close(L);

  return 0;
}
