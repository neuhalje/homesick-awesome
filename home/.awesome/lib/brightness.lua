-- Handle brightness (with xbacklight)
-- from https://raw.githubusercontent.com/cyrobin/awesome-wm/master/lib/brightness.lua

local awful        = require("awful")
local naughty      = require("naughty")
local tonumber     = tonumber
local string       = string
local os           = os

-- A bit odd, but...
require("lib/icons")
local icons        = package.loaded["lib/icons"]

require("lib/brightness_xbacklight")
require("lib/brightness_sys_fs")
require("lib/brightness_noop")


function find_delegate()
   local delegates = { 
     package.loaded["lib/brightness_xbacklight"],
     package.loaded["lib/brightness_sys_fs"],
     package.loaded["lib/brightness_noop"]
     }
   for k,v in pairs(delegates) do
      if v.is_available() then
         return v
      end
   end
end

local delegate = find_delegate()

local mymodule = {}

local nid = nil
local icon = icons.lookup({name = "display-brightness", type = "status"})



function show_new_brightness(percent)
   nid = naughty.notify({ text = string.format("%3d %%", percent),
              icon = icon,
              font = "Free Sans Bold 24",
              replaces_id = nid }).id
end

function show_message(msg)
   nid = naughty.notify({ text = string.format("%s", msg),
              icon = icon,
              font = "Free Sans Bold 24",
              replaces_id = nid }).id
end

function mymodule.is_available()
   return not (delegate == nil)
end

function mymodule.increase()
   new_value = delegate.increase()
   show_new_brightness(new_value)
end

function mymodule.decrease()
   new_value = delegate.decrease()
   show_new_brightness(new_value)
end


return mymodule
