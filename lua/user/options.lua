-- [[ Setting options ]] See `:help vim.o`
-- NOTE: You can change these options as you wish!

vim.wo.wrap = false

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true
vim.wo.relativenumber = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- disable auto commenting
local autogroup = vim.api.nvim_create_augroup('FormatOptionsAdjust', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  group = autogroup,
  command = 'set formatoptions-=r formatoptions-=c formatoptions-=o',
})

vim.o.sessionoptions = 'blank,buffers,curdir,tabpages,winsize,winpos,terminal,localoptions'

vim.o.spell = true
vim.o.spelllang = 'en_gb,cs'
