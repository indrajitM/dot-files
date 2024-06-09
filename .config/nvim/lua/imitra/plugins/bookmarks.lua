return {
  "LintaoAmons/bookmarks.nvim",
  tag = "v0.5.3", -- optional, pin the plugin at specific version for stability
  dependencies = {
    {"nvim-telescope/telescope.nvim"},
    {"stevearc/dressing.nvim"} -- optional: to have the same UI shown in the GIF
  },
  config = function()
    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set({ "n", "v" }, "<leader>mm", "<cmd>BookmarksMark<cr>", { desc = "Mark current line into active BookmarkList." })
    keymap.set({ "n", "v" }, "<leader>mo", "<cmd>BookmarksGoto<cr>", { desc = "Go to bookmark at current active BookmarkList" })
    keymap.set({ "n", "v" }, "<leader>ma", "<cmd>BookmarksCommands<cr>", { desc = "Find and trigger a bookmark command." })
    keymap.set({ "n", "v" }, "<leader>mg", "<cmd>BookmarksGotoRecent<cr>", { desc = "Go to latest visited/created Bookmark" })
  end,
}
