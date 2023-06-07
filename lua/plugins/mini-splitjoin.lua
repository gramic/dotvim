return {
  {
    "echasnovski/mini.splitjoin",
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
  },
}
