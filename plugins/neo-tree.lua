return {
    enable_diagnostics = false,
    filesystem = {
        follow_current_file = false,
        filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = true,
            always_show = {
                ".env",
            },
        },
    },

    window = {
        mappings = {
            H = "toggle_hidden",
            L = false,
        },
    },
}
