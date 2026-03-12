#include <print>

#include <lua.hpp>

struct GameData {
  const char *name;
  int amount{0};
};

// A new function to be used when constructing
// a new GameData table in Lua.
int GameData_new(lua_State *L) {
  // New user data from GameData
  auto *game_data =
      static_cast<GameData *>(lua_newuserdata(L, sizeof(GameData)));

  // Set up data from `new` function call in Lua.
  // On stack index -1 is the new user data located.
  game_data->amount = lua_tonumber(L, -2);
  game_data->name = lua_tostring(L, -3);

  // Set metatable to GameData
  luaL_setmetatable(L, "GameData");

  return 1;
}

// Meta method to read fields from Lua data
int GameData_index(lua_State *L) {
  // GameData is on top of the stack
  auto *game_data = static_cast<GameData *>(lua_touserdata(L, 1));

  // The key is at index 2. We only want to allow string indexing, so we'll use
  // checkstring:
  const std::string key = luaL_checkstring(L, 2);

  // Access to "name" field
  if (key == "name") {
    lua_pushstring(L, game_data->name);
    return 1;
  }

  // Access to "amount" field
  if (key == "amount") {
    lua_pushinteger(L, game_data->amount);
    return 1;
  }

  // Throw if field is not defined.
  luaL_error(L, "Unknown property access: %s", key.c_str());
  return 1;
}

// Meta method to write fields from Lua data
int GameData_newindex(lua_State *L) {
  auto *game_data = static_cast<GameData *>(lua_touserdata(L, 1));
  const std::string key = luaL_checkstring(L, 2);

  // Write to "name" field
  if (key == "name") {
    game_data->name = luaL_checkstring(L, 3);
    return 1;
  }

  // Write to "amount" field
  if (key == "amount") {
    game_data->amount = luaL_checkinteger(L, 3);
    return 1;
  }

  luaL_error(L, "Unknown property access: %s", key.c_str());
  return 1;
}

// Map out our metatable:
const luaL_Reg game_data_meta[] = {
    {"__index", GameData_index},
    {"__newindex", GameData_newindex},
    {nullptr, nullptr},
};

// A "registry" array to hold methods
// defined for the GameData module.
const luaL_Reg game_data_lib[] = {
    {"new", GameData_new},
    {nullptr, nullptr},
};

// A function to register the GameData module
int open_GameData(lua_State *L) {
  luaL_newmetatable(L, "GameData");
  luaL_setfuncs(L, game_data_meta, 0);

  luaL_newlib(L, game_data_lib);

  return 1;
}

int main() {
  // Open Lua state and standard library
  lua_State *L = luaL_newstate();
  luaL_openlibs(L);

  // Add GameData module for `require GameName`
  luaL_requiref(L, "GameData", open_GameData,
                0 // 0 = false do not create a global variable
  );

  // Load and run file
  if (luaL_dofile(L, "./script.lua") == LUA_OK) {
    std::print("Done\n");
  } else {
    std::print("Error reading configuration file:\n");
    luaL_error(L, "Error: %s\n", lua_tostring(L, -1));
  }

  lua_close(L);

  return 0;
}
