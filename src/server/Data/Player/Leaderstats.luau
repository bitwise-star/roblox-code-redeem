local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Leaderstats = {}

local PlayerTemplate = require(ReplicatedStorage.Shared.Data.Templates.Player)

function Leaderstats.AddToPlayer(player: Player, profile: PlayerTemplate.PlayerData)
    local leaderstats = Instance.new("Folder", player)
    leaderstats.Name = "leaderstats"

    local Cash = Instance.new("NumberValue", leaderstats)
    Cash.Name = "Cash"
    Cash.Value = profile.Cash

    local Gems = Instance.new("NumberValue", leaderstats)
    Gems.Name = "Gems"
    Gems.Value = profile.Gems
end

function Leaderstats.UpdateColumn(player: Player, toUpdate: string, update: number)
    local leaderstats = player:FindFirstChild("leaderstats")
    if not leaderstats then return end

    local column = leaderstats:FindFirstChild(toUpdate)
    if not column then return end

    column.Value = update
end

return Leaderstats