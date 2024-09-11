return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "neovim/nvim-lspconfig",
        },
        lazy = true,
        keys = {
            { "<F5>", ":lua require'dap'.continue()<CR>" },
            { "<F10>", ":lua require'dap'.step_over()<CR>" },
            { "<F11>", ":lua require'dap'.step_into()<CR>" },
            { "<F12>", ":lua require'dap'.step_out()<CR>" },
            { "<leader>b", ":lua require'dap'.toggle_breakpoint()<CR>" },
            { "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" },
            { "<leader>l", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap",
            "nvim-neotest/nvim-nio",
        },
        keys = {
            { "<leader>d", ":lua require'dapui'.toggle()<CR>" },
            { "<leader><leader>df", ":lua require'dapui'.eval()<CR>" },
        },
        opts = {},
    },
}
