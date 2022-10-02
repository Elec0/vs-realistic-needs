-- local user = require("modules/models/User")
local Player = require("models/Player")
-- local cron = require("modules/utils/Cron")
-- local observers = require("modules/controllers/Observers")
-- local listeners = require("modules/controllers/Listeners")

VRN = {
    description = "V's Realistic Needs",
    version = "0.1",
    strings = {},
    config = {}
}

-- Notif = require("modules/views/Notification")
-- User = user:new()
local player = Player:new()

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

function registerForEvent(name, fun)
    if name == "onInit" then fun() end
end

function VRN:new()
    registerForEvent("onInit", function()
        player:reset()

        -- Status effects: Rested (sleep), Refreshed (shower)
        -- Hydration (drink)
        -- Game tag: --[[ Buff --]] }
        -- observers.init()
        -- listeners.init()

        -- cron.Every(1.0, {tick = 1}, function(_)
        --     if Player.state.enable then
        --         Player:getConsumption()
        --         Player:updateMetabolism()
        --     end
        -- end)

        print("[Live in Night City] is initialized (v" .. VRN.version .. ")")
    end)

    -- registerForEvent("onUpdate", function(delta)
    --     cron.Update(delta)
    -- end)

    -- registerHotkey("LiveInNightCity", "Show Needs", function()
    --     Notif.show()
    -- end)
end

return VRN:new()
