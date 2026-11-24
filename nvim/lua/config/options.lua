-- Tecla líder: prefijo de nuestros atajos propios.
-- Debe definirse antes de cargar plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.ignorecase = true
opt.smartcase = true
opt.undofile = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.timeoutlen = 300  -- ms que espera Neovim antes de mostrar el menú de atajos
opt.cmdheight = 0  -- sin línea fija abajo; mensajes y cmdline flotan (requiere ui2)
opt.autoread = true
vim.g.copilot_no_tab_map = true  -- Copilot no usará Tab; lo aceptamos con Alt+l

-- Terminal: usar PowerShell 7 con el perfil personal.
-- exepath busca pwsh en el PATH y devuelve la ruta completa; si no lo encuentra, se queda el shell por defecto.
local pwsh = vim.fn.exepath("pwsh")
if pwsh ~= "" then
  opt.shell = pwsh
  -- Para los comandos ! de Neovim, sin cargar el perfil (más rápido).
  opt.shellcmdflag = "-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command"
end
