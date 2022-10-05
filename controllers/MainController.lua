
--- Do the ticking logic here.
--- All calculations, logic, etc
--- Interact with the game in GameController
--- @class MainController
--- @param player Player
--- @param lastUpdateTime number
MainController = { }

---
---@param player Player
---@return table
function MainController:new(player)
   local o = { }
   setmetatable(o, {__index = self})

   o.player = player
   o.lastUpdateTime = 0

   return o
end

--- @param gameTimestamp number
--- @return void
function MainController:tick(gameTimestamp)
   -- Seconds between last update and this one
   local delta = gameTimestamp - self.lastUpdateTime
   self.player:tick(delta)
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