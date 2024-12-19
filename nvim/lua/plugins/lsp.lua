return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "simrat39/rust-tools.nvim",
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "rust_analyzer", "pyright" },
    })

    local lspconfig = require("lspconfig")

    -- Python LSP (Pyright)
    lspconfig.pyright.setup({})

    -- Rust LSP with rust-tools
    require("rust-tools").setup({
      server = {
        on_attach = function(_, bufnr)
          -- Key mappings for Rust-specific LSP features
          local bufmap = function(mode, lhs, rhs, opts)
            opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
            vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
          end

          bufmap("n", "<leader>ca", "<cmd>RustCodeAction<CR>")
          bufmap("n", "<leader>rr", "<cmd>RustRun<CR>")
        end,
        settings = {
          ["rust-analyzer"] = {
            assist = { importGranularity = "module", importPrefix = "by_self" },
            cargo = { allFeatures = true },
            checkOnSave = { command = "clippy" },
          },
        },
      },
    })
  end,
}
