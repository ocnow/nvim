---leader setttings--
vim.g.mapleader = ' '
vim.g.maplocalleader = ' ' 

require('options')
require('lspSettings.rustAnalyzer')
require('lspSettings.clang')
require('lspSettings.go')
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
-----------------------------------------------------------------------------------------------------
----------------------------------------------DarcuboxNvim-------------------------------------------
-----------------------------------------------------------------------------------------------------
require('darcubox').setup({
    options = {
        transparent = true,
        styles = {
            comments = {},
            functions = {},
            keywords = {},
            types = {},
        },
    },
})
------------------------------------------------------------------------------------------------------
----------------------------------------------LauLine setup-------------------------------------------
------------------------------------------------------------------------------------------------------
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
