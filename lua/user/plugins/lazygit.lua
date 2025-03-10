return {
  'kdheepak/lazygit.nvim',
  enabled = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  config = function()
    vim.keymap.set('n', '<leader>gl', '<cmd>LazyGit<CR>', { silent = true, desc = '[L]azyGit' })
  end,
}
