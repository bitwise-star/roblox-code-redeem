local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local ProfileStore = require(ServerScriptService.Server.Libs.profilestore)
local Service = require(ServerScriptService.Server.Data.PlayerData.Service)
local Leaderstats = require(ServerScriptService.Server.Data.PlayerData.Leaderstats)
local Template = require(ReplicatedStorage.Shared.Data.Templates.Player)

local PlayerStore = ProfileStore.New("PlayerStore", Template)

if RunService:IsServer() then
    PlayerStore = PlayerStore.Mock
end

local function PlayerAdded(player: Player)
    local profile = PlayerStore:StartSessionAsync(`{player.UserId}`, {
        Cancel = function()
            return player.Parent ~= Players
        end
    })

    if profile == nil then
        profile:EndSession()
        return
    end

    profile:AddUserId(player.UserId)
    profile:Reconcile()

    profile.OnSessionEnd:Connect(function()
        Service.Profiles[player] = nil
        player:Kick("Session end")
    end)

    if player.Parent == Players then
        Service.Profiles[player] = profile
        Leaderstats.AddToPlayer(player, profile.Data)
    else
        profile:EndSession()
    end
end

local function PlayerRemoving(player: Player)
    local profile = Service.Profiles[player]

    if profile ~= nil then
        profile:EndSession()
    end
end

for _, player in Players:GetPlayers() do
    task.spawn(PlayerAdded, player)
end

Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoving)