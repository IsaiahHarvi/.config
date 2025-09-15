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
      ensure_installed = { "rust_analyzer", "ruff", "ty" },
    })

    local lspconfig = require("lspconfig")

    -- Rust
    require("rust-tools").setup({
      server = {
        on_attach = function(_, bufnr)
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

    -- ty
    local configs = require("lspconfig.configs")
    if not configs.ty then
      configs.ty = {
        default_config = {
          name = "ty",
          cmd = { "ty", "server" },
          filetypes = { "python" },
          root_dir = function(fname)
            return lspconfig.util.root_pattern("pyproject.toml", ".git")(fname)
                   or vim.fn.getcwd()
          end,
          single_file_support = true,
        },
      }
    end

    lspconfig.ty.setup({
      settings = {
        ty = {
          diagnosticMode = "openFilesOnly",
          inlayHints = {
            variableTypes = true,
            callArgumentNames = true,
          },
        },
      },
    })

    -- Inlay hints
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client and client.server_capabilities and client.server_capabilities.inlayHintProvider then
          pcall(vim.lsp.inlay_hint.enable, true, { bufnr = args.buf })
        end
      end,
    })

    -- Toggle hints
    vim.keymap.set("n", "<leader>ih", function()
      local on = vim.lsp.inlay_hint.is_enabled({ bufnr = 0 })
      vim.lsp.inlay_hint.enable(not on, { bufnr = 0 })
    end, { desc = "Toggle inlay hints" })

    vim.api.nvim_set_hl(0, "LspInlayHint", { italic = true })
  end,
}
