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
      require('user.keymaps').lsp_keymaps(bufnr)
      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
      end, { desc = 'Format current buffer with LSP' })

      if client.server_capabilities.codeLensProvider then
        local group_name = 'codelens_' .. bufnr
        vim.api.nvim_create_augroup(group_name, { clear = true })
        vim.api.nvim_create_autocmd({ 'BufEnter', 'BufAdd', 'BufCreate', 'BufRead', 'TextChanged', 'InsertLeave' }, {
          group = group_name,
          buffer = bufnr,
          callback = function()
            vim.lsp.codelens.refresh { bufnr = bufnr }
          end,
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

    lspconfig['gopls'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['templ'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
    }

    lspconfig['tailwindcss'].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { 'templ', 'astro', 'javascript', 'typescript', 'react' },
      init_options = { userLanguages = { templ = 'html' } },
    }

    lspconfig.htmx.setup {
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { 'html', 'templ' },
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

    lspconfig['nil_ls'].setup {
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
