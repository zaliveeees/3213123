if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local workspace = game:GetService("Workspace")

local player = Players.LocalPlayer

local autoFarmEnabled = false
local autoResetEnabled = false
local disableRenderEnabled = false
local antiAFKUsed = false
local farming = false
local bag_full = false
local resetting = false
local start_position = nil

if player.PlayerGui:FindFirstChild("MM2_UI") then
    player.PlayerGui.MM2_UI:Destroy()
end

local GUI = {}
GUI.__index = GUI

function GUI.new()
    local self = setmetatable({}, GUI)
    
    self.gui = Instance.new("ScreenGui", player.PlayerGui)
    self.gui.Name = "MM2_UI"
    self.gui.ResetOnSpawn = false
    
    self.frame = Instance.new("Frame", self.gui)
    self.frame.Size = UDim2.new(0, 320, 0, 260)
    self.frame.Position = UDim2.new(0.5, -160, 0.5, -130)
    self.frame.BackgroundColor3 = Color3.fromRGB(10, 20, 40)
    self.frame.BackgroundTransparency = 0.1
    self.frame.BorderSizePixel = 2
    self.frame.BorderColor3 = Color3.fromRGB(100, 200, 255)
    Instance.new("UICorner", self.frame).CornerRadius = UDim.new(0, 12)
    
    local gradient = Instance.new("UIGradient", self.frame)
    gradient.Rotation = 90
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(20, 40, 80)),
        ColorSequenceKeypoint.new(0.25, Color3.fromRGB(40, 80, 150)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(100, 180, 255)),
        ColorSequenceKeypoint.new(0.75, Color3.fromRGB(200, 230, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 255, 255))
    })
    
    self.frame.Size = UDim2.new(0, 0, 0, 0)
    TweenService:Create(self.frame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 320, 0, 260)
    }):Play()
    
    self:createSnowflake()
    self:createTitle()
    self:createCloseButton()
    self:createContentArea()
    self:createToggles()
    self:createAntiAFKButton()
    self:createPlayTimeCounter()
    self:createSnowAnimation()
    self:setupDragging()
    
    return self
end

function GUI:createSnowflake()
    self.snowflake = Instance.new("Frame", self.frame)
    self.snowflake.Size = UDim2.new(0, 42, 0, 42)
    self.snowflake.Position = UDim2.new(0.82, 0, 0.04, 0)
    self.snowflake.BackgroundTransparency = 1
    
    local function createArm(rotation)
        local arm = Instance.new("Frame", self.snowflake)
        arm.Size = UDim2.new(0, 2, 0, 18)
        arm.Position = UDim2.new(0.5, -1, 0.5, -9)
        arm.BackgroundColor3 = Color3.fromRGB(200, 230, 255)
        arm.Rotation = rotation
        arm.BorderSizePixel = 0
        return arm
    end
    
    for i = 0, 5 do
        local arm = createArm(i * 30)
        local side1 = Instance.new("Frame", arm)
        side1.Size = UDim2.new(0, 2, 0, 8)
        side1.Position = UDim2.new(0.5, -1, 0, 2)
        side1.BackgroundColor3 = Color3.fromRGB(180, 220, 255)
        side1.Rotation = 45
        side1.BorderSizePixel = 0
        
        local side2 = Instance.new("Frame", arm)
        side2.Size = UDim2.new(0, 2, 0, 8)
        side2.Position = UDim2.new(0.5, -1, 0, 2)
        side2.BackgroundColor3 = Color3.fromRGB(180, 220, 255)
        side2.Rotation = -45
        side2.BorderSizePixel = 0
    end
    
    local center = Instance.new("Frame", self.snowflake)
    center.Size = UDim2.new(0, 10, 0, 10)
    center.Position = UDim2.new(0.5, -5, 0.5, -5)
    center.BackgroundColor3 = Color3.fromRGB(230, 240, 255)
    center.BorderSizePixel = 0
    Instance.new("UICorner", center).CornerRadius = UDim.new(1, 0)
    
    local rotationSpeed = 0
    RunService.RenderStepped:Connect(function(delta)
        if not self.snowflake or not self.snowflake.Parent then return end
        rotationSpeed = rotationSpeed + delta * 20
        self.snowflake.Rotation = rotationSpeed % 360
    end)
end

function GUI:createTitle()
    local title = Instance.new("TextLabel", self.frame)
    title.Size = UDim2.new(1, -50, 0, 42)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "❄️ Murder Mystery 2 | Winter ❄️"
    title.TextColor3 = Color3.fromRGB(200, 230, 255)
    title.Font = Enum.Font.FredokaOne
    title.TextSize = 20
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.TextStrokeTransparency = 0.3
    title.TextStrokeColor3 = Color3.fromRGB(0, 30, 60)
