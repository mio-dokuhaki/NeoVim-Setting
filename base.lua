vim.cmd("autocmd!")

vim.scriptencoding = "utf-8"

vim.wo.number = true

-- Open hoge file
vim.api.nvim_create_user_command("Hoge", function(opts)
    vim.cmd("e " .. "~/_/hoge/hoge.markdown")
end, {})

vim.api.nvim_create_user_command('FTermOpen', require('FTerm').open, { bang = true })

vim.api.nvim_create_user_command('FTermClose', require('FTerm').close, { bang = true })

vim.api.nvim_create_user_command('FTermExit', require('FTerm').exit, { bang = true })

vim.api.nvim_create_user_command('FTermToggle', require('FTerm').toggle, { bang = true })

vim.api.nvim_create_user_command('ManLs', function()
    require('FTerm').run('man ls')
end, { bang = true })

vim.api.nvim_create_user_command('YarnBuild', function()
    require('FTerm').run({'yarn', 'build'})
end, { bang = true })
