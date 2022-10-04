--- Do the ticking logic here.
--- All calculations, logic, etc
--- Interact with the game in [GameController]
--- @class MainController
MainController = { }

function MainController:new()
   local o = { }
   setmetatable(o, {__index = self})

   return o
end

--- @param delta number
--- @return void
function MainController:tick(delta)
   
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