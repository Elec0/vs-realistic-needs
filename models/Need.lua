--- Store the data about the need, like
--- current stage, decay rate, etc.
--- @class Need
--- @field value number
--- @field decay_rate number
--- @field stage_table table
Need = {  }

function Need:new()
   local o = {}
   setmetatable(o, {__index = self})

   o.value = 0
   o.decay_rate = 0
   o.stage_table = {100, 80, 60, 40, 30, 10, 0, -1}
   
   return o
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