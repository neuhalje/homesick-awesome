local layout = require("wibox.layout")
local util = require("awful.util")
local awful = require("awful")
local launcher = require("awful.widget.launcher")
 

local launchbar = {}

local desktop_entries = require("lib/desktop_entries")
local icons = require("lib/icons")

function launchbar.new(filedir)
   if not filedir then
      error("Launchbar: filedir was not specified")
   end
   local items = desktop_entries.find_apps(filedir)
   local widget = layout.fixed.horizontal()
   local default_icon = assert(icons.lookup({name = "abrt"}))

   for _, v in ipairs(items) do
      if not v.image then
        v.image = default_icon
      end
      local l = launcher(v)
      widget:add(l)
      if v.tooltip then
              local tt = awful.tooltip({ objects = { l  } })
              tt:set_text(v.tooltip)
              tt:set_timeout (0)
      end
   end
   return widget
end
 
return setmetatable(launchbar, { __call = function(_, ...) return launchbar.new(...) end })
