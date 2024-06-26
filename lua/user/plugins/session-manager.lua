return {
  'shatur/neovim-session-manager',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  enabled = false,
  config = function()
    local config = require 'session_manager.config'
    require('session_manager').setup {
      autoload_mode = config.AutoloadMode.CurrentDir,
      autosave_ignore_not_normal = false,
      -- autosave_ignore_filetypes = { 'toggleterm', 'neotree' },
      -- autosave_ignore_buftypes = { 'terminal', 'neotree' },
    }
    -- local config_group = vim.api.nvim_create_augroup('MyConfigGroup', {}) -- A global group for all your config autocommands
    --
    -- vim.api.nvim_create_autocmd({ 'User' }, {
    --   pattern = 'SessionLoadPost',
    --   group = config_group,
    --   command = 'Neotree show reveal',
    -- })
  end,
}
