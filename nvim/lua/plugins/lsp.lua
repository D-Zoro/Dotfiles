-- lua/plugins/lsp.lua
-- Full LSP + Formatter + Linter setup for Next.js, MERN, AI/ML, Cybersecurity, and Blockchain stack

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      mason.setup()
      mason_lspconfig.setup({
        ensure_installed = {
          "tsserver",
          "html",
          "cssls",
          "jsonls",
          "eslint",
          "tailwindcss",
          "pyright",
          "clangd",
          "rust_analyzer",
          "solidity",
          "dockerls",
          "yamlls",
          "bashls",
          "marksman",
        },
        automatic_installation = true,
      })

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        nmap("gd", vim.lsp.buf.definition, "Go to Definition")
        nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
        nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        nmap("gr", require("telescope.builtin").lsp_references, "References")
      end

      local servers = {
        tsserver = {},
        html = {},
        cssls = {},
        jsonls = {},
        eslint = {},
        tailwindcss = {},
        pyright = {},
        clangd = {},
        rust_analyzer = {},
        solidity = {},
        dockerls = {},
        yamlls = {},
        bashls = {},
        marksman = {},
      }

      for server, config in pairs(servers) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = require("cmp_nvim_lsp").default_capabilities(),
          settings = config,
        })
      end
    end,
  },

  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          -- Formatters
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.autopep8,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.rustfmt,

          -- Linters
          null_ls.builtins.diagnostics.eslint,
          null_ls.builtins.diagnostics.flake8,
          null_ls.builtins.diagnostics.cpplint,
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.diagnostics.yamllint,
        },
      })
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          "prettier",
          "black",
          "autopep8",
          "clang-format",
          "rustfmt",
          "eslint",
          "flake8",
          "cpplint",
          "shellcheck",
          "yamllint",
        },
        automatic_installation = true,
      })
    end,
  },
}
