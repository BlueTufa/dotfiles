-- Set environment variables
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1

-- General settings
vim.opt.syntax = "on"
vim.opt.hidden = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.visualbell = true
vim.opt.number = true
vim.opt.encoding = "utf8"
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.ignorecase = true
vim.opt.clipboard:append("unnamedplus")
vim.opt.termguicolors = true

vim.opt.cmdheight = 2
vim.opt.updatetime = 300
vim.opt.shortmess:append("c")
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.wrap = false
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.undofile = true

vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"
vim.opt.showmatch = true

-- Search settings
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Plugin setup with vim-plug (this still uses vim-plug, but configured in Lua)
local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'scrooloose/nerdtree'
-- Plug 'chrisbra/Colorizer'
-- Plug 'elzr/vim-json'
Plug 'ayu-theme/ayu-vim'
-- Plug 'nanotech/jellybeans.vim'
Plug 'dag/vim-fish'
Plug 'ryanoasis/vim-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter'

Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

vim.call('plug#end')

-- Load external Lua modules
require('plugins')

-- Theme and color settings
vim.g.ayucolor = "mirage"
vim.cmd('colorscheme ayu')

-- Terminal key mappings
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>', {noremap = true})

-- Custom functions (converted to Lua)
function SwitchToNextBuffer(incr)
  local help_buffer = (vim.bo.filetype == 'help')
  local current = vim.fn.bufnr("%")
  local last = vim.fn.bufnr("$")
  local new = current + incr
  
  while true do
    if new ~= 0 and vim.fn.bufexists(new) and ((vim.fn.getbufvar(new, "&filetype") == 'help') == help_buffer) then
      vim.cmd(":buffer " .. new)
      break
    else
      new = new + incr
      if new < 1 then
        new = last
      elseif new > last then
        new = 1
      end
      if new == current then
        break
      end
    end
  end
end

-- Key mappings for buffer switching
vim.api.nvim_set_keymap('n', '<C-n>', ':lua SwitchToNextBuffer(1)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':lua SwitchToNextBuffer(-1)<CR>', {noremap = true, silent = true})

vim.api.nvim_create_autocmd("VimResized", {
  pattern = "*",
  callback = function()
    vim.cmd("wincmd =")  -- equalize window sizes
    vim.cmd("redraw!")   -- redraw UI
  end
})

-- NERDTree startup function
function StartUp()
  if vim.fn.argc() == 0 and not vim.g.std_in then
    vim.cmd("NERDTree")
  end
end

-- Autocommands using the Lua API
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    StartUp()
  end
})

-- Command abbreviations
vim.cmd("cabbrev tree NERDTreeToggle")

vim.api.nvim_create_autocmd({"BufNewFile", "BufRead"}, {
  pattern = "**/fish/*",
  command = "setf fish"
})
