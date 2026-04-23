return {
  'zbirenbaum/copilot.lua',
  requires = {
    'copilotlsp-nvim/copilot-lsp',
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  enabled = false,
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      panel = {
        keymap = {
          open = '<M-p>',
        },
      },
      suggestion = {
        enabled = true,
        auto_trigger = true,
        accept = false,
        keymap = {
          accept = '<C-l>',
          accept_word = '<C-Right>',
          dismiss = '<M-h>',
        },
      },
      filetypes = {
        javascript = true,
        typescript = true,
        elm = true,
        nix = true,
        lua = true,
        php = true,
        html = true,
      },
      should_attach = function(bufnr, bufname)
        -- Keep default safety checks
        if string.match(bufname, 'env') or not vim.bo[bufnr].buflisted or vim.bo[bufnr].buftype ~= '' then
          return false
        end

        local cwd = vim.loop.cwd() or ''

        -- Patterns of projects where Copilot must not run
        local blocked_patterns = {
          'Dnata',
        }

        for _, pat in ipairs(blocked_patterns) do
          if cwd:find(pat) then
            return false
          end
        end

        -- Marker file check
        local marker = vim.fs.find('.no-copilot', { upward = true, path = cwd })[1]
        if marker then
          return false
        end

        return true
      end,
    }
  end,
}
