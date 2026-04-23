local pid = vim.fn.getpid()

-- local omnisharp_path = vim.fn.stdpath 'data' .. '/mason/bin/omnisharp-mono'
local omnisharp_path = 'omnisharp-mono'
return {
  name = 'omnisharp',
  cmd = {
    omnisharp_path,
    '-z',
    '-lsp',
  },
  settings = {
    FormattingOptions = { EnableEditorConfigSupport = true },
    RoslynExtensionsOptions = {
      EnableAnalyzersSupport = true,
      EnableDecompilationSupport = true,
    },
  },
  filetypes = { 'cs', 'c#' },
  root_markers = { '.sln', '.csproj' },
}
