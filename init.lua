vim.g.mapleader = ' '
vim.g.have_nerd_font = false

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.termguicolors = true

vim.schedule(function()
	vim.opt.clipboard = 'unnamedplus'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text.',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Lazy Package Manager Configuration --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then
		error('Error cloning lazy.nvim:\n' .. out)
	end
end --@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
	-- Syntax highlighting theme
	{
	"loctvl842/monokai-pro.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		vim.opt.termguicolors = true
		vim.cmd("colorscheme monokai-pro")
	end
	},

	-- Telescope fuzzy finding
	{
	"nvim-telescope/telescope.nvim", tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim' }
	},
	
	-- Treesitter for syntax highlighting
	{"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
})


local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files.' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep.' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers.' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags.' })

