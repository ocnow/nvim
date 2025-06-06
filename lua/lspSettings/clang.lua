-- lua/lsp_servers/clangd.lua (or directly in init.lua)

vim.lsp.config['clangd'] = {
  -- The command to start the clangd server
  cmd = { 'clangd' },

  -- Filetypes for which clangd should activate
  filetypes = { 'c', 'cpp', 'objc', 'objcpp' },

  -- Root markers help clangd identify your project's root.
  -- compile_commands.json is CRUCIAL for C/C++ projects.
  root_markers = {
    'compile_commands.json',
    'compile_flags.txt',
    '.git',
    'Makefile',
    'CMakeLists.txt',
    'build/', -- Common build directory where compile_commands.json might reside
  },

  -- Specific settings to pass to the clangd server
  settings = {
    Clangd = {
      arguments = {
        '--clang-tidy',           -- Enable Clang-Tidy diagnostics (highly recommended)
        '--all-scopes-completion',-- Broader completion results
        '--completion-style=detailed', -- More detailed completion info
        '--suggest-missing-includes', -- Suggests missing #include directives
        '--background-index',     -- Index project files in the background
        '--function-arg-placeholders=false', -- Don't insert placeholders for function arguments
        '--offset-encoding=utf-16', -- Recommended for LSP clients
        '-j=8',                   -- Use 8 threads for clangd. Adjust based on your CPU.

        -- IMPORTANT: Fallback flags if compile_commands.json is NOT found.
        -- Customize these to match your C project's standard and warnings.
        -- E.g., for C99:
        '-std=c99',
        '-Wall',
        '-Wextra',
        -- For C11/C17/C20:
        -- '-std=c11',
        -- '-std=c17',
        -- '-std=c20',
        -- For C++ projects, use corresponding C++ standards:
        -- '-std=c++11', '-std=c++14', '-std=c++17', '-std=c++20', '-std=c++23'
      },
    },
  },

  -- Function to attach to the LSP client after it starts (for keybindings, etc.)
  on_attach = function(client, bufnr)
    local opts = { noremap = true, silent = true }

    -- Basic LSP keybindings (customize as needed)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)

    -- Auto-format on save (optional, requires clang-format in your PATH)
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('FormatCcpp', { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
  end,
}

-- Enable the clangd configuration so it automatically starts for C/C++ files
vim.lsp.enable('clangd')
