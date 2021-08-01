local lspconfig = require("lspconfig")

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...)
    vim.api.nvim_buf_set_keymap(bufnr, ...)
  end

  -- Mappings.
  local opts = { noremap = true, silent = true }
  buf_set_keymap("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<leader>ld", "<Cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "gh", "<Cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  -- buf_set_keymap('n', '<space>rm', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap("n", "<leader>ln", "<cmd>lua require'lsp-ui.rename'.rename()<CR>", opts)
  buf_set_keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>d", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  buf_set_keymap("n", "<leader>i", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", opts)
  buf_set_keymap("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", opts)

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.cmd([[command! LspFormat lua vim.lsp.buf.formatting_sync()]])
    vim.cmd([[augroup lsp_formatting]])
    vim.cmd([[autocmd!]])
    vim.cmd([[autocmd BufWritePre <buffer> :lua vim.lsp.buf.formatting_sync()]])
    vim.cmd([[augroup END]])
  end
end

local on_attach_without_format = function(client, bufnr)
  -- This makes sure we don't use the LSP for formatting
  -- example: use tsserver for lsp but prettier for formatting
  client.resolved_capabilities.document_formatting = false

  on_attach(client, bufnr)
end

-- Tsserver setup
lspconfig.tsserver.setup({
  root_dir = lspconfig.util.root_pattern("yarn.lock", ".git", "package.json"),
  on_attach = on_attach_without_format,
  settings = { documentFormatting = false },
})

-- Lua setup
local pathDotfiles = vim.fn.expand("$DOTFILES/lua-language-server")
local luadev = require("lua-dev").setup({
  lspconfig = {
    cmd = {
      pathDotfiles .. "/bin/macOs/lua-language-server",
      "-E",
      pathDotfiles .. "/main.lua",
    },
    on_attach = on_attach,
  },
})
lspconfig.sumneko_lua.setup(luadev)

-- Terraform setup
lspconfig.terraformls.setup({
  on_attach = on_attach,
})
lspconfig.tflint.setup({
  on_attach = on_attach,
})

-- YAML setup
lspconfig.yamlls.setup({
  settings = {
    yaml = {
      schemas = {
        ["http://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
        ["https://json.schemastore.org/chart.json"] = "**/Chart.yaml",
        ["https://raw.githubusercontent.com/Azure/vscode-kubernetes-tools/master/syntaxes/helm.tmLanguage.json"] = "/*",
      },
    },
  },
  on_attach = on_attach_without_format,
})

-- Vim lsp
lspconfig.vimls.setup({ on_attach = on_attach })

-- JSON lsp
lspconfig.jsonls.setup({
  on_attach = on_attach_without_format,
  settings = {
    json = {
      -- Schemas https://www.schemastore.org
      schemas = {
        {
          fileMatch = { "package.json" },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json" },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
            "prettier.config.json",
          },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = { ".eslintrc", ".eslintrc.json" },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = {
            ".babelrc",
            ".babelrc.json",
            "babel.config.json",
          },
          url = "https://json.schemastore.org/babelrc.json",
        },
        {
          fileMatch = {
            ".stylelintrc",
            ".stylelintrc.json",
            "stylelint.config.json",
          },
          url = "http://json.schemastore.org/stylelintrc.json",
        },
      },
    },
  },
})

-- Formatting and linting via efm
local prettier = require("fantunes.plugins.nvim-lsp.efm-prettier")
local eslint = require("fantunes.plugins.nvim-lsp.efm-eslint")
local luaformat = require("fantunes.plugins.nvim-lsp.efm-luaformat")
local fishformat = require("fantunes.plugins.nvim-lsp.efm-fish")

local languages = {
  css = { prettier },
  fish = { fishformat},
  html = { prettier },
  javascript = { prettier, eslint },
  javascriptreact = { prettier, eslint },
  json = { prettier },
  lua = { luaformat },
  markdown = { prettier },
  scss = { prettier },
  typescript = { prettier, eslint },
  typescriptreact = { prettier, eslint },
  yaml = { prettier },
}

lspconfig.efm.setup({
  root_dir = lspconfig.util.root_pattern("yarn.lock", "package.json", ".git"),
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true, codeAction = true },
  settings = { languages = languages, log_level = 1, log_file = vim.fn.expand("~/efm.log") },
  on_attach = on_attach,
})

-- Enable (broadcasting) snippet capability for completion
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
