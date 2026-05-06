return {
  "EdenEast/nightfox.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({})
    vim.cmd.colorscheme("nordfox")
  end,
}
