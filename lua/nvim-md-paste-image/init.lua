-- workaround to satisfy linter that
-- does not know about global vim variable
vim = vim

local function paste_image()
  local cwd = vim.fn.getcwd() .. "/"
  local current_dir_abs_path = vim.fn.expand("%:p:h")
  local current_dir_path_from_cwd = string.gsub(current_dir_abs_path, cwd, "", 1)
  local image_dir_name = "_img"
  local image_dir_path_from_cwd = current_dir_path_from_cwd.. "/" .. image_dir_name
  local image_dir_path_from_buffer = "./" .. image_dir_name

  if os.execute("mkdir -p " .. image_dir_path_from_cwd) ~= 0 then
    error("Could not create image dir: " .. image_dir_path_from_cwd)
  end

  -- os.date only is no more precise than seconds
  -- that is why a random number is added to the
  -- filename to avoid any collisions
  math.randomseed(os.time())
  local random_number = math.random(1000, 9999)
  local date = os.date("%Y-%m-%d_%H-%M-%S")
  local image_file_name = date .. "_" .. random_number .. ".png"
  local image_file_path_from_cwd = image_dir_path_from_cwd .. "/" .. image_file_name
  local image_file_path_from_buffer = image_dir_path_from_buffer .. "/" .. image_file_name

  -- this plugin currently works for my use case where I
  -- mainly use WSL for my work.
  if
    os.execute(
      "powershell.exe -c \"(get-clipboard -format image).save('" .. image_file_path_from_cwd .. "')\" > /dev/null"
    ) ~= 0
  then
    error("Failure in copying image data from clipboard to " .. image_file_path_from_cwd)
  end

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { "![image](" .. image_file_path_from_buffer .. ")" })
end

local function setup()
  vim.api.nvim_create_user_command("PasteImage", paste_image, { nargs = 0, desc = "Paste image" })
end

return {
  setup = setup,
}
