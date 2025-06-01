-- In your init.lua or a dedicated LSP configuration file (e.g., lua/lsp_servers/rust_analyzer.lua)

-- Define the configuration for rust_analyzer
vim.lsp.config['rust_analyzer'] = {
  -- Command to start the server
  cmd = { 'rust-analyzer' }, -- Make sure 'rust-analyzer' is in your system's PATH

  -- Filetypes to automatically attach to
  filetypes = { 'rust' },

  -- Root markers help Neovim determine the project root and attach the LSP server
  -- These are crucial for rust-analyzer to find your Cargo.toml
  root_markers = {
    'Cargo.toml',
    '.git', -- Often a good generic root marker for any project
  },

  -- Specific settings to send to the server (same as before, nested under 'rust-analyzer')
  settings = {
    ['rust-analyzer'] = {
      cargo = {
        allFeatures = true,
        loadOutDirsFromCheck = true, -- Essential for build scripts
      },
      checkOnSave = {
        command = "clippy", -- Highly recommended for thorough linting
        allTargets = true,
      },
      inlayHints = {
        enable = true,
        typeHints = true,
        parameterHints = true,
        chainingHints = true,
        closureCaptureHints = true,
        lifetimeElisionHints = "always",
        maxLength = 25,
      },
      procMacro = {
        enable = true, -- Important for projects using derive macros
      },
      diagnostics = {
        enable = true,
      },
      files = {
        excludeDirs = {
          ".direnv",
          ".git",
          "target",
        },
      },
    },
  },

  -- The on_attach function is still used for buffer-local setup (keymaps, etc.)
  on_attach = function(client, bufnr)
    -- Keybindings for LSP features (example)
    local opts = { noremap = true, silent = true }
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.format({ async = true })<CR>', opts)
    vim.keymap.set('n', '|', function()
      vim.diagnostic.open_float(nil, {
        focusable = false,
        border = 'rounded',
        source = 'always',
        prefix = '',
      })
    end, { desc = "Show diagnostics on hover" })
    -- Auto-format on save (optional, but highly recommended for Rust)
    -- This relies on `rustfmt` being installed and in your PATH.
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('FormatRust', { clear = true }),
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ async = true })
      end,
    })
  end,
}

-- Enable the rust_analyzer configuration so it automatically starts for Rust files
vim.lsp.enable('rust_analyzer')

