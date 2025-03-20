return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2", -- Using the newer version of Harpoon
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")

		-- REQUIRED: Setup harpoon
		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				enter_on_sendcmd = false,
				tmux_autoclose_windows = false,
				excluded_filetypes = { "harpoon", "TelescopePrompt", "NvimTree", "neo-tree" },
				mark_branch = false,
				menu = {
					width = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
				}
			}
		})

		-- Basic keymaps
		vim.keymap.set("n", "<leader>ma", function() harpoon:list():add() end,
			{ desc = "Harpoon: Add current file" })
		vim.keymap.set("n", "<leader>mm", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
			{ desc = "Harpoon: Toggle quick menu" })

		-- Navigation keymaps (using leader key)
		vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end,
			{ desc = "Harpoon: Jump to file 1" })
		vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end,
			{ desc = "Harpoon: Jump to file 2" })
		vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end,
			{ desc = "Harpoon: Jump to file 3" })
		vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end,
			{ desc = "Harpoon: Jump to file 4" })

		-- Sequential navigation
		vim.keymap.set("n", "<C-n>", function() harpoon:list():next() end,
			{ desc = "Harpoon: Next file" })
		vim.keymap.set("n", "<C-p>", function() harpoon:list():prev() end,
			{ desc = "Harpoon: Previous file" })

		-- Simple replacement function for Harpoon 2
		local function replace_at_position(position)
			local list = harpoon:list()
			local current_file = vim.fn.expand("%:p")

			-- First check if file is already in the list
			local found_idx = nil
			for i, item in ipairs(list.items) do
				if item.value == current_file then
					found_idx = i
					break
				end
			end

			-- If file is found and not at desired position, remove it
			if found_idx and found_idx ~= position then
				table.remove(list.items, found_idx)
			end

			-- If file wasn't found or was at wrong position and removed
			if not found_idx or found_idx ~= position then
				-- Ensure the list has enough items
				while #list.items < position - 1 do
					table.insert(list.items, { value = "" }) -- Insert placeholders
				end

				-- Now insert at the desired position
				if position <= #list.items then
					table.insert(list.items, position, { value = current_file })
				else
					table.insert(list.items, { value = current_file })
				end
			end

			-- Save the changes
			harpoon:sync()

			vim.notify("Set file at position " .. position, vim.log.levels.INFO)
		end

		-- Replace files at specific positions
		vim.keymap.set("n", "<leader>mr1", function()
			replace_at_position(1)
		end, { desc = "Harpoon: Replace file 1" })

		vim.keymap.set("n", "<leader>mr2", function()
			replace_at_position(2)
		end, { desc = "Harpoon: Replace file 2" })

		vim.keymap.set("n", "<leader>mr3", function()
			replace_at_position(3)
		end, { desc = "Harpoon: Replace file 3" })

		vim.keymap.set("n", "<leader>mr4", function()
			replace_at_position(4)
		end, { desc = "Harpoon: Replace file 4" })

		-- Interactive position replacement
		vim.keymap.set("n", "<leader>mr", function()
			vim.ui.input({ prompt = "Replace harpoon at position: " }, function(position)
				if position and tonumber(position) then
					local pos = tonumber(position)
					replace_at_position(pos)
				end
			end)
		end, { desc = "Harpoon: Replace file at position" })

		-- Remove file from Harpoon list
		vim.keymap.set("n", "<leader>md", function()
			harpoon:list():remove()
			vim.notify("Removed current file from Harpoon", vim.log.levels.INFO)
		end, { desc = "Harpoon: Remove current file" })

		-- Clear all marks
		vim.keymap.set("n", "<leader>mc", function()
			harpoon:list():clear()
			vim.notify("Cleared all Harpoon marks", vim.log.levels.INFO)
		end, { desc = "Harpoon: Clear all marks" })

		-- Optional: Telescope integration
		local function toggle_telescope(harpoon_files)
			local file_paths = {}
			for _, item in ipairs(harpoon_files.items) do
				table.insert(file_paths, item.value)
			end

			require("telescope.pickers").new({}, {
				prompt_title = "Harpoon",
				finder = require("telescope.finders").new_table({
					results = file_paths,
				}),
				previewer = require("telescope.config").values.file_previewer({}),
				sorter = require("telescope.config").values.generic_sorter({}),
			}):find()
		end

		-- Only set up telescope integration if telescope is available
		local telescope_available, _ = pcall(require, "telescope")
		if telescope_available then
			vim.keymap.set("n", "<leader>mf", function() toggle_telescope(harpoon:list()) end,
				{ desc = "Harpoon: Open in Telescope" })
		end

		-- Status line integration (optional)
		_G.harpoon_status = function()
			local list = harpoon:list()
			local file_path = vim.fn.expand("%:.")
			for i, item in ipairs(list.items) do
				if item.value == file_path then
					return "⚓ " .. i
				end
			end
			return ""
		end
	end,
}
