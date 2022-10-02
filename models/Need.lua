
Need = {}

function Need:new()
   local n = {}
   setmetatable(n, {__index = self})

   return n
end

return Need