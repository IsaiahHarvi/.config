return {
  'kyazdani42/nvim-tree.lua',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('nvim-tree').setup {}
  end
}

