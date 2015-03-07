local autostart = {}
local util = require("awful.util")
local desktop_entries = require("lib/desktop_entries")

function autostart.run(filedir)
   if not filedir then
      error("Autostart: filedir was not specified")
   end

   local items = desktop_entries.find_apps(filedir)

   for k,v in pairs(items) do
       local cmd = v.command
       util.spawn_with_shell(cmd)
   end
end
 
return autostart
