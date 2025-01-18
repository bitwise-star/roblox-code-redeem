local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Leaderstats = require(ServerScriptService.Server.Data.Player.Leaderstats)
local CodesConfig = require(ReplicatedStorage.Shared.Config.Codes)

type TSetByParam = "Cash" | "Gems"

local Service = {}
Service.Profiles = {}

function Service.SetBy(player: Player, toSet: TSetByParam, setBy: number)
    local profile = Service.Profiles[player]
    if not profile then return end

    profile.Data[toSet] += setBy
    Leaderstats.UpdateColumn(player, toSet, profile.Data[toSet])
end

function Service.RedeemCode(player: Player, code: string)
    local profile = Service.Profiles[player]

    if not profile then
        return false, "Cannot find player data"
    end

    if not Service.FindRedeemedCode(player, code) then
        local CodeRewards = CodesConfig[code]
        if not CodeRewards then return false, "Code doesn't exists!" end

        table.insert(profile.Data.RedeemedCodes, code)
        Service.SetBy(player, "Cash", CodeRewards.Cash)
        Service.SetBy(player, "Gems", CodeRewards.Gems)

        return true
    end

    return false, "You already redeemed this code!"
end

function Service.FindRedeemedCode(player: Player, code: string)
    local profile = Service.Profiles[player]
    if not profile then return end

    local redeemIndex = table.find(profile.Data.RedeemedCodes, code)

    return if redeemIndex then true else false
end

return Service