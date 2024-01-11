return {
  'alexlafroscia/postcss-syntax.vim',
  config = function()
    vim.cmd [[autocmd BufNewFile,BufRead *.pcss set filetype=css]]
  end,
}
