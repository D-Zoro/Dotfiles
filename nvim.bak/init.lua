-- 🧠 NeoHacker Config 🧠
-- A powerful, customizable Neovim setup with cyberpunk aesthetics
-- Optimized for keyboard-driven workflow with modern IDE features

-- =============================================
-- 📦 Bootstrap Package Manager (Packer)
-- =============================================

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

-- =============================================
-- 🔧 General Settings
-- =============================================
vim.g.mapleader = " "  -- Set leader key to space
vim.g.maplocalleader = ","

-- Basic settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.mouse = "a"  -- Enable mouse (but we'll focus on keyboard shortcuts)
vim.opt.clipboard = "unnamedplus"  -- System clipboard integration
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.signcolumn = "yes"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.wrap = false
vim.opt.fileencoding = "utf-8"
vim.opt.conceallevel = 0
vim.opt.pumheight = 10
vim.opt.showmode = false  -- Don't show mode since we have a statusline
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.undofile = true

-- =============================================
-- 🔌 Plugins
-- =============================================
require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'
  
  -- Optimization
  use 'lewis6991/impatient.nvim'
  
  -- Theme and visuals
  use 'folke/tokyonight.nvim'  -- Purple/violet theme with neon accents
  use {
    'nvim-lualine/lualine.nvim',  -- Status line
    requires = {'kyazdani42/nvim-web-devicons'}
  }
  use 'akinsho/bufferline.nvim'  -- Buffer tabs
  use 'lukas-reineke/indent-blankline.nvim'  -- Indent guides
  use {
    'norcalli/nvim-colorizer.lua',  -- Color highlighter
    config = function() require('colorizer').setup() end
  }
  use {
    'glepnir/dashboard-nvim',  -- Start screen
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  
  -- File navigation and management
  use {
    'nvim-tree/nvim-tree.lua',  -- File explorer
    requires = {'nvim-tree/nvim-web-devicons'}
  }
  use {
    'nvim-telescope/telescope.nvim',  -- Fuzzy finder
    requires = {{'nvim-lua/plenary.nvim'}}
  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
  
  -- Editor enhancements
  use 'windwp/nvim-autopairs'  -- Auto pairs for brackets, quotes, etc.
  use 'tpope/vim-surround'  -- Surround text objects
  use 'numToStr/Comment.nvim'  -- Quick commenting
  use 'JoosepAlviste/nvim-ts-context-commentstring'  -- Better comment strings for different languages
  use 'phaazon/hop.nvim'  -- Quick navigation in visible text
  use 'folke/which-key.nvim'  -- Key binding helper
  use 'karb94/neoscroll.nvim'  -- Smooth scrolling
  use 'folke/zen-mode.nvim'  -- Distraction-free writing
  use 'lewis6991/gitsigns.nvim'  -- Git integration
  use 'akinsho/toggleterm.nvim'  -- Terminal integration
  
  -- Language support and completion
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'nvim-treesitter/nvim-treesitter-context'  -- Show context of current scope
  use {'HiPhish/nvim-ts-rainbow2'} -- Using the maintained fork instead of the original
  
  -- LSP and autocompletion
  use 'neovim/nvim-lspconfig'  -- LSP configurations
  use 'williamboman/mason.nvim'  -- Package manager for LSP servers
  use 'williamboman/mason-lspconfig.nvim'  -- Bridge mason with lspconfig
  use 'hrsh7th/nvim-cmp'  -- Completion engine
  use 'hrsh7th/cmp-nvim-lsp'  -- LSP source for nvim-cmp
  use 'hrsh7th/cmp-buffer'  -- Buffer source for nvim-cmp
  use 'hrsh7th/cmp-path'  -- Path source for nvim-cmp
  use 'hrsh7th/cmp-cmdline'  -- Command line source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip'  -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip'  -- Snippet engine
  use 'rafamadriz/friendly-snippets'  -- Snippet collection
  use 'onsails/lspkind-nvim'  -- Pictograms for LSP completions
  use 'folke/trouble.nvim'  -- Pretty diagnostics
  use 'ray-x/lsp_signature.nvim'  -- Function signature help
  
  -- AI assistance
  use 'github/copilot.vim'  -- GitHub Copilot integration
  
  -- Debug
  use 'mfussenegger/nvim-dap'  -- Debug Adapter Protocol client
  use 'rcarriga/nvim-dap-ui'  -- UI for DAP
  
  -- Automatic setup if packer was just installed
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- =============================================
-- 📊 Status Line (Lualine)
-- =============================================
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

-- =============================================
-- 🏷️ Buffer Line (Tabs)
-- =============================================
require("bufferline").setup {
  options = {
    numbers = "none",
    close_command = "bdelete! %d",
    right_mouse_command = "bdelete! %d",
    left_mouse_command = "buffer %d",
    middle_mouse_command = nil,
    indicator = {
      icon = '▎',
      style = 'icon',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    max_name_length = 18,
    max_prefix_length = 15, 
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "center"}},
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true,
    separator_style = "thin",
    enforce_regular_tabs = true,
    always_show_bufferline = true,
  }
}

-- =============================================
-- 🌲 File Explorer (Nvim
-- =============================================
require("nvim-tree").setup {
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
    adaptive_size = false,
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
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },
  actions = {
    open_file = {
      quit_on_open = false,
      resize_window = true,
    },
  },
}

-- =============================================
-- 🔍 Fuzzy Finder (Telescope)
-- =============================================
require('telescope').setup {
  defaults = {
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
    layout_config = {
      horizontal = {
        width = 0.8,
        preview_width = 0.6,
      },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}

require('telescope').load_extension('fzf')

-- =============================================
-- 🌳 Syntax Highlighting (TreeSitter)
-- =============================================
require('nvim-treesitter.configs').setup {
  ensure_installed = {
    "lua", "vim", "query", "javascript", "typescript", "python", 
    "c", "cpp", "rust", "go", "html", "css", "json", "yaml", "toml", "markdown"
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true
  },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}

-- =============================================
-- 💡 LSP Configuration
-- =============================================
-- Initialize Mason (LSP installer)
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

require("mason-lspconfig").setup({
  ensure_installed = { 
    "lua_ls", "tsserver", "pyright", "clangd", "rust_analyzer", 
    "gopls", "html", "cssls", "jsonls", "yamlls" 
  },
  automatic_installation = true,
})

-- Configure LSP servers
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Default LSP server configurations
local servers = {
  "tsserver", "pyright", "clangd", "rust_analyzer", 
  "gopls", "html", "cssls", "jsonls", "yamlls"
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
  }
end

-- Special config for Lua LSP
lspconfig.lua_ls.setup {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        },
      },
    },
  },
}

