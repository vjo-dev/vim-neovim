-- import telescope plugin safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  print("lelescope not found!")
	return
end

-- import telescope actions safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  print("telescope.actions not found!")
	return
end

-- configure telescope
telescope.setup({
	-- configure custom mappings
	defaults = {
    
    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

		mappings = {
			i = {
				["<C-k>"] = actions.move_selection_previous, -- move to prev result
				["<C-j>"] = actions.move_selection_next, -- move to next result
				["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist

        ["<C-u>"] = actions.preview_scrolling_up,
        ["<C-d>"] = actions.preview_scrolling_down,
			},
		},
	},
})

telescope.load_extension("fzf")
