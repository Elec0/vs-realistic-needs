local Need = require("models/Need")

--- @class Player
--- @field needs Need[]
Player = {}

--- To be called on game init, sets up the empty objects
--- @return Player
function Player:new()
   local o = {}
   setmetatable(o, {__index = self})

   --- @type Need[]
   o.needs = {
      hunger = Need:new(),
      thirst = Need:new(),
      fatigue = Need:new(),
      cleanliness = Need:new()
   }
   return o
end

--- Notification that time has passed and we need to update our state
--- Delta is in seconds
---@param delta number
function Player:tick(delta)

   for _, need in pairs(self.needs) do
      need:decay(delta)
   end
end

function Player:reset()
   print("Player Reset")
end

return Player