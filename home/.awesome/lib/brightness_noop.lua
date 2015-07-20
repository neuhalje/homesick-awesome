-- Handle brightness (with NOOP)


local mymodule = {}


function mymodule.is_available()
   return true
end

function mymodule.increase()
   return 0
end

function mymodule.decrease()
   return 0
end

return mymodule
