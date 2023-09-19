return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim" },
    opts = {
      ensure_installed = {
        "pyright",
        "yapf",
        "cppdbg",
        "codelldb",
      },
    },
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = { "williamboman/mason.nvim" },
    opts = function()
      local dap = require("dap")
      vim.print("in dap opts")
      local launchWithArgs = {
        args = function()
          local argument_string = vim.fn.input("Program arguments: ")
          return vim.fn.split(argument_string, " ", true)
        end,
        cwd = "${workspaceFolder}",
        name = "Launch file with arguments",
        program = function()
          return vim.fn.input(
            "Path to executable: ",
            vim.fn.getcwd() .. "/",
            "file"
          )
        end,
        request = "launch",
        stopOnEntry = true,
        type = "codelldb",
      }
      if not dap.configurations.cpp then
        dap.configurations.cpp = {
          launchWithArgs,
        }
      else
        vim.list_extend(dap.configurations.cpp, { launchWithArgs })
      end
    end,
  },
}
