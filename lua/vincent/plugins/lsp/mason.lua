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
mason.setup()

mason_lspconfig.setup({
	-- list of servers for mason to install
	ensure_installed = {
		"tsserver",
		"html",
		"cssls",
		"tailwindcss",
		"sumneko_lua",
		"pyright",
	},
})

mason_null_ls.setup({
	-- list of formatters & linters for mason to install
	ensure_installed = {
		"prettier", -- ts/js formatter
		"alex", -- markdown
		"stylua", -- lua formatter
		"autopep8", -- python formatter
		"eslint_d", -- ts/js diagnostics
	},
	-- auto-install configured formatters & linters (with null-ls)
	automatic_installation = true,
})
