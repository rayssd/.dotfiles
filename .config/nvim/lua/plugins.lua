-- add list of plugins to install
return {
  -- lua functions that many plugins use

  -- colorscheme
  "ellisonleao/gruvbox.nvim",

  -- treesitter
  { "nvim-treesitter/nvim-treesitter",
    event = "BufReadPost",
    build = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require("lazy-configs.treesitter")
    end,
  },

  { "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("lazy-configs.autopairs")
    end,
  },

  -- lua line
  "nvim-lualine/lualine.nvim",

  -- essential plugins
  "tpope/vim-surround", -- add, delete, change surroundings (it's awesome)

  -- commenting with gc
  "numToStr/Comment.nvim",

  -- Vimwiki
  {"vimwiki/vimwiki", keys={'<Leader>ww'}},

  -- JS Beautify
  { "maksimr/vim-jsbeautify", event="FuncUndefined" },
  -- { "maksimr/vim-jsbeautify", cmd="RangeJsonBeautify" },
  -- { "maksimr/vim-jsbeautify", keys={'<leader>jj'}},


  -- rainbow paranthesis
  -- "p00f/nvim-ts-rainbow")

  -- highlight unmatched brackets
  "vim-scripts/Highlight-UnMatched-Brackets",

  -- file explorer
  { "nvim-tree/nvim-tree.lua",
    dependencies = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    cmd = "NvimTreeToggle",
    config = function()
      require("lazy-configs.nvim-tree")
    end
  },


  -- fuzzy finding w/ telescope
  { "nvim-telescope/telescope.nvim", branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      { "nvim-lua/plenary.nvim" },
    }, -- dependency for better sorting performance
    config = function()
      require("lazy-configs.telescope")
    end
  }, -- fuzzy finder

  { 'VonHeikemen/lsp-zero.nvim',
    event = "InsertEnter",
    config = function()
      require("lazy-configs.lsp")
    end,
    dependencies = {
    -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  },
  -- AI
  { "aduros/ai.vim", cmd = "AI"},

  { "abecodes/tabout.nvim",
    event ="InsertEnter",
    config = function()
      require("lazy-configs.tabout")
    end,
  }
}