end

function GUI:createCloseButton()
    self.closeBtn = Instance.new("TextButton", self.frame)
    self.closeBtn.Size = UDim2.new(0, 30, 0, 30)
    self.closeBtn.Position = UDim2.new(1, -35, 0, 6)
    self.closeBtn.Text = "X"
    self.closeBtn.BackgroundColor3 = Color3.fromRGB(180, 220, 255)
    self.closeBtn.TextColor3 = Color3.fromRGB(10, 40, 80)
    self.closeBtn.Font = Enum.Font.GothamBold
    self.closeBtn.TextSize = 16
    Instance.new("UICorner", self.closeBtn).CornerRadius = UDim.new(1, 0)
    
    self.isHidden = false
    self.closeBtn.MouseButton1Click:Connect(function()
        self.isHidden = not self.isHidden
        local newSize = self.isHidden and UDim2.new(0, 320, 0, 42) or UDim2.new(0, 320, 0, 260)
        TweenService:Create(self.frame, TweenInfo.new(0.3), { Size = newSize }):Play()
        self.contentBg.Visible = not self.isHidden
        self.snowflake.Visible = not self.isHidden
        self.snowContainer.Visible = not self.isHidden
    end)
end

function GUI:createContentArea()
    self.contentBg = Instance.new("Frame", self.frame)
    self.contentBg.Size = UDim2.new(0.92, 0, 0.76, 0)
    self.contentBg.Position = UDim2.new(0.04, 0, 0.18, 0)
    self.contentBg.BackgroundColor3 = Color3.fromRGB(20, 50, 100)
    self.contentBg.BackgroundTransparency = 0.4
    Instance.new("UICorner", self.contentBg)
    
    local iceGradient = Instance.new("UIGradient", self.contentBg)
    iceGradient.Rotation = 45
    iceGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0.00, Color3.fromRGB(40, 100, 180)),
        ColorSequenceKeypoint.new(0.50, Color3.fromRGB(100, 180, 255)),
        ColorSequenceKeypoint.new(1.00, Color3.fromRGB(180, 220, 255))
    })
    iceGradient.Transparency = NumberSequence.new(0.7)
    
    self.content = Instance.new("Frame", self.contentBg)
    self.content.Size = UDim2.new(1, -10, 1, -10)
    self.content.Position = UDim2.new(0, 5, 0, 5)
    self.content.BackgroundTransparency = 1
end

function GUI:createToggle(labelText, defaultValue, callback)
    local toggle = {}
    toggle.value = defaultValue
    
    toggle.label = Instance.new("TextLabel", self.content)
    toggle.label.Size = UDim2.new(0.7, 0, 0, 30)
    toggle.label.BackgroundTransparency = 1
    toggle.label.Text = labelText
    toggle.label.TextColor3 = Color3.fromRGB(220, 240, 255)
    toggle.label.Font = Enum.Font.GothamSemibold
    toggle.label.TextSize = 16
    toggle.label.TextXAlignment = Enum.TextXAlignment.Left
    
    toggle.bg = Instance.new("TextButton", self.content)
    toggle.bg.Size = UDim2.new(0, 50, 0, 25)
    toggle.bg.BackgroundColor3 = defaultValue and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(60, 100, 150)
    toggle.bg.Text = ""
    toggle.bg.AutoButtonColor = false
    Instance.new("UICorner", toggle.bg).CornerRadius = UDim.new(1, 0)
    
    toggle.knob = Instance.new("Frame", toggle.bg)
    toggle.knob.Size = UDim2.new(0, 20, 0, 20)
    toggle.knob.Position = defaultValue and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
    toggle.knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", toggle.knob).CornerRadius = UDim.new(1, 0)
    
    toggle.bg.MouseButton1Click:Connect(function()
        toggle.value = not toggle.value
        local pos = toggle.value and UDim2.new(1, -22, 0, 2) or UDim2.new(0, 2, 0, 2)
        local color = toggle.value and Color3.fromRGB(100, 200, 255) or Color3.fromRGB(60, 100, 150)
        TweenService:Create(toggle.knob, TweenInfo.new(0.25), { Position = pos }):Play()
        TweenService:Create(toggle.bg, TweenInfo.new(0.25), { BackgroundColor3 = color }):Play()
        callback(toggle.value)
    end)
    
    return toggle
end

