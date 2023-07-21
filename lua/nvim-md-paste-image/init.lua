print("hello from nvim-md-paste-image")

local function paste_image()
  print("function paste_image")
  local image_dir = "./_img"
  if os.execute("mkdir -p " .. image_dir) ~= 0 then
    error("Could not create image dir: " .. image_dir)
  end
  math.randomseed(os.time())
  local random_number = math.random(1000, 9999)
  local date = os.date("%Y-%m-%d_%H-%M-%S")
  local image_file_name = date .. "_" .. random_number .. ".png"
  local image_file_path = image_dir .. "/" .. image_file_name
  if os.execute("powershell.exe -c \"(get-clipboard -format image).save('" .. image_file_path .. "')\" > /dev/null") ~= 0 then
    error("Failure in copying image data from clipboard to " .. image_file_path)
  end
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, {"![image](" .. image_file_path .. ")" })
end

local function setup()
  vim.api.nvim_create_user_command("PasteImage", paste_image, { nargs = 0, desc = "Paste image" })
end

return {
  setup = setup
}