local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.after.event_terminalted.dapui_config = function() dapui.close() end
dap.listeners.after.event_exited.dapui_config = function() dapui.close() end

require("mason-nvim-dap").setup({
    automatic_setup =true,
    handlers = {
        -- function(config)
        --     require("mason-nvim-dap").default_setup(config)
        -- end,
    },
})

vim.keymap.set("n", "<F5>", function() dap.continue() end, { desc = "Debug: Start/Continue" })
vim.keymap.set("n", "<F10>", function() dap.step_over() end, { desc = "Debug: Step Over" })
vim.keymap.set("n", "<F11>", function() dap.step_into() end, { desc = "Debug: Step Into" })
vim.keymap.set("n", "<F12>", function() dap.step_out() end, { desc = "Debug: Step Out" })
vim.keymap.set("n", "<leader>b", function() dap.toggle_breakpoint() end, { desc = "Debug: Toggle Breakpoint" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "Debug: Toggle UI" })
