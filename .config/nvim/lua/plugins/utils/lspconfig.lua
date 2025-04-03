local M = {}
local map = vim.keymap.set

-- export on_attach & capabilities
M.on_attach = function(_, bufnr)
   local function opts(desc)
      return { buffer = bufnr, desc = "LSP " .. desc }
   end

   map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
   map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
   map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
   map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")

end

-- disable semanticTokens
M.on_init = function(client, _)
   if client.supports_method "textDocument/semanticTokens" then
      client.server_capabilities.semanticTokensProvider = nil
   end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
   documentationFormat = { "markdown", "plaintext" },
   snippetSupport = true,
   preselectSupport = true,
   insertReplaceSupport = true,
   labelDetailsSupport = true,
   deprecatedSupport = true,
   commitCharactersSupport = true,
   tagSupport = { valueSet = { 1 } },
   resolveSupport = {
      properties = {
         "documentation",
         "detail",
         "additionalTextEdits",
      },
   },
}

return M
