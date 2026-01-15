-- Simple commands
vim.api.nvim_create_user_command('W', 'w', {})
vim.api.nvim_create_user_command('WA', 'wa', {})
vim.api.nvim_create_user_command('Wa', 'wa', {})
vim.api.nvim_create_user_command('WQ', 'wq', {})
vim.api.nvim_create_user_command('Wq', 'wq', {})
vim.api.nvim_create_user_command('Q', 'q', {})
vim.api.nvim_create_user_command('QA', 'qa', {})
vim.api.nvim_create_user_command('Qa', 'qa', {})
vim.api.nvim_create_user_command('Up', 'up', {})
vim.api.nvim_create_user_command('UP', 'up', {})

-- WriteWithSudo
vim.api.nvim_create_user_command('WriteWithSudo', function()
  vim.cmd('w !sudo tee % >/dev/null')
end, { nargs = 0 })
