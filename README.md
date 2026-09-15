# gelato.nvim

A warm, dark Base24 colorscheme for Neovim, rendered by
[tinted-nvim](https://github.com/tinted-theming/tinted-nvim).

## Installation

With [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
  "cocoix/gelato.nvim",
  lazy = false,
  priority = 1000,
  dependencies = {
    "tinted-theming/tinted-nvim",
  },
  config = function()
    vim.cmd.colorscheme("gelato")
  end,
}
```

For Neovim's built-in package manager:

```lua
vim.pack.add({
  "https://github.com/tinted-theming/tinted-nvim",
  "https://github.com/cocoix/gelato.nvim",
})
vim.cmd.colorscheme("gelato")
```

## Configuration

Call `setup()` before applying the colorscheme. Rendering options are passed to
tinted-nvim; Gelato keeps ownership of the palette and scheme selection.

```lua
require("gelato").setup({
  compile = true,
  ui = {
    transparent = true,
  },
  styles = {
    comments = { italic = false },
  },
  highlights = {
    overrides = function(palette)
      return {
        FloatBorder = { fg = palette.base0D },
      }
    end,
  },
})

vim.cmd.colorscheme("gelato")
```

The `default_scheme`, `apply_scheme_on_startup`, and `selector.enabled` options
are managed by gelato.nvim. Other tinted-nvim options, including capabilities,
styles, integrations, highlight overrides, and compilation, are supported.

When using lualine, select its tinted theme:

```lua
require("lualine").setup({
  options = { theme = "tinted" },
})
```

## Palette

The Lua palette in `lua/gelato/palette.lua` is the single source of truth and
contains all Base24 colors from `base00` through `base17`.

## Development

Run the headless checks with the repository paths for Gelato and tinted-nvim:

```sh
GELATO_NVIM_ROOT="$PWD" nvim --headless -u NONE \
  --cmd 'set runtimepath^=/path/to/tinted-nvim' \
  -l tests/headless.lua

GELATO_NVIM_ROOT="$PWD" nvim --headless -u NONE \
  --cmd 'set runtimepath^=/path/to/tinted-nvim' \
  -l tests/config.lua
```
