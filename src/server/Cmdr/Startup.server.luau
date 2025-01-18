local ServerScriptService = game:GetService("ServerScriptService")

local Cmdr = require(ServerScriptService.Server.Libs.cmdr)

local Commands = ServerScriptService.Server.Cmdr.Commands
local Hooks = ServerScriptService.Server.Cmdr.Hooks

Cmdr:RegisterDefaultCommands()
Cmdr:RegisterCommandsIn(Commands)
Cmdr:RegisterHooksIn(Hooks)