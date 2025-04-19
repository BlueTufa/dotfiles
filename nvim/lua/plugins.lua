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

local function get_poetry_python()
  local handle = io.popen("poetry env info -p")
  if handle then
    local result = handle:read("*a")
    handle:close()
    local venv_path = vim.fn.trim(result)
    return venv_path .. "/bin/python"
  else
    print("Could not find poetry environment")
    return "/usr/bin/python3" -- os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
  end
end

local dap = require("dap")
dap.adapters.python = {
  type = "executable",
  command = get_poetry_python(),
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file in pytest",
    module = "pytest",
    args = { "${file}" },
    console = "integratedTerminal",
    pythonPath = get_poetry_python
  }
}

local dapui = require("dapui")
dapui.setup({
  layouts = {
    {
      elements = {
        { id = "scopes", size = 0.75 },
        { id = "breakpoints", size = 0.25 },
        { id = "stacks", size = 0.25 },
      },
      size = 40,  -- columns
      position = "left", -- can be "left" or "right"
    },
    {
      elements = {
         { id = "repl", size = 0.5 },
         { id = "console", size = 0.5 },
      },
      size = 15, -- lines
      position = "bottom", -- can be "bottom" or "top"
    },
  },
  controls = {
    enabled = true,
    element = "repl",
    icons = {
      pause = "⏸", play = "▶", step_into = "⤵", step_over = "⤼",
      step_out = "⤴", step_back = "⏪", run_last = "↻", terminate = "⏹"
    },
  },
})

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
-- TODO: set up typescript support
-- TypeScript/JavaScript
-- require('lspconfig')['tsserver'].setup {
--   capabilities = capabilities
-- }

-- Navigation keybindings
vim.keymap.set("n", "gt", ":NERDTreeToggle<CR>", {silent = true})
vim.keymap.set("n", "<leader>w", "<C-w>w", { silent = true })
vim.keymap.set("n", "<leader>o", ":tab split<CR>", { silent = true })
vim.keymap.set("n", "<leader>p", ":tabclose<CR>", { silent = true })

-- LSP keybindings
local opts = { noremap = true, silent = true }
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
vim.keymap.set('n', 'gy', vim.lsp.buf.type_definition, opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
vim.keymap.set("n", "gb", "<C-o>", { desc = "Jump back" })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, opts)

-- Key mappings for buffer switching
vim.api.nvim_set_keymap('n', '<C-n>', ':lua SwitchToNextBuffer(1)<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<C-p>', ':lua SwitchToNextBuffer(-1)<CR>', {noremap = true, silent = true})
-- Debugging keys
vim.keymap.set("n", "<F9>", function() require("dap").continue() end)
vim.keymap.set("n", "<F8>", function() require("dap").step_over() end)
vim.keymap.set("n", "<F19>", function() require("dap").step_into() end)
vim.keymap.set("n", "<F20>", function() require("dap").step_out() end)
vim.keymap.set("n", "<Leader>t", function() require("dap").terminate() end)

vim.keymap.set("n", "<Leader>b", function() require("dap").toggle_breakpoint() end)
vim.keymap.set("n", "<Leader>dd", function() require("dapui").toggle() end)

