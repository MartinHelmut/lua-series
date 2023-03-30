rockspec_format = "3.0"
package = "lua-series"
version = "1.0.0-1"
source = {
    url = "git+https://github.com/MartinHelmut/lua-series",
    tag = "v1.0.0"
}
description = {
    summary = "The companion repository to my Lua blog series.",
    detailed = [[
        This package is for educational purposes and contains only some test
        code for my Lua series of articles.
    ]],
    license = "MIT",
    homepage = "https://martin-fieber.de/series/lua/",
    issues_url = "https://github.com/MartinHelmut/lua-series/issues",
    maintainer = "Martin Helmut Fieber <info@martin-fieber.se>",
    labels = { "lua-series", "educational" }
}
dependencies = {
    "lua >= 5.1, < 5.5",
    "inspect >= 3.1"
}
test_dependencies = {
	"luaunit >= 3.4"
}
build = {
    type = "builtin",
    copy_directories = { "doc" },
    modules = {
        main = "src/main.lua"
    }
}