-- =============================================
-- 🔄 Autocompletion (nvim-cmp)
-- =============================================
local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require('lspkind')

-- Load snippets
require("luasnip/loaders/from_vscode").lazy_load()

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
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
    { name = 'path' }
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text',
      maxwidth = 50,
      ellipsis_char = '...',
      menu = {
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[Snippet]",
        path = "[Path]",
      },
    }),
  },
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    },
    completion = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      winhighlight = "Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,CursorLine:PmenuSel,Search:None",
    },
  },
  experimental = {
    ghost_text = true,
  },
})

-- Command line completion
cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

-- =============================================
-- 🪟 Other Plugin Setups
-- =============================================
-- Autopairs
require('nvim-autopairs').setup({
  check_ts = true,
  ts_config = {
    lua = {'string'},
    javascript = {'template_string'},
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "vim" },
  fast_wrap = {
    map = "<M-e>",
    chars = { "{", "[", "(", '"', "'" },
    pattern = [=[[%'%"%)%>%]%)%}%,]]=],
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "Search",
    highlight_grey = "Comment"
  },
})

-- Comment
require('Comment').setup({
  pre_hook = function(ctx)
    local U = require('Comment.utils')
    
    local location = nil
    if ctx.ctype == U.ctype.block then
      location = require('ts_context_commentstring.utils').get_cursor_location()
    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
      location = require('ts_context_commentstring.utils').get_visual_start_location()
    end
    
    return require('ts_context_commentstring.internal').calculate_commentstring {
      key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
      location = location,
    }
  end,
})

-- Hop (Quick navigation)
require('hop').setup({
  keys = 'etovxqpdygfblzhckisuran'
})

-- Which-key (Key binding helper)
require("which-key").setup {
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = false,
      suggestions = 20,
    },
    presets = {
      operators = true,
      motions = true,
      text_objects = true,
      windows = true,
      nav = true,
      z = true,
      g = true,
    },
  },
  icons = {
    breadcrumb = "»",
    separator = "➜",
    group = "+",
  },
  window = {
    border = "rounded",
    position = "bottom",
    margin = { 1, 0, 1, 0 },
    padding = { 2, 2, 2, 2 },
  },
  layout = {
    height = { min = 4, max = 25 },
    width = { min = 20, max = 50 },
    spacing = 3,
    align = "center",
  },
  ignore_missing = false,
  hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " },
  show_help = true,
  triggers = "auto",
}

-- Gitsigns (Git integration)
require('gitsigns').setup {
  signs = {
    add          = { text = '│' },
    change       = { text = '│' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '┆' },
  },
  signcolumn = true,
  numhl      = false,
  linehl     = false,
  word_diff  = false,
  on_attach  = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map('n', '<leader>hs', gs.stage_hunk)
    map('n', '<leader>hr', gs.reset_hunk)
    map('v', '<leader>hs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('v', '<leader>hr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end)
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)
  end
}

