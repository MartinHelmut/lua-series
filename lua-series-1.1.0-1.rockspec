rockspec_format = "3.0"
package = "lua-series"
version = "1.1.0-1"
source = {
   url = "git+https://github.com/MartinHelmut/lua-series",
   tag = "v1.1.0"
}
description = {
   summary = "The companion repository to my Lua blog series.",
   detailed = [[
        This package is for educational purposes and contains only some test
        code for my Lua series of articles.
    ]],
   homepage = "https://martin-fieber.de/series/lua/",
   license = "MIT",
   issues_url = "https://github.com/MartinHelmut/lua-series/issues",
   labels = {
      "lua-series",
      "educational"
   },
   maintainer = "Martin Helmut Fieber <info@martin-fieber.se>"
}
dependencies = {
   "lua >= 5.1, < 5.5",
   "inspect >= 3.1"
}
build = {
   type = "builtin",
   modules = {
      ["lua-series"] = "src/main.lua"
   },
   copy_directories = {
      "doc"
   }
}
test_dependencies = {
   "luaunit >= 3.4"
}
