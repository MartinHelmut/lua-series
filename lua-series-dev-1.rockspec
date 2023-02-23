package = "lua-series"
version = "dev-1"
source = {
   url = "https://github.com/MartinHelmut/lua-series.git"
}
description = {
   summary = "The companion repository to my Lua blog series.",
   homepage = "https://martin-fieber.de/series/lua/",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "inspect >= 3.1"
}
build = {
   type = "builtin",
   modules = {
      main = "src/main.lua"
   }
}
