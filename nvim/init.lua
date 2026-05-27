vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = false
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.g.mapleader = " "
vim.o.signcolumn = "yes"


vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>cc', ':noh<CR>', { silent = true })
vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>p', '"+p<CR>')
vim.keymap.set({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')
-- vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
vim.keymap.set('n', '<leader>pv', '<CMD>Oil<CR>')


vim.pack.add({
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	-- { src = "https://github.com/nvim-telescope/telescope.nvim",              version = "0.1.8" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	-- { src = "https://github.com/nvim-treesitter/nvim-treesitter",            version = "main" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mbbill/undotree" },
	{ src = "https://github.com/theprimeagen/harpoon" },
	-- { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
	{ src = "https://github.com/nvim-neotest/nvim-nio" },
})

-- autocompletion
vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})
vim.o.completeopt = "menu,menuone,noselect"
vim.keymap.set("i", "<Tab>", function()
		if vim.fn.pumvisible() == 1 then
				return "<C-n>"
		else
				return "<Tab>"
		end
end, {expr = true})
vim.keymap.set("i", "<S-Tab>", function()
		if vim.fn.pumvisible() == 1 then
				return "<C-p>"
		else
				return "<Tab>"
		end
end, {expr = true})

require "mason".setup()
require "vague".setup({ tansparent = true })
require "oil".setup()
-- vim.cmd("colorscheme vague")
local default_color = "vague"
vim.cmd('colorscheme ' .. default_color)
-- vim.cmd(":hi statusline guibg=NONE")


vim.lsp.enable({
	"lua_ls", "cssls", "clangd", "svelte", "tinymist",
	"rust_analyzer", "clangd", "ruff",
	"glsl_analyzer", "haskell-language-server", "hlint",
	"intelephense", "tailwindcss", "ts_ls",
	"emmet_language_server", "emmet_ls", "solargraph", "zls", "pyright"
})



local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', builtin.find_files, {})

local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set('n', '<leader>a', mark.add_file)
vim.keymap.set('n', '<C-e>', ui.toggle_quick_menu)

vim.keymap.set('n', '<C-h>', function() ui.nav_file(1) end)
vim.keymap.set('n', '<C-j>', function() ui.nav_file(2) end)
vim.keymap.set('n', '<C-k>', function() ui.nav_file(3) end)
vim.keymap.set('n', '<C-l>', function() ui.nav_file(4) end)

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)
