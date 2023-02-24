rockspec_format = "3.0"
package = "lua-series"
version = "dev-1"
source = {
    url = "https://github.com/MartinHelmut/lua-series.git"
}
description = {
    summary = "The companion repository to my Lua blog series.",
    homepage = "https://martin-fieber.de/series/lua/",
    issues_url = "https://github.com/MartinHelmut/lua-series/issues",
    license = "MIT",
    maintainer = "Martin Helmut Fieber <info@martin-fieber.se>"
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
