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

local mymodule = {}

local nid = nil
local icon = icons.lookup({name = "display-brightness", type = "status"})

local function change(what)
   os.execute("xbacklight " .. what, false)
   local out = awful.util.pread("xbacklight -get")

   if not out then return end

   out = tonumber(out)

   nid = naughty.notify({ text = string.format("%3d %%", out),
              icon = icon,
              font = "Free Sans Bold 24",
              replaces_id = nid }).id
end

function mymodule.increase()
   change(" -steps 5 -inc 5")
end

function mymodule.decrease()
   change(" -steps 5 -dec 5")
end


return mymodule
