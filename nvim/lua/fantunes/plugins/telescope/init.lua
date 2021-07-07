vim.cmd([[packadd popup.nvim]])
vim.cmd([[packadd plenary.nvim]])
vim.cmd([[packadd telescope.nvim]])

local actions = require("telescope.actions")

require("telescope").setup({
	defaults = {
		initial_mode = "insert",
		shorten_path = false,
		mappings = {
			i = {
				-- To disable a keymap, put [map] = false
				-- So, to not map "<C-n>", just put
				["<C-n>"] = false,
				["<C-p>"] = false,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
				["<esc>"] = actions.close,
			},
		},
	},
})

local M = {}
M.search_dotfiles = function()
	require("telescope.builtin").find_files({
		prompt_title = "< dotfiles >",
		cwd = "$DOTFILES",
	})
end

local relativePath = function(src, dst)
	-- same directory?
	if src == dst then
		return "."
	end

	-- dollar macro? Can't tell what the real path is; use absolute
	-- This enables paths like $(SDK_ROOT)/include to work correctly.
	if dst:startswith("$") then
		return dst
	end

	src = src .. "/"
	dst = dst .. "/"

	-- find the common leading directories
	local idx = 0
	while true do
		local tst = src:find("/", idx + 1, true)
		if tst then
			if src:sub(1, tst) == dst:sub(1, tst) then
				idx = tst
			else
				break
			end
		else
			break
		end
	end

	-- if they have nothing in common return absolute path
	local first = src:find("/", 0, true)
	if idx <= first then
		return dst:sub(1, -2)
	end

	-- trim off the common directories from the front
	src = src:sub(idx + 1)
	dst = dst:sub(idx + 1)

	-- back up from dst to get to this common parent
	local result = ""
	idx = src:find("/")
	while idx do
		result = result .. "../"
		idx = src:find("/", idx + 1)
	end

	-- tack on the path down to the dst from here
	result = result .. dst

	-- remove the trailing slash
	return result:sub(1, -2)
end

return M
