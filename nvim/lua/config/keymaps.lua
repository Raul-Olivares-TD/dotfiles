-- Atajos propios. Se cargan después de los plugins, porque algunos
-- atajos llaman a funciones que solo existen cuando el plugin está cargado.
local map = vim.keymap.set

-- Buscar archivos por nombre (equivalente a Doble Shift / Ctrl+N en PyCharm)
map("n", "<leader>ff", function() Snacks.picker.files() end, { desc = "Buscar archivos" })

-- Buscar texto dentro de los archivos (equivalente a Ctrl+Shift+F)
map("n", "<leader>fg", function() Snacks.picker.grep() end, { desc = "Buscar en proyecto" })

-- Buscar en los buffers abiertos
map("n", "<leader>fb", function() Snacks.picker.buffers() end, { desc = "Buffers abiertos" })

-- Explorador de archivos (oil). Abre el directorio del archivo actual.
map("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Explorador de archivos" })
map("n", "-", "<cmd>Oil<cr>", { desc = "Abrir directorio padre" })

-- Git (gitsigns). "g" de git, después la acción.
map("n", "]c", function() require("gitsigns").nav_hunk("next") end, { desc = "Siguiente cambio" })
map("n", "[c", function() require("gitsigns").nav_hunk("prev") end, { desc = "Cambio anterior" })
map("n", "<leader>gh", function() require("gitsigns").stage_hunk() end, { desc = "Preparar cambio (stage)" })
map("n", "<leader>gr", function() require("gitsigns").reset_hunk() end, { desc = "Descartar cambio" })
map("n", "<leader>gp", function() require("gitsigns").preview_hunk() end, { desc = "Ver cambio" })
map("n", "<leader>gb", function() require("gitsigns").blame_line() end, { desc = "Blame de la línea" })

-- Lazygit en una ventana flotante. "g" de git, "g" de lazygit.
map("n", "<leader>gg", function() Snacks.lazygit() end, { desc = "Lazygit" })

-- Buscar y reemplazar en el proyecto (grug-far).
-- "s" de search, "r" de replace.
map("n", "<leader>sr", "<cmd>GrugFar<cr>", { desc = "Buscar y reemplazar" })

-- Lo mismo, con la palabra bajo el cursor ya escrita en el campo de búsqueda.
map("n", "<leader>sw", function()
  require("grug-far").open({
    prefills = { search = vim.fn.expand("<cword>") },
  })
end, { desc = "Buscar palabra bajo el cursor" })

-- Formatear el archivo actual a mano. "c" de código, "f" de formatear.
map("n", "<leader>cf", function() require("conform").format({ async = true }) end, { desc = "Formatear archivo" })

-- Moverse entre archivos abiertos (bufferline).
map("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Archivo siguiente" })
map("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Archivo anterior" })

-- Cerrar el archivo actual, sin cerrar la ventana.
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Cerrar archivo" })

-- Terminal (snacks). "t" de terminal.
map("n", "<leader>tt", function() Snacks.terminal.toggle() end, { desc = "Abrir o cerrar terminal" })

-- Salir del modo terminal a modo normal con doble Esc.
-- En la terminal, Esc solo no basta: lo usan programas como vim, por eso el doble.
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Salir del modo terminal" })

-- Tareas (overseer). "t" de tareas.
map("n", "<leader>tr", function()
  vim.cmd("OverseerRunCmd python " .. vim.fn.expand("%:p"))
end, { desc = "Ejecutar archivo Python" })
map("n", "<leader>to", "<cmd>OverseerToggle<cr>", { desc = "Panel de tareas" })

-- Apariencia. "u" de UI.
map("n", "<leader>ut", "<cmd>Theme<cr>", { desc = "Elegir tema" })

-- Movimiento rápido con la tecla líder. Funcionan en normal y en visual.
map({ "n", "v" }, "<leader>h", "0", { desc = "Inicio de la frase" })
map({ "n", "v" }, "<leader>l", "$", { desc = "Final de la línea" })
map({ "n", "v" }, "<leader>k", "gg", { desc = "Inicio del archivo" })
map({ "n", "v" }, "<leader>j", "G", { desc = "Final del archivo" })

-- Seleccionar todo el archivo: "v" de visual, "a" de all.
map("n", "<leader>va", "ggVG", { desc = "Seleccionar todo el archivo" })

-- Splits de Ventanas. "w" de ventanas.
map("n", "<leader>wv", "<cmd>vsplit<cr>", { desc = "Dividir en vertical" })
map("n", "<leader>wh", "<cmd>split<cr>", { desc = "Dividir en horizontal" })
map("n", "<leader>wq", "<cmd>close<cr>", { desc = "Cerrar ventana" })
map("n", "<leader>wo", "<cmd>only<cr>", { desc = "Cerrar las demás ventanas" })
map("n", "<leader>w=", "<C-w>=", { desc = "Igualar tamaños" })

