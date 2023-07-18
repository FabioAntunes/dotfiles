local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")

local find_files_hidden = function()
  builtin.find_files({ hidden = true })
end

local live_grep_hidden = function()
  builtin.live_grep({ hidden = true })
end
vim.keymap.set("n", "<leader>tk", builtin.keymaps, { desc = "List available keymaps" })
vim.keymap.set("n", "<leader>td", builtin.diagnostics, { desc = "List all diagnostics in the project" })
vim.keymap.set("n", "<leader>p", find_files_hidden, { desc = "Fuzzy search file names" })
vim.keymap.set("t", "<leader>p", find_files_hidden, { desc = "Fuzzy search file names" })
vim.keymap.set("n", "<leader>f", live_grep_hidden, { desc = "Fuzzy search string in files" })
vim.keymap.set("t", "<leader>f", live_grep_hidden, { desc = "Fuzzy search string in files" })
vim.keymap.set("n", "<leader>wf", function()
  builtin.grep_string({ hidden = true })
end, {
  desc = "Fuzzy search the word selected or under the cursor",
})
vim.keymap.set("v", "<leader>wf", function()
  builtin.grep_string({ hidden = true })
end, {
  desc = "Fuzzy search the word selected or under the cursor",
})
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Fuzzy search open buffers" })
vim.keymap.set("t", "<leader>b", builtin.buffers, { desc = "Fuzzy search open buffers" })

local search_dotfiles = function()
  require("telescope.builtin").find_files({
    hidden = true,
    prompt_title = "< dotfiles >",
    cwd = "$DOTFILES",
  })
end
vim.keymap.set("n", "<leader>dot", search_dotfiles, { desc = "Fuzzy search file names in the dotfiles folder" })
vim.keymap.set("t", "<leader>dot", search_dotfiles, { desc = "Fuzzy search file names in the dotfiles folder" })

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

-- strip any extensions from some file types as they are not useful
local stripExtensions = function(path)
  path = string.gsub(path, "%.tsx?$", "")
  path = string.gsub(path, "%.jsx?$", "")
  path = string.gsub(path, "/index$", "/")
  return path
end

vim.keymap.set("i", "<C-o><C-p>", function()
  require("telescope.builtin").find_files({
    prompt_title = "< relative path >",
    attach_mappings = function(_)
      -- This will replace select no mather on which key it is mapped by default
      action_set.select:replace(function(prompt_bufnr)
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
end, {
  desc = "Fuzzy search file names and returns a relative path",
})
