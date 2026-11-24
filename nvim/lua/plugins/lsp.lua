-- Mason: instala los servidores y herramientas en una carpeta propia de Neovim.
require("mason").setup()

vim.lsp.config("basedpyright", {
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "standard",
      },
    },
  },
})

-- Activa los servidores que queremos para Python.
-- Neovim busca la configuración de cada uno en el catálogo de nvim-lspconfig.
vim.lsp.enable({ "basedpyright", "ruff" })

-- Este bloque se ejecuta cada vez que un servidor se conecta a un buffer.
-- Así los atajos solo existen donde hay un servidor activo.
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)

    -- ruff analiza estilo, pero el "hover" (K) lo da mejor basedpyright.
    -- Lo desactivamos en ruff para que no haya dos ventanas distintas.
    if client and client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    local map = function(keys, fn, desc)
      vim.keymap.set("n", keys, fn, { buffer = event.buf, desc = desc })
    end

    map("<leader>ca", vim.lsp.buf.code_action, "Acciones de código")
    map("<leader>cr", vim.lsp.buf.rename, "Renombrar símbolo")
    map("<leader>cd", vim.diagnostic.open_float, "Ver error de la línea")
  end,
})
