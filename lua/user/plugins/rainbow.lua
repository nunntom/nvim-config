return {
  'HiPhish/rainbow-delimiters.nvim',
  branch = 'master',
  config = function()
    local rainbow_delimiters = require 'rainbow-delimiters'
    require('rainbow-delimiters.setup').setup {
      strategy = {
        [''] = rainbow_delimiters.strategy['global'],
        vim = rainbow_delimiters.strategy['local'],
      },
      query = {
        [''] = 'rainbow-delimiters',
        lua = 'rainbow-blocks',
      },
      highlight = {
        'RainbowDelimiterYellow',
        'RainbowDelimiterViolet',
        'RainbowDelimiterBlue',
        --'RainbowDelimiterOrange',
        --'RainbowDelimiterGreen',
        --'RainbowDelimiterCyan',
        --'RainbowDelimiterRed',
      },
    }
  end,
}
