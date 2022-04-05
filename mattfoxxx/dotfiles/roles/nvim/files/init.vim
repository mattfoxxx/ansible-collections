" set runtimepath^=~/.vim runtimepath+=~/.vim/after
" let &packpath = &runtimepath
source ~/.vim.keybinds

call plug#begin('~/.config/nvim/plugged')

" native LSP
Plug 'neovim/nvim-lspconfig'

" LSP autocomplete
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'

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

" colorscheme
"Plug 'arcticicestudio/nord-vim'
Plug 'shaunsingh/nord.nvim'

"devicons
Plug 'kyazdani42/nvim-web-devicons'

" nvim-tree
Plug 'kyazdani42/nvim-tree.lua'

" salt-vim
Plug 'saltstack/salt-vim'

" markdown preview
Plug 'ellisonleao/glow.nvim'

" support more filetypes
Plug 'sheerun/vim-polyglot'

" vertical indentation rulers
Plug 'lukas-reineke/indent-blankline.nvim'

" Vim Script
Plug 'folke/which-key.nvim'

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
  ["<leader>t"] = {
    name = "+tabs",
    n = { "<cmd>tabnew<cr>", "New tab" },
    x = { "<cmd>tabclose<cr>", "Close tab" },
  },
  ["<leader>t<Tab>"] = { "<cmd>tabnext<cr>", "Next tab" },
  ["<leader>t<S-Tab>"] = { "<cmd>tabprev<cr>", "Previous tab" },
})
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

" markdown preview glow
noremap <leader>mp :Glow<CR>

" neogit
nnoremap <leader>gg <cmd>Neogit<cr>

