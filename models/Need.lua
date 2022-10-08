local Log = require("utils/log")

--- Store the data about the need, like
--- current stage, decay rate, etc.
---
--- 1 hour of real time = 8 hours of in-game time.
---
--- @class Need
--- @field value number
--- @field decay_rate number
--- @field stage_table table
Need = {  }



--- 
--- @param need_uid number
--- @param init_value number
--- @return table
function Need:new(need_uid, init_value)
   local o = {}
   setmetatable(o, {__index = self})

   o.value = init_value
   o.decay_rate = 0
   o.stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
   o.uid = need_uid
   return o
end

--- Make sure our variables are valid
--- @param need Need
--- @return boolean
local function verify_values(need)
   if need.value > need.stage_table["max"] or 
      need.value < need.stage_table[#need.stage_table] then
         return false
   end
   return true
end

--- Given number of seconds, decay the need value.
--- decay_rate is in negative points per minute.
--- 
--- Delta is in seconds and should always be positive
--- @param delta number
function Need:decay(delta)
   if delta < 0 then 
      Log.w("Need: Invalid delta value of '" .. delta .. "'!")
      return
   end

   local decay_rate_second = self.decay_rate / 60
   local decay_amt = decay_rate_second * delta

   self.value = self.value - decay_amt

   if not verify_values(self) then
      Log.w("Invalid value '" .. self.value .. "'! Reverting by " .. decay_amt)
      -- Presumably the previous value was valid
      self.value = self.value + decay_amt
   end
end

--- What stage the need is at.  
--- This is determined by comparing `value` with `stage_table`, and 
--- finding the lowest index `value` is greater than. That is the stage.
--- 
--- For example:  
--- If `value` = 50, and we have the default `stage_table` as above, then  
--- ```
--- 0:100 > 1:80 > 2:60 > `value` > 3:40 [...]
--- ```
--- So, `stage == 3`
--- 
--- Important note: the need arrays do not go to 0, but there is a stage 0.
--- Stage 0 is the 'overfull' stage. This means the index result is subtracted
--- by 1 to get the actual stage.  
--- See the readme for a full list of need stages.
--- 
--- @return number
function Need:get_stage()
   -- Assume nominal stage if it cannot be determined
   local found_stage = 1
   for stage, threshold in ipairs(self.stage_table) do
      if self.value > threshold then
         found_stage = stage
         break
      end
   end
   return found_stage - 1
end

return Need