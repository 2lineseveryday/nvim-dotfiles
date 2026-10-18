vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {noremap = true})

-- replaces selected text WITHOUT losing what you yanked
vim.keymap.set("x", "p", [["_dP]], {desc = "Paste over selection without losing yanked text"})

-- Delete text without saving it to any register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], {desc = "Delete without yanking"})

-- vim.keymap.set("i", "<C-c>", "<Esc>")
-- vim.keymap.set("n", "<C-c>", "<cmd>noh<CR>", {desc = "Clear search highlighting", silent = true})
vim.keymap.set("n", "<Esc>", "<cmd>noh<CR>")

vim.keymap.set("n", "<C-j>", ":m +1<CR>", {desc = "moves a line down"})
vim.keymap.set("n", "<C-k>", ":m -2<CR>", {desc = "moves a line up"})
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", {desc = "moves lines down in visual selection"})
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", {desc = "moves lines up in visual selection"})

vim.keymap.set("v", "<", "<gv", {desc = "Unindent and keep selection"})
vim.keymap.set("v", ">", ">gv", {desc = "Indent and keep selection"})

vim.keymap.set("n", "J", "mzJ`z", {desc = "Join lines without moving cursor"})

vim.keymap.set("n", "<C-d>", "<C-d>zz", {desc = "move down in buffer with cursor centered"})
vim.keymap.set("n", "<C-u>", "<C-u>zz", {desc = "move up in buffer with cursor centered"})

vim.keymap.set("n", "n", "nzzzv", {desc = "Next search result cursor centered"})
vim.keymap.set("n", "N", "Nzzzv", {desc = "Previous search result cursor centered"})

vim.keymap.set("n", "<leader>r", [[:%s/<C-r><C-w>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = "Replace"})
-- vim.keymap.set("n", "<leader>re", "<cmd>restart!<CR>")

vim.keymap.set("n", "<leader>u", function()
    vim.cmd.packadd("nvim.undotree")
    require("undotree").open()
end, {desc = "Toggle Builtin Undotree"}
)

-- vim.keymap.set("n", "<leader>/", function()
--     local text = vim.fn.input("Grep > ")
--     if text == "" then return end
--     vim.cmd("silent grep! " .. text)
--     vim.cmd("copen")
-- end, {desc="Grep to quickfix"}
-- )
