local options = {
    encoding = "utf-8",
    fileencoding = "utf-8",
    title = true,
    backup = false,
    clipboard = "unnamedplus",
    cmdheight = 2,
    completeopt = { "menuone", "noselect" },
    conceallevel = 0,
    hlsearch = true,
    ignorecase = true,
    mouse = "a",
    pumheight = 10,
    showmode = false,
    showtabline = 2,
    smartcase = true,
    smartindent = true,
    swapfile = false,
    termguicolors = true,
    timeoutlen = 300,
    undofile = true,
    updatetime = 300,
    writebackup = false,
    shell = "fish",
    backupskip = { "/tmp/*", "/private/tmp/*" },
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    cursorline = true,
    cursorcolumn = true,
    number = true,
    relativenumber = true,
    numberwidth = 4,
    signcolumn = "yes",
    wrap = false,
    winblend = 0,
    wildoptions = "pum",
    pumblend = 5,
    background = "dark",
    scrolloff = 8,
    sidescrolloff = 8,
    guifont = "Mononoki Nerd Font Mono:h28:i",
    splitbelow = false, -- オンのとき、ウィンドウを横分割すると新しいウィンドウはカレントウィンドウの下に開かれる
    splitright = false, -- オンのとき、ウィンドウを縦分割すると新しいウィンドウはカレントウィンドウの右に開かれる
    inccommand = "split",
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd("set whichwrap+=<,>,[,],h,l")
vim.cmd([[set iskeyword+=-]])
vim.cmd([[set formatoptions-=cro]]) -- TODO: this doesn't seem to work

vim.opt.termguicolors = true

vim.api.nvim_set_option('clipboard', 'unnamedplus')

vim.api.nvim_win_set_option(0, 'signcolumn', 'yes:1')

vim.opt.guifont = "Mononoki Nerd Font Mono:h28:i"

vim.opt.clipboard = 'unnamedplus'

vim.api.nvim_set_option('clipboard', 'unnamedplus')
