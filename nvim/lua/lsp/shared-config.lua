vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('yolo.lsp', {}),
  callback = function(args)
    local map = function(mode, keys, func, desc)
      vim.keymap.set(mode, keys, func, { buffer = args.buf, desc = desc })
    end

    map("n", "gD", vim.lsp.buf.declaration, "LSP Go to Declaration")
    map("n", "gd", vim.lsp.buf.definition, "LSP Go to Definition")
    map("n", "gt", vim.lsp.buf.type_definition, "LSP Type Definition")
    map("n", "gi", vim.lsp.buf.implementation, "LSP Go to Implementation")
    map("n", "K", vim.lsp.buf.hover, "LSP Hover Docs")
    map("n", "grs", vim.lsp.buf.references, "LSP Signature Help")
    map("n", "grr", vim.lsp.buf.references, "LSP References")
    map("n", "grn", vim.lsp.buf.rename, "LSP Rename")
    map("n", "gra", vim.lsp.buf.code_action, "LSP Code Action")
    map("n", "<leader>tld", "<cmd>Telescope diagnostics<CR>", "LSP Telescope Diagnostics")
  end,
})
