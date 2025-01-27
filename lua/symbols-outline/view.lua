local config = require('symbols-outline.config')

local M = {}

---creates the outline window and sets it up
---@return string bufnr
---@return string bufnr
function M.setup_view()
    -- create a scratch unlisted buffer
    local bufnr = vim.api.nvim_create_buf(false, true)

    -- delete buffer when window is closed / buffer is hidden
    vim.api.nvim_buf_set_option(bufnr, "bufhidden", "delete")

    local current_win = vim.api.nvim_get_current_win()
    local current_win_width = vim.api.nvim_win_get_width(current_win)

    -- create a split
    vim.cmd(config.get_split_command())
    -- resize to a % of the current window size
    vim.cmd("vertical resize " ..
                math.ceil(current_win_width * config.get_width_percentage()))

    -- get current (outline) window and attach our buffer to it
    local winnr = vim.api.nvim_get_current_win()
    vim.api.nvim_win_set_buf(winnr, bufnr)

    -- window stuff
    vim.api.nvim_win_set_option(winnr, "number", false)
    vim.api.nvim_win_set_option(winnr, "relativenumber", false)
    vim.api.nvim_win_set_option(winnr, "winfixwidth", true)
    -- buffer stuff
    vim.api.nvim_buf_set_name(bufnr, "OUTLINE")
    vim.api.nvim_buf_set_option(bufnr, "filetype", "Outline")
    vim.api.nvim_buf_set_option(bufnr, "modifiable", false)

    if config.options.show_numbers or config.options.show_relative_numbers then
        vim.api.nvim_win_set_option(winnr, "nu", true)
    end

    if config.options.show_relative_numbers then
        vim.api.nvim_win_set_option(winnr, "rnu", true)
    end

    return bufnr, winnr
end

return M
