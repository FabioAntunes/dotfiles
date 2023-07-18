vim.cmd([[packadd popup.nvim]])
vim.cmd([[packadd plenary.nvim]])
vim.cmd([[packadd telescope.nvim]])

local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")

require("telescope").setup({
  defaults = {
    initial_mode = "insert",
    shorten_path = false,
    mappings = {
      i = {
        ["<C-n>"] = actions.move_selection_next,
        ["<C-p>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
        ["<esc>"] = actions.close,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
    },
  },
})
