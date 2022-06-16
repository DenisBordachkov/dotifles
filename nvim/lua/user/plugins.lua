local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install plugins here
return packer.startup(function(use)
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "kyazdani42/nvim-web-devicons"
  use { "kyazdani42/nvim-tree.lua" }
  use "nvim-lua/plenary.nvim"
  use "nvim-lualine/lualine.nvim"
  use "unblevable/quick-scope"
  use "akinsho/bufferline.nvim"
  use "norcalli/nvim-colorizer.lua"
  use "rcarriga/nvim-notify"
  use "tpope/vim-repeat"
  use "moll/vim-bbye"

  -- cmp
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "L3MON4D3/LuaSnip" --snippet engine
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim"
  use "rafamadriz/friendly-snippets"

  -- Colorshemes
  use "lunarvim/darkplus.nvim"
  use "folke/tokyonight.nvim"

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'
  use "nvim-telescope/telescope-file-browser.nvim"

  -- TreeSitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"

  -- LaTeX
  use "lervag/vimtex"

  -- Autopairs
  use "windwp/nvim-autopairs"

  -- Comment package
  use "numToStr/Comment.nvim" -- Easily comment stuff
  use 'JoosepAlviste/nvim-ts-context-commentstring'

  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

