-- lsp-config: holds all lsp related configuration
-- ansiblels: npm install -g @ansible/ansible-language-server
-- salt_ls: pip install salt-lsp
-- Native LSP setup

-- LSP autocomplete

vim.opt.completeopt={"menu", "menuone", "noselect"} -- sets vim options in lua

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
    ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it. 
  }, {
    { name = 'buffer' },
  })
})

-- -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
 cmp.setup.cmdline('/', {
   sources = {
     { name = 'buffer' }
   }
 })
-- 
-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })

-- Setup lspconfig.
-- next line should go to top of the file
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
-- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
--   capabilities = capabilities
-- }
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
local opts = { noremap=true, silent=true }

-- vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>Telescope diagnostics<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>dk', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>dj', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>i', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright', 'gopls', 'terraformls' }
for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
	capabilities=capabilities,
    on_attach = on_attach,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

-- salt_ls LSP without keybinds as it lacks capabilities
require'lspconfig'.salt_ls.setup{
	capabilities=capabilities,
	cmd = { "salt_lsp_server" },
    filetypes = { "sls" },
    -- root_dir = root_pattern('.git'),
    single_file_support = true,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
} -- connect to lsp server

-- ansiblels LSP
require'lspconfig'.ansiblels.setup{
	capabilities=capabilities,
	cmd = { "ansible-language-server", "--stdio" },
    filetypes = { "yaml.ansible" },
    -- root_dir = function(startpath)
    --     return M.search_ancestors(startpath, matcher)
    -- end,
    settings = {
      ansible = {
        ansible = {
          path = "ansible"
        },
        ansibleLint = {
          enabled = true,
          path = "ansible-lint"
        },
        executionEnvironment = {
          enabled = false
        },
        python = {
          interpreterPath = "python"
        }
      }
    },
    single_file_support = true,
    flags = {
      -- This will be the default in neovim 0.7+
      debounce_text_changes = 150,
    }
} -- connect to lsp server

-- ### OLD GOPLS LSP CONFIG START ### ---
--
-- -- gopls needs to be found on $PATH
-- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
-- 
-- require'lspconfig'.gopls.setup{
--   capabilities = capabilities,
--   on_attach = function()
--   vim.keymap.set("n", "K", vim.lsp.buf.hover, {buffer=0})
--   vim.keymap.set("n", "gd", vim.lsp.buf.definition, {buffer=0})
--   vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, {buffer=0})
--   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, {buffer=0})
--   vim.keymap.set("n", "gr", vim.lsp.buf.references, {buffer=0})
--   vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next, {buffer=0})
--   vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev, {buffer=0})
--   vim.keymap.set("n", "<leader>dl", "<cmd>Telescope diagnostics<cr>", {buffer=0})
--   vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, {buffer=0})
--   end,
-- } -- connect to lsp server
-- ### OLD GOPLS LSP CONFIG END ### ---


