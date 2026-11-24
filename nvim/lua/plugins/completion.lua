-- blink.cmp con el matcher en Lua: no necesita compilar ni descargar nada,
-- así que no bloquea el arranque.
local ok, cmp = pcall(require, "blink.cmp")
if not ok then
  return
end

cmp.setup({
  -- Ctrl+y acepta, Ctrl+Space abre el menú, flechas o Ctrl+n/Ctrl+p navegan, Ctrl+e cierra.
  keymap = { preset = "enter" },
  appearance = { nerd_font_variant = "mono" },
  completion = {
    documentation = { auto_show = true },
  },
  sources = {
    default = { "lsp", "path", "snippets", "buffer" },
  },
  -- "lua" evita el binario en Rust. Es algo menos rápido, pero sin dependencias externas.
  fuzzy = { implementation = "lua" },
})
