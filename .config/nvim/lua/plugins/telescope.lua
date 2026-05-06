return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          find_command = { "rg", "--files", "--hidden", "--glob", "!.git" },
        })
      end,
      desc = "Find files",
    },
    { "<leader>fg", function() require("telescope.builtin").live_grep() end, desc = "Live grep" },
    { "<leader>fb", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
    { "<leader>fo", function() require("telescope.builtin").oldfiles() end, desc = "Old files" },
  },
}
