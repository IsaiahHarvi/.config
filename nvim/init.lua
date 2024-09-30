vim.g.base46_cache = vim.fn.stdpath "data" .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.opt.clipboard = "unnamedplus"

-- bootstrap lazy.nvim and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins using lazy.nvim
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },
  -- devcontainer.nvim plugin
  {
    "esensar/nvim-dev-container",
    lazy = false,
    config = function()
      require("devcontainer").setup({})
    end,
  },
  -- Telescope plugin for fuzzy finding
  {
    'nvim-telescope/telescope.nvim',
    lazy = false,
    dependencies = { 'nvim-lua/plenary.nvim' },
    cmd = 'Telescope',
  },
  -- nvim-cmp for auto-completion
  {
    'hrsh7th/nvim-cmp',
    lazy = false,
    dependencies = {
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline', -- Command-line completion
      'nvim-telescope/telescope.nvim',
      'nvim-lua/plenary.nvim',
    },
    event = "InsertEnter", -- Load cmp on insert mode
    config = function()
      local cmp = require('cmp')
      -- Setup completion sources for insert mode
      cmp.setup {
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer' },
          { name = 'path' },
        },
      }

      -- Setup for ':' command-line completion with fuzzy matching
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' }
        }, {
          { name = 'cmdline' }
        })
      })

      -- Setup for '/' and '?' to search in buffers
      cmp.setup.cmdline({'/', '?'}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })
    end,
  },
  {
  'neovim/nvim-lspconfig',
  config = function()
    require('lspconfig').pyright.setup {}
  end
  },
  {
  'p00f/nvim-ts-rainbow',
  dependencies = 'nvim-treesitter/nvim-treesitter',
  config = function()
    require'nvim-treesitter.configs'.setup {
      rainbow = {
        enable = true,
        extended_mode = true, -- Highlight also non-bracket delimiters like html tags, boolean or table: lang -> boolean
      }
    }
  end
  },
  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