function GUI:createToggles()
    local yPositions = {10, 40, 70}
    
    self.autoFarmToggle = self:createToggle("❄️ Auto Farm Coins", autoFarmEnabled, function(value)
        autoFarmEnabled = value
    end)
    self.autoFarmToggle.label.Position = UDim2.new(0.05, 0, 0, yPositions[1])
    self.autoFarmToggle.bg.Position = UDim2.new(0.78, 0, 0, yPositions[1] + 2)
    
    self.autoResetToggle = self:createToggle("🎿 Auto Reset", autoResetEnabled, function(value)
        autoResetEnabled = value
    end)
    self.autoResetToggle.label.Position = UDim2.new(0.05, 0, 0, yPositions[2])
    self.autoResetToggle.bg.Position = UDim2.new(0.78, 0, 0, yPositions[2] + 2)
    
    self.disableRenderToggle = self:createToggle("⛄ Disable Render", disableRenderEnabled, function(value)
        disableRenderEnabled = value
        RunService:Set3dRenderingEnabled(not disableRenderEnabled)
    end)
    self.disableRenderToggle.label.Position = UDim2.new(0.05, 0, 0, yPositions[3])
    self.disableRenderToggle.bg.Position = UDim2.new(0.78, 0, 0, yPositions[3] + 2)
end

function GUI:createAntiAFKButton()
    self.afkBtn = Instance.new("TextButton", self.content)
    self.afkBtn.Size = UDim2.new(0.9, 0, 0, 32)
    self.afkBtn.Position = UDim2.new(0.05, 0, 0, 110)
    self.afkBtn.BackgroundColor3 = antiAFKUsed and Color3.fromRGB(70, 180, 200) or Color3.fromRGB(100, 180, 255)
    self.afkBtn.Text = antiAFKUsed and "⛄ Anti-AFK Active" or "❄️ Enable Anti-AFK"
    self.afkBtn.TextColor3 = Color3.fromRGB(10, 40, 80)
    self.afkBtn.Font = Enum.Font.GothamBold
    self.afkBtn.TextSize = 15
    Instance.new("UICorner", self.afkBtn)
    
    self.afkBtn.MouseButton1Click:Connect(function()
        if not antiAFKUsed then
            antiAFKUsed = true
            self.afkBtn.Text = "⛄ Anti-AFK Active"
            self.afkBtn.BackgroundColor3 = Color3.fromRGB(70, 180, 200)
            loadstring(game:HttpGet("https://pastebin.com/raw/bwP4bmed"))()
        end
    end)
end

function GUI:createPlayTimeCounter()
    self.startTime = tick()
    self.playTimeLabel = Instance.new("TextLabel", self.content)
    self.playTimeLabel.Size = UDim2.new(0.9, 0, 0, 28)
    self.playTimeLabel.Position = UDim2.new(0.05, 0, 0, 155)
    self.playTimeLabel.BackgroundTransparency = 1
    self.playTimeLabel.Text = "⌛ time in game: 0d 0h 0m 0s"
    self.playTimeLabel.TextColor3 = Color3.fromRGB(200, 230, 255)
    self.playTimeLabel.Font = Enum.Font.GothamBold
    self.playTimeLabel.TextSize = 14
    self.playTimeLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    task.spawn(function()
        while self.playTimeLabel and self.playTimeLabel.Parent do
            local delta = math.floor(tick() - self.startTime)
            local d = math.floor(delta/86400)
            local h = math.floor(delta%86400/3600)
            local m = math.floor(delta%3600/60)
            local s = delta%60
            self.playTimeLabel.Text = string.format("⌛ time in game: %dd %02dh %02dm %02ds", d, h, m, s)
            task.wait(1)
        end
    end)
end

function GUI:createSnowAnimation()
    self.snowContainer = Instance.new("Frame", self.frame)
    self.snowContainer.Size = UDim2.new(1, 0, 1, 0)
    self.snowContainer.BackgroundTransparency = 1
    self.snowContainer.ClipsDescendants = true
    self.snowContainer.ZIndex = 0
    
    local function createFlake()
        local snow = Instance.new("TextLabel", self.snowContainer)
        snow.Size = UDim2.new(0, math.random(15, 25), 0, math.random(15, 25))
        snow.Position = UDim2.new(math.random(), -20, 0, -20)
        snow.Text = "❄"
        snow.BackgroundTransparency = 1
        snow.TextColor3 = Color3.fromRGB(255, 255, 255)
        snow.TextSize = math.random(12, 18)
        snow.Font = Enum.Font.Gotham
        snow.ZIndex = 0
        
        local speed = math.random(20, 40)
        local sway = math.random(-30, 30)
        local swaySpeed = math.random(1, 3)
        local time = 0
        
        task.spawn(function()
            while snow and snow.Parent do
                time = time + 0.016
                if not snow.Parent then break end
                
                local currentPos = snow.Position
                local newX = currentPos.X.Offset + math.sin(time * swaySpeed) * sway * 0.5
                local newY = currentPos.Y.Offset + speed
                
                snow.Position = UDim2.new(currentPos.X.Scale, newX, currentPos.Y.Scale, newY)
                
                if newY > 260 then
                    snow:Destroy()
                    break
                end
                
                task.wait(0.016)
            end
        end)
    end
    
    task.spawn(function()
        while self.snowContainer and self.snowContainer.Parent do
            createFlake()
            task.wait(math.random(0.2, 0.4))
        end
    end)
