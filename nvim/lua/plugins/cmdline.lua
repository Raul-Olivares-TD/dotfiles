-- Activa el sistema de mensajes y línea de comandos ui2 de Neovim 0.12.
-- No viene activado por defecto; hay que encenderlo explícitamente.
require("vim._core.ui2").enable({})

-- tiny-cmdline: muestra la línea de comandos como una ventana flotante centrada.
-- Usa ui2, así que debe cargarse después de activarlo.
require("tiny-cmdline").setup({})
