return {
  {
    "echasnovski/mini.splitjoin",
    -- name = "mini.splitjoin",
    version = false,
    keys = {
      {
        "gS",
        "<cmd>lua MiniSplitjoin.toggle()<cr>",
        desc = "Mini SplitJoin toggle",
      },
    },
    dependencies = { "folke/which-key.nvim" },
    opts = {
      mappings = {
        toggle = "",
      },
    },
    config = function(_, opts)
      require("mini.splitjoin").setup(opts or {})
    end,
  },
}