-- Terminal integration
require("toggleterm").setup{
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
    winblend = 0,
    highlights = {
      border = "Normal",
      background = "Normal",
    },
  },
}

-- Trouble (Diagnostics)
require("trouble").setup {
  position = "bottom",
  height = 10,
  width = 50,
  icons = true,
  mode = "workspace_diagnostics",
  fold_open = "",
  fold_closed = "",
  group = true,
  padding = true,
  action_keys = {
    close = "q",
    cancel = "<esc>",
    refresh = "r",
    jump = {"<cr>", "<tab>"},
    open_split = { "<c-x>" },
    open_vsplit = { "<c-v>" },
    open_tab = { "<c-t>" },
    jump_close = {"o"},
    toggle_mode = "m",
    toggle_preview = "P",
    hover = "K",
    preview = "p",
    close_folds = {"zM", "zm"},
    open_folds = {"zR", "zr"},
    toggle_fold = {"zA", "za"},
    previous = "k",
    next = "j"
  },
  indent_lines = true,
  auto_open = false,
  auto_close = false,
  auto_preview = true,
  auto_fold = false,
  auto_jump = {"lsp_definitions"},
  signs = {
    error = "",
    warning = "",
    hint = "",
    information = "",
    other = "﫠"
  },
  use_diagnostic_signs = false
}

-- LSP signature
require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  }
})

-- Indent guides
require("ibl").setup {
  indent = {
    char = "▏",
  },
  scope = {
    enabled = true,
    show_start = true,
    show_end = false,
  },
  exclude = {
    filetypes = {
      "help",
      "dashboard",
      "packer",
      "NvimTree",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
      "toggleterm",
    },
    buftypes = {"terminal", "nofile"},
  },
}

-- Smooth scrolling
require('neoscroll').setup({
  mappings = {'<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb'},
  hide_cursor = true,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  easing_function = "sine",
  pre_hook = nil,
  post_hook = nil,
})

-- Zen mode
require("zen-mode").setup {
  window = {
    backdrop = 0.95,
    width = 90,
    height = 1,
  },
  plugins = {
    options = {
      enabled = true,
      ruler = false,
      showcmd = false,
    },
    twilight = { enabled = false },
    gitsigns = { enabled = false },
    tmux = { enabled = false },
    kitty = {
      enabled = false,
      font = "+4",
    },
  },
}

-- Dashboard
local db = require('dashboard')
db.setup({
  theme = 'doom',
  config = {
    header = {
      '',
      '███╗   ██╗███████╗ ██████╗ ██╗  ██╗ █████╗  ██████╗██╗  ██╗███████╗██████╗ ',
      '████╗  ██║██╔════╝██╔═══██╗██║  ██║██╔══██╗██╔════╝██║ ██╔╝██╔════╝██╔══██╗',
      '██╔██╗ ██║█████╗  ██║   ██║███████║███████║██║     █████╔╝ █████╗  ██████╔╝',
      '██║╚██╗██║██╔══╝  ██║   ██║██╔══██║██╔══██║██║     ██╔═██╗ ██╔══╝  ██╔══██╗',
      '██║ ╚████║███████╗╚██████╔╝██║  ██║██║  ██║╚██████╗██║  ██╗███████╗██║  ██║',
      '╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝',
      '',
      '                       [ Cyberpunk Neovim Setup ]                          ',
      '',
    },
    center = {
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Configuration',
        desc_hl = 'String',
        key = 'c',
        key_hl = 'Number',
        action = 'edit ~/.config/nvim/init.lua'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Package Manager',
        desc_hl = 'String',
        key = 'p',
        key_hl = 'Number',
        action = 'PackerSync'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find File',
        desc_hl = 'String',
        key = 'f',
        key_hl = 'Number',
        action = 'Telescope find_files'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Recent Files',
        desc_hl = 'String',
        key = 'r',
        key_hl = 'Number',
        action = 'Telescope oldfiles'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Find Word',
        desc_hl = 'String',
        key = 'g',
        key_hl = 'Number',
        action = 'Telescope live_grep'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'New File',
        desc_hl = 'String',
        key = 'n',
        key_hl = 'Number',
        action = 'enew'
      },
      {
        icon = ' ',
        icon_hl = 'Title',
        desc = 'Quit',
        desc_hl = 'String',
        key = 'q',
        key_hl = 'Number',
        action = 'qa'
      }
    },
    footer = {"🚀 Ready to hack the matrix?"}
  }
})

