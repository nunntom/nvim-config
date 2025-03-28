return {
  'nvim-telescope/telescope.nvim',
  -- branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    -- Fuzzy Finder Algorithm which requires local dependencies to be built.
    -- Only load if `make` is available. Make sure you have the system
    -- requirements installed.
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      -- NOTE: If you are having trouble with this installation,
      --       refer to the README for telescope-fzf-native for more instructions.
      build = 'make',
      -- cond = function()
      --   return vim.fn.executable 'make' == 1
      -- end,
    },
    {
      'nvim-telescope/telescope-live-grep-args.nvim',
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = '^1.0.0',
    },
    { 'alduraibi/telescope-glyph.nvim' },
    { 'protex/better-digraphs.nvim' },
  },
  config = function()
    require('telescope').load_extension 'live_grep_args'
    require('telescope').load_extension 'fzf'
    require('telescope').load_extension 'glyph'

    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['<C-u>'] = false,
            ['<C-d>'] = false,
          },
        },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
        buffers = {
          previewer = false,
          mappings = {
            i = {
              ['<c-d>'] = 'delete_buffer',
            },
            n = {
              ['d'] = 'delete_buffer',
            },
          },
        },
      },
    }
  end,
}
