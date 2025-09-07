return {
	{
		"linux-cultist/venv-selector.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("venv-selector").setup({
				name = ".venv", -- venv folder to detect
				default = vim.fn.exepath("python3"), -- fallback python if no venv
			})

			-- Optional keymap to manually select a venv
			vim.keymap.set("n", ";v", ":VenvSelect<CR>", { desc = "Select Python venv for this project" })
		end,
	},
}
