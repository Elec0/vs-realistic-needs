
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
--- @param msg any
local function printlog(msg_level, msg)
   if VLog.level < msg_level then
      return
   end

   if type(msg) ~= "string" then
      msg = dump(msg)
   end
   local fmsg = VLog.format
                  :gsub("$L", VLog.LEVEL_NAMES[msg_level])
                  :gsub("$M", msg)
   VLog.log_func(fmsg)
end

--- Print a debug log message
--- @param msg any
function VLog.d(msg)
   printlog(LEVELS.DEBUG, msg)
end
--- Print a info log message
--- @param msg any
function VLog.i(msg)
   printlog(LEVELS.INFO, msg)
end
--- Print a warn log message
--- @param msg any
function VLog.w(msg)
   printlog(LEVELS.WARN, msg)
end
--- Print a error log message
--- @param msg any
function VLog.e(msg)
   printlog(LEVELS.ERROR, msg)
end

return VLog