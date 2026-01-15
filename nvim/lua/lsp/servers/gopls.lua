local lsp = require("lsp.shared-config")

return {
  on_attach = function(client, bufnr)
    lsp.on_attach(client, bufnr)
  end
}
