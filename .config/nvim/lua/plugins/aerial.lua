return {
  "stevearc/aerial.nvim",
  cmd = { "AerialToggle", "AerialOpen" },
  config = function()
    require("aerial").setup()
  end,
}