end

function GUI:setupDragging()
    local dragging, dragInput, dragStart, startPos
    
    local function updatePosition(input)
        local delta = input.Position - dragStart
        self.frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    
    self.frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = self.frame.Position
            
            if input.UserInputType == Enum.UserInputType.Touch then
                local connection
                connection = input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                        connection:Disconnect()
                    else
                        updatePosition(input)
                    end
                end)
            end
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    self.frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input == dragInput then
            updatePosition(input)
        end
    end)
end

local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)
    
    self.CoinCollected = ReplicatedStorage:FindFirstChild("Remotes") and 
                         ReplicatedStorage.Remotes:FindFirstChild("Gameplay") and 
                         ReplicatedStorage.Remotes.Gameplay:FindFirstChild("CoinCollected")
    
    self.RoundStart = ReplicatedStorage:FindFirstChild("Remotes") and 
                      ReplicatedStorage.Remotes:FindFirstChild("Gameplay") and 
                      ReplicatedStorage.Remotes.Gameplay:FindFirstChild("RoundStart")
    
    self.RoundEnd = ReplicatedStorage:FindFirstChild("Remotes") and 
                    ReplicatedStorage.Remotes:FindFirstChild("Gameplay") and 
                    ReplicatedStorage.Remotes.Gameplay:FindFirstChild("RoundEndFade")
    
    return self
end

function Game:setupAntiAFK()
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

function Game:getCharacter()
    return player.Character or player.CharacterAdded:Wait()
end

function Game:getHRP()
    local char = self:getCharacter()
    return char:WaitForChild("HumanoidRootPart", 10)
end

function Game:setupCoinEvents()
    if not self.CoinCollected then return end
    
    self.CoinCollected.OnClientEvent:Connect(function(_, current, max)
        if current == max and not resetting and autoResetEnabled then
            resetting = true
            bag_full = true
            local hrp = self:getHRP()
            if hrp and start_position then
                local tween = TweenService:Create(hrp, TweenInfo.new(2, Enum.EasingStyle.Linear), {CFrame = start_position})
                tween:Play()
                tween.Completed:Wait()
            end
            task.wait(0.5)
            if player.Character and player.Character:FindFirstChild("Humanoid") then
                player.Character.Humanoid.Health = 0
            end
            player.CharacterAdded:Wait()
            task.wait(1.5)
            resetting = false
            bag_full = false
        end
    end)
end

function Game:setupRoundEvents()
    if self.RoundStart then
        self.RoundStart.OnClientEvent:Connect(function()
            farming = true
            if player.Character then
                local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                if hrp then
                    start_position = hrp.CFrame
                end
            end
        end)
    end
    
    if self.RoundEnd then
        self.RoundEnd.OnClientEvent:Connect(function()
            farming = false
        end)
    end
end

function Game:getNearestCoin()
    local hrp = self:getHRP()
    if not hrp then return nil, math.huge end
    
    local closest, dist = nil, math.huge
    for _, m in pairs(workspace:GetChildren()) do
        if m:FindFirstChild("CoinContainer") then
            for _, coin in pairs(m.CoinContainer:GetChildren()) do
                if coin:IsA("BasePart") and coin:FindFirstChild("TouchInterest") then
                    local d = (hrp.Position - coin.Position).Magnitude
                    if d < dist then 
                        closest, dist = coin, d 
                    end
                end
            end
        end
    end
    return closest, dist
end

function Game:startAutoFarm()
    task.spawn(function()
        while true do
            if autoFarmEnabled and farming and not bag_full then
                local coin, dist = self:getNearestCoin()
                if coin and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        local tween = TweenService:Create(hrp, TweenInfo.new(dist / 30, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                        tween:Play()
                        repeat 
                            task.wait() 
                        until not coin:FindFirstChild("TouchInterest") or not farming or not autoFarmEnabled or not hrp.Parent
                        tween:Cancel()
                    end
                end
            end
            task.wait(0.2)
        end
    end)
end

local function main()
    local gui = GUI.new()
    local game = Game.new()
    game:setupAntiAFK()
    game:setupCoinEvents()
    game:setupRoundEvents()
    game:startAutoFarm()
end

main()