-- =============================================
-- 🎮 Key Mappings (Which-key Integration)
-- =============================================
local wk = require("which-key")

-- General keybindings
wk.register({
  -- File operations
  ["<leader>f"] = {
    name = "File",
    f = { "<cmd>Telescope find_files<cr>", "Find File" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep Files" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    n = { "<cmd>enew<cr>", "New File" },
    s = { "<cmd>w<cr>", "Save File" },
    S = { "<cmd>wa<cr>", "Save All Files" },
  },
  
  -- Buffer operations
  ["<leader>b"] = {
    name = "Buffer",
    d = { "<cmd>bdelete<cr>", "Delete Buffer" },
    n = { "<cmd>bnext<cr>", "Next Buffer" },
    p = { "<cmd>bprevious<cr>", "Previous Buffer" },
    f = { "<cmd>bfirst<cr>", "First Buffer" },
    l = { "<cmd>blast<cr>", "Last Buffer" },
  },
  
  -- Window operations
  ["<leader>w"] = {
    name = "Window",
    h = { "<cmd>split<cr>", "Split Horizontal" },
    v = { "<cmd>vsplit<cr>", "Split Vertical" },
    c = { "<cmd>close<cr>", "Close Window" },
    o = { "<cmd>only<cr>", "Only Window" },
    ["="] = { "<C-w>=", "Balance Windows" },
    -- Movement between windows
    ["<left>"] = { "<C-w>h", "Go Left" },
    ["<down>"] = { "<C-w>j", "Go Down" },
    ["<up>"] = { "<C-w>k", "Go Up" },
    ["<right>"] = { "<C-w>l", "Go Right" },
  },
  
  -- LSP operations
  ["<leader>l"] = {
    name = "LSP",
    d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
    D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
    r = { "<cmd>lua vim.lsp.buf.references()<cr>", "References" },
    i = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<cr>", "Type Definition" },
    R = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
    a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    h = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Hover" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Signature Help" },
    n = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next Diagnostic" },
    p = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous Diagnostic" },
    l = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Line Diagnostic" },
    q = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "Quickfix" },
  },
  
  -- Git operations
  ["<leader>g"] = {
    name = "Git",
    s = { "<cmd>Telescope git_status<cr>", "Status" },
    c = { "<cmd>Telescope git_commits<cr>", "Commits" },
    b = { "<cmd>Telescope git_branches<cr>", "Branches" },
    d = { "<cmd>Gitsigns diffthis<cr>", "Diff This" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk" },
    n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
    v = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
    r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset Hunk" },
    R = { "<cmd>Gitsigns reset_buffer<cr>", "Reset Buffer" },
    S = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk" },
    u = { "<cmd>Gitsigns undo_stage_hunk<cr>", "Undo Stage Hunk" },
    B = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
  },
  
  -- Packer operations
  ["<leader>p"] = {
    name = "Packer",
    s = { "<cmd>PackerSync<cr>", "Sync" },
    i = { "<cmd>PackerInstall<cr>", "Install" },
    u = { "<cmd>PackerUpdate<cr>", "Update" },
    c = { "<cmd>PackerCompile<cr>", "Compile" },
    C = { "<cmd>PackerClean<cr>", "Clean" },
  },

  -- Code operations
  ["<leader>c"] = {
    name = "Code",
    f = { "<cmd>lua vim.lsp.buf.format({async = true})<cr>", "Format" },
    d = { "<cmd>TroubleToggle<cr>", "Diagnostics" },
    s = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },
  },
  
  -- Toggle operations
  ["<leader>t"] = {
    name = "Toggle",
    t = { "<cmd>NvimTreeToggle<cr>", "File Tree" },
    z = { "<cmd>ZenMode<cr>", "Zen Mode" },
    l = { "<cmd>set relativenumber!<cr>", "Relative Line Numbers" },
    s = { "<cmd>set spell!<cr>", "Spell Check" },
    w = { "<cmd>set wrap!<cr>", "Word Wrap" },
    c = { "<cmd>ColorizerToggle<cr>", "Colorizer" },
  },
  
  -- Search operations
  ["<leader>s"] = {
    name = "Search",
    f = { "<cmd>Telescope find_files<cr>", "Find Files" },
    g = { "<cmd>Telescope live_grep<cr>", "Grep" },
    b = { "<cmd>Telescope buffers<cr>", "Buffers" },
    h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
    m = { "<cmd>Telescope marks<cr>", "Marks" },
    c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
    M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
    r = { "<cmd>Telescope oldfiles<cr>", "Recent Files" },
    k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
    C = { "<cmd>Telescope commands<cr>", "Commands" },
  },
  
  -- Trouble diagnostics shortcuts
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
    l = { "<cmd>TroubleToggle loclist<cr>", "Location List" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
  },
  
  -- Terminal
  ["<leader>T"] = {
    name = "Terminal",
    t = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
    h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
    v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
  },
  
  -- Quick navigation with Hop
  ["<leader>h"] = {
    name = "Hop",
    w = { "<cmd>HopWord<cr>", "Word" },
    l = { "<cmd>HopLine<cr>", "Line" },
    c = { "<cmd>HopChar1<cr>", "Character" },
    p = { "<cmd>HopPattern<cr>", "Pattern" },
  },
  
  -- Comments
  ["<leader>/"] = { 
    "<cmd>lua require('Comment.api').toggle.linewise.current()<cr>", 
    "Toggle Comment" 
  },
})

