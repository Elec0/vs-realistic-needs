local Need = require("models/Need")
local Log = require("utils/log")

--- @class Player
--- @field needs Need[]
Player = {
   HUNGER = 1,
   THIRST = 2,
   FATIGUE = 3,
   CLEANLINESS = 4
}

--- To be called on game init, sets up the empty objects
--- TODO: Load values from save here somehow
--- @return Player
function Player:new()
   local o = {}
   setmetatable(o, {__index = self})

   --- @type Need[]
   o.needs = {
      [Player.HUNGER] = Need:new(Player.HUNGER, 100),
      [Player.THIRST] = Need:new(Player.THIRST, 100),
      [Player.FATIGUE] = Need:new(Player.FATIGUE, 100),
      [Player.CLEANLINESS] = Need:new(Player.CLEANLINESS, 100)
   }
   return o
end

---
--- @param diff table
function Player:set_difficulty(diff)
   --- @enum PlayerNeeds
   local player_needs = {
      Player.HUNGER,
      Player.THIRST,
      Player.FATIGUE,
      Player.CLEANLINESS
   }
   for _, v in pairs(player_needs) do
      self.needs[v].decay_rate = diff[v].decay_rate
      self.needs[v].stage_table = diff[v].stage_table
   end
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