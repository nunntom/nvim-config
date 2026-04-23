return {
  cmd = { 'elm-language-server' },
  root_markers = { 'elm.json' },
  filetypes = { 'elm' },
  on_attach = function(client, bufnr)
    local group_name = 'codelens_' .. bufnr
    vim.api.nvim_create_augroup(group_name, { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufCreate', 'BufRead', 'TextChanged', 'InsertLeave' }, {
      group = group_name,
      buffer = bufnr,
      callback = function()
        vim.lsp.codelens.refresh { bufnr = bufnr }
      end,
    })
  end,
}
