lu = require("libs.luaunit")
local Player = require("models.Player")
local Need = require("models.Need")

TestPlayer = {}
   function TestPlayer:setUp()
      self.player = Player:new()
   end
   function TestPlayer:testInit()
      lu.assertNotNil(self.player.needs.thirst)
      lu.assertNotNil(self.player.needs.hunger)
      lu.assertNotNil(self.player.needs.fatigue)
      lu.assertNotNil(self.player.needs.cleanliness)
   end
-- end of table TestPlayer


TestNeed = {}

-- end of table TestNeed

os.exit(lu.LuaUnit.run())