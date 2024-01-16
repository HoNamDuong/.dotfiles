return {
    "mfussenegger/nvim-dap",
    dependencies = {
        -- Fancy UI for the debugger
        {
            "rcarriga/nvim-dap-ui",
            keys = {
                -- stylua: ignore start
                { "<leader>du", function() require("dapui").toggle({}) end, desc = "Toggle UI [nvim-dap-ui]", },
                { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate under cursor [nvim-dap-ui]", mode = { "n", "v" }, },
                -- stylua: ignore end
            },
            opts = {},
            config = function(_, opts)
                local dap, dapui = require("dap"), require("dapui")
                dapui.setup(opts)

                dap.listeners.before.attach.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.launch.dapui_config = function()
                    dapui.open()
                end
                dap.listeners.before.event_terminated.dapui_config = function()
                    dapui.close()
                end
                dap.listeners.before.event_exited.dapui_config = function()
                    dapui.close()
                end
            end,
        },
        -- Virtual text for the debugger
        {
            "theHamsta/nvim-dap-virtual-text",
            opts = {},
        },
    },
    keys = {
        -- stylua: ignore start
        -- Breakpoint
        { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Add or remove breakpoint", },
        { "<leader>dB", function() require("dap").clear_breakpoints() end, desc = "Clear breakpoints", },
        { "<leader>dc", function() require("dap").set_breakpoint(vim.fn.input("Condition: ")) end, desc = "Add conditional breakpoint", },
        { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log message: ')) end, desc = "Add log point", },
        { "<leader>dh", function() require("dap").set_breakpoint(nil, vim.fn.input("Hit condition: ")) end, desc = "Add hit condition", },

        -- { "<leader>d", function() require("dap").session() end, desc = "Session" },
        -- { "<leader>d", function() require("dap").run_to_cursor() end, desc = "Run to cursor" },
        -- { "<leader>d", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
        -- { "<leader>d", function() require("dap.ui.widgets").preview() end, desc = "Widgets" },
        -- { "<leader>d", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
        -- { "<leader>d", function() require("dap").pause() end, desc = "Pause", },
        -- { "<leader>d", function() require("dap").restart_frame() end, desc = "Restart", },
        -- { "<leader>d", function() require("dap").close() end, desc = "Close session", },

        -- Control
        { "<leader>d<F5>", function() require("dap").continue() end, desc = " Run or continue", },
        { "<leader>d<F9>", function() require("dap").step_back() end, desc = " Step back", },
        { "<leader>d<F10>", function() require("dap").step_over() end, desc = " Step over", },
        { "<leader>d<F11>", function() require("dap").step_into() end, desc = " Step into", },
        { "<leader>d<F12>", function() require("dap").step_out() end, desc = " Step out", },
        { "<leader>dr", function() require("dap").run_last() end, desc = " Run last", },
        { "<leader>dt", function() require("dap").terminate() end, desc = " Terminate", },
        { "<leader>dd", function() require("dap").disconnect() require("dap").close() end, desc = " Disconnect", },
        -- stylua: ignore end
    },

    config = function()
        local signs = {
            Stopped = { "󰁕 ", "DiagnosticWarn" },
            LogPoint = { ".>", "DiagnosticInfo" },
            Breakpoint = { " ", "DiagnosticInfo" },
            BreakpointCondition = { " ", "DiagnosticInfo" },
            BreakpointRejected = { " ", "DiagnosticError" },
        }

        for name, sign in pairs(signs) do
            sign = type(sign) == "table" and sign or { sign }
            vim.fn.sign_define("Dap" .. name, { text = sign[1], texthl = sign[2], linehl = sign[3], numhl = sign[3] })
        end

        local dap = require("dap")

        -- Javascript
        dap.adapters["pwa-node"] = {
            type = "server",
            host = "localhost",
            port = "${port}",
            executable = {
                command = "node",
                args = { vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js", "${port}" },
            },
        }
        dap.configurations.javascript = {
            {
                name = "Launch file",
                type = "pwa-node",
                request = "launch",
                program = "${file}",
                cwd = "${workspaceFolder}",
                console = "integratedTerminal",
            },
        }

        -- C
        dap.adapters.codelldb = {
            type = "server",
            port = "${port}",
            executable = {
                command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
                args = { "--port", "${port}" },
            },
        }
        dap.configurations.c = {
            {
                name = "Launch file",
                type = "codelldb",
                request = "launch",
                program = function()
                    return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        }
    end,
}
