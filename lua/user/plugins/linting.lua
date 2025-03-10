return {
  'mfussenegger/nvim-lint',
  enabled = false,
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },
    }

    local eslint = lint.linters.eslint_d

    eslint.args = {
      '--no-warn-ignored', -- <-- this is the key argument
      '--format',
      'json',
      '--stdin',
      '--stdin-filename',
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        if vim.g.disable_lint or vim.b.disable_lint then
          return
        end
        lint.try_lint(nil, {
          ignore_errors = true, -- ignore command-not-found errors
        })
      end,
    })

    vim.api.nvim_create_user_command('LintDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_lint = true
      else
        vim.g.disable_lint = true
      end
    end, {
      desc = 'Disable lint-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('LintEnable', function()
      vim.b.disable_lint = false
      vim.g.disable_lint = false
    end, {
      desc = 'Re-enable lint-on-save',
    })

    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint(nil, {
        ignore_errors = true, -- ignore command-not-found errors
      })
    end, { desc = 'Trigger linting for current file' })
  end,
}
