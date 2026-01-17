-- Navigating files like buffer

return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    default_file_explorer = true,
    columns = {
      'icon',
      add_padding = false,
    },
    view_options = {
      show_hidden = true,
    },
    float = {
      padding = 5,
      border = 'rounded',
    },
    preview_win = {
      update_on_cursor_moved = true,
      preview_method = 'fast_scratch',
    },
  },
  keys = {
    { '<leader>o', '<cmd>Oil --float<CR>', desc = 'Explorer' },
  },
  dependencies = {
    { 'nvim-mini/mini.icons', opts = {} },
    { 'nvim-tree/nvim-web-devicons', opts = {} },
  },
  lazy = false,
}
