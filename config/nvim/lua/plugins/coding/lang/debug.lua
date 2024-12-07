return {
  {
    "mfussenegger/nvim-dap",
    enable = false,
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    lazy = true,
    keys = {
      { "<F5>", ":lua require'dap'.continue()<CR>" },
      { "<F10>", ":lua require'dap'.step_over()<CR>" },
      { "<F11>", ":lua require'dap'.step_into()<CR>" },
      { "<F12>", ":lua require'dap'.step_out()<CR>" },
      { "<Space>b", ":lua require'dap'.toggle_breakpoint()<CR>" },
      { "<Space>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
      { "<Space>l", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    enable = false,
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      { "<Space>d", ":lua require'dapui'.toggle()<CR>" },
      { "<Space><Space>df", ":lua require'dapui'.eval()<CR>" },
    },
    opts = {},
  },
}
