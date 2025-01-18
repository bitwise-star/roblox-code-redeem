local ServerScriptService = game:GetService("ServerScriptService")

local PlayerService = require(ServerScriptService.Server.Data.PlayerData.Service)

return function(context, code: string)
    local success, error = PlayerService.RedeemCode(context.Executor, code)

    if success then
        return "Code redeemed!"
    end

    return error
end