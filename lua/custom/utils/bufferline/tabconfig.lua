-- Buffers belong to tabs
local cache = {}
local last_tab = 0

local utils = {}

utils.is_valid = function(buf_num)
  if not buf_num or buf_num < 1 then
    return false
  end
  local exists = vim.api.nvim_buf_is_valid(buf_num)
  return vim.bo[buf_num].buflisted and exists
end

utils.get_valid_buffers = function()
  local buf_nums = vim.api.nvim_list_bufs()
  local ids = {}
  for _, buf in ipairs(buf_nums) do
    if utils.is_valid(buf) then
      ids[#ids + 1] = buf
    end
  end
  return ids
end

local autocmd = vim.api.nvim_create_autocmd

autocmd('TabEnter', {
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    local buf_nums = cache[tab]
    if buf_nums then
      for _, k in pairs(buf_nums) do
        vim.api.nvim_buf_set_option(k, 'buflisted', true)
      end
    end
  end,
})
autocmd('TabLeave', {
  callback = function()
    local tab = vim.api.nvim_get_current_tabpage()
    local buf_nums = utils.get_valid_buffers()
    cache[tab] = buf_nums
    for _, k in pairs(buf_nums) do
      vim.api.nvim_buf_set_option(k, 'buflisted', false)
    end
    last_tab = tab
  end,
})
autocmd('TabClosed', {
  callback = function()
    cache[last_tab] = nil
  end,
})
autocmd('TabNewEntered', {
  callback = function()
    vim.api.nvim_buf_set_option(0, 'buflisted', true)
  end,
})
