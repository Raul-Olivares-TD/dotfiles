-- lualine: barra de estado con modo, rama de git, cambios, archivo, errores y posición.
require("lualine").setup({
  options = {
    theme = "auto",       -- toma los colores del tema activo (neotheme)
    globalstatus = true,  -- una sola barra abajo, en lugar de una por ventana
    -- Separadores con forma de flecha. Necesitan una Nerd Font.
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_a = { "mode" },                          -- NORMAL, INSERT, VISUAL...
    lualine_b = { "branch", "diff" },                -- rama de git y líneas añadidas/quitadas
    lualine_c = { { "filename", path = 1 } },        -- ruta relativa al proyecto
    lualine_x = { "diagnostics", "filetype" },       -- errores de LSP y tipo de archivo
    lualine_y = { "progress" },                      -- posición en el archivo (%)
    lualine_z = { "location" },                      -- línea:columna
  },
})
