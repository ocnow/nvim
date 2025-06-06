-- lua/lsp_servers/gopls.lua (or directly in init.lua)

vim.lsp.config['gopls'] = {
  -- The command to start the gopls server
  cmd = { 'gopls' },

  -- Filetypes for which gopls should activate
  filetypes = { 'go', 'gomod', 'gowork', 'go.mod', 'go.work' },

  -- Root markers help gopls identify your Go module's root
  root_markers = {
    'go.mod',
    '.git',
    '.golangci.yml', -- For golangci-lint config
  },

  -- Specific settings to pass to the gopls server
  settings = {
    gopls = {
      -- General configuration
      buildFlags = { '-tags=wireinject,tools' }, -- Example: add specific build tags if your project uses them
      gofumpt = true,                           -- Use gofumpt for formatting if installed
      staticcheck = true,                       -- Enable staticcheck diagnostics
      analyses = {                              -- Enable/disable specific analyses
        unusedparams = true,
        shadow = true,
        nilness = true,
      },
      codelenses = {                            -- Enable/disable specific code lenses
        generate = true,                        -- For go generate
        test = true,                            -- For running tests
        tidy = true,                            -- For go mod tidy
      }
    }
  },

  -- Function to attach to the LSP client after it starts (for keybindings, etc.)
  on_attach = function(client, bufnr)
    -- Standard LSP keybindings (customize as needed)
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

    -- Auto-format on save (recommended for Go)
    vim.api.nvim_create_autocmd('BufWritePre', {
      group = vim.api.nvim_create_augroup('FormatGo', { clear = true }),
      buffer = bufnr,
      callback = function()
        -- Ensure goimports/gofumpt is used via LSP formatting
        vim.lsp.buf.format({ async = true })
      end,
    })

    -- Optional: If you want to use golangci-lint for diagnostics
    -- You'll need to integrate this separately, often via null-ls.nvim (deprecated)
    -- or nvim-lint. For simplicity, gopls's staticcheck is often enough.
  end,
}

vim.lsp.enable('gopls')
