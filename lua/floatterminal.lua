local M = {}
vim.keymap.set("t","<esc><esc>","<C-\\><C-n>")
---@class floatingOptions
---@field buf number
---@field win number
---
---@class floatingStateClass
---@field floating floatingOptions

---@type floatingStateClass
local state = {
  floating = {
    buf = -1,
    win = -1,
  }
}

---@return floatingOptions
local function create_floating_win(opts)
  opts = opts or {}

  -- Set defaults
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)
  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)
  local border = opts.border or 'rounded'
  local style = opts.style or 'minimal'
  local title = opts.title or nil

  -- Create buffer
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end
  if not buf then
    vim.notify("Failed to create buffer", vim.log.levels.ERROR)
    return {buf = -1, win = -1}
  end

  -- Floating window config
  local win_opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = style,
    border = border,
    title = title,
  }

  local win = vim.api.nvim_open_win(buf, true, win_opts)

  return {buf = buf, win = win}
end

function M.create_floating_terminal()
  if not vim.api.nvim_win_is_valid(state.floating.win) then
    state.floating = create_floating_win({buf = state.floating.buf})
    if vim.bo[state.floating.buf].buftype ~= 'terminal' then
      vim.cmd.terminal()
    end
    return {createdTerminal = true}
  else
    vim.api.nvim_win_hide(state.floating.win)
    return {createdTerminal = false}
  end
end

function M.send_to_floating_terminal(cmd)
  if vim.api.nvim_win_is_valid(state.floating.win) and vim.bo[state.floating.buf].buftype == 'terminal' then
    local chan = vim.api.nvim_get_option_value('channel',{buf = state.floating.buf})
    vim.api.nvim_chan_send(chan, cmd .. '\n')
  else
    vim.notify("No valid floating terminal found", vim.log.levels.ERROR)
  end
end

return M

