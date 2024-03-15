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
      keys = {
        {
          '<leader>du',
          function()
            require('dapui').toggle {}
          end,
          desc = '[D]ebug [U]I',
        },
        {
          '<leader>de',
          function()
            require('dapui').eval()
          end,
          desc = '[D]ebug [E]val',
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

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, { desc = '[D]ebug: Toggle [B]reakpoint' })
    vim.keymap.set('n', '<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = '[D]ebug: Set [B]reakpoint' })

    -- Dap UI setup
    -- For more information, see |:help nvim-dap-ui|
    dapui.setup {
      -- Set icons to characters that are more likely to work in every terminal.
      --    Feel free to remove or use ones that you like more! :)
      --    Don't feel like these are good choices.
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    }

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

  -- TODO: add change and sort out the keymaps
  -- keys = {
  --   { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
  --   { "<leader>db", function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
  --   { "<leader>dc", function() require("dap").continue() end,                                             desc = "Continue" },
  --   { "<leader>da", function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
  --   { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
  --   { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
  --   { "<leader>di", function() require("dap").step_into() end,                                            desc = "Step Into" },
  --   { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
  --   { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
  --   { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
  --   { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
  --   { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
  --   { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
  --   { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
  --   { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
  --   { "<leader>dt", function() require("dap").terminate() end,                                            desc = "Terminate" },
  --   { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
  -- },
}
