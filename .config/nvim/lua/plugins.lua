-- auto install packer if not installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer() -- true if packer was just installed

-- autocommand that reloads neovim and installs/updates/removes plugins
-- when file is saved
vim.cmd([[ 
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- import packer safely
local status, packer = pcall(require, "packer")
if not status then
  return
end

-- add list of plugins to install
return packer.startup(function(use)
  -- packer can manage itself
  use("wbthomason/packer.nvim")

  -- lua functions that many plugins use
  use("nvim-lua/plenary.nvim") 

  -- colorscheme
  use("ellisonleao/gruvbox.nvim")

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
      ts_update()
    end,
  })

  -- lua line
  use("nvim-lualine/lualine.nvim")

  -- essential plugins
  use("tpope/vim-surround") -- add, delete, change surroundings (it's awesome)

  -- commenting with gc
  use("numToStr/Comment.nvim")

  -- Vimwiki
  -- use("vimwiki/vimwiki")
  use{"vimwiki/vimwiki", keys={{'n', '<Leader>ww'}}}

  -- JS Beautify
  -- use{ "maksimr/vim-jsbeautify", event="FuncUndefined" }
  use{ "maksimr/vim-jsbeautify", fn="RangeJsonBeautify" }


  -- rainbow paranthesis
  -- use("p00f/nvim-ts-rainbow")

  -- highlight unmatched brackets
  use("vim-scripts/Highlight-UnMatched-Brackets")

  -- auto closing
  use("windwp/nvim-autopairs") -- autoclose parens, brackets, quotes, etc...

  -- file explorer
  use{ "nvim-tree/nvim-tree.lua", 
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    cmd = "NvimTreeToggle",
    config = function()
      require("lazy-configs.nvim-tree")
    end
  }

  -- vs-code like icons
  -- use{ "nvim-tree/nvim-web-devicons", after = "nvim-tree.lua" }
  use("nvim-tree/nvim-web-devicons")

  -- fuzzy finding w/ telescope
  use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" }) -- dependency for better sorting performance
  use{ "nvim-telescope/telescope.nvim", branch = "0.1.x",
    cmd = "Telescope",
    config = function()
      require("lazy-configs.telescope")
    end
  } -- fuzzy finder

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  requires = {
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
  }

  -- AI
  use("aduros/ai.vim")

if packer_bootstrap then
   require("packer").sync()
  end
end)
