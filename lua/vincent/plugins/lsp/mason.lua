-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  print("mason not found!")
  return
end

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  print("mason-lspconfig not found!")
  return
end

-- import mason-null-ls plugin safely
local mason_null_ls_status, mason_null_ls = pcall(require, "mason-null-ls")
if not mason_null_ls_status then
  print("mason-null-ls not found!")
  return
end

-- enable mason
mason.setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

mason_lspconfig.setup({
  -- list of servers for mason to install : https://github.com/williamboman/mason-lspconfig.nvim#configuration
  ensure_installed = {
    -- "bashls",
    -- "cssls",
    -- "dockerls",
    -- "eslint",
    -- "html",
    -- "jsonls",
    -- "tsserver",
    -- "sumneko_lua",
    -- "marksman",
    -- "powershell_es",
    -- "pyright",
    -- "sqls",
    -- "yamlls",
  },
  automatic_installation = false,
})

mason_null_ls.setup({
  -- list of formatters & linters for mason to install : https://github.com/jayp0521/mason-null-ls.nvim
  ensure_installed = {
    -- "djlint", -- django jinja.html htmldjango
    -- "hadolint", -- Dockerfile
    -- "xo", -- javascript javascriptreact typescript typescriptreact
    -- "eslint_d", -- javascript javascriptreact typescript typescriptreact vue
    -- "prettier", -- javascript javascriptreact typescript typescriptreact vue css scss less html json jsonc yaml markdown markdown.mdx graphql handlebars
    -- "fixjson", -- json
    -- "stylua", -- lua formatter
    -- "alex", -- markdown
    -- "black", -- python
    -- "shellcheck", -- sh
    -- "sqlfluff", -- sql
    -- "vint", -- vim
    -- "actionlint", -- yaml
  },
  automatic_installation = true,
  automatic_setup = true,
})
