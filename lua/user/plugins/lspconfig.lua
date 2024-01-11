return {
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs to stdpath for neovim
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',

    -- Useful status updates for LSP
    -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
    { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

    -- Additional lua configuration, makes nvim stuff amazing!
    'folke/neodev.nvim',
  },
  config = function()
    require('neodev').setup()
    local on_attach = function(client, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

      nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      -- nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
      nmap('gr', ':Lspsaga finder ref<CR>', '[G]oto [R]eferences')
      nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
      nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
      nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
      nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

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

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      if client.server_capabilities.codeLensProvider then
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufCreate', 'BufRead', 'TextChanged', 'InsertLeave' }, {
          buffer = bufnr,
          callback = vim.lsp.codelens.refresh,
        })
      end

      vim.diagnostic.config {
        virtual_text = false,
      }
      vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]
    end

    local lspconfig = require 'lspconfig'
    local capabilities = vim.lsp.protocol.make_client_capabilities()

    lspconfig['html'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'html', 'twig', 'hbs' },
    }

    lspconfig['tsserver'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['elmls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['intelephense'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        intelephense = {
          stubs = {

            'apache',
            'bcmath',
            'bz2',
            'calendar',
            'com_dotnet',
            'Core',
            'ctype',
            'curl',
            'date',
            'dba',
            'dom',
            'enchant',
            'exif',
            'FFI',
            'fileinfo',
            'filter',
            'fpm',
            'ftp',
            'gd',
            'gettext',
            'gmp',
            'hash',
            'iconv',
            'imap',
            'intl',
            'json',
            'ldap',
            'libxml',
            'mbstring',
            'meta',
            'mysqli',
            'oci8',
            'odbc',
            'openssl',
            'pcntl',
            'pcre',
            'PDO',
            'pdo_ibm',
            'pdo_mysql',
            'pdo_pgsql',
            'pdo_sqlite',
            'pgsql',
            'Phar',
            'posix',
            'pspell',
            'readline',
            'Reflection',
            'session',
            'shmop',
            'SimpleXML',
            'snmp',
            'soap',
            'sockets',
            'sodium',
            'SPL',
            'sqlite3',
            'standard',
            'superglobals',
            'sysvmsg',
            'sysvsem',
            'sysvshm',
            'tidy',
            'tokenizer',
            'xml',
            'xmlreader',
            'xmlrpc',
            'xmlwriter',
            'xsl',
            'Zend OPcache',
            'zip',
            'zlib',
            'wordpress',
            'imagick',
            'woocommerce',
            'wordpress-globals',
            'wp-cli',
          },
          files = {
            maxSize = 5000000,
          },
        },
      },
    }

    lspconfig['rnix'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['lua_ls'].setup {
      on_attach = on_attach,
      on_init = function(client)
        local path = client.workspace_folders[1].name
        if not vim.loop.fs_stat(path .. '/.luarc.json') and not vim.loop.fs_stat(path .. '/.luarc.jsonc') then
          client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
            Lua = {
              autoFixOnSave = true,
              runtime = {
                version = 'LuaJIT',
              },
              workspace = {
                checkThirdParty = false,
                library = {
                  vim.env.VIMRUNTIME,
                },
              },
            },
          })
          client.notify('workspace/didChangeConfiguration', { settings = client.config.settings })
        end
        return true
      end,
    }
  end,
}
