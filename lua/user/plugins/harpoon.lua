return {
  'ThePrimeagen/harpoon',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
  },
  config = function()
    require('harpoon').setup {}
    local mark = require 'harpoon.mark'
    local ui = require 'harpoon.ui'

    local set_nav_keymap = function(key, idx)
      vim.keymap.set('n', key, function()
        ui.nav_file(idx)
      end, { desc = 'Navigate to harpooned file ' .. idx })
    end

    vim.keymap.set('n', '<leader>h', mark.add_file, { desc = 'Harpoon this file' })
    vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu, { desc = 'Toggle Harpoon menu' })

    set_nav_keymap('<C-1>', 1)
    set_nav_keymap('<C-2>', 2)
    set_nav_keymap('<C-3>', 3)
    set_nav_keymap('<C-4>', 4)
  end,
}
