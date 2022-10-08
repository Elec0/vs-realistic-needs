local lu = require("libs/luaunit")
local Player = require("models/Player")
local Need = require("models/Need")
local MainController = require("controllers/MainController")
local Config = require("config/Config")
local Log = require("utils/log")

--#region TestMainController
TestMainController = {}
   function TestMainController:setUp()
      -- Turn off the logging
      self.old_log = VLog.log_func
      VLog.log_func = function () end
      local p = Player:new()
      -- Handle defining our variables directly, since we're testing logic and not
      -- the value of the variables
      local diff = { 
         [Player.THIRST] = {
            decay_rate = 30,
            stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
         },
         [Player.HUNGER] = {
               decay_rate = 60,
               stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
         },
         [Player.FATIGUE] = {
               decay_rate = 1,
               stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
         },
         [Player.CLEANLINESS] = {
               decay_rate = 1,
               stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
         }
      }
      self.gameTime = 1000

      self.main_c = MainController:new(diff, p, self.gameTime)
   end
   function TestMainController:tearDown()
      VLog.log_func = self.old_log
   end

   function TestMainController:test_init()
      lu.assertNotNil(self.main_c.player)
      lu.assertNotNil(self.main_c.difficulty)
      lu.assertNotNil(self.main_c.lastUpdateTime)
   end

   function TestMainController:test_tick()
      local hunger = { n = self.main_c.player.needs[Player.HUNGER] }
      hunger["val_old"] = hunger.n.value
      local thirst = { n = self.main_c.player.needs[Player.THIRST] }
      thirst["val_old"] = thirst.n.value

      self.gameTime = self.gameTime + 1
      self.main_c:tick(self.gameTime)
      
      lu.assertEquals(hunger.n.value, hunger.val_old - 1, "Test need tick 1 per 1s")
      lu.assertAlmostEquals(thirst.n.value, thirst.val_old - 0.5, 0.1, "Test need tick 1 per 2s")
   end

   function TestMainController:test_negative_tick()
      local n_hunger = self.main_c.player.needs[Player.HUNGER]
      local val_old = n_hunger.value
      
      self.gameTime = self.gameTime - 1
      self.main_c:tick(self.gameTime)
      lu.assertEquals(n_hunger.value, val_old, "Test need doesn't change with invalid gameTime")
   end
--#endregion

--#region TestPlayer
TestPlayer = {}
   function TestPlayer:setUp()
      self.player = Player:new()
   end
   function TestPlayer:test_init()
      lu.assertNotNil(self.player.needs[Player.THIRST])
      lu.assertNotNil(self.player.needs[Player.HUNGER])
      lu.assertNotNil(self.player.needs[Player.FATIGUE])
      lu.assertNotNil(self.player.needs[Player.CLEANLINESS])
   end
--#endregion TestPlayer

--#region TestNeed
TestNeed = {}
   function TestNeed:setUp()
      --- @type Need
      self.need = Need:new(0, 0)
   end

   --- Ensure value decay works properly
   function TestNeed:test_decay()
      -- Decay rate of 1/s
      self.need.value = 100
      self.need.decay_rate = 60
      self.need:decay(1)
      lu.assertEquals(self.need.value, 99, "")
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
--#endregion TestNeed

--#region TestLog
TestLog = {
   backup = {},
   returned = nil
}
   function TestLog:setUp()
      TestLog.backup = {
         log_func = VLog.log_func,
         level = VLog.level,
         format = VLog.format
      }
      -- Set up the function so we can actually test it
      VLog.log_func = function (msg)
         TestLog.returned = msg
      end
   end

   function TestLog:test_error()
      VLog.level = VLog.LEVELS.ERROR

      VLog.e("Error message")
      lu.assertEquals(TestLog.returned, "ERROR/VRN: Error message")
      VLog.w("Warn message")
      lu.assertNotEquals(TestLog.returned, "WARN/VRN: Warn message")
      VLog.i("Info message")
      lu.assertNotEquals(TestLog.returned, "INFO/VRN: Info message")
      VLog.d("Debug message")
      lu.assertNotEquals(TestLog.returned, "DEBUG/VRN: Debug message")
   end
   function TestLog:test_warn()
      VLog.level = VLog.LEVELS.WARN

      VLog.e("Error message")
      lu.assertEquals(TestLog.returned, "ERROR/VRN: Error message")
      VLog.w("Warn message")
      lu.assertEquals(TestLog.returned, "WARN/VRN: Warn message")
      VLog.i("Info message")
      lu.assertNotEquals(TestLog.returned, "INFO/VRN: Info message")
      VLog.d("Debug message")
      lu.assertNotEquals(TestLog.returned, "DEBUG/VRN: Debug message")
   end
   function TestLog:test_info()
      VLog.level = VLog.LEVELS.INFO

      VLog.e("Error message")
      lu.assertEquals(TestLog.returned, "ERROR/VRN: Error message")
      VLog.w("Warn message")
      lu.assertEquals(TestLog.returned, "WARN/VRN: Warn message")
      VLog.i("Info message")
      lu.assertEquals(TestLog.returned, "INFO/VRN: Info message")
      VLog.d("Debug message")
      lu.assertNotEquals(TestLog.returned, "DEBUG/VRN: Debug message")
   end
   function TestLog:test_debug()
      VLog.level = VLog.LEVELS.DEBUG

      VLog.e("Error message")
      lu.assertEquals(TestLog.returned, "ERROR/VRN: Error message")
      VLog.w("Warn message")
      lu.assertEquals(TestLog.returned, "WARN/VRN: Warn message")
      VLog.i("Info message")
      lu.assertEquals(TestLog.returned, "INFO/VRN: Info message")
      VLog.d("Debug message")
      lu.assertEquals(TestLog.returned, "DEBUG/VRN: Debug message")
   end
   function TestLog:test_format()
      VLog.level = VLog.LEVELS.DEBUG

      VLog.format = "$L: $M"
      VLog.i("Info format")
      lu.assertEquals(TestLog.returned, "INFO: Info format")

      VLog.format = "$L$L$L"
      VLog.i("Info format")
      lu.assertEquals(TestLog.returned, "INFOINFOINFO")

      VLog.format = "$M"
      VLog.i("Info format")
      lu.assertEquals(TestLog.returned, "Info format")
   end
   function TestLog:test_varargs()
      VLog.level = VLog.LEVELS.INFO

   end
   function TestLog:test_negatives()
      VLog.level = VLog.LEVELS.WARN

      VLog.e("")
      lu.assertEquals(TestLog.returned, "ERROR/VRN: ")

      VLog.e(nil)
      lu.assertEquals(TestLog.returned, "ERROR/VRN: nil")

      VLog.e(1)
      lu.assertEquals(TestLog.returned, "ERROR/VRN: 1")

      VLog.e({assah="dude"})
      lu.assertStrContains(TestLog.returned, "[\"assah\"] = dude")
   end

   -- Restore the log settings from the start
   function TestLog:teardown()
      VLog.log_func = TestLog.backup.log_func
      VLog.level = TestLog.backup.level
      VLog.format = TestLog.backup.format
   end
--#endregion TestLog

os.exit(lu.LuaUnit.run())