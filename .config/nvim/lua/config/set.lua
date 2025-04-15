vim.wo.number = true
vim.wo.relativenumber = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.termguicolors = true
vim.cmd("colorscheme kanagawa-dragon")
vim.opt.guicursor = ""
vim.opt.mouse = ""
vim.keymap.set("n", "dn", vim.diagnostic.goto_next)
vim.keymap.set("n", "dp", vim.diagnostic.goto_prev)
