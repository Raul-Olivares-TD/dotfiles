-- which-key: muestra los atajos disponibles tras pulsar la tecla líder.
local wk = require("which-key")

wk.setup({})

-- Nombres para los grupos de atajos. Así el menú dice "Buscar" en lugar de "+prefix".
wk.add({
  { "<leader>c", group = "Código" },
  { "<leader>f", group = "Buscar archivos" },
  { "<leader>g", group = "Git" },
  { "<leader>s", group = "Buscar en proyecto" },
  { "<leader>b", group = "Buffers" },
  { "<leader>t", group = "Terminal y tareas" },
  { "<leader>u", group = "Apariencia" },
  { "<leader>w", group = "Ventanas" },
})

require("bufferline").setup({
  options = {
    diagnostics = "nvim_lsp",
    -- Forma de las separaciones entre pestañas. "thin" es una línea fina,
    -- más sobria que las flechas por defecto.
    separator_style = "thin",
    offsets = {
      { filetype = "oil", text = "Explorador", text_align = "left" },
    },
  },
})

-- Colores de las pestañas: enlazamos cada parte a un grupo estándar de Neovim.
-- Así siguen al tema activo, en lugar de usar colores fijos de bufferline.
vim.api.nvim_set_hl(0, "BufferLineFill", { link = "TabLineFill" })
vim.api.nvim_set_hl(0, "BufferLineBackground", { link = "TabLine" })
vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { link = "TabLine" })
vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { link = "TabLineSel" })
