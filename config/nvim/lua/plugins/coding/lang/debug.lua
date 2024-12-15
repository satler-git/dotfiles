return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    keys = {
      {
        "<F1>",
        "<Cmd>lua require('dap').terminate()<CR>",
      },
      {
        "<F5>",
        "<Cmd>lua require('dap').continue()<CR>",
      },
      {
        "<F9>",
        "<Cmd>lua require('dap').pause()<CR>",
      },
      {
        "<F10>",
        "<Cmd>lua require('dap').step_over()<CR>",
      },
      {
        "<F11>",
        "<Cmd>lua require('dap').step_into()<CR>",
      },
      {
        "<F12>",
        "<Cmd>lua require('dap').step_out()<CR>",
      },
      {
        "<F56>", -- <A-F8>
        "<Cmd>lua require('dap').down()<CR>",
      },
      {
        "<F57>", -- <A-F9>
        "<Cmd>lua require('dap').up()<CR>",
      },
      {
        "<Space>b",
        "<Cmd>lua require('dap').toggle_breakpoint()<CR>",
      },
      -- {
      --   "<Space>bc",
      --   function()
      --     require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
      --   end,
      -- },
      -- {
      --   "<Space>l",
      --   function()
      --     require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
      --   end,
      -- },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "jonboh/nvim-dap-rr",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<Space>d",
        "<Cmd>lua require('dapui').toggle()<CR>",
      },
      {
        "<Space><Space>df",
        "<Cmd>lua require('dapui').eval()<CR>",
      },
    },
    opts = {},
  },
  {
    "jonboh/nvim-dap-rr",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local dap = require("dap")
      local rr_dap = require("nvim-dap-rr")

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        command = vim.g.cpptools_path,
      }

      dap.configurations.rust = { rr_dap.get_rust_config() }

      rr_dap.setup({
        mappings = {
          continue = "<F5>",
          reverse_continue = "<F17>", -- <S-F5>

          step_over = "<F10>",
          step_over_i = "<F34>", -- <C-F10>
          reverse_step_over = "<F22>", -- <S-F10>
          reverse_step_over_i = "<F46>", -- <SC-F10>

          step_into = "<F11>",
          step_into_i = "<F36>", -- <C-F11>
          reverse_step_into = "<F23>", -- <S-F11>
          reverse_step_into_i = "<F47>", -- <SC-F11>

          step_out = "<F12>",
          step_out_i = "<F36>", -- <C-F12>
          reverse_step_out = "<F24>", -- <S-F12>
          reverse_step_out_i = "<F48>", -- <SC-F12>
        },
      })
    end,
  },
}
