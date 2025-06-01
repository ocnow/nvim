local termFunctions = require("floatterminal")

vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('v', '>', '>gv', { noremap = true })
vim.keymap.set('v', '<', '<gv', { noremap = true })

vim.keymap.set("n", "<leader>zz", function()
  local current = vim.diagnostic.config().virtual_text
  local new = not current
  vim.diagnostic.config({
    update_in_insert = new,
    virtual_text = new,
    virtual_lines = new,
    underline = new,
    signs = new,
    float = new,
  })
  vim.b.completion = not vim.b.completion
  vim.notify("Inline diagnostics: " .. (new and "ON" or "OFF"))
end, { desc = "Toggle inline LSP diagnostics" })
vim.api.nvim_create_user_command("W", "w", {})
vim.api.nvim_create_user_command("Q", "q", {})

vim.keymap.set('n','K',function()
    vim.lsp.buf.hover({border = "rounded"})
end)

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

local function openTerm()
  termFunctions.create_floating_terminal()
end
vim.keymap.set("n", "<A-]>", openTerm)

--mapping to inable or disable inlay hints
local function toggleInalyHints()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end
vim.keymap.set('n', '<leader>h', toggleInalyHints)

