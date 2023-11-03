return {
  'mfussenegger/nvim-lint',
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

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = lint_augroup,
      callback = function()
        if vim.g.disable_lint or vim.b.disable_lint then
          return
        end
        lint.try_lint()
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
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
