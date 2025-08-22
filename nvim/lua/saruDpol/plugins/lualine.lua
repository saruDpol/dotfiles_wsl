local colors = {
	black = "#383a42",
	white = "#e5e5e5",
	orange = "#f8520e",
	red = "#d0140e",
	green = "#859901",
	blue = "#124f5e",
	purple = "#6c71c4",
	gold = "#ffc102",
	darkblue = "#012b36",
	pink = "#f255a1",
	darkgold = "#332700",
}
return { -- Statusline
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		options = {
			icons_enabled = true,
			--theme = "solarized_dark",
			theme = {
				normal = {
					a = { fg = colors.white, bg = colors.red, gui = "bold" },
					b = { fg = colors.white, bg = colors.grey },
					c = { fg = colors.white, bg = colors.blue },
					z = { fg = colors.white, bg = colors.red, gui = "bold" },
				},
				insert = {
					a = { fg = colors.white, bg = colors.green, gui = "bold" },
					z = { fg = colors.white, bg = colors.green, gui = "bold" },
				},
				visual = {
					a = { fg = colors.white, bg = colors.pink, gui = "bold" },
					z = { fg = colors.white, bg = colors.pink, gui = "bold" },
				},
				replace = {
					a = { fg = colors.white, bg = colors.purple, gui = "bold" },
					z = { fg = colors.white, bg = colors.purple, gui = "bold" },
				},
				command = {
					a = { fg = colors.darkblue, bg = colors.gold, gui = "bold" },
					z = { fg = colors.darkblue, bg = colors.gold, gui = "bold" },
				},
			},
			component_separators = { left = "|", right = "|" },
			section_separators = { left = "", right = "" },
			disabled_filetypes = {
				statusline = {},
				winbar = {},
			},
			ignore_focus = {},
			always_divide_middle = true,
			always_show_tabline = true,
			globalstatus = false,
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
			lualine_b = {
				{
					"filename",
					separator = { left = "░▒▓", right = "" },
					color = { fg = "#d6a04a", bg = "#012b36" },
				},
				{
					"diagnostics",
					symbols = { error = " ", warn = " ", info = " " },
					separator = { right = "" },
					color = { bg = "#063642" },
					diagnostics_color = {
						color_error = { fg = "#b7221e" },
						color_warn = { fg = "#ffc102" },
						color_info = { fg = "#27eedf" },
					},
				},
			},
			lualine_c = { { "branch", color = { bg = "#124f5e" } } },
			lualine_x = {
				{ "encoding", color = { bg = "#124f5e" } },
				{ "fileformat", color = { bg = "#124f5e" } },
				{ "filetype", separator = { right = "" }, color = { bg = "#124f5e" } },
			},
			lualine_y = {
				{
					"progress",
					separator = { right = "▓▒░" },
					color = { fg = "#d6a04a", bg = colors.darkblue },
				},
			},
			lualine_z = {
				{ "location", separator = { right = "" }, left_padding = 2 },
			},
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = { "filename" },
			lualine_c = {},
			lualine_x = { "location" },
			lualine_y = {},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = {},
	},
}
