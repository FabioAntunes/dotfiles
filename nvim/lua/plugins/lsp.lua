return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("lsp.shared-config")
      -- Mason setup
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "gopls" },
        automatic_installation = true, -- This isn't currently working with nvim 11 - https://github.com/williamboman/mason-lspconfig.nvim/issues/535
      })
      -- Tune diagnostics
      vim.diagnostic.config({
        virtual_text = true, -- still keep inline error signs (or set false to hide)
        signs = true, -- left gutter signs
        underline = true, -- underline the problem
        update_in_insert = false, -- do not update diagnostics while typing
        severity_sort = true, -- show most serious first
        float = {
          border = "rounded",
          source = true, -- show where the error comes from (lsp, etc.)
          header = "",
          prefix = "",
        },
      })
    end,
  },
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" }, -- only load right before saving
    dependencies = {
      "LittleEndianRoot/mason-conform",
    },
    config = function()
      require("conform").setup({
        format_on_save = {
          lsp_fallback = true,
          timeout_ms = 500,
        },
        formatters_by_ft = {
          go = { "goimports", "gofumpt" },
          lua = { "stylua" },
          javascript = { "prettierd", "prettier" },
          -- other mappings
        },
      })
    end,
  },
  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
}
