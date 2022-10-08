local Log = require("utils/log")

--- Do the ticking logic here.
--- All calculations, logic, etc
--- Interact with the game in GameController
--- @class MainController
--- @field difficulty table
--- @field player Player
--- @field lastUpdateTime number
MainController = { }

--- @param difficulty table
--- @param player Player
--- @param gameTimestamp number
--- @return MainController
function MainController:new(difficulty, player, gameTimestamp)
   local o = {}
   setmetatable(o, {__index = self})
   
   o.difficulty = difficulty
   o.player = player
   o.lastUpdateTime = gameTimestamp

   o.player:set_difficulty(difficulty)

   return o
end

--- @param gameTimestamp number
--- @return void
function MainController:tick(gameTimestamp)
   -- Calculate seconds between last update and this one
   local delta = gameTimestamp - self.lastUpdateTime
   self.player:tick(delta)

   self.lastUpdateTime = gameTimestamp
end

function MainController:update_stages()
   for _, need in self.player.needs do
      Log.i(need)
   end
end

-- Input functions

function MainController:player_eat()

end

function MainController:player_drink()

end

function MainController:player_sleep()

end

function MainController:player_shower()
   
end

return MainController