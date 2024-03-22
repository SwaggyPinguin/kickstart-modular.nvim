-- return {
--   'eddyekofo94/gruvbox-flat.nvim',
--   priority = 1000,
--   enabled = true,
--   config = function()
--     -- vim.g.gruvbox_flat_style = 'dark' -- 'dark', 'hard'
--     -- vim.g.gruvbox_italic_functions = true
--     vim.g.gruvbox_sidebars = {
--       'terminal', --[[ 'lazy', 'mason', 'neo-tree', 'telescope' ]]
--     }
--     vim.g.gruvbox_dark_float = true
--     -- vim.g.gruvbox_hide_inactive_statusline = true
--     -- vim.g.gruvbox_transparent = true
--
--     vim.cmd [[colorscheme gruvbox-flat]]
--   end,
-- }

return {
  'sainnhe/gruvbox-material',
  config = function()
    vim.g.gruvbox_material_background = 'soft' -- 'hard', 'medium', 'soft'
    vim.g.gruvbox_material_better_performance = 1
    -- vim.g.gruvbox_material_transparent_background = 1 -- 0, 1, 2

    vim.cmd [[colorscheme gruvbox-material]]
  end,
}

-- return {
--   {
--     'ellisonleao/gruvbox.nvim',
--     priority = 1000,
--     config = function()
--       require('gruvbox').setup {
--         terminal_colors = true, -- add neovim terminal colors
--         undercurl = true,
--         underline = true,
--         bold = true,
--         italic = {
--           strings = true,
--           emphasis = true,
--           comments = true,
--           operators = false,
--           folds = true,
--         },
--         strikethrough = true,
--         invert_selection = false,
--         invert_signs = false,
--         invert_tabline = false,
--         invert_intend_guides = false,
--         inverse = true, -- invert background for search, diffs, statuslines and errors
--         contrast = '', -- can be "hard", "soft" or empty string
--         palette_overrides = {},
--         overrides = {},
--         dim_inactive = false,
--         transparent_mode = false,
--       }
--     end,
--     opts = {},
--     init = function()
--       vim.cmd.colorscheme 'gruvbox'
--     end,
--   },
-- }
-- vim: ts=2 sts=2 sw=2 et
