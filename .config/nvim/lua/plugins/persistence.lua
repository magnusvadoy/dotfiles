-- NOTE: Lets tmux-resurrect restore the session for the current directory
-- (see @resurrect-processes in tmux.conf)
return {
  "folke/persistence.nvim",
  init = function()
    vim.api.nvim_create_user_command("SessionRestore", function()
      require("persistence").load()
    end, { desc = "Restore session for the current directory" })

    -- persistence only saves on VimLeavePre, which doesn't run when tmux is
    -- killed. Save on write and focus loss too, reusing its own save logic.
    vim.api.nvim_create_autocmd({ "BufWritePost", "FocusLost" }, {
      group = vim.api.nvim_create_augroup("persistence_autosave", { clear = true }),
      callback = function()
        local persistence = package.loaded["persistence"]
        if persistence and persistence.active() then
          vim.api.nvim_exec_autocmds("VimLeavePre", { group = "persistence" })
        end
      end,
    })
  end,
}
