-- return {
-- 	"neovim/nvim-lspconfig",
-- 	event = { "BufReadPre", "BufNewFile" },
-- 	dependencies = {
-- 		"nvim-lua/plenary.nvim",
-- 		"hrsh7th/nvim-cmp",
-- 		"hrsh7th/cmp-nvim-lsp",
-- 		{ "antosha417/nvim-lsp-file-operations", config = true },
-- 		{ "folke/neodev.nvim", opts = {} },
-- 		-- null-ls for formatters and linters
-- 		{
-- 			"nvimtools/none-ls.nvim",
-- 			config = function()
-- 				local null_ls = require("null-ls")
-- 				null_ls.setup({
-- 					sources = {
-- 						null_ls.builtins.formatting.black.with({
-- 							extra_args = { "--fast" }, -- optional Black args
-- 						}),
-- 					},
-- 				})
-- 			end,
-- 		},
-- 	},
-- 	config = function()
-- 		local cmp_nvim_lsp = require("cmp_nvim_lsp")
--
-- 		-- Setup capabilities for LSP servers to support completion
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
-- 			severity_sort = true,
-- 		})
--
-- 		-- General LSP config with capabilities
-- 		vim.lsp.config("*", {
-- 			capabilities = capabilities,
-- 		})
--
-- 		-- Specific configs for some servers
-- 		vim.lsp.config("svelte", {
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
-- 		vim.lsp.config("graphql", {
-- 			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
-- 		})
--
-- 		vim.lsp.config("emmet_ls", {
-- 			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
-- 		})
--
-- 		local function get_root(fname)
-- 			local files = vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { path = fname, upward = true })
-- 			return files[1] and vim.fs.dirname(files[1]) or vim.loop.cwd()
-- 		end
--
-- 		require("lspconfig").ts_ls.setup({
-- 			root_dir = get_root,
-- 			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx", "jsx" },
-- 		})
--
-- 		vim.lsp.config("lua_ls", {
-- 			settings = {
-- 				Lua = {
-- 					diagnostics = { globals = { "vim" } },
-- 					completion = { callSnippet = "Replace" },
-- 				},
-- 			},
-- 		})
--
-- 		-- Python LSP (pyright) with no extra config here, but formatting via null-ls (Black) is enabled
-- 		vim.lsp.config("pyright", {
-- 			capabilities = capabilities,
-- 			settings = {
-- 				python = {
-- 					-- pythonPath = "/home/sarudpol/projects/biosfer/LED-Prediction/.venv/bin/python",
-- 					pythonPath = "python3",
-- 				},
-- 			},
-- 		})
-- 	end,
-- }
--
--
--

return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },

		-- Mason for automatic LSP management
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",

		-- Null-ls (now none-ls) for formatters and linters
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
		-- Mason setup
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"pyright",
				"html",
				"cssls",
				"emmet_ls",
				"graphql",
				"svelte",
				"tailwindcss",
			},
			automatic_installation = true,
		})

		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		-- Capabilities for completion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Diagnostic signs
		vim.diagnostic.config({
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = " ",
					[vim.diagnostic.severity.WARN] = " ",
					[vim.diagnostic.severity.HINT] = "󰠠 ",
					[vim.diagnostic.severity.INFO] = " ",
				},
			},
			severity_sort = true,
		})

		-- Svelte LSP (extra on_attach)
		lspconfig.svelte.setup({
			capabilities = capabilities,
			on_attach = function(client, bufnr)
				vim.api.nvim_create_autocmd("BufWritePost", {
					pattern = { "*.js", "*.ts" },
					callback = function(ctx)
						client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
					end,
				})
			end,
		})

		-- GraphQL
		lspconfig.graphql.setup({
			capabilities = capabilities,
			filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
		})

		-- Emmet
		lspconfig.emmet_ls.setup({
			capabilities = capabilities,
			filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
		})

		-- TypeScript / JavaScript
		lspconfig.ts_ls.setup({
			capabilities = capabilities,
			root_dir = function(fname)
				local files = vim.fs.find({ "package.json", "tsconfig.json", ".git" }, { path = fname, upward = true })
				return files[1] and vim.fs.dirname(files[1]) or vim.loop.cwd()
			end,
			filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "tsx", "jsx" },
		})

		-- Lua
		lspconfig.lua_ls.setup({
			capabilities = capabilities,
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					completion = { callSnippet = "Replace" },
				},
			},
		})

		-- Python (Pyright)
		lspconfig.pyright.setup({
			capabilities = capabilities,
			settings = {
				python = {
					pythonPath = "python3",
				},
			},
		})

		-- HTML / CSS / TailwindCSS
		lspconfig.html.setup({ capabilities = capabilities })
		lspconfig.cssls.setup({ capabilities = capabilities })
		lspconfig.tailwindcss.setup({ capabilities = capabilities })
	end,
}
