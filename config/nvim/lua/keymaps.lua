local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

local keymap = vim.api.nvim_set_keymap

-- keymap("n", "<Leader>", "<Cmd><CR>", opts)

local function set_hjkl(h, j, k, l) -- TODO: コードが冗長
    local hu, ju, ku, lu = string.upper(h), string.upper(j), string.upper(k), string.upper(l)
    return {
        "h" .. h,
        h .. "h",
        "H" .. hu,
        hu .. "H",
        "j" .. j,
        j .. "j",
        "J" .. ju,
        ju .. "J",
        "k" .. k,
        k .. "k",
        "K" .. ku,
        ku .. "K",
        "l" .. l,
        l .. "l",
        "L" .. lu,
        lu .. "L",
    }
end

-- vim.opt.langmap = set_hjkl("k", "t", "n", "s")
keymap("n", "U", "<C-r>", opts)
