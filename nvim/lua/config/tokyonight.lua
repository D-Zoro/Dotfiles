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
      colors.bg = "#0a0017"
      colors.bg_dark = "#050010"
      colors.bg_float = "#0e0021"
      colors.bg_highlight = "#1a0033"
      colors.bg_popup = "#12002a"
      colors.bg_sidebar = "#0e0021"
      colors.bg_statusline = "#12002a"
  
      colors.fg = "#e2ccff"
      colors.fg_dark = "#c0a6f7"
      colors.fg_gutter = "#564b7c"
  
      colors.border = "#bb00ff"
      colors.selection_bg = "#3a0070"
  
      colors.comment = "#605582"
      colors.purple = "#bb00ff"
      colors.magenta = "#ff36e3"
      colors.blue = "#a682ff"
      colors.cyan = "#00ffe1"
      colors.green = "#9580ff"
      colors.yellow = "#cf9fff"
      colors.orange = "#ffb3ff"
      colors.red = "#ff2975"
  
      colors.git = {
        add = "#bb36ff",
        change = "#cf9fff",
        delete = "#ff2975",
      }
  
      colors.error = "#ff2975"
      colors.warning = "#ffb3ff"
      colors.info = "#00ffe1"
      colors.hint = "#bb00ff"
    end,
  
    on_highlights = function(highlights, colors)
      highlights.Normal = { fg = colors.fg, bg = colors.bg }
      highlights.LineNr = { fg = "#564b7c" }
      highlights.CursorLineNr = { fg = "#ff36e3", bold = true }
      highlights.Search = { bg = "#3a0070", fg = "#ffffff" }
      highlights.IncSearch = { bg = "#bb00ff", fg = "#ffffff" }
      highlights.Visual = { bg = "#3a0070" }
  
      highlights.Keyword = { fg = "#bb00ff", bold = true }
      highlights.Function = { fg = "#ff36e3" }
      highlights.String = { fg = "#00ffe1" }
      highlights.Number = { fg = "#ffb3ff" }
      highlights.Type = { fg = "#a682ff", bold = true }
      highlights.Comment = { fg = "#605582", italic = true }
  
      highlights.Pmenu = { bg = "#12002a", fg = "#e2ccff" }
      highlights.PmenuSel = { bg = "#3a0070", fg = "#ffffff" }
      highlights.NvimTreeNormal = { bg = "#0e0021", fg = "#e2ccff" }
      highlights.StatusLine = { bg = "#12002a", fg = "#e2ccff" }
  
      highlights.TelescopeBorder = { fg = "#bb00ff" }
      highlights.TelescopePromptBorder = { fg = "#bb00ff" }
      highlights.WhichKeyFloat = { bg = "#12002a" }
  
      highlights.DiagnosticError = { fg = "#ff2975" }
      highlights.DiagnosticWarn = { fg = "#ffb3ff" }
      highlights.DiagnosticInfo = { fg = "#00ffe1" }
      highlights.DiagnosticHint = { fg = "#bb00ff" }
    end,
  })
  