
local function is_capslock_on()
  local handle = io.popen("ioreg -r -c IOHIDSystem | grep -i CapsLock | grep '1'")
  if not handle then
    return false
  end
  local result = handle:read("*a")
  handle:close()
  return result ~= ""
end

local noice_ok, noice = pcall(require, "noice")
if not noice_ok then
  vim.notify("Noice is not installed!", vim.log.levels.ERROR)
  return
end

local capslock_notification_id = nil

local function check_capslock()
  if is_capslock_on() then
    if not capslock_notification_id then
      capslock_notification_id = noice.notify("⚠️ Caps Lock is ON!", "warn", { keep = true })
    end
  else
    if capslock_notification_id then
      noice.dismiss({}) -- Dismiss the notification
      capslock_notification_id = nil
    end
  end
end

-- Run on mode changes and insert events
vim.api.nvim_create_autocmd({ "ModeChanged", "CursorHold", "InsertEnter", "InsertLeave" }, {
  callback = check_capslock,
})

-- Run on startup
vim.defer_fn(check_capslock, 1000)
