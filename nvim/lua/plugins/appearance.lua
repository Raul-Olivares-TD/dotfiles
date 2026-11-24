local neotheme = require("neotheme")

-- Kanagawa: sin cursivas ni negritas. setup debe llamarse antes de aplicar el tema.
pcall(function()
  require("kanagawa").setup({
    commentStyle = { italic = false },
    keywordStyle = { italic = false },
    variablebuiltinStyle = { italic = false },
    statementStyle = { bold = false },
    functionStyle = {},
    typeStyle = {},
  })
end)

local state_dir = vim.fn.stdpath("state")
local state_file = state_dir .. "/theme.txt"

local state_dir = vim.fn.stdpath("state")
local state_file = state_dir .. "/theme.txt"

-- Temas de otros plugins, agrupados por etiqueta. Si un nombre no existe, se ignora.
local others = {
  { label = "tokyo", names = { "tokyonight-night", "tokyonight-storm", "tokyonight-moon", "tokyonight-day" } },
  { label = "catppuccin", names = { "catppuccin-mocha", "catppuccin-macchiato", "catppuccin-frappe", "catppuccin-latte" } },
  { label = "kanagawa", names = { "kanagawa-wave", "kanagawa-dragon", "kanagawa-lotus" } },
}

-- Lista unificada: cada variante de neotheme con su familia, y las de Tokyo Night.
local function build_items()
  local items = {}

  -- Todas las variantes de neotheme, agrupadas por familia.
  for _, family in ipairs(neotheme.families()) do
    for _, name in ipairs(neotheme.themes(family)) do
      table.insert(items, { text = family .. " · " .. name, kind = "neotheme", name = name })
    end
  end

  -- Temas de otros plugins (Tokyo Night, Catppuccin...).
  for _, group in ipairs(others) do
    for _, name in ipairs(group.names) do
      table.insert(items, { text = group.label .. " · " .. name, kind = "colorscheme", name = name })
    end
  end

  return items
end

-- Aplica un elemento de la lista. Devuelve true si funcionó.
local function apply(item)
  local ok, err = pcall(function()
    if item.kind == "neotheme" then
      vim.cmd.colorscheme("neotheme")
      neotheme.switch(item.name)
    else
      vim.cmd.colorscheme(item.name)
    end
  end)
  if not ok then
    vim.notify("No se pudo aplicar " .. item.name .. ": " .. tostring(err), vim.log.levels.WARN)
  end
  require("config.transparency").apply()
  return ok
end

-- Guardar y leer la elección como "tipo:nombre".
local function encode(item) return item.kind .. ":" .. item.name end

local function decode(line)
  local kind, name = line:match("^(%w+):(.+)$")
  if not kind then return nil end
  return { kind = kind, name = name }
end

local function load_saved()
  local f = io.open(state_file, "r")
  if not f then return nil end
  local line = f:read("*l")
  f:close()
  return line and decode(line) or nil
end

local function save(item)
  vim.fn.mkdir(state_dir, "p")
  local f = io.open(state_file, "w")
  if f then
    f:write(encode(item))
    f:close()
  end
end

-- Arranque: configura neotheme y aplica el tema guardado (o el de por defecto).
local default = { kind = "neotheme", name = "gruber-dark-muted" }
local saved = load_saved() or default
local baseline = saved.kind == "neotheme" and { theme = saved.name } or {}
if not pcall(neotheme.setup, baseline) then
  neotheme.setup({})
end
if not apply(saved) then
  apply(default)
  saved = default
end

-- Tema activo, para poder volver a él si cancelas el selector.
local current = saved

-- Selector con vista previa: al moverte por la lista, el tema cambia en vivo.
local function pick_theme()
  local confirmed = false
  local closed = false
  local before = current

  Snacks.picker.pick({
    title = "Temas",
    items = build_items(),
    -- Muestra el campo "text" de cada elemento, sin intentar tratarlos como archivos.
    format = "text",
    -- No hay archivo que previsualizar: el propio tema es la vista previa.
    preview = "none",
    on_change = function(_, item)
      if item and not confirmed and not closed then
        apply(item)
      end
    end,
    confirm = function(picker, item)
      confirmed = true
      picker:close()
      if item and apply(item) then
        current = item
        save(item)
      end
    end,
    on_close = function()
      closed = true
      if not confirmed then
        apply(before)
      end
    end,
  })
end

vim.api.nvim_create_user_command("Theme", pick_theme, {})
