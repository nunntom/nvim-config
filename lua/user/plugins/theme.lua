return {
  'Mofiqul/vscode.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function()
    local c = require('vscode.colors').get_colors()
    require('vscode').setup {
      group_overrides = {
        DiagnosticUnnecessary = {
          fg = 'NONE',
          undercurl = true,
          sp = c.vscYellow,
        },
        CopilotSuggestion = {
          fg = c.vscGray,
        },
        LspCodeLens = {
          fg = c.vscGray,
        },
        SagaFileName = {
          fg = c.vscGray,
        },
        SagaFolderName = {
          fg = c.vscGray,
        },
        BufferlineBackground = {
          fg = c.vscGray,
        },
        BufferlineCloseButton = {
          fg = c.vscGray,
        },
        BufferlineCloseButtonVisible = {
          fg = c.vscGray,
        },
        BufferlineTruncMarker = {
          fg = c.vscGray,
        },
      },
    }
    vim.cmd [[
      colorscheme vscode
    ]]
    local hl = function(name, val)
      vim.api.nvim_set_hl(0, name, val)
    end

    hl('@type.elm', { fg = c.vscBlue })
    hl('@constructor.elm', { fg = c.vscFront })
    hl('@namespace.elm', { fg = c.vscFront })
    hl('@variable.elm', { fg = c.vscLightBlue })
    hl('type_variable', { fg = c.vscLightBlue })
  end,
}
