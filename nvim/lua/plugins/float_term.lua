-- Add this to your lazy.nvim plugin configuration
-- ~/.config/nvim/lua/plugins/cyber-terminal.lua

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    require("toggleterm").setup({
      -- Terminal settings
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        else
          return 20
        end
      end,
      open_mapping = nil, -- Disabled - using custom keymaps only
      hide_numbers = true,
      shade_filetypes = {},
      shade_terminals = false, -- We want transparency
      shading_factor = 1,
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      direction = "float",
      close_on_exit = true,
      shell = "zsh", -- Force zsh instead of default shell

      -- HD Resolution Optimized Floating Terminal Configuration
      float_opts = {
        border = "curved", -- 'single' | 'double' | 'shadow' | 'curved' | 'rounded'
        width = function()
          local cols = vim.o.columns
          -- HD resolution optimized sizing (1920+ width)
          if cols >= 1920 then
            return math.floor(cols * 0.6) -- 60% for HD screens
          elseif cols >= 1440 then
            return math.floor(cols * 0.65) -- 65% for smaller HD
          else
            return math.floor(cols * 0.7) -- 70% for smaller screens
          end
        end,
        height = function()
          local lines = vim.o.lines
          -- HD resolution optimized sizing (1080+ height)
          if lines >= 60 then
            return math.floor(lines * 0.6) -- 60% for HD screens
          elseif lines >= 40 then
            return math.floor(lines * 0.65) -- 65% for medium screens
          else
            return math.floor(lines * 0.7) -- 70% for smaller screens
          end
        end,
        winblend = 12, -- Optimized transparency for HD clarity
        row = function()
          return math.floor((vim.o.lines - math.floor(vim.o.lines * 0.6)) / 2)
        end,
        col = function()
          return math.floor((vim.o.columns - math.floor(vim.o.columns * 0.6)) / 2)
        end,
        highlights = {
          border = "CyberPurpleBorder",
          background = "CyberPurpleBackground",
        },
        title_pos = "center",
      },

      -- Custom highlights for cyber purple theme
      highlights = {
        Normal = {
          guibg = "NONE", -- Transparent background
        },
        NormalFloat = {
          guibg = "NONE",
        },
        FloatBorder = {
          guifg = "#9d4edd", -- Cyber purple border
          guibg = "NONE",
        },
      },
    })

    -- Custom highlight groups for HD cyber purple aesthetic
    vim.api.nvim_set_hl(0, "CyberPurpleBorder", {
      fg = "#a855f7", -- Vibrant purple-500 for HD clarity
      bg = "NONE",
      bold = true, -- Enhanced visibility on HD
    })

    vim.api.nvim_set_hl(0, "CyberPurpleBackground", {
      bg = "#0f0a1a", -- Darker purple-tinted background for HD contrast
      blend = 88, -- Optimized transparency for HD
    })

    -- HD optimized terminal colors with better contrast
    vim.api.nvim_set_hl(0, "TerminalNormal", {
      bg = "NONE",
      fg = "#e879f9", -- Brighter purple-400 for HD readability
    })

    -- Additional HD cyber effects
    vim.api.nvim_set_hl(0, "TerminalCursor", {
      fg = "#c084fc", -- Purple-300 cursor
      bg = "NONE",
      reverse = true,
    })

    -- Custom keymaps for different terminal modes
    local function set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- Apply keymaps when terminal opens
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

    -- Custom commands for different terminal types
    local Terminal = require("toggleterm.terminal").Terminal

    -- Main HD floating zsh terminal
    local cyber_terminal = Terminal:new({
      cmd = "zsh", -- Force zsh shell
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 12,
        width = function()
          local cols = vim.o.columns
          if cols >= 1920 then
            return math.floor(cols * 0.6)
          else
            return math.floor(cols * 0.65)
          end
        end,
        height = function()
          local lines = vim.o.lines
          if lines >= 60 then
            return math.floor(lines * 0.6)
          else
            return math.floor(lines * 0.65)
          end
        end,
        row = function()
          local lines = vim.o.lines
          local height = lines >= 60 and math.floor(lines * 0.6) or math.floor(lines * 0.65)
          return math.floor((lines - height) / 2)
        end,
        col = function()
          local cols = vim.o.columns
          local width = cols >= 1920 and math.floor(cols * 0.6) or math.floor(cols * 0.65)
          return math.floor((cols - width) / 2)
        end,
        highlights = {
          border = "CyberPurpleBorder",
          background = "CyberPurpleBackground",
        },
        title = " 🚀 CYBER ZSH TERMINAL 🚀 ",
        title_pos = "center",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
        -- Set zsh-specific environment for better HD experience
        vim.fn.setenv("TERM", "xterm-256color")
      end,
      on_close = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- HD Lazygit terminal with cyber theme
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 8, -- Less transparency for better git visibility
        width = function()
          local cols = vim.o.columns
          if cols >= 1920 then
            return math.floor(cols * 0.65) -- Slightly larger for git interface
          else
            return math.floor(cols * 0.7)
          end
        end,
        height = function()
          local lines = vim.o.lines
          if lines >= 60 then
            return math.floor(lines * 0.65)
          else
            return math.floor(lines * 0.7)
          end
        end,
        highlights = {
          border = "CyberPurpleBorder",
          background = "CyberPurpleBackground",
        },
        title = " 🌟 LAZYGIT CYBER HD 🌟 ",
        title_pos = "center",
      },
      on_open = function(term)
        vim.cmd("startinsert!")
      end,
    })

    -- HD Htop terminal
    local htop = Terminal:new({
      cmd = "htop",
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 12,
        width = function()
          local cols = vim.o.columns
          if cols >= 1920 then
            return math.floor(cols * 0.65)
          else
            return math.floor(cols * 0.7)
          end
        end,
        height = function()
          local lines = vim.o.lines
          if lines >= 60 then
            return math.floor(lines * 0.65)
          else
            return math.floor(lines * 0.7)
          end
        end,
        highlights = {
          border = "CyberPurpleBorder",
          background = "CyberPurpleBackground",
        },
        title = " 📊 SYSTEM MONITOR HD 📊 ",
        title_pos = "center",
      },
    })

    -- Key mappings (removed Ctrl+\ to avoid conflicts)
    vim.keymap.set("n", "<leader>tf", function()
      cyber_terminal:toggle()
    end, { desc = "Toggle Cyber ZSH Terminal" })
    vim.keymap.set("n", "<leader>tg", function()
      lazygit:toggle()
    end, { desc = "Toggle Lazygit HD" })
    vim.keymap.set("n", "<leader>th", function()
      htop:toggle()
    end, { desc = "Toggle Htop HD" })
    vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Toggle Terminal" })

    -- Alternative quick access without Ctrl+\
    vim.keymap.set("n", "<leader>tc", function()
      cyber_terminal:toggle()
    end, { desc = "Quick Cyber Terminal" })

    -- Terminal size adjustments
    vim.keymap.set("n", "<leader>t1", "<cmd>1ToggleTerm direction=horizontal<cr>", { desc = "Horizontal Terminal" })
    vim.keymap.set("n", "<leader>t2", "<cmd>2ToggleTerm direction=vertical<cr>", { desc = "Vertical Terminal" })
    vim.keymap.set("n", "<leader>t3", "<cmd>3ToggleTerm direction=float<cr>", { desc = "Floating Terminal" })

    -- Global function for keymaps
    _G.set_terminal_keymaps = set_terminal_keymaps
  end,

  -- Dependencies for enhanced experience
  dependencies = {
    "nvim-lua/plenary.nvim",
  },

  -- Lazy loading
  cmd = {
    "ToggleTerm",
    "TermExec",
    "ToggleTermToggleAll",
    "ToggleTermSendCurrentLine",
    "ToggleTermSendVisualLines",
    "ToggleTermSendVisualSelection",
  },

  keys = {
    { "<leader>tf", desc = "Toggle Cyber ZSH Terminal" },
    { "<leader>tc", desc = "Quick Cyber Terminal" },
    { "<leader>tg", desc = "Toggle Lazygit HD" },
    { "<leader>th", desc = "Toggle Htop HD" },
  },
}
