package = "lua-series"
version = "dev-1"
source = {
   url = "https://github.com/MartinHelmut/lua-series.git"
}
description = {
   homepage = "https://martin-fieber.de/series/lua/",
   license = "MIT"
}
dependencies = {
   "lua >= 5.1, < 5.5"
}
build = {
   type = "builtin",
   modules = {
      main = "src/main.lua"
   }
}
