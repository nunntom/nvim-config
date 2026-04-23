return {
  'kdheepak/lazygit.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>gg', '<cmd>LazyGit<CR>', { silent = true, desc = 'Lazy[G]it' })
  end,
}
