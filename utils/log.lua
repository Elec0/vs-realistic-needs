
--- Handle hiding or showing different log messages based on the log level
--- If level >= messageLevel, display message
---
--- @class VLog
--- @field format string Define the log message format using the following variables:
---   * $L : Log level
---   * $M : Log message
--- @field level level What log level to display up to
--- @field log_func function Override the logging function if desired
VLog = {
   --- @enum level
   LEVELS = {
      ERROR = 0,
      WARN = 1,
      INFO = 2,
      DEBUG = 3
   },
   LEVEL_NAMES = {
      [0] = "ERROR",
      [1] = "WARN",
      [2] = "INFO",
      [3] = "DEBUG"
   },

   --- @type string
   format = "$L/VRN: $M",

   --- @type level
   level = 0,

   --- @type function
   log_func = print
}
-- Set this after main declaration as you can't do internal references during init
VLog.level = VLog.LEVELS.DEBUG

-- Shorthand
local LEVELS = VLog.LEVELS

--- Dump log method from
--- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
--- @param o any
--- @return string
local function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

--- Actually do the logging
--- @param msg_level level
--- @param ... any
local function printlog(msg_level, ...)
   if VLog.level < msg_level then
      return
   end
   local args = {...}
   local msg = ""

   -- If there's nothing to print, output nil
   if #args == 0 then
      msg = "nil"
   end
   for i, v in ipairs(args) do
      if type(v) ~= "string" then
         msg = msg .. dump(v)
      else
         msg = msg .. v
      end
   end
   

   local fmsg = VLog.format
                  :gsub("$L", VLog.LEVEL_NAMES[msg_level])
                  :gsub("$M", msg)
   VLog.log_func(fmsg)
end

--- Print a debug log message
--- @param ... any
function VLog.d(...)
   printlog(LEVELS.DEBUG, table.unpack({...}))
end
--- Print a info log message
--- @param ... any
function VLog.i(...)
   printlog(LEVELS.INFO, table.unpack({...}))
end
--- Print a warn log message
--- @param ... any
function VLog.w(...)
   printlog(LEVELS.WARN, table.unpack({...}))
end
--- Print a error log message
--- @param ... any
function VLog.e(...)
   printlog(LEVELS.ERROR, table.unpack({...}))
end

return VLog