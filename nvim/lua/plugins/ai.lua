return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      { 'MeanderingProgrammer/render-markdown.nvim', ft = { 'markdown', 'codecompanion' } },
    },
    config = function()
      require('codecompanion').setup({
        -- Define adapter customizations
        adapters = {
          gemini = function()
            return require('codecompanion.adapters').extend('gemini', {
              -- Override schema defaults
              schema = {
                model = {
                  default = 'gemini-2.5-flash-preview-04-17', -- Specify your desired model
                  -- You can list other choices if needed for model switching commands
                  -- choices = { 'gemini-1.5-pro-latest', 'gemini-1.5-flash-latest', 'gemini-pro' }
                },
                -- You might be able to adjust other parameters here if needed,
                -- consult the adapter's specific options
                -- max_output_tokens = { default = 4096 },
              },
              -- If you didn't want to use ENV VAR (less secure):
              env = {
                api_key = "cmd:op read op://Employee/GenAI-API/credential --no-newline"
              }
            })
          end,
        },
        -- Set gemini as the default adapter for strategies
        strategies = {
          chat = { adapter = 'gemini' },
          inline = { adapter = 'gemini' },
          agent = { adapter = 'gemini' },
        },
        opts = {
          -- log_level = "DEBUG",
        }
      })

      -- Optional: Setup render-markdown
      pcall(require('render-markdown').setup, {})
    end,
  },
}
