-- Set up nvim-cmp
local cmp = require('cmp')

require("lualine").setup({
      options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
      },
    })

require'nvim-treesitter.configs'.setup {
  highlight = { enable = true },
  indent = { enable = true }
}

-- Configure nvim-cmp and LSP settings
cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif vim.fn['vsnip#available'](1) == 1 then
        feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
        feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '')
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- To use git you need to install the plugin petertriho/cmp-git and uncomment lines below
-- Set configuration for specific filetype.
--[[ cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'git' },
  }, {
    { name = 'buffer' },
  })
})
require("cmp_git").setup() ]]-- 

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  }),
  matching = { disallow_symbol_nonprefix_matching = false }
})

-- Set up lspconfig
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- In your plugins.lua file
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure Python LSP (pyright)
require('lspconfig').pyright.setup({
  capabilities = capabilities,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic"
      }
    }
  }
})

require("oil").setup({
  -- Oil configuration options
  columns = {
    "icon",
    -- "permissions",
    -- "size",
    -- "mtime",
  },
  -- Add view_options and other settings as needed
  view_options = {
    show_hidden = false,
  },
  -- Configure oil to use a vertical split and appear on the left
  float = {
    enable = false,
  },
  -- Add this to create a sidebar effect
  default_file_explorer = true,
  -- Set keymaps
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-s>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["."] = "actions.toggle_hidden",
  },
})

-- Define a function to open oil in a left sidebar
function OpenOilSidebar()
  -- Open a vertical split to the left
  vim.cmd("vsplit")
  -- Move to the left window
  vim.cmd("wincmd h")
  -- Resize to 30 columns (adjust as needed)
  vim.cmd("vertical resize 30")
  -- Open oil in this window
  require("oil").open()
  -- Set local options for this buffer to make it feel more like a sidebar
  vim.opt_local.number = false
  vim.opt_local.relativenumber = false
  vim.opt_local.signcolumn = "no"
  vim.opt_local.cursorline = true
  -- Add more local options as desired
end

-- Create a command for easy access
vim.api.nvim_create_user_command("OilSidebar", OpenOilSidebar, {})

-- Optional: Map a key to open the oil sidebar
vim.keymap.set("n", "<leader>e", OpenOilSidebar, { desc = "Open oil in sidebar" })

-- Optional: Auto-open oil in sidebar on startup if no files specified
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.bo.filetype ~= "gitcommit" and vim.bo.filetype ~= "gitrebase" then
      if not vim.opt.diff:get() then
        OpenOilSidebar()
      end
    end
  end,
  desc = "Open oil sidebar when Neovim starts with no arguments",
})


-- TODO: set up typescript support
-- TypeScript/JavaScript
-- require('lspconfig')['tsserver'].setup {
--   capabilities = capabilities
-- }

-- LSP keybindings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

