return {
  'ThePrimeagen/harpoon',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-lua/popup.nvim',
  },
  config = function()
    require('harpoon').setup {}
  end,
}
