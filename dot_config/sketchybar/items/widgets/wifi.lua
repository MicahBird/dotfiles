local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "network_update"
-- for the network interface "en0", which is fired every 2.0 seconds.
-- sbar.exec("killall network_load >/dev/null; $CONFIG_DIR/helpers/event_providers/network_load/bin/network_load en0 network_update 2.0")

local wifi_up = sbar.add("item", "widgets.wifi1", {
  position = "right",
  padding_left = -5,
  width = 0,
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.red,
    string = "???????",
  },
  y_offset = 4,
})

local wifi_down = sbar.add("item", "widgets.wifi2", {
  position = "right",
  padding_left = -5,
  label = {
    font = {
      family = settings.font.numbers,
      style = settings.font.style_map["Bold"],
      size = 9.0,
    },
    color = colors.blue,
    string = "???????",
  },
  y_offset = -4,
})

local wifi = sbar.add("item", "widgets.wifi.padding", {
  position = "right",
  label = { drawing = false },
})

-- Background around the item
local wifi_bracket = sbar.add("bracket", "widgets.wifi.bracket", {
  wifi.name,
  wifi_up.name,
  wifi_down.name
}, {
  background = { color = colors.bg1 },
  popup = { align = "center", height = 30 }
})

wifi:subscribe({"wifi_change", "system_woke"}, function(env)
  sbar.exec("ipconfig getifaddr en0", function(ip)
    local connected = not (ip == "")
    wifi:set({
      icon = {
        string = connected and icons.wifi.connected or icons.wifi.disconnected,
        color = connected and colors.white or colors.red,
      },
    })
  end)
end)

sbar.add("item", { position = "right", width = settings.group_paddings })
-- For first time load
-- Get the SSID of the current WiFi network
sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
  wifi_up:set({
    icon = { color = up_color },
    label = {
      string = result,
      color = up_color
    }
  })
end)
  
-- Get the IP of the current WiFi network
sbar.exec("ipconfig getifaddr en0", function(result)
  wifi_down:set({
    icon = { color = down_color },
    label = {
      string = result,
      color = down_color
    }
  })
end)

wifi_up:subscribe({"routine", "system_woke", "mouse.clicked"}, function()
  -- Get the SSID of the current WiFi network
  sbar.exec("ipconfig getsummary en0 | awk -F ' SSID : '  '/ SSID : / {print $2}'", function(result)
    wifi_up:set({
      icon = { color = up_color },
      label = {
        string = result,
        color = up_color
      }
    })
  end)
    
  -- Get the IP of the current WiFi network
  sbar.exec("ipconfig getifaddr en0", function(result)
    wifi_down:set({
      icon = { color = down_color },
      label = {
        string = result,
        color = down_color
      }
    })
  end)
  end)