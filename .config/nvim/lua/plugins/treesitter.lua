return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").install({
      "ruby", "javascript", "typescript", "vue", "lua",
      "html", "css", "json", "yaml", "rust", "go",
      "bash", "markdown", "vim", "vimdoc", "astro",
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "ruby", "javascript", "typescript", "vue", "lua",
        "html", "css", "json", "yaml", "rust", "go",
        "bash", "markdown", "vim", "astro",
      },
      callback = function() vim.treesitter.start() end,
    })
  end,
}
