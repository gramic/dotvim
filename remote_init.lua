return {
  {
    "rafamadriz/friendly-snippets",
    enabled = false,
  },
  {
    "akinsho/bufferline.nvim",
    enabled = false,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
  },
  -- search quick with s keymap
  {
    "folke/flash.nvim",
    enabled = false,
  },
  -- buffer remove
  {
    "echasnovski/mini.bufremove",
    enabled = false,
  },
  {
    -- easily jump to any location and enhanced f/t motions for Leap
    "ggandor/flit.nvim",
    enabled = false,
  },
  {
    "ggandor/leap.nvim",
    enabled = false,
  },
  -- auto pairs
  {
    "echasnovski/mini.pairs",
    enabled = false,
  },
  {
    "echasnovski/mini.ai",
    config = true,
  },
  {
    "echasnovski/mini.comment",
    enabled = false,
  },
  {
    -- vertical column line
    "m4xshen/smartcolumn.nvim",
    opts = {
      colorcolumn = "81",
    },
  },
  "gcmt/taboo.vim",
  "shumphrey/fugitive-gitlab.vim",
  "mbbill/undotree",
  "qpkorr/vim-bufkill",
  "nelstrom/vim-visual-star-search",
  { "navarasu/onedark.nvim" }, -- colorscheme
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "everforest",
        section_separators = "",
        component_separators = "",
        globalstatus = false,
      },
      sections = {
        lualine_a = { "%{winnr()}" },
        lualine_b = {},
        lualine_c = {
          { "filename", color = "DiffAdd" },
          { "filename", path = 1 },
        },
      },
      inactive_sections = {
        lualine_a = { "%{winnr()}" },
        lualine_b = {},
        lualine_c = {
          "filename",
          { "filename", path = 1, show_filename_only = false },
        },
        lualine_x = { "location", "progress" },
        lualine_y = {},
        lualine_z = {},
      },
    },
  },
  { "ConradIrwin/vim-bracketed-paste" },
  { "ryvnf/readline.vim" },
  "tpope/vim-dadbod",
  "tpope/vim-speeddating",
  "tpope/vim-eunuch",
  "tpope/vim-rhubarb",
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  "tpope/vim-repeat",
  "tpope/vim-unimpaired",
  "tpope/vim-obsession",
  "tpope/vim-abolish",
  "tpope/vim-characterize",
  "tpope/vim-repeat",
  "tpope/vim-surround",
  {
    "nvim-lua/plenary.nvim",
  },
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>ff",
        function()
          require("telescope.builtin").git_files()
        end,
        desc = "Find Git File",
      },
      {
        "<leader>fl",
        function()
          require("telescope.builtin").live_grep()
        end,
        desc = "Find Live Grep",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  { "junegunn/fzf", build = "./install --bin" },
  -- {
  --   "ibhagwan/fzf-lua",
  --   dependencies = { "nvim-tree/nvim-web-devicons", "junegunn/fzf" },
  --   config = true,
  --   -- command = "FzfLua",
  --   keys = {
  --     {
  --       "<leader>fg",
  --       "<cmd>FzfLua live_grep_glob<cr>",
  --       desc = "Live grep glob",
  --     },
  --   },
  -- },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "-",
        "<CMD>Oil<CR>",
        desc = "Open parent directory",
      },
    },
    opts = {
      view_options = {
        show_hidden = true,
        sort = {
          { "name", "asc" },
        },
      },
    },
  },
  { "tomtom/tcomment_vim" },
}
