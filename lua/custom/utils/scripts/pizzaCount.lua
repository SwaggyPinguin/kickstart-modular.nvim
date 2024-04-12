vim.api.nvim_create_user_command('FilterPizza', function()
  local numbers = {}
  local total_sum = 0
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  -- Process each line to extract the item and its corresponding quantity
  for _, line in ipairs(lines) do
    local quantity, item = line:match '(%d+)x%s*(.+)'
    if quantity and item then
      -- strip leading and trailing whitespace and convert item to lowercase
      item = item:match('^%s*(.-)%s*$'):lower()
      quantity = tonumber(quantity)
      numbers[item] = (numbers[item] or 0) + quantity
      total_sum = total_sum + quantity
    end
  end

  -- Append the sum of numbers for each item to the end of the file
  for item, sum in pairs(numbers) do
    -- convert the first letter of each word in item to uppercase
    item = item:gsub("(%a)([%w_']*)", function(first, rest)
      return first:upper() .. rest:lower()
    end)
    vim.api.nvim_buf_set_lines(0, -1, -1, true, { sum .. 'x ' .. item })
  end

  -- Append total sum
  vim.api.nvim_buf_set_lines(0, -1, -1, true, { 'Gesamt: ' .. total_sum })
end, {
  desc = 'Filter and sum pizza',
})
