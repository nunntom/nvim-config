return {
  'echasnovski/mini.files',
  version = false,
  enabled = false,
  config = function()
    require('mini.files').setup {
      windows = {
        preview = true,
        width_preview = 60,
      },
    }
    vim.keymap.set('n', '-', function()
      require('mini.files').open(vim.api.nvim_buf_get_name(0))
    end, { desc = 'Open current directory' })
  end,
}
