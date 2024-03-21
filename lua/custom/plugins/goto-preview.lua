return {
  'rmagatti/goto-preview',
  lazy = true,
  opts = {},
  init = function()
    vim.keymap.set('n', 'gpd', ':lua require("goto-preview").goto_preview_definition()<CR>', { silent = true, desc = '[G]oto [P]review [D]efinition' })
    vim.keymap.set('n', 'gpi', ':lua require("goto-preview").goto_preview_implementation()<CR>', { silent = true, desc = '[G]oto [P]review [I]mplementation' })
    vim.keymap.set(
      'n',
      'gpt',
      ':lua require("goto-preview").goto_preview_type_definition()<CR>',
      { silent = true, desc = '[G]oto [P]review [T]ype [D]efinition' }
    )
    vim.keymap.set('n', 'gpr', ':lua require("goto-preview").goto_preview_references()<CR>', { silent = true, desc = '[G]oto [P]review [R]eferences' })
    vim.keymap.set('n', 'gpD', ':lau require("goto-preview).goto_preview_declaration()<CR>', { silent = true, desc = '[G]oto [P]review [D]eclaration' })
    vim.keymap.set(
      'n',
      'gpc',
      -- ':lua require("goto-preview").close_all_win({ skip_curr_window = true })<CR>',
      ':lua require("goto-preview").close_all_win()<CR>',
      { silent = true, desc = '[G]oto [P]review [C]lose all windows' }
    )
  end,
}
