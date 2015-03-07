local mymodule = {}
local util = require("awful.util")
local icons = require("lib/icons")

local function getValue(t, key)
   local _, _, res = string.find(t, key .. " *= *([^%c]+)%c")
   return res
end

local function strip_exec_args(cmdline)
   return string.gmatch(cmdline, "([^ ]+)")()
end
 
local function find_icon(icon_name)
   if string.sub(icon_name, 1, 1) == '/' then
      if util.file_readable(icon_name) then
         return icon_name
      else
         return nil
      end
   else
      return icons.lookup( { name = icon_name})
   end
   return nil
end

-- module("lib/desktop_entries")
 
function mymodule.find_apps(filedir, icon_dirs)
   -- retruns  list of dicts wit the keys
   ---- image, command, position
   -- sorted by position

   local default_icon = assert(icons.lookup({name = "abrt"}))

   if not filedir then
      error("find_apps: filedir was not specified")
   end

   local items = {}
   local files = io.popen("/bin/ls " .. filedir .. "/*.desktop")

   for f in files.lines(files) do
      local t1 = io.open(f)
      if t1 then
         local t = t1:read("*all")
         local icon = find_icon(getValue(t,"Icon"))
         if not icon then
            icon = default_icon
         end
         table.insert(items, { image = icon,
                               tooltip = getValue(t,"Name"),
                               command =  strip_exec_args(getValue(t,"Exec")),
                               position = tonumber(getValue(t,"Position")) or 255 })
     end
   end

   table.sort(items, function(a,b) return a.position < b.position end)
   return items
end

return mymodule 
