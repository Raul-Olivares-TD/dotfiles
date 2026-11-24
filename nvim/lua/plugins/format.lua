-- conform: formatea el archivo al guardar, con el formateador de cada lenguaje.
require("conform").setup({
  formatters_by_ft = {
    python = { "ruff_format" },
  },
  -- Si el formateador falla o no existe, intenta el formateo del servidor de lenguaje.
  format_on_save = {
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
})
