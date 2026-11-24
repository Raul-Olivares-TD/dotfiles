-- rustaceanvim gestiona rust-analyzer directamente.
-- No añadas rust_analyzer a vim.lsp.enable ni a nvim-lspconfig: causaría conflictos.
vim.g.rustaceanvim = {
  server = {
    on_attach = function(_, bufnr)
      local map = function(keys, fn, desc)
        vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
      end

      -- Rust. "r" de Rust.
      map("<leader>rr", function() vim.cmd.RustLsp("runnables") end, "Rust: ejecutar")
      map("<leader>rt", function() vim.cmd.RustLsp("testables") end, "Rust: tests")
      map("<leader>ra", function() vim.cmd.RustLsp("codeAction") end, "Rust: acciones de código")
      map("<leader>rc", function() vim.cmd.RustLsp("openCargo") end, "Rust: abrir Cargo.toml")
    end,
  },
}
