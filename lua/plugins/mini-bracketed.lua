return {
  {
    "echasnovski/mini.bracketed",
    version = false,
    enabled = false,
    dependencies = {
      "echasnovski/mini.nvim",
      "folke/which-key.nvim",
    },
    -- keys = {
    --   {
    --     "]f",
    --     "<cmd>lua MiniBracketed.file('forward')<cr>",
    --     desc = "Next file on disk",
    --   },
    --   {
    --     "]F",
    --     "<cmd>lua MiniBracketed.file('last')<cr>",
    --     desc = "Last file on disk",
    --   },
    --   {
    --     "[f",
    --     "<cmd>lua MiniBracketed.file('backward')<cr>",
    --     desc = "Previous file on disk",
    --   },
    --   {
    --     "[F",
    --     "<cmd>lua MiniBracketed.file('first')<cr>",
    --     desc = "First file on disk",
    --   },
    -- },
    opts = {
      -- First-level elements are tables describing behavior of a target:
      --
      -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
      --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
      --   Supply empty string `''` to not create mappings.
      --
      -- - <options> - table overriding target options.
      --
      -- See `:h MiniBracketed.config` for more info.
      buffer = { suffix = "", options = {} },
      comment = { suffix = "", options = {} },
      conflict = { suffix = "", options = {} },
      diagnostic = { suffix = "", options = {} },
      file = { suffix = "f", options = {} },
      indent = { suffix = "", options = {} },
      jump = { suffix = "", options = {} },
      location = { suffix = "", options = {} },
      oldfile = { suffix = "", options = {} },
      quickfix = { suffix = "", options = {} },
      treesitter = { suffix = "", options = {} },
      undo = { suffix = "", options = {} },
      window = { suffix = "", options = {} },
      yank = { suffix = "", options = {} },
    },
  },
}
