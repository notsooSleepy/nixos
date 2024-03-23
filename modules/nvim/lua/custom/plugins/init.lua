return {
	-- TODO:
	-- Add treesj
	-- Do i touch markmap?
	-- Check if you need more cmp sources
	-- modify folke/flash below
	--
	{
		"Wansmer/treesj",
		keys = { "<leader>qtm", "<leader>qtj", "<leader>qts" },
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				---@type boolean Use default keymaps (<space>m - toggle, <space>j - join, <space>s - split)
				use_default_keymaps = true,
				---@type boolean Node with syntax error will not be formatted
				check_syntax_error = true,
				---If line after join will be longer than max value,
				---@type number If line after join will be longer than max value, node will not be formatted
				max_join_length = 120,
				---Cursor behavior:
				---hold - cursor follows the node/place on which it was called
				---start - cursor jumps to the first symbol of the node being formatted
				---end - cursor jumps to the last symbol of the node being formatted
				---@type 'hold'|'start'|'end'
				cursor_behavior = "hold",
				---@type boolean Notify about possible problems or not
				notify = true,
				---@type boolean Use `dot` for repeat action
				dot_repeat = true,
				---@type nil|function Callback for treesj error handler. func (err_text, level, ...other_text)
				on_error = nil,
				---@type table Presets for languages
				-- langs = {}, -- See the default presets in lua/treesj/langs
			})
		end,
	},
	{
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		opts = {
			menu = {
				width = vim.api.nvim_win_get_width(0) - 4,
			},
		},
		keys = {
			{
				"<leader>H",
				function()
					require("harpoon"):list():append()
				end,
				desc = "Harpoon file",
			},
			{
				"<leader>hh",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon quick menu",
			},
			{
				"<leader>1",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon to file 1",
			},
			{
				"<leader>2",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon to file 2",
			},
			{
				"<leader>3",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon to file 3",
			},
			{
				"<leader>4",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon to file 4",
			},
			{
				"<leader>5",
				function()
					require("harpoon"):list():select(5)
				end,
				desc = "Harpoon to file 5",
			},
		},
	},
	{
		--TODO:
		--Add more setup options
		"folke/flash.nvim",
		event = "VeryLazy",
		---@type Flash.Config
		opts = {},
	    -- stylua: ignore
	    keys = {
	      { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
	      { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
	      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
	      { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
	      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
	    },
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = vim.opt.sessionoptions:get() },
    -- stylua: ignore
    keys = {
      { "<leader>qps", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>qpl", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qpd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},
}
-- vim: ts=2 sts=2 sw=2 et
