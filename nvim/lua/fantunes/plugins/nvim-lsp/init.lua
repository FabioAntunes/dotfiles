require("neodev").setup()
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

function Gopls_org_imports(wait_ms)
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { "source.organizeImports" } }
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
  for _, res in pairs(result or {}) do
    for _, r in pairs(res.result or {}) do
      if r.edit then
        vim.lsp.util.apply_workspace_edit(r.edit, "utf-16")
      else
        vim.lsp.buf.execute_command(r.command)
      end
    end
  end
end

-- Setup everything on lsp attach
local on_attach = function(client, bufnr)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0, desc = "LSP declaration" })
  -- C-t jump back previous position
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0, desc = "LSP definition" })
  vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0, desc = "LSP type definition" })
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = 0, desc = "LSP implementation" })
  vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0, desc = "LSP hover" })
  vim.keymap.set("n", "<C-i>", vim.lsp.buf.signature_help, { buffer = 0, desc = "LSP signature help" })
  vim.keymap.set("n", "<leader>ln", vim.lsp.buf.rename, { buffer = 0, desc = "LSP rename" })
  vim.keymap.set("n", "<leader>lr", vim.lsp.buf.references, { buffer = 0, desc = "LSP references" })
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { buffer = 0, desc = "LSP code action" })

  vim.keymap.set(
    "n",
    "<leader>dl",
    "<cmd>Telescope diagnostics<CR>",
    { buffer = 0, desc = "LSP telescope diagnostics" }
  )
  vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, { buffer = 0, desc = "LSP next diagnostic" })
  vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, { buffer = 0, desc = "LSP previous diagnostic" })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    vim.api.nvim_command([[augroup Format]])
    vim.api.nvim_command([[autocmd! * <buffer>]])
    vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]])
    if client.name == "gopls" then
      vim.api.nvim_command([[autocmd BufWritePre <buffer> lua Gopls_org_imports()]])
    end
    vim.api.nvim_command([[augroup END]])
  end

  if client.name == "yamlls" and (vim.bo[bufnr].buftype ~= "" or vim.bo[bufnr].filetype == "gotmpl") then
    vim.diagnostic.disable()
  end

  if client.name == "tflint" then
    vim.diagnostic.config({ signs = false })
  end

  if client.server_capabilities.documentHighlightProvider and client.name ~= "efm" then
    vim.cmd([[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]])
  end
end

local on_attach_without_format = function(client, bufnr)
  -- This makes sure we don't use the LSP for formatting
  -- example: use tsserver for lsp but prettier for formatting
  client.server_capabilities.documentFormattingProvider = false

  on_attach(client, bufnr)
end

-- Tsserver setup
lspconfig.ts_ls.setup({
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("yarn.lock", ".git", "package.json"),
  on_attach = on_attach_without_format,
  settings = { documentFormatting = false },
})

require("lspconfig").gopls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- Lua setup
-- local pathDotfiles = vim.fn.expand("$DOTFILES/lua-language-server")
-- local luadev = require("lua-dev").setup({
--   capabilities = capabilities,
--   lspconfig = {
--     cmd = {
--       pathDotfiles .. "/bin/macOs/lua-language-server",
--       "-E",
--       pathDotfiles .. "/main.lua",
--     },
--     on_attach = on_attach,
--   },
-- })

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace",
      },
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
})
-- Terraform setup
lspconfig.terraformls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "terraform", "terraform-vars", "hcl" },
})
lspconfig.tflint.setup({
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "terraform", "terraform-vars", "hcl" },
})

-- YAML setup
lspconfig.yamlls.setup({
  capabilities = capabilities,
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
lspconfig.vimls.setup({
  capabilities = capabilities,
  on_attach = on_attach,
})

-- JSON lsp
lspconfig.jsonls.setup({
  capabilities = capabilities,
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
local rego = require("fantunes.plugins.nvim-lsp.efm-rego")
local eslint = require("fantunes.plugins.nvim-lsp.efm-eslint")
local luaformat = require("fantunes.plugins.nvim-lsp.efm-luaformat")
local fishformat = require("fantunes.plugins.nvim-lsp.efm-fish")

local languages = {
  css = { prettier },
  fish = { fishformat },
  html = { prettier },
  javascript = { prettier, eslint },
  javascriptreact = { prettier, eslint },
  json = { prettier },
  lua = { luaformat },
  markdown = { prettier },
  rego = { rego },
  scss = { prettier },
  typescript = { prettier, eslint },
  typescriptreact = { prettier, eslint },
  yaml = { prettier },
}

lspconfig.efm.setup({
  capabilities = capabilities,
  cmd = { "efm-langserver", "-logfile", vim.fn.expand("$HOME") .. "/tmp/efm.log" },
  root_dir = lspconfig.util.root_pattern(".git", "package.json", "yarn.lock"),
  filetypes = vim.tbl_keys(languages),
  init_options = { documentFormatting = true, codeAction = false },
  settings = { languages = languages },
  on_attach = on_attach,
})

-- Enable (broadcasting) snippet capability for completion
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
