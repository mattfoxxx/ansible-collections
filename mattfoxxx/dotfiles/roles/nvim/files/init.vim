" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
source ~/.vim.keybinds
set mouse=a

call plug#begin('~/.config/nvim/plugged')

" native LSP
Plug 'neovim/nvim-lspconfig'

" LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

" Snippet collection
Plug 'rafamadriz/friendly-snippets'

" Linters
Plug 'mfussenegger/nvim-lint'

"File browsing
Plug 'nvim-telescope/telescope-file-browser.nvim'

"Buffer navigation
Plug 'nvim-lualine/lualine.nvim'

" telescope reqs
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"Telescope
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"magit
Plug 'TimUntersberger/neogit'
Plug 'APZelos/blamer.nvim'

" colorscheme
"Plug 'arcticicestudio/nord-vim'
Plug 'shaunsingh/nord.nvim'

"devicons
Plug 'kyazdani42/nvim-web-devicons'

" nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

" nvim-cokeline for buffers
Plug 'noib3/nvim-cokeline'

" salt-vim
Plug 'saltstack/salt-vim'

" vim surround
Plug 'tpope/vim-surround'

" markdown preview
Plug 'ellisonleao/glow.nvim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
source ~/.config/nvim/mkdp.vim

" support more filetypes
Plug 'sheerun/vim-polyglot'

" vertical indentation rulers
Plug 'lukas-reineke/indent-blankline.nvim'

" Vim Script
Plug 'folke/which-key.nvim'

" Dashboard like doom emacs
Plug 'glepnir/dashboard-nvim'

call plug#end()

" set colorscheme
let g:nord_contrast = v:true
let g:nord_borders = v:true
let g:nord_disable_background = v:false
let g:nord_italic = v:false
colorscheme nord

" show where code actions are available
" autocmd CursorHold,CursorHoldI * lua require('code_action_utils').code_action_listener()


" Find files using Telescope command-line sugar.
"nnoremap <leader>ff <cmd>Telescope find_files<cr>
"nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>bb <cmd>Telescope buffers<cr>
"nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Using Lua functions
"nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
"nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>bb <cmd>lua require('telescope.builtin').buffers()<cr>
"nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

" all lsp config in a separate file
lua require("lsp-config")

" plugin config
lua require("plugins")

" keybinds

lua << EOF
  require("which-key").setup {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  }
  local wk = require("which-key")
  wk.register({
  ["<Tab>"] = { "<Plug>(cokeline-focus-next)", "focus next buffer" },
  ["<S-Tab>"] = { "<Plug>(cokeline-focus-prev)", "focus previous buffer" },
  ["<leader>b"] = {
    name = "+Buffers",
    d = { "<cmd>bd<cr>", "kill buffer" },
    n = { "<Plug>(cokeline-switch-next)", "switch next buffer" },
    p = { "<Plug>(cokeline-switch-prev)", "switch previous buffer" },
  },
  ["<leader>f"] = {
    name = "+file",
    f = { "<cmd>Telescope find_files<cr>", "Find file" },
    g = { "<cmd>NvimTreeFindFile<cr>", "Open file in browser" },
    h = { "<cmd>lua require('telescope.builtin').help_tags()<cr>", "Browse help tags" },
    n = { "<cmd>enew<cr>", "New file" },
    r = { "<cmd>Telescope oldfiles<cr>", "Open recent file" },
    s = { "<cmd>lua require('telescope.builtin').live_grep()<cr>", "Grep over File" },
    t = { "<cmd>NvimTreeToggle<cr>", "Toggle file browser" },
  },
  ["<leader>g"] = {
    name = "+Git",
    g = { "<cmd>Neogit<cr>", "Neogit" },
    b = { "<cmd>BlamerToggle<cr>", "Neogit" },
  },
  ["<leader>m"] = {
    name = "+Markdown",
    p = { "<cmd>Glow<cr>", "Preview with glow" },
    t = { "<cmd>MarkdownPreviewToggle<cr>", "Toggle browser preview" },
    m = { "<cmd>MarkdownPreview<cr>", "Start browser preview" },
    s = { "<cmd>MarkdownPreviewStop<cr>", "Stop browser preview" },
	u = { "<cmd>!mark -c ~/.mark -f %<cr>", "Upload to confluence with mark" },
	r = { "<cmd>!plantuml %<cr>", "Render plantuml image" },
  },
  ["<leader>t"] = {
    name = "+tabs",
    t = { "<cmd>tabnew<cr>", "New tab" },
	n = { "<cmd>tabnext<cr>", "Next tab" },
	p = { "<cmd>tabprev<cr>", "Previous tab" },
    x = { "<cmd>tabclose<cr>", "Close tab" },
  },
  ["<leader>t<Tab>"] = { "<cmd>tabnext<cr>", "Next tab" },
  ["<leader>t<S-Tab>"] = { "<cmd>tabprev<cr>", "Previous tab" },
})


-- nvim lint
require('lint').linters_by_ft = {
  markdown = {'vale', 'markdownlint', }
}
EOF

" nvim-tree
nnoremap <C-e> :NvimTreeToggle<CR>
nnoremap <leader>nr :NvimTreeRefresh<CR>
nnoremap <leader>nt :NvimTreeFindFile<CR>
" More available functions:
" NvimTreeOpen
" NvimTreeClose
" NvimTreeFocus
" NvimTreeFindFileToggle
" NvimTreeResize
" NvimTreeCollapse
" NvimTreeCollapseKeepBuffers

" dashboard-nvim
let g:mapleader="\<Space>"
let g:dashboard_default_executive = 'telescope'
nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <silent> <Leader>fh :DashboardFindHistory<CR>
nnoremap <silent> <Leader>ff :DashboardFindFile<CR>
nnoremap <silent> <Leader>tc :DashboardChangeColorscheme<CR>
nnoremap <silent> <Leader>fa :DashboardFindWord<CR>
nnoremap <silent> <Leader>fb :DashboardJumpMark<CR>
nnoremap <silent> <Leader>cn :DashboardNewFile<CR>


" FORMATTING
autocmd BufWritePre *.tf lua vim.lsp.buf.formatting_sync()

" Linting
au BufWritePost <buffer> lua require('lint').try_lint()
