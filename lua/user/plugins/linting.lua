return {
  'mfussenegger/nvim-lint',
  enabled = true,
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
      php = { 'mago_analyze' },
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

    local severities = {
      error = vim.diagnostic.severity.ERROR,
      warning = vim.diagnostic.severity.WARN,
      note = vim.diagnostic.severity.INFO,
      help = vim.diagnostic.severity.HINT,
    }

    local pattern = '[^:]+:(%d+):(%d+):%s?(%l+)%[([%w-]+)%]:%s?(.+)'
    local groups = { 'lnum', 'col', 'severity', 'code', 'message' }

    -- lint.linters.mago_analyze = {
    --   name = 'mago_analyze',
    --   cmd = 'mago',
    --   args = { '--no-colors', 'analyze', '--reporting-format=short' },
    --   append_fname = true,
    --   stdin = false,
    --   ignore_exitcode = true,
    --   parser = require('lint.parser').from_pattern(pattern, groups, severities, { ['source'] = 'mago_analyze' }),
    -- }

    local phpstan_bin = 'phpstan'

    lint.linters.phpstan = {
      name = 'phpstan',
      cmd = function()
        local local_bin = vim.fn.fnamemodify('phpstan.sh', ':p')
        return vim.loop.fs_stat(local_bin) and local_bin or phpstan_bin
      end,
      args = {
        'analyze',
        '--error-format=json',
        '--no-progress',
      },
      ignore_exitcode = true,
      parser = function(output, bufnr)
        if vim.trim(output) == '' or output == nil then
          return {}
        end

        local file = vim.json.decode(output).files[vim.api.nvim_buf_get_name(bufnr)]

        if file == nil then
          return {}
        end

        local diagnostics = {}

        for _, message in ipairs(file.messages or {}) do
          table.insert(diagnostics, {
            lnum = type(message.line) == 'number' and (message.line - 1) or 0,
            col = 0,
            message = message.message,
            source = phpstan_bin,
            code = message.identifier,
          })
        end

        return diagnostics
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
          ignore_errors = false, -- ignore command-not-found errors
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
