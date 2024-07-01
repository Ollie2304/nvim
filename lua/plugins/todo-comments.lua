return {
    {
        'folke/todo-comments.nvim',
        event = 'VimEnter',
        dependencies = { 'nvim-lua/plenary.nvim' },
        opts = {},
        vim.keymap.set("n", "<leader>stq", ":TodoQuickFix<CR>", { desc = "[S]earch [T]odo [Q]ickFix"}),
        vim.keymap.set("n", "<leader>stt", ":TodoTelescope<CR>", { desc = "[S]earch [T]odo [T]elescope"})
    },
}
