return {
  'zbirenbaum/copilot.lua',
  enabled = true,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        accept = false,
        keymap = {
          accept_word = '<C-Right>',
        },
      },
      filetypes = {
        javascript = true,
        typescript = true,
        elm = true,
        nix = true,
        lua = true,
        php = true,
        html = true,
      },
    }
  end,
}