-- Moverse entre ventanas con Ctrl + h/j/k/l, solo en modo normal.
-- Solo en "n": así no interfieren con el borrado al escribir (modo insertar).
map("n", "<C-h>", "<C-w>h", { desc = "Ventana izquierda" })
map("n", "<C-j>", "<C-w>j", { desc = "Ventana de abajo" })
map("n", "<C-k>", "<C-w>k", { desc = "Ventana de arriba" })
map("n", "<C-l>", "<C-w>l", { desc = "Ventana derecha" })

-- Mover la línea actual arriba o abajo. Alt+j / Alt+k, en modo normal.
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Mover línea abajo" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Mover línea arriba" })
-- Mover la selección completa abajo / arriba en visual (v), visual de línea (V) y bloque.
-- ":m '>+1" mueve el bloque seleccionado una línea abajo; "gv=gv" mantiene la selección
-- y vuelve a indentar.
map("x", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Mover selección abajo" })
map("x", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Mover selección arriba" })

-- Pestañas nativas de Vim (espacios de trabajo). "t" de tab.
map("n", "<leader>tn", "<cmd>tabnew<cr>", { desc = "Nueva pestaña" })
map("n", "<leader>tq", "<cmd>tabclose<cr>", { desc = "Cerrar pestaña" })

-- Nuevo buffer vacío (pestaña nueva en bufferline). "b" de buffer, "n" de nuevo.
map("n", "<leader>bn", "<cmd>enew<cr>", { desc = "Nuevo archivo vacío" })

-- Shift+Tab en modo insertar: si el menú de autocompletado está abierto, sube por
-- las sugerencias; si no, quita una indentación (4 espacios, según shiftwidth).
map("i", "<S-Tab>", function()
  local ok, blink = pcall(require, "blink.cmp")
  if ok and blink.is_visible() then
    blink.select_prev()
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-d>", true, false, true), "n", false)
  end
end, { desc = "Quitar indentación / subir en el menú" })

-- Tab y Shift+Tab en visual (v) y visual de línea (V) y bloque: indentan o desindentan la selección.
-- "gv" restaura la selección después de indentar, así puedes pulsar Tab varias veces seguidas.
map("x", "<Tab>", ">gv", { desc = "Indentar selección" })
map("x", "<S-Tab>", "<gv", { desc = "Desindentar selección" })
map("n", "<Tab>", ">gv", { desc = "Indentar selección" })
map("n", "<S-Tab>", "<gv", { desc = "Desindentar selección" })

-- Comentar con Ctrl+/ (algunas terminales lo envían como Ctrl+_).
-- remap = true es necesario porque "gcc" y "gc" son mapeos nativos.
map("n", "<C-_>", "gcc", { remap = true, desc = "Comentar línea" })
map("n", "<C-/>", "gcc", { remap = true, desc = "Comentar línea" })
map("x", "<C-_>", "gc", { remap = true, desc = "Comentar selección" })
map("x", "<C-/>", "gc", { remap = true, desc = "Comentar selección" })

-- Comprueba si los archivos cambiaron en disco (por Antigravity u otra herramienta).
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- Revisión de cambios con diffview. "g" de git.
map("n", "<leader>gd", "<cmd>DiffviewOpen<cr>", { desc = "Ver todos los cambios" })
map("n", "<leader>gc", "<cmd>DiffviewClose<cr>", { desc = "Cerrar revisión de cambios" })
map("n", "<leader>gl", "<cmd>DiffviewFileHistory %<cr>", { desc = "Historial del archivo" })

-- Terminal a pantalla completa en la ventana actual, sin split.
-- Usa el shell configurado (PowerShell 7 con tu perfil).
map("n", "<leader>tf", function()
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { desc = "Terminal en esta ventana" })

-- Redimensionar ventanas con la tecla líder (grupo "Ventanas").
map("n", "<leader>w+", "<C-w>+", { desc = "Aumentar altura" })
map("n", "<leader>w-", "<C-w>-", { desc = "Reducir altura" })
map("n", "<leader>w>", "<C-w>>", { desc = "Aumentar anchura" })
map("n", "<leader>w<", "<C-w><", { desc = "Reducir anchura" })

-- Duplicar línea o selección debajo. ":t." copia la línea actual debajo de sí misma;
-- ":t'>" copia el bloque seleccionado debajo de su última línea.
map("n", "<A-S-j>", "<cmd>t.<cr>", { desc = "Duplicar línea abajo" })
map("x", "<A-S-j>", ":t'><cr>gv", { desc = "Duplicar selección abajo" })

-- Aceptar la sugerencia de Copilot en modo insertar con Alt+l.
map("i", "<A-l>", 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Aceptar sugerencia de Copilot",
})


