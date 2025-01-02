return {
    "nvim-telescope/telescope.nvim", branch = '0.1.x',
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-live-grep-args.nvim",
            version = "^1.0.0",
        }
    },

    keys = {
        { "ff", "<cmd>lua require('telescope.builtin').find_files()<cr>", desc = "[Telescope] find files" },
        { "fg", "<cmd>lua require('telescope').extensions.live_grep_args.live_grep_args()<cr>", desc = "[Telescope] grep string" },
        { "fb", "<cmd>lua require('telescope.builtin').buffers()<cr>", desc = "[Telescope] search buffers" },
        { "fh", "<cmd>lua require('telescope.builtin').help_tags()<cr>", desc = "[Telescope] search help and plugin functions" },
        { "ft", "<cmd>lua require('telescope.builtin').treesitter()<cr>", desc = "[Telescope] search for function/var" },
    },

    config = function()
        require("telescope").setup({
            pickers = {
                find_files = {
                    mappings = {
                        i = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                        n = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                    },
                    hidden = true,
                    no_ignore = true,
                },

                buffers = {
                    mappings = {
                        i = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                        n = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                    },
                    hidden = true,
                    no_ignore = true,
                },
            },

            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },

                file_browser = {
                    theme = "ivy",

                    hijack_netrw = true,

                    mappings = {
                        i = {
                            ["<tab>"] = "move_selection_next",
                            ["<S-tab>"] = "move_selection_previous",
                        },
                        n = {
                            ["<tab>"] = "move_selection_next",
                            ["<S-tab>"] = "move_selection_previous",
                        },
                    },

                    hidden = true,
                    no_ignore = true,
                },

                live_grep_args = {
                    mappings = {
                        i = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                        n = {
                            ["<S-tab>"] = "move_selection_next",
                            ["<tab>"] = "move_selection_previous",
                        },
                    },
                    hidden = true,
                    no_ignore = true,
                },
            },
        })

        require("telescope").load_extension("fzf")
        require("telescope").load_extension("file_browser")
        require("telescope").load_extension("live_grep_args")
    end
}
