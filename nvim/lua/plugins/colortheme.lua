return {
  'rose-pine/neovim',
  name = 'rose-pine',
  opts = {
    variant = 'moon',
    dark_variant = 'moon',
    styles = {
      italic = false,
    },
  },
  lazy = false,
  config = function(_, opts)
    require('rose-pine').setup(opts)
    vim.cmd.colorscheme 'rose-pine'
  end,
}
