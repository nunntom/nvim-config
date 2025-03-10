return {
  'michaelb/sniprun',
  branch = 'master',

  build = 'sh install.sh',
  -- do 'sh install.sh 1' if you want to force compile locally
  -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

  config = function()
    require('sniprun').setup {
      interpreter_options = {
        Generic = {
          error_truncate = 'long', -- strongly recommended to figure out what's going on
          PHPConfig = { -- any key name is ok
            supported_filetypes = { 'php' }, -- mandatory
            extension = '.php', -- recommended, but not mandatory. Sniprun use this to create temporary files

            interpreter = 'php', -- interpreter or compiler (+ options if any)
            compiler = '', -- exactly one of those MUST be non-empty
          },
        },
      },
    }
  end,
}
