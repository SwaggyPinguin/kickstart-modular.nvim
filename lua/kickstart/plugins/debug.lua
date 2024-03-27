-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
  'mfussenegger/nvim-dap',

  dependencies = {
    -- Creates a beautiful debugger UI
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
      keys = {
        {
          '<leader>ddu',
          function()
            require('dapui').toggle {}
          end,
          desc = '[D]ocument [D]ebug [U]I',
        },
        {
          '<leader>dde',
          function()
            require('dapui').eval()
          end,
          desc = '[D]ocument [D]ebug [E]val',
          mode = { 'n', 'v' },
        },
      },
      opts = {},
    },

    {
      'theHamsta/nvim-dap-virtual-text',
      opts = {},
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    -- 'leoluz/nvim-dap-go',
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    require('mason-nvim-dap').setup {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_setup = true,
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
        -- 'delve', -- Go
        'php-debug-adapter',
      },
    }

    -- TODO: add change and sort out the keymaps
    -- keys = {
    --   { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    --   { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
    --   { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
    --   { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
    --   { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
    --   { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
    --   { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
    --   { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
    --   { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
    --   { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
    --   { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    -- },

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = '[D]ebug: Start/Continue' })
    vim.keymap.set('n', '<leader>ddP', dap.pause, { desc = '[D]ocument [D]ebug: [P]ause' })
    vim.keymap.set('n', '<F10>', dap.step_over, { desc = '[D]ebug: Step Over' })
    vim.keymap.set('n', '<leader>ddi', dap.step_into, { desc = '[D]ocument [D]ebug: Step [I]nto' })
    vim.keymap.set('n', '<leader>ddo', dap.step_out, { desc = '[D]ocument [D]ebug: Step [O]ut' })
    vim.keymap.set('n', '<leader>ddT', dap.terminate, { desc = '[D]ocument [D]ebug: [T]erminate' })

    vim.keymap.set('n', '<leader>ddb', dap.toggle_breakpoint, { desc = '[D]ocument [D]ebug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>ddB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ocument [D]ebug: Set [B]reakpoint' })

    vim.keymap.set({ 'n', 'v' }, '<leader>ddh', function()
      require('dap.ui.widgets').hover()
    end, { desc = '[D]ocument [D]ebug: [H]over' })

    vim.keymap.set({ 'n', 'v' }, '<leader>ddp', function()
      require('dap.ui.widgets').preview()
    end, { desc = '[D]ocument [D]ebug: [P]review' })

    vim.keymap.set('n', '<leader>ddf', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.frames)
    end, { desc = '[D]ocument [D]ebug: [F]rames' })

    vim.keymap.set('n', '<leader>dds', function()
      local widgets = require 'dap.ui.widgets'
      widgets.centered_float(widgets.scopes)
    end, { desc = '[D]ocument [D]ebug: [S]copes' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    -- dapui.setup {
    --   icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
    --   controls = {
    --     enabled = true,
    --     icons = {
    --       pause = '⏸',
    --       play = '▶',
    --       step_into = '', -- ⏎
    --       step_out = '', -- ⏮
    --       step_over = '', -- ⏭
    --       step_back = '', -- b
    --       run_last = '▶▶',
    --       terminate = '', -- ⏹
    --       disconnect = '', -- ⏏
    --     },
    --   },
    -- }

    -- 🔴🛑
    vim.fn.sign_define('DapBreakpoint', { text = '🔴', texthl = 'DapBreakpoint', linehl = 'DapBreakpoint', numhl = 'DapBreakpoint' })

    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    dap.adapters.php = {
      type = 'executable',
      command = 'node',
      args = { vim.env.HOME .. '/.config/vscode-php-debug/out/phpDebug.js' },
    }

    dap.configurations.php = {
      {
        type = 'php',
        request = 'launch',
        name = 'BMC Debug',
        port = 9003,
        pathMappings = {
          ['/var/www/bmc'] = '${workspaceFolder}',
          ['/var/www/bmc-staging'] = '${workspaceFolder}',
          ['/var/www/wifimedia4u'] = '${workspaceFolder}',
        },
      },
      {
        type = 'php',
        request = 'launch',
        name = 'Patient Portal Debug',
        port = 9004,
        pathMappings = {
          ['/var/www/patientportal'] = '${workspaceFolder}',
        },
      },
    }
    -- Install golang specific config
    -- require('dap-go').setup()
  end,
}
