-- NOTE: Plugins can also be configured to run lua code when they are loaded.
--
-- This is often very useful to both group configuration, as well as handle
-- lazy loading plugins that don't need to be loaded immediately at startup.
--
-- For example, in the following configuration, we use:
--  event = 'VimEnter'
--
-- which loads which-key before all the UI elements are loaded. Events can be
-- normal autocommands events (`:help autocmd-events`).
--
-- Then, because we use the `config` key, the configuration only runs
-- after the plugin has been loaded:
--  config = function() ... end

return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()

      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>dd'] = { name = '[D]ocument [D]ebug', _ = 'which_key_ignore' },
        ['<leader>dF'] = { name = '[D]ocument [F]ormat', _ = 'which_key_ignore' },
        ['<leader>ds'] = { name = '[D]ocument [S]ymbols', _ = 'which_key_ignore' },
        ['<leader>dt'] = { name = '[D]ocument [T]wilight', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
        ['<leader>sr'] = { name = '[S]earch [R]eplace | [R]esume', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
        ['<leader>ws'] = { name = '[W]orkspace [S]ymbols', _ = 'which_key_ignore' },
        ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
        ['<leader>bg'] = { name = '[B]uffer [G]roup', _ = 'which_key_ignore' },
        ['<leader>bs'] = { name = '[B]uffer [S]ort', _ = 'which_key_ignore' },
        ['<leader>n'] = { name = '[N]eoTree', _ = 'which_key_ignore' },
        ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
        ['<leader>gh'] = { name = '[G]it [H]unk', _ = 'which_key_ignore' },
        ['<leader>gt'] = { name = '[G]it [T]oggle', _ = 'which_key_ignore' },
        ['<leader>o'] = { name = '[O]rgmode', _ = 'which_key_ignore' },
        ['<leader>x'] = { name = 'Trouble', _ = 'which_key_ignore' },
        ['<leader>u'] = { name = 'Notifications', _ = 'which_key_ignore' },
        ['gp'] = { name = '[G]oto [P]review', _ = 'which_key_ignore' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
