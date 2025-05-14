-- This file will be loaded after plugins are installed

-- NvimTree (file explorer)
require('nvim-tree').setup({
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
    },
  },
})

-- Open NvimTree with Ctrl+E (like VSCode)
vim.keymap.set('n', '<C-e>', ':NvimTreeToggle<CR>', { silent = true })

-- Lualine (status line)
require('lualine').setup({
  options = {
    theme = 'vscode',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
  },
})

-- Bufferline (tabs)
require('bufferline').setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        text_align = "center",
        separator = true
      }
    }
  }
})

-- VSCode theme
require('vscode').setup({
  style = 'dark'
})
vim.cmd('colorscheme vscode')

-- Autocomplete setup
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  })
})

-- LSP setup
require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "pyright", "tsserver", "html", "cssls" }
})

-- Configure LSP servers
local lspconfig = require('lspconfig')
require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
    })
  end,
})

-- Telescope (fuzzy finder)
local telescope = require('telescope')
telescope.setup()
-- Ctrl+P for file search (like VSCode)
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>', { silent = true })
-- Ctrl+Shift+F for text search (like VSCode)
vim.keymap.set('n', '<C-f>', '<cmd>Telescope live_grep<cr>', { silent = true })

-- Treesitter (syntax highlighting)
require('nvim-treesitter.configs').setup({
  ensure_installed = { "lua", "vim", "python", "javascript", "typescript", "json", "html", "css" },
  highlight = { enable = true },
})

-- Autopairs
require('nvim-autopairs').setup()

-- Gitsigns
require('gitsigns').setup()

-- Start with NvimTree open
vim.cmd('autocmd VimEnter * NvimTreeToggle')
