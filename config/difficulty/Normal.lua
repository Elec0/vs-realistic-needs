local Player = require("models/Player")

local Normal = {
    [Player.THIRST] = {
        decay_rate = 1,
        stage_table = {["max"] = 110, 100, 80, 60, 40, 30, 10, 0, -1}
    },
    [Player.HUNGER] = {
        decay_rate = 1,
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

return Normal
