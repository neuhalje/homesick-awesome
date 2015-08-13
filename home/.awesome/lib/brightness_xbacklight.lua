-- Handle brightness (with xbacklight)
-- from https://raw.githubusercontent.com/cyrobin/awesome-wm/master/lib/brightness.lua

-- local awful        = require("awful")
-- local naughty      = require("naughty")
local tonumber     = tonumber
local string       = string
local os           = os

local mymodule = {}

local function test_xbacklight()
   local works = pcall(os.execute("xbacklight -get"))
   return works
end

local function change_xbacklight(what)
   amount = tonumber(what)
   if (amount > 0) then
       xbacklight_ok = os.execute("xbacklight -steps 5 -time 10 -inc " .. amount, false)
   else
       xbacklight_ok = os.execute("xbacklight -steps 5 -time 10 -dec " .. (-1 * amount), false)
   end

   local out = awful.util.pread("xbacklight -get")

   if not out then return end

   new_brightness = tonumber(out)
   return new_brightness
end

function mymodule.is_available()
   return test_xbacklight()
end

function mymodule.increase()
   return change_xbacklight(5)
end

function mymodule.decrease()
   return change_xbacklight(-5)
end

return mymodule
