local StarterGui = game:GetService("StarterGui")
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hum = char:WaitForChild("Humanoid")
local root = char:WaitForChild("HumanoidRootPart")
local TweenService = game:GetService("TweenService")
local teleportPos = Vector3.new(880, 3, -39430)

local chairFound, x, y, zStart, zEnd, step, dur = false, 57, 3, 30000, -49032.99, -2000, 0.5
local tpCount, delay = 10, 0.1

-- Noclip
spawn(function()
    while true do
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then part.CanCollide = false end
        end
        task.wait()
    end
end)

-- Notifications
spawn(function()
    while true do
        StarterGui:SetCore("SendNotification", {
            Title = "RINGTA MADE THIS!",
            Text = "discord.gg/ringta",
            Icon = "rbxassetid://99581962287910",
            Duration = 5
        })
        task.wait(20)
    end
end)

-- Tween and chair search
for z = zStart, zEnd, step do
    if chairFound then break end
    local tween = TweenService:Create(root, TweenInfo.new(dur, Enum.EasingStyle.Linear), {CFrame = CFrame.new(x, math.max(y, 3), z)})
    tween:Play()
    tween.Completed:Wait()

    local closestChair, closestDist = nil, math.huge
    for _, item in pairs(workspace.RuntimeItems:GetDescendants()) do
        if item.Name == "Chair" and item:FindFirstChild("Seat") then
            local dist = (root.Position - item.Seat.Position).Magnitude
            if dist < closestDist then
                closestChair, closestDist = item.Seat, dist
            end
        end
    end

    if closestChair then
        char:PivotTo(closestChair.CFrame)
        closestChair:Sit(hum)
        chairFound = true
    end
end

-- Teleportation
if chairFound then
    for _ = 1, tpCount do
        root.CFrame = CFrame.new(teleportPos)
        task.wait(delay)
    end
end
