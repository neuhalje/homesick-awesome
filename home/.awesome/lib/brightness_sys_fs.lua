-- Handle brightness (with /sys/class/backlight)

local io           = require("io")
local math         = require("math")
local tonumber     = tonumber
local string       = string

local mymodule = {}

local  path = "/sys/class/backlight/intel_backlight/"

local function read_brightness()
   local f = assert(io.open(path .. "actual_brightness","r"))
   local works = f:read("*number")
   f:close()
   if (works) then works=tonumber(works) end
   return works
end

local function read_max_brightness()
   local f = assert(io.open(path .. "max_brightness","r"))
   local works = f:read("*number")
   f:close()
   return tonumber(works)
end

local function write_brightness(val)
   local f = assert(io.open(path .. "brightness","w"))
   f:write(tonumber(val))
   f:close()
end

local function test_sys_fs()
   return not (nil == read_brightness()) and not ( nil == read_max_brightness())
end

local function change(what)
   amount = tonumber(what)

   cur_val = read_brightness()
   max_brightness = read_max_brightness()
   min_brightness = 0

   one_percent = (max_brightness - min_brightness) / 100

   new_brightness = math.floor(one_percent * what + cur_val)

   if (new_brightness < min_brightness) then new_brightness = min_brightness end
   if (new_brightness > max_brightness) then new_brightness = max_brightness end

   write_brightness(new_brightness)

   return math.floor(100 * new_brightness / max_brightness)
end

function mymodule.is_available()
   return test_sys_fs()
end

function mymodule.increase()
   return change(5)
end

function mymodule.decrease()
   return change(-5)
end

return mymodule
