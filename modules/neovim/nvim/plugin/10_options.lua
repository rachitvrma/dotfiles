-- [nfnl] plugin/10_options.fnl
vim.g.mapleader = " "
vim.o.mouse = "a"
vim.o.mousescroll = "ver:25,hor:6"
vim.o.switchbuf = "usetab"
vim.o.undofile = true
vim.o.shada = "'100,<50,s10,:1000,/100,@100,h"
vim.o.background = "dark"
vim.o.breakindent = true
vim.o.breakindentopt = "list:-1"
vim.o.colorcolumn = "+1"
vim.o.cursorline = true
vim.o.linebreak = true
vim.o.list = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.pumborder = "rounded"
vim.o.pumheight = 10
vim.o.pummaxwidth = 100
vim.o.ruler = false
vim.o.shortmess = "CFOSWaco"
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.splitbelow = true
vim.o.splitkeep = "screen"
vim.o.splitright = true
vim.o.winborder = "rounded"
vim.o.wrap = false
vim.o.cursorlineopt = "screenline,number"
vim.o.fillchars = "eob: ,fold:\226\149\140"
vim.o.listchars = "extends:\226\128\166,nbsp:\226\144\163,precedes:\226\128\166,tab:> "
vim.o.foldlevel = 10
vim.o.foldmethod = "indent"
vim.o.foldnestmax = 10
vim.o.foldtext = ""
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.formatoptions = "rqnl1j"
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.infercase = true
vim.o.shiftwidth = 2
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.spelloptions = "camel"
vim.o.tabstop = 2
vim.o.virtualedit = "block"
vim.o.iskeyword = "@,48-57,_,192-255,-"
vim.o.formatlistpat = "^\\s*[0-9\\-\\+\\*]\\+[\\.\\)]*\\s\\+"
vim.o.complete = ".,w,b,kspell"
vim.o.completeopt = "menuone,noselect,fuzzy,nosort"
vim.o.completetimeout = 100
local function _1_()
  vim.o.clipboard = "unnamedplus"
  return nil
end
vim.schedule(_1_)
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.inccommand = "split"
vim.o.scrolloff = 10
vim.o.confirm = true
vim.o.jumpoptions = "view"
vim.g.markdown_recommended_style = 0
vim.o.softtabstop = 2
vim.o.shiftround = true
vim.o.smoothscroll = true
vim.o.sidescrolloff = 8
vim.o.undolevels = 10000
vim.o.winminwidth = 5
vim.o.pumblend = 10
vim.o.laststatus = 3
local f
local function _2_()
  return vim.cmd("setlocal formatoptions-=c formatoptions-=o")
end
f = _2_
Config.new_autocmd("FileType", nil, f, "Proper 'formatoptions'")
local diagnostic_opts = {signs = {priority = 9999, severity = {min = "WARN", max = "ERROR"}}, underline = {severity = {min = "HINT", max = "ERROR"}}, virtual_text = {current_line = true, severity = {min = "ERROR", max = "ERROR"}}, update_in_insert = false, virtual_lines = false}
local function _3_()
  return vim.diagnostic.config(diagnostic_opts)
end
return Config.later(_3_)
