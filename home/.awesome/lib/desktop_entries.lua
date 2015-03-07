local mymodule = {}
local util = require("awful.util")

local function getValue(t, key)
   local _, _, res = string.find(t, key .. " *= *([^%c]+)%c")
   return res
end
 
local function find_icon(icon_name, icon_dirs)
   if string.sub(icon_name, 1, 1) == '/' then
      if util.file_readable(icon_name) then
         return icon_name
      else
         return nil
      end
   end
 
   if icon_dirs then
      for _, v in ipairs(icon_dirs) do
         if util.file_readable(v .. "/" .. icon_name) then
            return v .. '/' .. icon_name
         end
         if util.file_readable(v .. "/" .. icon_name .. ".png" ) then
            return v .. '/' .. icon_name .. ".png"
         end
      end
   end
   -- error("Launchbar: icon not found " .. icon_name)
   return nil
end

-- module("lib/desktop_entries")
 
function mymodule.find_apps(filedir, icon_dirs)
   -- retruns  list of dicts wit the keys
   ---- image, command, position
   -- sorted by position

   if not filedir then
      error("find_apps: filedir was not specified")
   end
   local items = {}
   local files = io.popen("/bin/ls " .. filedir .. "/*.desktop")

   for f in files.lines(files) do
      local t1 = io.open(f)
      if t1 then
         local t = t1:read("*all")
         table.insert(items, { image = find_icon(getValue(t,"Icon"), icon_dirs),
                               command = getValue(t,"Exec"),
                               position = tonumber(getValue(t,"Position")) or 255 })
     end
   end
   table.sort(items, function(a,b) return a.position < b.position end)
   return items
end
return mymodule 
