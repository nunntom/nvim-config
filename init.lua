vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require 'user.options'
require 'user.lazy'
require 'user.keymaps'
require 'user.highlightonyank'
require 'user.lsp'
require 'user.filetypes'

-- Fix incorrect line-ending detection for Unix files
vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.bo.fileformat == 'dos' and vim.fn.search('\r', 'nw') == 0 then
      vim.bo.fileformat = 'unix'
    end
  end,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
