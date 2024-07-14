return {
  {
    "mikavilpas/yazi.nvim",
    keys = {
      {
        -- Open in the current working directory
        "<leader>y",
        function()
          require("yazi").yazi(nil, vim.fn.getcwd())
        end,
        desc = "Open Yazi",
      },
    },
  },
}
