local Need = require("models/Need")

Player = {}

function Player:new()
   local o = {}
   setmetatable(o, {__index = self})

   o.needs = {
      hunger = Need:new(),
      thirst = Need:new(),
      fatigue = Need:new(),
      cleanliness = Need:new()
   }
   return o
end

function Player:reset()
   print("Player Reset")
end

return Player