return {
  'lewis6991/satellite.nvim',
  event = 'BufEnter',
  config = function()
    require('satellite').setup {
      winblend = 0,
    }
  end,
}
