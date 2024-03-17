return {
  {
    'nvim-pack/nvim-spectre',
    lazy = true,
    build = false,
    cmd = 'Spectre',
    opts = { open_cmd = 'noswapfile vnew' },
    -- stylua: ignore
    keys = {
      { "<leader>srp", function() require("spectre").open() end, desc = "[S]earch [R]e[P]lace in files (Spectre)" },
    },
  },
}
