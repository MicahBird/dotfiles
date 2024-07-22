local colors = require("colors")
local settings = require("settings")

-- Equivalent to the --bar domain

if settings.monitorCheck == 'Built-in\n' then
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
