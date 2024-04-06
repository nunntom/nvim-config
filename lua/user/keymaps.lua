local opts = { noremap = true, silent = true }
local wk = require 'which-key'
local telescope = require 'telescope.builtin'

-- Shorten function name
local keymap = vim.keymap.set

-- See `:help vim.keymap.set()`
keymap({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Press jk fast to exit insert mode
keymap('i', 'jk', '<ESC>', opts)
keymap('i', 'kj', '<ESC>', opts)

-- Close buffer
keymap('n', '<leader>q', MiniBufremove.wipeout, opts)

-- Better window navigation
-- keymap('n', '<C-h>', '<C-w>h', opts)
-- keymap('n', '<C-j>', '<C-w>j', opts)
-- keymap('n', '<C-k>', '<C-w>k', opts)
-- keymap('n', '<C-l>', '<C-w>l', opts)
--
-- Resize with arrows
keymap('n', '<C-Up>', ':resize -2<CR>', opts)
keymap('n', '<C-Down>', ':resize +2<CR>', opts)
keymap('n', '<C-Left>', ':vertical resize -2<CR>', opts)
keymap('n', '<C-Right>', ':vertical resize +2<CR>', opts)

-- Navigate buffers
-- keymap('n', '<S-l>', ':bnext<CR>', opts)
-- keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', ':m .+1<CR>==', opts)
keymap('n', '<A-k>', ':m .-2<CR>==', opts)

keymap('n', '<C-d>', '<C-d>zz', opts)
keymap('n', '<C-u>', '<C-u>zz', opts)

-- Visual --

-- Paste without yanking
-- keymap('v', 'p', '"_dP', opts)

-- https://github.com/pazams/d-is-for-delete

-- keymap('n', 'x', '"_x', opts)
-- keymap('n', 'd', '"_d', opts)
-- keymap('n', 'D', '"_D', opts)
-- keymap('v', 'd', '"_d', opts)
--
-- keymap('n', '<leader>d', '""d', opts)
-- keymap('n', '<leader>D', '""D', opts)
-- keymap('v', '<leader>d', '""d', opts)

-- Stay in indent mode
keymap('v', '<', '<gv^', opts)
keymap('v', '>', '>gv^', opts)

-- Move text up and down
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Visual Block --
-- Move text up and down
keymap('x', 'J', ":m '>+1<CR>gv=gv", opts)
keymap('x', 'K', ":m '<-2<CR>gv=gv", opts)
keymap('x', '<A-j>', ":m '>+1<CR>gv=gv", opts)
keymap('x', '<A-k>', ":m '<-2<CR>gv=gv", opts)

-- Remap for dealing with word wrap
keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

--Toggle NeoTree
keymap('n', '<C-n>', ':Neotree filesystem reveal left toggle<CR>', { silent = true })

-- Diagnostic keymaps
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
keymap('n', '<leader>dl', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Telescope

keymap('n', '<leader>gf', telescope.git_files, { desc = 'Search [G]it [F]iles' })
keymap('n', '<leader>sf', telescope.find_files, { desc = '[S]earch [F]iles' })
keymap('n', '<leader>sh', telescope.help_tags, { desc = '[S]earch [H]elp' })
keymap('n', '<leader>sw', telescope.grep_string, { desc = '[S]earch current [W]ord' })
keymap('n', '<leader>sg', telescope.live_grep, { desc = '[S]earch by [G]rep' })
keymap('n', '<leader>sd', telescope.diagnostics, { desc = '[S]earch [D]iagnostics' })
keymap('n', '<leader>sr', telescope.resume, { desc = '[S]earch [R]esume' })
keymap('n', '<leader>fs', require('telescope').extensions.live_grep_args.live_grep_args, { noremap = true })

keymap('n', '<leader>?', telescope.oldfiles, { desc = '[?] Find recently opened files' })
keymap('n', '<leader><space>', telescope.buffers, { desc = '[ ] Find existing buffers' })
keymap('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  telescope.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

require('which-key').register {
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
}

local lsp_keymaps = function(bufnr)
  wk.register({
    l = {
      name = 'Lspsaga',
      c = { '<cmd>Lspsaga code_action<cr>', 'Code Action' },
      o = { '<cmd>Lspsaga outline<cr>', 'Outline' },
      r = { '<cmd>Lspsaga rename<cr>', 'Rename' },
      d = { '<cmd>Lspsaga goto_definition<cr>', 'Lsp GoTo Definition' },
      f = { '<cmd>Lspsaga finder<cr>', 'Lsp Finder' },
      p = { '<cmd>Lspsaga preview_definition<cr>', 'Preview Definition' },
      s = { '<cmd>Lspsaga signature_help<cr>', 'Signature Help' },
      w = { '<cmd>Lspsaga show_workspace_diagnostics<cr>', 'Show Workspace Diagnostics' },
    },
  }, { prefix = '<leader>', buffer = bufnr })

  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    keymap('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', telescope.lsp_definitions, '[G]oto [D]efinition')
  -- nmap('gr', telescope.lsp_references, '[G]oto [R]eferences')
  nmap('gr', ':Lspsaga finder ref<CR>', '[G]oto [R]eferences')
  nmap('<leader>pd', ':Lspsaga peek_definition<CR>', '[P]eek [D]efinition')
  nmap('gI', telescope.lsp_implementations, '[G]oto [I]mplementation')
  nmap('<leader>D', telescope.lsp_type_definitions, 'Type [D]efinition')
  nmap('<leader>ds', telescope.lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', telescope.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')
end

return {
  lsp_keymaps = lsp_keymaps,
}
