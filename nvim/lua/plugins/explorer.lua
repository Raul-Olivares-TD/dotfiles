-- Iconos para oil (y para otros plugins que los usen).
require("mini.icons").setup()

-- oil: el directorio se muestra como un buffer de texto.
-- Puedes moverte con las teclas normales y editar nombres o borrar líneas.
require("oil").setup({
  -- Muestra los archivos ocultos (los que empiezan por punto, como .gitignore)
  view_options = {
    show_hidden = true,
  },
})
