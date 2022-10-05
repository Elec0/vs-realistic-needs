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
-- end of table TestNeed

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
-- end of table TestLog

os.exit(lu.LuaUnit.run())