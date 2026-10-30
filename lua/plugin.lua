vim.pack.add({
    { src = "https://github.com/NStefan002/screenkey.nvim.git",   tags = "main" },
    { src = "https://github.com/catppuccin/nvim.git",             name = "catppuccin" },
    { src = "https://github.com/nvim-mini/mini.nvim.git" },
    { src = "https://github.com/stevearc/oil.nvim.git" },
    { src = "https://github.com/rafamadriz/friendly-snippets.git" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/jay-babu/mason-nvim-dap.nvim.git"},

    { src = "https://github.com/tpope/vim-fugitive" },
    { src = "https://github.com/mfussenegger/nvim-dap.git" },
    { src = "https://github.com/nvim-neotest/nvim-nio.git"},
    { src = "https://github.com/rcarriga/nvim-dap-ui.git"},
    {src = "https://github.com/nvim-tree/nvim-web-devicons"},
    {src = "https://github.com/nvim-lualine/lualine.nvim"},
    {src = "https://github.com/OXY2DEV/markview.nvim"},
})

require("screenkey").setup({
    win_opts = {
        anchor = "SE",
        width = 15,
        height = 1,
        title = "",
    }
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("AutostartScreenkey", {
        clear = true
    }),
    callback = function()
        local ok, screenkey = pcall(require, "screenkey")
        if ok and not screenkey.is_active() then
            screenkey.toggle()
        end
    end,
    desc = "Neovim 시작 시 screenkey 자동 활성화",
})

require("catppuccin").setup({
    flavour = "mocha",
    auto_integration = true,
})

require("oil").setup({
    default_file_explorer = true,
    columns = {
        "icon",
        "mtime",
    }
})

---- mini files ----
require("mini.files").setup({
    --    mappings = {
    --        go_in = "l",
    --        go_in_plug = "L",
    --        go_out = "h",
    --        go_out_plug = "H",
    --    }
})

vim.keymap.set("n", "-", "<cmd>lua MiniFiles.open()<CR>", { desc = "Toggle mini file explorer" })
vim.keymap.set("n", "<leader>-", function()
    MiniFiles.open(vim.api.nvim_buf_get_name(0), false)
    MiniFiles.reveal_cwd()
end, { desc = "Toggle into currently opened file" }
)

---- mini notify ----
require("mini.notify").setup({
    content = {
        format = function(notif)
            return notif.msg
        end,
    }
})

---- mini cmdline completion----
require("mini.cmdline").setup({
    autocorrect = { enable = false }
})

---- mini surround ----
require("mini.surround").setup({

})

---- mini comment ----
-- require("mini.comment").setup({})
--

---- mini picker ----
local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup({})
MiniExtra.setup({})

vim.keymap.set("n", "<leader>ff", function() MiniPick.builtin.files() end, { desc = "Mini File Picker" })
vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep_live() end, {})
-- vim.keymap.set("n", "<leader>/", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, {})
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, { desc = "Mini Help" })

vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Mini Picker Diagnostics" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = "Search keymaps" })

---- mini completions ----
local MiniCompletion = require("mini.completion")
MiniCompletion.setup({
    lsp_completion = {
        auto_setup = true,
        process_items = function(items, base)
            return MiniCompletion.default_process_items(items, base, {
                filtersort = "fuzzy",
            })
        end,
    }
})

---- mini snippets ----
local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(),
    },
    expand = {
        insert = function(snippet)
            MiniSnippets.default_insert(snippet, { empty_tabstop = "" })
        end,
    },
})

MiniSnippets.start_lsp_server({ match = false })
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.api.nvim_set_hl(0, "MiniSnippetsCurrent", {})
        vim.api.nvim_set_hl(0, "MiniSnippetsCurrentReplace", {})
        vim.api.nvim_set_hl(0, "MiniSnippetsFinal", {})
        vim.api.nvim_set_hl(0, "MiniSnippetsUnvisited", {})
        vim.api.nvim_set_hl(0, "MiniSnippetsVisited", {})
    end,
})

---- mini diff ----
local MiniDiff = require("mini.diff")
MiniDiff.setup({
    source = MiniDiff.gen_source.git({ index = false }),
})


-- vim.keymap.set("n", "[h", function() MiniDiff.goto_hunk("prev") end, { desc = "Prev hunk" })
-- vim.keymap.set("n", "]h", function() MiniDiff.goto_hunk("next") end, { desc = "Next hunk" })

-- gh : stage hunk
-- gH : reset hunk

vim.keymap.set("n", "<leader>gg", "<cmd>tabnew | Git | only<CR>", { desc = "Fugitive Full Page New Tab" })
vim.keymap.set("n", "<leader>gd", "<cmd>Gvdiffsplit<CR>", { desc = "Git diff split" })

require('lualine').setup()

---- nvim treesitter ----
require("treesitter")

---- lsp ----
require("lsp")

---- dap ----
require("daps")
