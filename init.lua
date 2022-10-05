local Player = require("models/Player")
local Cron = require("libs/cet-kit/Cron")
local MainController = require("controllers/MainController")
-- local GameController = require("controllers/GameController")

VRN = {
    description = "V's Realistic Needs",
    version = "0.1",
    strings = {},
    config = {}
}

local player = Player:new()
local main_controller = MainController:new()
-- local game_controller = GameController:new()

-- Eating
-- https://nativedb.red4ext.com/ItemActionsHelper
--   press eye icon to see the mangled name, you can also get it from RTTI dump
--     Override(
--     'ItemActionsHelper', 'GetEatAction;ItemActionsHelper', function(itemID, wrappedMethod)
--         DEBUG('[Metabolism] Override ItemActionsHelper::GetEatAction')
--         if IsNotNil(self:GetItemSurvivalStats(itemID)) and self:SPTooStuffedFor(itemID) then return nil end
--         return wrappedMethod(itemID)
--     end
-- )
--
-- dialogChoiceHubs = FromVariant(Game.GetBlackboardSystem():Get(Game.GetAllBlackboardDefs().UIInteractions):GetVariant(Game.GetAllBlackboardDefs().UIInteractions.DialogChoiceHubs))
-- if UIInteractions.DialogChoiceHubs > 0 or AdjustHubsCount evt > 0 then a dialog is active with some options to select 
-- dialogChoiceHubs.choiceHubs[1].title = LocKey of name of thing (like Bar Stool)
-- dialogChoiceHubs.choiceHubs[1].choices[1].localizedName
--   == "[Sit]"
-- See dialogUI.UpdateDialogHubData

function VRN:new()
    registerForEvent("onInit", function()
        player:reset()

        -- Status effects: Rested (sleep), Refreshed (shower)
        -- Hydration (drink)
        -- Game tag: --[[ Buff --]] }
        -- observers.init()
        -- listeners.init()

        -- GameTime Days, Hours, Minutes, Seconds
        -- Current time: 71, 7:25:7
        -- Current time: 71, 14:25:24

        -- Game.GetTimeSystem():GetGameTimeStamp()
        -- Time in seconds, adds up to GetGameTime as you would expect

        -- You can switch args & callback ordering, apparently
        Cron.Every(10.0, { }, function(_)
            local gameTime = Game.GetTimeSystem():GetGameTime()
            print("Current time: " .. GameTime.Days(gameTime) .. ", " .. GameTime.Hours(gameTime) .. ":" 
                .. GameTime.Minutes(gameTime) .. ":" .. GameTime.Seconds(gameTime))
        end)

        print("[V's Realistic Needs] is initialized (v" .. VRN.version .. ")")
    end)

    registerForEvent("onUpdate", function(delta)
        Cron.Update(delta)
    end)

    -- registerHotkey("LiveInNightCity", "Show Needs", function()
    --     Notif.show()
    -- end)
end

return VRN:new()
