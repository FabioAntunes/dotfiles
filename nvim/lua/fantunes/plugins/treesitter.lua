require("nvim-treesitter.configs").setup({
  ensure_installed = {
    "bash",
    "css",
    "fish",
    "dockerfile",
    "go",
    "gomod",
    "html",
    "hcl",
    "javascript",
    "json",
    "lua",
    "query",
    "yaml",
  },
  highlight = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
    enable = true,
  },
})
