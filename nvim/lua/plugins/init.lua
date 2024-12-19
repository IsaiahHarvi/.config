local plugins = {
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "nvim-treesitter/nvim-treesitter" },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
        integrations = {
          treesitter = true,
          cmp = true,
          telescope = true,
          nvimtree = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}

local plugin_modules = { "cmp", "lsp", "treesitter", "telescope" }
for _, module in ipairs(plugin_modules) do
  local ok, mod = pcall(require, "plugins." .. module)
  if ok then
    vim.list_extend(plugins, mod)
  end
end

return plugins
