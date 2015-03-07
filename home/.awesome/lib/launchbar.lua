local layout = require("wibox.layout")
local util = require("awful.util")
local launcher = require("awful.widget.launcher")
 

local launchbar = {}

local desktop_entries        =require("lib/desktop_entries")
 -- package.loaded["lib/desktop_entries"]

function launchbar.new(filedir, icondirs)
   if not filedir then
      error("Launchbar: filedir was not specified")
   end
   local items = desktop_entries.find_apps(filedir,icondirs)
   local widget = layout.fixed.horizontal()

   for _, v in ipairs(items) do
      if v.image then
         widget:add(launcher(v))
      end
   end
   return widget
end
 
return setmetatable(launchbar, { __call = function(_, ...) return launchbar.new(...) end })
