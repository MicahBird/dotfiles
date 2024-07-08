local colors = require("colors")

-- Equivalent to the --bar domain

local monitorCheck = io.popen("system_profiler SPDisplaysDataType | grep -B 3 'Main Display:' | awk '/Display Type/ {print $3}'")
local result = monitorCheck:read("*a")
monitorCheck:close()

if result == 'Built-in\n' then
  print("Main display detected.")
  sbar.bar({
    topmost = "window",
    height = 32,
    color = colors.bar.bg,
    padding_right = 2,
    padding_left = 2,
  })
else
  print("External display detected.")
  sbar.bar({
    topmost = "window",
    height = 20,
    color = colors.bar.bg,
    padding_right = 2,
    padding_left = 2,
  })
  sbar.exec("yabai -m config external_bar main:20:0")
end
