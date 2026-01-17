local gitlab_url = 'https://gitlab.myteksi.net'
local gitlab_token_file_path = '~/.secrets/grab_gitlab_access_token'
local gitlab_token = ''

return {
  'harrisoncramer/gitlab.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
    'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
  },
  build = function()
    require('gitlab.server').build(true)
  end, -- Builds the Go binary
  config = function()
    require('gitlab').setup {
      auth_provider = function()
        if gitlab_token_file_path == '' then
          gitlab_token = os.getenv 'GITLAB_TOKEN' or ''
          if gitlab_token == '' then
            vim.notify('GitLab token not found in GITLAB_TOKEN environment variable', vim.log.levels.ERROR)
          end
        else
          local expanded_path = vim.fn.expand(gitlab_token_file_path)
          local file = io.open(expanded_path, 'r')
          if file then
            gitlab_token = file:read '*l'
            file:close()
          else
            vim.notify('GitLab token file not found at ' .. expanded_path, vim.log.levels.ERROR)
          end
        end
        return gitlab_token, gitlab_url, nil
      end,
    }
  end,
}
