local M = {}

-- Internal variable to hold the original window layout command
M._saved_layout = nil

-- Function to maximize the current window height (equivalent to <C-w>_)
function M.maximize()
  if M._saved_layout then
    return -- Already maximized
  end
  M._saved_layout = vim.fn.winrestcmd()
  vim.cmd("wincmd _")
end

-- Function to restore the previous window layout
function M.restore()
  if not M._saved_layout then
    return -- Nothing to restore
  end

  -- Restore the saved window layout
  vim.cmd(M._saved_layout)
  -- Reset the saved layout to allow future maximizations
  M._saved_layout = nil
end

-- Toggle function: if maximized, restore; otherwise, maximize (if there are splits)
function M.toggle()
  if M._saved_layout then
    M.restore()
  elseif vim.fn.winnr('$') > 1 then
    M.maximize()
  end
end

return M
