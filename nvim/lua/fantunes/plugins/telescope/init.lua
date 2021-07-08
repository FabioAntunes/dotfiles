vim.cmd([[packadd popup.nvim]])
vim.cmd([[packadd plenary.nvim]])
vim.cmd([[packadd telescope.nvim]])

local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")

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

-- function adapted from https://svn.science.uu.nl/repos/edu.3803627.INFOMOV/0AD/build/premake/premake4/src/base/path.lua
local relativePath = function(src, dst)
	-- same directory?
	if src == dst then
		return "."
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
		result = result .. "./"
		idx = src:find("/", idx + 1)
	end

	-- tack on the path down to the dst from here
	result = result .. dst

	-- remove the trailing slash
	return result:sub(1, -2)
end

-- strip any extensions from some file types as tehy are not useful
local stripExtensions = function(path)
	path = string.gsub(path, "%.tsx?$", "")
	path = string.gsub(path, "%.jsx?$", "")
	path = string.gsub(path, "/index$", "/")
	return path
end

M.find_relative_path = function()
	require("telescope.builtin").find_files({
		prompt_title = "< relative path >",
		attach_mappings = function(prompt_bufnr)
			-- This will replace select no mather on which key it is mapped by default
			action_set.select:replace(function(prompt_bufnr, type)
				local pathSelectedFile = require("telescope.actions.state").get_selected_entry().path
				pathSelectedFile = pathSelectedFile
				print(vim.inspect(pathSelectedFile))
				actions.close(prompt_bufnr)
				local currentBufNum = vim.api.nvim_get_current_buf()
				local pathCurrentFile = vim.fn.expand("#" .. currentBufNum .. ":p")
				local finalPath = stripExtensions(relativePath(pathCurrentFile, pathSelectedFile))
				vim.api.nvim_put({ finalPath }, "", true, true)
			end)
			return true
		end,
	})
end

return M
