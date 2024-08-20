return {
  'stevearc/oil.nvim',
  enabled = true,
  opts = {},
  -- Optional dependencies
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    require('oil').setup {
      skip_confirm_for_simple_edits = true,
      natural_order = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name, _)
          return name == '.git'
        end,
      },
      keymaps = {
        ['q'] = 'actions.close',
      },
    }
    vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
  end,
}
