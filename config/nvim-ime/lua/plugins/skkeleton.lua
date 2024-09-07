return {
        {
                "vim-skk/skkeleton",
                dependencies = {
                        "vim-denops/denops.vim",
                },
                keys = {
                        { "<C-j>", "<Plug>(skkeleton-enable)", mode = { "i", "c" } }
                },
                config = function()
                        require("dicts")
                end
        }
}
