lu = require("libs.luaunit")
local Player = require("models.Player")
local Need = require("models.Need")

TestPlayer = {}
   function TestPlayer:setUp()
      self.player = Player:new()
   end
   function TestPlayer:test_init()
      lu.assertNotNil(self.player.needs.thirst)
      lu.assertNotNil(self.player.needs.hunger)
      lu.assertNotNil(self.player.needs.fatigue)
      lu.assertNotNil(self.player.needs.cleanliness)
   end
-- end of table TestPlayer


TestNeed = {}
   function TestNeed:setUp()
      self.need = Need:new()
   end

   --- Test correct values give correct stage values as based on 
   --- the stage_table. Use the hunger stage names just because.
   function TestNeed:test_get_stage()
      self.need.value = 110
      lu.assertEquals(self.need:get_stage(), 0, "Test Bloated")

      -- Full
      self.need.value = 90
      lu.assertEquals(self.need:get_stage(), 1, "Test Full")

      -- Satisfied
      self.need.value = 75
      lu.assertEquals(self.need:get_stage(), 2, "Test Satisfied")

      -- Peckish
      self.need.value = 50
      lu.assertEquals(self.need:get_stage(), 3, "Test Peckish")

      -- Hungry
      self.need.value = 31
      lu.assertEquals(self.need:get_stage(), 4, "Test Hungry")

      -- Very Hungry
      self.need.value = 20
      lu.assertEquals(self.need:get_stage(), 5, "Test Very Hungry")

      -- Starving
      self.need.value = 1
      lu.assertEquals(self.need:get_stage(), 6, "Test Starving")

      -- Dead
      self.need.value = 0
      lu.assertEquals(self.need:get_stage(), 7, "Test Dead")
   end
-- end of table TestNeed

os.exit(lu.LuaUnit.run())