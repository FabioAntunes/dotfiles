local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  execute("packadd packer.nvim")
end

vim.cmd([[packadd packer.nvim]])

vim.cmd("autocmd BufWritePost plugins.lua PackerCompile") -- Auto compile when there are changes in plugins.lua

return require("packer").startup(function(use)
  use({ "wbthomason/packer.nvim", opt = true })
  -- utils
  use({ "jordwalke/VimAutoMakeDirectory" })
  use({ "thinca/vim-visualstar" })
  use({ "tpope/vim-commentary" })
  use({ "tpope/vim-eunuch" })
  use({ "tpope/vim-repeat" })
  use({ "tpope/vim-surround" })

  -- color related stuff
  use({
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup()
    end,
  })
  use({
    "RRethy/nvim-base16",
    config = function()
      require("fantunes.plugins.base16")
    end,
  })

  use({
    "lewis6991/gitsigns.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup({ signcolumn = false })
    end,
  })

  use({
    "nvim-telescope/telescope.nvim",
    cmd = { "Telescope", "TelescopeDotfiles" },
    requires = {
      { "nvim-lua/popup.nvim", opt = true },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
    },
    config = function()
      require("fantunes.plugins.telescope")
    end,
  })

  use({
    "luukvbaal/nnn.nvim",
    config = function()
      require("fantunes.plugins.nnn-nvim")
    end,
  })

  use({
    "famiu/feline.nvim",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("fantunes.plugins.feline")
    end,
  })

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    config = function()
      require("fantunes.plugins.treesitter")
    end,
  })
  use({
    "nvim-treesitter/playground",
    cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
  })
  use({ "windwp/nvim-ts-autotag" })
  use({ "andymass/vim-matchup" })

  -- LSP configs
  use({
    "neovim/nvim-lspconfig",
    requires = { "folke/lua-dev.nvim" },
    config = function()
      require("fantunes.plugins.nvim-lsp")
    end,
  })
  use({
    "hrsh7th/nvim-compe",
    config = function()
      require("fantunes.plugins.nvim-compe")
    end,
  })
end)
