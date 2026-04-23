return {
  'stevearc/conform.nvim',
  enabled = true,
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    local conform = require 'conform'

    conform.setup {
      formatters_by_ft = {
        javascript = { 'prettierd', 'eslint_d' },
        typescript = { 'prettierd', 'eslint_d' },
        javascriptreact = { 'prettierd', 'eslint_d' },
        typescriptreact = { 'prettierd', 'eslint_d' },
        svelte = { 'prettierd', 'eslint_d' },
        css = { 'prettierd' },
        html = { 'prettierd' },
        json = { 'prettierd' },
        yaml = { 'yamlfmt' },
        markdown = { 'prettierd' },
        graphql = { 'prettierd' },
        lua = { 'stylua' },
        twig = { 'prettierd' },
        php = { 'mago_format' },
        elm = { 'elm-format' },
        nix = { 'nixfmt', 'nil_ls' },
        scm = { 'prettierd' },
        go = { 'gofmt', 'gofumpt' },
        sql = { 'sqlfmt' },
        vue = { 'prettierd', 'eslint_d' },
        kdl = { 'kdlfmt' },
        scss = { 'prettierd' },
        pug = { 'prettierd' },
        dockerfile = { 'dockerfmt' },
        caddy = { 'caddyfmt' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 10000, lsp_fallback = true }
      end,
      formatters = {
        ['php-cs-fixer'] = {
          command = 'php-cs-fixer',
          args = {
            'fix',
            '--rules=@PSR12', -- Formatting preset. Other presets are available, see the php-cs-fixer docs.
            '$FILENAME',
          },
          stdin = false,
        },

        ['caddyfmt'] = {
          command = 'caddy',
          args = { 'fmt', '-' },
          stdin = true,
        },
      },
    }

    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    })

    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    })

    vim.keymap.set({ 'n', 'v' }, '<leader>mp', function()
      conform.format {
        lsp_fallback = true,
        async = false,
        timeout_ms = 10000,
      }
    end, { desc = 'Format file or range (in visual mode)' })
  end,
}
