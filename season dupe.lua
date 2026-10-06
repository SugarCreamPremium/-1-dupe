-- Version 0.01
repeat wait() until game:IsLoaded()
local GAME_ID = 118805555015549
if game.PlaceId ~= GAME_ID then
    return
end
local RS = game:GetService("ReplicatedStorage")
local TP = game:GetService("TeleportService")
local p = game:GetService("Players").LocalPlayer
local R = RS:FindFirstChild("Remote") and RS.Remote:FindFirstChild("Season")
local tpStarted = false
local function hop()
    delay(1, function()
        TP:Teleport(game.PlaceId, p)
        tpStarted = true
    end)
end
if not R then task.wait(2) return hop() end
local allR = R:FindFirstChild("TryClaimAllRewardRE")
local freeR = R:FindFirstChild("TryClaimFreeRewardRE")
local vipR  = R:FindFirstChild("TryClaimVIPRewardRE")
if not allR then task.wait(2) return hop() end
local d = os.clock()+12
repeat task.wait(0.2) until p:FindFirstChild("Eco") or os.clock()>d
if not p:FindFirstChild("Eco") then return hop() end
local o,s = pcall(function() return require(RS.ProfileData).GetStoreData("Season") end)
local k = workspace:GetAttribute("Season")
local L = o and type(s)=="table" and k and type(s[k])=="table" and (tonumber(s[k].Level) or 0) or 0
pcall(function() allR:FireServer() end)
for _,re in ipairs({freeR, vipR}) do
    if re and L > 0 then
        for i=1,math.min(L,15) do pcall(function() re:FireServer(i) end) task.wait(0.05) end
    end
end
task.wait(0.6)
hop()
