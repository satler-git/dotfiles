return {
    {
        "romgrk/barbar.nvim",
        dependencies = {
            "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
            "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
        },
        init = function()
            vim.g.barbar_auto_setup = false
        end,
        event = "VeryLazy",
        keys = {
            { "<A-,>", "<Cmd>BufferPrevious<CR>" },
            { "<A-.>", "<Cmd>BufferNext<CR>" },
            { "<A-1>", "<Cmd>BufferGoto 1<CR>" },
            { "<A-2>", "<Cmd>BufferGoto 2<CR>" },
            { "<A-3>", "<Cmd>BufferGoto 3<CR>" },
            { "<A-4>", "<Cmd>BufferGoto 4<CR>" },
            { "<A-5>", "<Cmd>BufferGoto 5<CR>" },
            { "<A-6>", "<Cmd>BufferGoto 6<CR>" },
            { "<A-7>", "<Cmd>BufferGoto 7<CR>" },
            { "<A-8>", "<Cmd>BufferGoto 8<CR>" },
            { "<A-9>", "<Cmd>BufferGoto 9<CR>" },
            { "<A-0>", "<Cmd>BufferLast<CR>" },
            { "<A-c>", "<Cmd>BufferClose<CR>" },
            { "<A-s-c>", "<Cmd>BufferRestore<CR>" },
            -- { "<A-a-c>", "<Cmd>BufferCloseAllButVisible<CR>" },
            {
                "<Leader>bsd",
                "<Cmd>BufferOrderByDirectory<CR>",
                desc = "Buffer OrderByDirectory",
            },
        },
        opts = { preserve_window_layout = { "this" } },
        version = "^1.0.0",
    },
}
