return {
  {
    'mfussenegger/nvim-dap',
    config = function()
      local dap = require 'dap'
      dap.adapters.php = {
        type = 'executable',
        command = 'node',
        args = { '/home/tom/Projects/vscode-php-debug/out/phpDebug.js' },
      }
      dap.configurations.php = {
        {
          type = 'php',
          request = 'launch',
          name = 'Listen for Xdebug',
          port = 9003,
          pathMappings = { ['/api/'] = '${workspaceFolder}' },
        },
      }
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dapui').setup()
    end,
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('nvim-dap-virtual-text').setup()
    end,
  },
  {
    'leoluz/nvim-dap-go',
    config = function()
      require('dap-go').setup()
    end,
  },
}
