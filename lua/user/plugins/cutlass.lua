return {
  {
    'svermeulen/vim-yoink',
    config = function()
      vim.g.yoinkIncludeDeleteOperations = 1
      vim.keymap.set({ 'n', 'x' }, 'x', 'd')
      vim.keymap.set({ 'n', 'x' }, 'xx', 'dd')
      vim.keymap.set({ 'n', 'x' }, 'X', 'D')
    end,
  },
  'svermeulen/vim-cutlass',
  'svermeulen/vim-subversive',
}
