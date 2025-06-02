return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    build = ":Copilot auth",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          debounce = 75,
          keymap = {
            accept = "<C-l>", -- or "<C-l>" if you prefer
            next = "<M-]>",
            prev = "<M-[>",
            dismiss = "<C-j>",
          },
        },
        panel = { enabled = false },
        filetypes = {
          ["*"] = true, -- enable in all filetypes
          markdown = true,
          help = false,
          gitcommit = true,
        },
      })
    end,
  },
}
