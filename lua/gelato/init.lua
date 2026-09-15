local M = {}

local PUBLIC_NAME = "gelato"
local SCHEME_NAME = "base24-gelato"

local configured = false
local configured_options

local function tinted_nvim()
  local ok, tinted = pcall(require, "tinted-nvim")
  if not ok then
    error("gelato.nvim requires tinted-theming/tinted-nvim", 0)
  end
  return tinted
end

local function build_options(opts)
  local options = vim.deepcopy(opts or {})

  options.schemes = options.schemes or {}
  options.schemes[SCHEME_NAME] = vim.deepcopy(require("gelato.palette"))

  -- Gelato owns scheme selection. The remaining tinted-nvim options are
  -- deliberately passed through unchanged.
  options.default_scheme = SCHEME_NAME
  options.apply_scheme_on_startup = false
  options.selector = options.selector or {}
  options.selector.enabled = false

  return options
end

---Configure the tinted-nvim renderer without applying the colorscheme.
---@param opts? table tinted-nvim options
---@return table gelato
function M.setup(opts)
  local options = build_options(opts)

  if configured then
    if not vim.deep_equal(configured_options, options) then
      error("gelato.nvim is already configured; call setup() before loading the colorscheme", 0)
    end
    return M
  end

  tinted_nvim().setup(options)
  configured = true
  configured_options = options
  return M
end

---Internal colorscheme entrypoint.
function M._load()
  if not configured then
    M.setup()
  end

  tinted_nvim().load(SCHEME_NAME, { colorscheme_event = false })
  vim.g.colors_name = PUBLIC_NAME
end

return M
