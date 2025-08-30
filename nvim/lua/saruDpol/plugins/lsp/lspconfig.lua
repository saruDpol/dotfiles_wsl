return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		-- null-ls for formatters and linters
		{
			"nvimtools/none-ls.nvim",
			config = function()
				local null_ls = require("null-ls")
				null_ls.setup({
					sources = {
						null_ls.builtins.formatting.black.with({
							extra_args = { "--fast" }, -- optional Black args
						}),
					},
				})
			end,
		},
	},
	config = function()
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Setup capabilities for LSP servers to support completion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
		})

		-- General LSP config with capabilities
		vim.lsp.config("*", {
			capabilities = capabilities,
		})

		-- Specific configs for some servers
		vim.lsp.config("svelte", {
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		vim.lsp.config("graphql", {
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- vim.lsp.config("eslint", {
		-- 	root_dir = function()
		-- 		return vim.loop.cwd()
		-- 	end,
		-- 	filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte", "tsx" },
		-- })

		local function get_root(fname)
			local files = vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { path = fname, upward = true })
			return files[1] and vim.fs.dirname(files[1]) or vim.loop.cwd()
		end

		require("lspconfig").ts_ls.setup({
			root_dir = get_root,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx", "jsx" },
		})

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Python LSP (pyright) with no extra config here, but formatting via null-ls (Black) is enabled
		vim.lsp.config("pyright", {
			capabilities = capabilities,
			settings = {
				python = {
					pythonPath = "/usr/bin/python3",
				},
			},
		})
	end,
}
--
-- return {
-- 	"neovim/nvim-lspconfig",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"hrsh7th/nvim-cmp",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		{ "antosha417/nvim-lsp-file-operations", config = true },
-- 		{ "folke/neodev.nvim", opts = {} },
-- 		{
-- 			"nvimtools/none-ls.nvim",
-- 			config = function()
-- 				local null_ls = require("null-ls")
-- 				null_ls.setup({
-- 					sources = {
-- 						null_ls.builtins.formatting.black.with({
-- 							extra_args = { "--fast" },
-- 						}),
-- 					},
-- 				})
-- 			end,
-- 		},
-- 	},
-- 	config = function()
-- 		local lspconfig = require("lspconfig")
-- 		local util = require("lspconfig.util")
-- 		local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- 		local capabilities = cmp_nvim_lsp.default_capabilities()
--
-- 		vim.diagnostic.config({
-- 			signs = {
-- 				text = {
-- 					[vim.diagnostic.severity.ERROR] = " ",
-- 					[vim.diagnostic.severity.WARN] = " ",
-- 					[vim.diagnostic.severity.HINT] = "󰠠 ",
-- 					[vim.diagnostic.severity.INFO] = " ",
-- 				},
-- 			},
-- 		})
--
-- 		-- General LSP setup with capabilities
-- 		vim.lsp.config("*", {
-- 			capabilities = capabilities,
-- 		})
--
-- 		-- Helper: ESLint safe root_dir
-- 		local function eslint_root_dir(fname)
-- 			local root = util.root_pattern(".eslintrc.js", ".eslintrc.json", ".git")(fname)
-- 			if type(root) == "table" then
-- 				root = root[1] or vim.loop.cwd()
-- 			end
-- 			return root or vim.loop.cwd()
-- 		end
--
-- 		-- TS / TSX LSP
-- 		lspconfig.ts_ls.setup({
-- 			capabilities = capabilities,
-- 			filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact" },
-- 			root_dir = function(fname)
-- 				local root = util.root_pattern("tsconfig.json", "package.json", ".git")(fname)
-- 				if type(root) == "table" then
-- 					root = root[1] or vim.loop.cwd()
-- 				end
-- 				return root or vim.loop.cwd()
-- 			end,
-- 		})
--
-- 		-- ESLint LSP
-- 		lspconfig.eslint.setup({
-- 			capabilities = capabilities,
-- 			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte", "tsx" },
-- 			root_dir = eslint_root_dir,
-- 			settings = { validate = "on" },
-- 		})
--
-- 		-- Svelte
-- 		lspconfig.svelte.setup({
-- 			capabilities = capabilities,
-- 			filetypes = { "svelte" },
-- 			on_attach = function(client, bufnr)
-- 				vim.api.nvim_create_autocmd("BufWritePost", {
-- 					pattern = { "*.js", "*.ts" },
-- 					callback = function(ctx)
-- 						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
-- 					end,
-- 				})
-- 			end,
-- 		})
--
-- 		-- GraphQL
-- 		lspconfig.graphql.setup({
-- 			capabilities = capabilities,
-- 			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
-- 		})
--
-- 		-- Emmet
-- 		lspconfig.emmet_ls.setup({
-- 			capabilities = capabilities,
-- 			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- 		})
--
-- 		-- Lua
-- 		lspconfig.lua_ls.setup({
-- 			capabilities = capabilities,
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = { globals = { "vim" } },
-- 					completion = { callSnippet = "Replace" },
-- 				},
-- 			},
-- 		})
--
-- 		-- Python
-- 		lspconfig.pyright.setup({
-- 			capabilities = capabilities,
-- 			settings = {
-- 				python = {
-- 					pythonPath = "/usr/bin/python3",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }
