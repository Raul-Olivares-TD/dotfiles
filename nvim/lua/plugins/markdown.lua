-- Activa el resaltado de treesitter en los lenguajes que usamos.
-- Usa la API nativa de Neovim: no hace falta configurar nada más en nvim-treesitter.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "python", "rust" },
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- render-markdown: muestra el Markdown con formato. Usa mini.icons para los iconos.
require("render-markdown").setup({
  file_types = { "markdown" },
  -- "n" y "c" muestran el formato; en insertar se ve el texto en bruto.
  render_modes = { "n", "c" },
})
