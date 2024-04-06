-- return {
--   'Tsuzat/NeoSolarized.nvim',
--   lazy = false, -- make sure we load this during startup if it is your main colorscheme
--   priority = 1000, -- make sure to load this before all the other start plugins
--   config = function()
--     require('NeoSolarized').setup {
--       style = 'dark',
--       styles = { undercurl = true },
--     }
--     vim.cmd [[ colorscheme NeoSolarized ]]
--   end,
-- }
-- return {
--   'rebelot/kanagawa.nvim',
--   config = function()
--     require('kanagawa').setup {
--       undercurl = true,
--     }
--   end,
-- }

-- return {
--   'tiagovla/tokyodark.nvim',
--   opts = {
--     -- custom options here
--     undercurl = true,
--   },
--   config = function(_, opts)
--     require('tokyodark').setup(opts) -- calling setup is optional
--     vim.cmd [[colorscheme tokyodark]]
--   end,
-- }
-- return {
--   'craftzdog/solarized-osaka.nvim',
--   config = function()
--     require('solarized-osaka').setup {}
--   end,
-- }
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
