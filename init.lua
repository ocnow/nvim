require('options')
require('lspSettings.rustAnalyzer')
require('keymaps')

------------------------------------------------------------------------------------
-----------------------------treeSitter setup----------------------------------------
------------------------------------------------------------------------------------
require('nvim-treesitter.configs').setup {
  ensure_installed = { "lua", "rust", "vimdoc", "query" }, -- Example languages
  sync_install = false,
  auto_install = true, -- Auto-install parsers if not found
  highlight = { enable = true },
  indent = { enable = true },
}

------------------------------------------------------------------------------------
-----------------------------telescope setup----------------------------------------
------------------------------------------------------------------------------------
require('telescope').setup{
  defaults = {
    hidde = true,
  },
  pickers = {
  },
  extensions = {
    extensions = {
        fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
        }
    }
  }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fw', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = 'Telescope fuzzy search in current buffer' })
vim.keymap.set("n", "<leader>flf", function()
              require("telescope.builtin").lsp_document_symbols({
                symbols = { "Function", "Method" },
                prompt_title = "Functions in Current Buffer",
              })
            end, { desc = "Search functions in current buffer" })

vim.keymap.set("n", "<leader>fn", function()
            require("telescope.builtin").find_files({
              prompt_title = "Neovim Config",
              cwd = vim.fn.stdpath("config"),
            })
          end, { desc = "Find files in Neovim config" })

-----------------------------------------------------------------------------------------------------
----------------------------------------------OIL Setup----------------------------------------------
-----------------------------------------------------------------------------------------------------
require("oil").setup()
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
-----------------------------------------------------------------------------------------------------
----------------------------------------------Diagnostic Setup---------------------------------------
-----------------------------------------------------------------------------------------------------
vim.diagnostic.config({
  update_in_insert = false,
  virtual_text = false,
  virtual_lines = false,
  underline = false,
  signs = false,
  float = false,
})
vim.b.completion = false
