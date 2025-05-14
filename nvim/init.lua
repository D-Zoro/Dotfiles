-- init.lua
-- Basic settings for a better experience
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = true  -- Show relative line numbers
vim.opt.mouse = 'a'            -- Enable mouse support
vim.opt.clipboard = 'unnamedplus' -- Use system clipboard
vim.opt.tabstop = 4            -- Tab width
vim.opt.shiftwidth = 4         -- Indent width
vim.opt.expandtab = true       -- Use spaces instead of tabs
vim.opt.smartindent = true     -- Smart indentation
vim.opt.wrap = false           -- Don't wrap lines
vim.opt.cursorline = true      -- Highlight current line
vim.opt.termguicolors = true   -- Enable 24-bit RGB colors
vim.opt.signcolumn = 'yes'     -- Always show sign column
vim.opt.updatetime = 300       -- Faster update time
vim.opt.timeoutlen = 500       -- Faster timeout for key combinations

-- VSCode-like keybindings
-- Save with Ctrl+S
vim.keymap.set('n', '<C-s>', ':w<CR>', { silent = true })
vim.keymap.set('i', '<C-s>', '<Esc>:w<CR>a', { silent = true })

-- Quit with Ctrl+Q
vim.keymap.set('n', '<C-q>', ':q<CR>', { silent = true })

-- Navigate tabs with Ctrl+Tab and Ctrl+Shift+Tab
vim.keymap.set('n', '<C-Tab>', ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<C-S-Tab>', ':bprevious<CR>', { silent = true })

-- Navigate split windows with Ctrl+arrow keys
vim.keymap.set('n', '<C-h>', '<C-w>h', { silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { silent = true })
vim.keymap.set('n', '<C-l>', '<C-w>l', { silent = true })

-- Ensure packer is installed and loaded
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

-- Create a packer.lua file in lua/plugins directory
local fn = vim.fn
local install_path = fn.stdpath('config')..'/lua/plugins'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'mkdir', '-p', install_path})
end

-- Write the plugins.lua file
local packer_file = io.open(fn.stdpath('config')..'/lua/plugins/init.lua', 'w')
if packer_file then
  packer_file:write([[
return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  
  -- File explorer (NvimTree)
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- Optional, for file icons
    }
  }
  
  -- Status line (Lualine)
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  
  -- Buffer line (tabs)
  use {'akinsho/bufferline.nvim', tag = "*", requires = 'nvim-tree/nvim-web-devicons'}
  
  -- VSCode-like theme
  use 'Mofiqul/vscode.nvim'
  
  -- Autocompletion
  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  }
  
  -- LSP (Language Server Protocol)
  use {
    'neovim/nvim-lspconfig',
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
  }
  
  -- Fuzzy finder
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  
  -- Syntax highlighting
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }
  
  -- Auto pairs for '(', '[', etc.
  use 'windwp/nvim-autopairs'

  -- Git integration
  use 'lewis6991/gitsigns.nvim'
  
  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
]])
  packer_file:close()
end

-- Create the config.lua file for configuring plugins after installation
local config_file = io.open(fn.stdpath('config')..'/lua/plugins/config.lua', 'w')
if config_file then
  config_file:write([[
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
]])
  config_file:close()
end

-- Load the plugins module
require('plugins')

-- Check if plugins have been installed and load config
local plugin_config_path = vim.fn.stdpath('config')..'/lua/plugins/config.lua'
if vim.fn.filereadable(plugin_config_path) == 1 then
  -- Try to load plugins, but don't crash if they're not installed yet
  local status_ok, _ = pcall(require, 'plugins.config')
  if not status_ok then
    print("Plugins not yet installed. Run :PackerSync first.")
  end
end