-- Visual mode mappings
wk.register({
  ["<leader>/"] = {
    "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>",
    "Toggle Comment",
  }
}, { mode = "v" })

-- Normal mode mappings (without leader)
wk.register({
  ["<C-h>"] = { "<C-w>h", "Window left" },
  ["<C-j>"] = { "<C-w>j", "Window down" },
  ["<C-k>"] = { "<C-w>k", "Window up" },
  ["<C-l>"] = { "<C-w>l", "Window right" },
  
  -- Easy buffer navigation
  ["<S-l>"] = { "<cmd>bnext<cr>", "Next buffer" },
  ["<S-h>"] = { "<cmd>bprevious<cr>", "Previous buffer" },
  
  -- Keep cursor centered when navigating search results
  ["n"] = { "nzzzv", "Next search result (centered)" },
  ["N"] = { "Nzzzv", "Previous search result (centered)" },
  
  -- Keep cursor centered when joining lines
  ["J"] = { "mzJ`z", "Join lines (maintain cursor)" },
  
  -- Easy indenting in visual mode
  ["<"] = { "<gv", "Unindent line" },
  [">"] = { ">gv", "Indent line" },
  
  -- Quick escape from insert mode
  ["jk"] = { "<ESC>", "Escape insert mode" },
  ["kj"] = { "<ESC>", "Escape insert mode" },
  
  -- Diagnostics
  ["[d"] = { "<cmd>lua vim.diagnostic.goto_prev()<cr>", "Previous diagnostic" },
  ["]d"] = { "<cmd>lua vim.diagnostic.goto_next()<cr>", "Next diagnostic" },
})

-- Additional key settings outside of which-key
vim.keymap.set("n", "<ESC>", "<cmd>nohlsearch<cr>")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>") -- Exit terminal mode with Escape

-- =============================================
-- 📱 Auto commands
-- =============================================
-- Auto create directories when saving files
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local dir = vim.fn.expand("<afile>:p:h")
    if vim.fn.isdirectory(dir) == 0 then
      vim.fn.mkdir(dir, "p")
    end
  end,
})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  pattern = "*",
  callback = function()
    vim.highlight.on_yank { higroup = "IncSearch", timeout = 300 }
  end,
})

-- Auto format on save if formatter is available
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    if vim.lsp.buf.server_ready() then
      vim.lsp.buf.format({ async = false })
    end
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    local line = vim.fn.line('\'"')
    if line > 1 and line <= vim.fn.line("$") then
      vim.api.nvim_exec("normal! g'\"", false)
    end
  end,
})

-- =============================================
-- 🚀 Performance Optimization
-- =============================================
-- Load impatient.nvim for faster startup
pcall(require, 'impatient')

