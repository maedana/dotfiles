return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        javascript = { "biome" },
        typescript = { "biome" },
        vue = { "biome" },
        ruby = { "rubocop" },
      },
      formatters = {
        rubocop = {
          command = "bundle",
          prepend_args = { "exec", "rubocop" },
        },
      },
    })
  end,
}
