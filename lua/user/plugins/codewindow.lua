return {
    'gorbit99/codewindow.nvim',
    config = function()
      local codewindow = require('codewindow')
      codewindow.setup({
        minimap_width = 15
      })
      codewindow.apply_default_keybinds()
    end,
  }