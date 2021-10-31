vim.g.nvim_tree_quit_on_open = 1

require("nvim-tree").setup({
  -- disables netrw completely
  disable_netrw = false,
  -- hijack netrw window on startup
  hijack_netrw = false,
  -- open the tree when running this setup function
  open_on_setup = false,
  -- closes neovim automatically when the tree is the last **WINDOW** in the view
  auto_close = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab = false,
  -- hijacks new directory buffers when they are opened.
  update_to_buf_dir = {
    -- enable the feature
    enable = false,
    -- allow to open the tree if it was previously closed
    auto_open = false,
  },
})
