-- Transparencia: quita el color de fondo de los grupos de interfaz para que
-- se vea el fondo de Windows Terminal. Mantiene la selección y la línea del cursor.
local M = {}

-- Grupos que nunca se hacen transparentes, porque necesitan fondo para verse.
local keep = {
  Visual = true,
  CursorLine = true,
  ColorColumn = true,
  Search = true,
  IncSearch = true,
  CurSearch = true,
}

-- Patrones de nombres de grupo que sí se hacen transparentes.
local patterns = {
  "^Normal",       -- texto normal, flotantes y ventanas inactivas
  "Float",         -- ventanas flotantes y bordes
  "^SignColumn",   -- columna de signos (git, diagnósticos)
  "^EndOfBuffer",  -- líneas vacías al final del archivo
  "^LineNr",       -- números de línea
  "^Fold",         -- pliegues
  "^Snacks",       -- picker, explorador y ventanas de snacks
  "^GrugFar",      -- panel de grug-far
  "^BufferLine",   -- pestañas de bufferline
  "^Oil",          -- explorador oil
  "^TabLine",      -- pestañas nativas de Vim
  "^Whichkey",     -- menú de which-key
  "^Notify",       -- notificaciones
}

local function matches(name)
  for _, pattern in ipairs(patterns) do
    if name:find(pattern) then
      return true
    end
  end
  return false
end

function M.apply()
  for name, attrs in pairs(vim.api.nvim_get_hl(0, {})) do
    -- Los grupos enlazados (link) no tienen color propio: los dejamos como están.
    if not keep[name] and not attrs.link and matches(name) then
      attrs.bg = "none"
      attrs.ctermbg = nil
      vim.api.nvim_set_hl(0, name, attrs)
    end
  end
end

-- Se vuelve a aplicar cada vez que cambia el tema, porque el tema
-- redefine los colores de fondo.
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function() M.apply() end,
})

return M
