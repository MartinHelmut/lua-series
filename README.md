# Lua series

This is the companion repository for my [Lua series on my Blog](https://martin-fieber.de/series/lua/). Specifically for the second article: [Create, publish, and integrate dependencies in Lua](https://martin-fieber.de/blog/create-publish-integrate-dependencies-in-lua/).

The `main` branch is the latest iteration of the series. Every article has its own branch, based on what part it is. The first one being `part-1` and so on.

## Requirements

- [Lua](http://www.lua.org), version 5.1 or up
- [LuaRocks](https://luarocks.org), any recent version supporting Lua 5.1 and up, e.g. 3.9

How to get Lua and LuaRocks is in detail covered in [the first article of the Lua series](https://martin-fieber.de/blog/lua-project-setup-with-luarocks/).

- [direnv](https://direnv.net) is optional, but very helpful

## Setup and run

### With direnv

After cloning the repo and entering the project folder, load the project environment context with `direnv allow`, and install all dependencies.

```shell
direnv allow  # Only needed once
luarocks install --deps-only lua-series-dev-1.rockspec
```

Now you can run any script from the project.

```shell
$ lua src/main.lua
{ "Hello, reader.", 42 }
```

### Without direnv

After cloning the repo and entering the project folder install all dependencies.

```shell
luarocks install --deps-only lua-series-dev-1.rockspec
```

When running any script from the project you also need to load the setup module.

```shell
$ lua -lsrc/setup src/main.lua
{ "Hello, reader.", 42 }
```
