local lspkind = require("lspkind")
local cmp = require("cmp")

vim.opt.completeopt = { "menu", "menuone", "noselect" }

-- Setup nvim-cmp.

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
    ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
    ["<C-e>"] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ["<c-y>"] = cmp.mapping(
      cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      { "i", "c" }
    ),

    ["<c-space>"] = cmp.mapping({
      i = cmp.mapping.complete(),
      c = function(
        _ --[[fallback]]
      )
        if cmp.visible() then
          if not cmp.confirm({ select = true }) then
            return
          end
        else
          cmp.complete()
        end
      end,
    }),
    ["<tab>"] = cmp.config.disable,
  }),
  sources = cmp.config.sources({
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "path" },
    { name = "luasnip" }, -- For luasnip users.
  }, {
    { name = "buffer", keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format({
      with_text = true,
      menu = {
        buffer = "[buf]",
        luasnip = "[snip]",
        nvim_lsp = "[LSP]",
        nvim_lua = "[api]",
        path = "[path]",
      },
      maxwidth = 50,
    }),
  },
  window = {
    completion = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
    documentation = {
      border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
    },
  },
})