-- =============================================
-- 🎭 Additional Customizations
-- =============================================
-- Disable some builtin plugins we don't need
local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  "netrw",
  "netrwPlugin",
  "netrwSettings",
  "netrwFileHandlers",
  "matchit",
  "tar",
  "tarPlugin",
  "rrhelper",
  "spellfile_plugin",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

-- Set up python provider - use system python for better performance
vim.g.python3_host_prog = '/usr/bin/python3'

-- =============================================
-- 🎨 Theme Configuration - Deep Neo Purple
-- =============================================
require("tokyonight").setup({
  style = "night",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true, bold = true },
    functions = { bold = true },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help", "terminal", "packer", "NvimTree" },
  
  -- Deep Neo-Purple customization
  on_colors = function(colors)
    -- Base colors
    colors.bg = "#0a0017"           -- Deeper background
    colors.bg_dark = "#050010"      -- Even deeper background
    colors.bg_float = "#0e0021"     -- Floating window background
    colors.bg_highlight = "#1a0033" -- Selection highlight
    colors.bg_popup = "#12002a"     -- Popup background
    colors.bg_sidebar = "#0e0021"   -- Sidebar background
    colors.bg_statusline = "#12002a" -- Status line background
    
    -- Text colors
    colors.fg = "#e2ccff"           -- Main text color
    colors.fg_dark = "#c0a6f7"     -- Secondary text color
    colors.fg_gutter = "#564b7c"    -- Line numbers color
    
    -- UI element colors
    colors.border = "#bb00ff"       -- Borders
    colors.selection_bg = "#3a0070" -- Visual selection background
    
    -- Syntax colors
    colors.comment = "#605582"      -- Comments
    colors.purple = "#bb00ff"       -- Primary purple (keywords)
    colors.magenta = "#ff36e3"      -- Magenta variant (functions)
    colors.blue = "#a682ff"         -- Blue variant (types)
    colors.cyan = "#00ffe1"         -- Cyan variant (strings)
    colors.green = "#9580ff"        -- Green variant (success)
    colors.yellow = "#cf9fff"       -- Yellow variant (warnings)
    colors.orange = "#ffb3ff"       -- Orange variant (constants)
    colors.red = "#ff2975"          -- Red variant (errors)
    
    -- Git colors
    colors.git = {
      add = "#bb36ff",
      change = "#cf9fff",
      delete = "#ff2975",
    }
    
    -- Diagnostics
    colors.error = "#ff2975"
    colors.warning = "#ffb3ff"
    colors.info = "#00ffe1"
    colors.hint = "#bb00ff"
  end,
  
  on_highlights = function(highlights, colors)
    -- Editor highlights
    highlights.Normal = { fg = colors.fg, bg = colors.bg }
    highlights.LineNr = { fg = "#564b7c" }
    highlights.CursorLineNr = { fg = "#ff36e3", bold = true }
    highlights.Search = { bg = "#3a0070", fg = "#ffffff" }
    highlights.IncSearch = { bg = "#bb00ff", fg = "#ffffff" }
    highlights.Visual = { bg = "#3a0070" }
    
    -- Syntax highlights
    highlights.Keyword = { fg = "#bb00ff", bold = true }
    highlights.Function = { fg = "#ff36e3" }
    highlights.String = { fg = "#00ffe1" }
    highlights.Number = { fg = "#ffb3ff" }
    highlights.Type = { fg = "#a682ff", bold = true }
    highlights.Comment = { fg = "#605582", italic = true }
    
    -- UI element highlights
    highlights.Pmenu = { bg = "#12002a", fg = "#e2ccff" }
    highlights.PmenuSel = { bg = "#3a0070", fg = "#ffffff" }
    highlights.NvimTreeNormal = { bg = "#0e0021", fg = "#e2ccff" }
    highlights.StatusLine = { bg = "#12002a", fg = "#e2ccff" }
    
    -- Plugin specific
    highlights.TelescopeBorder = { fg = "#bb00ff" }
    highlights.TelescopePromptBorder = { fg = "#bb00ff" }
    highlights.WhichKeyFloat = { bg = "#12002a" }
    
    -- Diagnostics
    highlights.DiagnosticError = { fg = "#ff2975" }
    highlights.DiagnosticWarn = { fg = "#ffb3ff" }
    highlights.DiagnosticInfo = { fg = "#00ffe1" }
    highlights.DiagnosticHint = { fg = "#bb00ff" }
  end,
})

-- =============================================
-- 🎨 Apply Theme Configuration
-- =============================================
vim.cmd[[colorscheme tokyonight]]
