return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      suggestion = {
        enabled = true,
        auto_trigger = true,
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
