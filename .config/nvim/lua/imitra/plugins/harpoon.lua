return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim"
  },
  config = function()
    local harpoon = require("harpoon")

    -- basic telescope configuration
    -- local conf = require("telescope.config").values
    -- local function toggle_telescope(harpoon_files)
    --     local file_paths = {}
    --     for _, item in ipairs(harpoon_files.items) do
    --         table.insert(file_paths, item.value)
    --     end
    --
    --     require("telescope.pickers").new({}, {
    --         prompt_title = "Harpoon",
    --         finder = require("telescope.finders").new_table({
    --             results = file_paths,
    --         }),
    --         previewer = conf.file_previewer({}),
    --         sorter = conf.generic_sorter({}),
    --     }):find()
    -- end

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>a", function() harpoon:list():append() end)
    keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
    -- keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
    -- keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
    -- keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
    -- keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)

    -- Toggle previous & next buffers stored within Harpoon list
    keymap.set("n", "<leader>hp", function() harpoon:list():prev() end)
    keymap.set("n", "<leader>hn", function() harpoon:list():next() end)

    -- keymap.set("n", "<leader>h", function() toggle_telescope(harpoon:list()) end,
    -- { desc = "Open harpoon window" })

    harpoon:extend({
      UI_CREATE = function(cx)
      keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

      keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
    end, { buffer = cx.bufnr })

      keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})
    --     keymap.set(
    --   "n",
    --   "<leader>hm",
    --   "<cmd>lua require('harpoon.mark').add_file()<cr>",
    --   { desc = "Mark file with harpoon" }
    -- )
    -- keymap.set("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<cr>", { desc = "Go to next harpoon mark" })
    -- keymap.set(
    --   "n",
    --   "<leader>hp",
    --   "<cmd>lua require('harpoon.ui').nav_prev()<cr>",
    --   { desc = "Go to previous harpoon mark" }
    -- )
  end,
}
