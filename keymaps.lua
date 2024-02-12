-- keymapping（キーマッピング）
local opts = { noremap = true, silent = true }
local term_opts = { silent = true }

--local keymap = vim.keymap
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = 'n',
--   insert_mode = 'i',
--   visual_mode = 'v',
--   visual_block_mode = 'x',
--   term_mode = 't',
--   command_mode = 'c',

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- New tab
keymap("n", "te", ":tabedit", opts)
-- 新しいタブを一番右に作る
keymap("n", "gn", ":tabnew<Return>", opts)
-- move tab
keymap("n", "gh", "gT", opts)
keymap("n", "gl", "gt", opts)

-- Split window
keymap("n", "ss", ":split<Return><C-w>w", opts)
keymap("n", "sv", ":vsplit<Return><C-w>w", opts)

-- Select all
keymap("n", "<C-a>", "gg<S-v>G", opts)

-- Do not yank with x
keymap("n", "x", '"_x', opts)

-- Delete a word backwards
keymap("n", "dw", 'vb"_d', opts)

-- 行の端に行く
keymap("n", "<Space>h", "^", opts)
keymap("n", "<Space>l", "$", opts)

-- ;でコマンド入力( ;と:を入れ替)
keymap("n", ";", ":", opts)

-- 行末までのヤンクにする
keymap("n", "Y", "y$", opts)

-- q で強制終了
keymap("n", "q", ":q!<Return>", opts)

-- w で保存&強制終了
keymap("n", "w", ":wqa<Return>", opts)

-- ESC*2 でハイライトやめる
keymap("n", "<Esc><Esc>", ":<C-u>set nohlsearch<Return>", opts)

-- Insert --
-- Press jk fast to exit insert mode
keymap("i", "jk", "<ESC>", opts)

-- コンマの後に自動的にスペースを挿入
keymap("i", ",", ",<Space>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- ビジュアルモード時vで行末まで選択
keymap("v", "v", "$h", opts)

-- 0番レジスタを使いやすくした
keymap("v", "<C-p>", '"0p', opts)

-- NerdTree
keymap("n", "<C-e>", ":NERDTreeToggle<CR>", opts)

keymap("n", "<Nop>n", ":NERDTreeFocus<CR>", opts)

-- Telescope
keymap("n", "ff", ":Telescope find_files<CR>", opts)
keymap("n", "fg", ":Telescope live_grep<CR>", opts)
keymap("n", "fb", ":Telescope buffers<CR>", opts)
keymap("n", "fh", ":Telescope help_tags<CR>", opts)

-- Fern
keymap("n", "F", ":Fern . -drawer -toggle<CR>", opts)

-- Packer
keymap("n", "P", ":PackerInstall<CR>", opts)

-- coc marketplace
keymap("n", "L", ":CocList marketplace<CR>", opts)

keymap("i", "<C-n>", 'pumvisible() ? "<Down>" : "<C-n>"', opts)

keymap("i", "<C-p>", 'pumvisible() ? "<Up>" : "<C-p>"', opts)

keymap("i", "<CR>", 'pumvisible() ? "<C-y>" : "<CR>"', opts)

keymap("n", "S", ":MasonInstall<CR>", opts)

keymap("n", "K", ":LspInstall<CR>", opts)

keymap("n", "T", ":TermRun<CR>", opts)

keymap("n", "t", ":TermClose<CR>", opts)

-- system clipboard
-- Paste from system clipboard in normal mode
keymap("n", "<D-v>", '"*p', opts)

-- Copy to system clipboard in insert mode
keymap("i", "<D-c>", '<Esc>"+y', opts)

-- Copy to system clipboard in visual mode
keymap("v", "<D-c>", '"+y', opts)

-- Paste from system clipboard in insert mode
keymap("i", "<D-v>", '<Esc>"+p', opts)

-- Paste from system clipboard in visual mode
keymap("v", "<D-v>", '"+p', opts)

-- Copy to system clipboard in normal mode
keymap("n", "<D-c>", '"+y', opts)

-- NvimTree
keymap("n", "<C-e>", ":NvimTreeToggle<CR>", opts)

keymap("n", "<C-f>", ":NvimTreeFindFile<CR>", opts)

keymap("n", "<C-t>", ":Trim<CR>", opts)
