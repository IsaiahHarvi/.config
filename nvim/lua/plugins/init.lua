local plugins = {
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "nvim-treesitter/nvim-treesitter" },
  {
    'AlexvZyl/nordic.nvim',
    name = "nordic",
    lazy = false,
    priority = 100,
    config = function()
        require('nordic').setup({
            transparent = { bg = true, float = true},
        })
        vim.cmd.colorscheme("nordic")
    end,
  --   "scottmckendry/cyberdream.nvim",
  --   lazy = false,
  --   priority = 100,
  --   config = function()
  --       require("cyberdream").setup({
  --           variant = "default",
  --           transparent = true,
  --           borderless_pickers = false,
  --           italic_comments = false,
  --           saturation = 0.75
  --       })
  --       vim.cmd.colorscheme("cyberdream")
  --   end,
  --
    -- "catppuccin/nvim",
    -- name = "catppuccin",
    -- config = function()
    --   require("catppuccin").setup({
    --     flavour = "macchiato", -- Options: latte, frappe, macchiato, mocha
    --     integrations = {
    --       treesitter = true,
    --       cmp = true,
    --       telescope = true,
    --       nvimtree = true,
    --     },
    --   })
    --   vim.cmd.colorscheme("catppuccin")
    -- end,
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
