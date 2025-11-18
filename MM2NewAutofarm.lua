if not game:GetService("RunService"):IsClient() then
    return
end

if not game:IsLoaded() then 
    game.Loaded:Wait() 
end

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local VirtualUser = game:GetService("VirtualUser")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

-- Ожидаем загрузки игрока
if not player then
    Players.PlayerAdded:Wait()
    player = Players.LocalPlayer
end

-- Удаляем старый UI
if player:FindFirstChild("PlayerGui") then
    if player.PlayerGui:FindFirstChild("MM2_UI") then
        player.PlayerGui.MM2_UI:Destroy()
    end
end

-- Стартовые значения
local autoFarmEnabled = false
local autoResetEnabled = false
local disableRenderEnabled = false
local antiAFKUsed = false

-- Современный UI
local gui = Instance.new("ScreenGui")
gui.Name = "MM2_UI"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Главный контейнер
local mainContainer = Instance.new("Frame")
mainContainer.Size = UDim2.new(0, 360, 0, 420)
mainContainer.Position = UDim2.new(0.5, -180, 0.5, -210)
mainContainer.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
mainContainer.BackgroundTransparency = 0.05
mainContainer.BorderSizePixel = 0
mainContainer.Parent = gui

local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 14)
mainCorner.Parent = mainContainer

-- Эффект тени
local shadow = Instance.new("ImageLabel")
shadow.Size = UDim2.new(1, 24, 1, 24)
shadow.Position = UDim2.new(0, -12, 0, -12)
shadow.BackgroundTransparency = 1
shadow.Image = "rbxassetid://5554236805"
shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
shadow.ImageTransparency = 0.85
shadow.ScaleType = Enum.ScaleType.Slice
shadow.SliceCenter = Rect.new(23, 23, 277, 277)
shadow.ZIndex = -1
shadow.Parent = mainContainer

-- Анимированное появление
mainContainer.Size = UDim2.new(0, 0, 0, 0)
TweenService:Create(mainContainer, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 360, 0, 420)
}):Play()

-- Верхняя панель с градиентом
local topBar = Instance.new("Frame")
topBar.Size = UDim2.new(1, 0, 0, 50)
topBar.Position = UDim2.new(0, 0, 0, 0)
topBar.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
topBar.BorderSizePixel = 0
topBar.Parent = mainContainer

local topBarCorner = Instance.new("UICorner")
topBarCorner.CornerRadius = UDim.new(0, 14)
topBarCorner.Parent = topBar

local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(106, 90, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 95, 109))
})
gradient.Parent = topBar

-- Заголовок
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.BackgroundTransparency = 1
title.Text = "MURDER MYSTERY 2"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBlack
title.TextSize = 16
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = topBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -60, 1, -20)
subtitle.Position = UDim2.new(0, 20, 0, 20)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Premium Auto Farm"
subtitle.TextColor3 = Color3.fromRGB(220, 220, 240)
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 11
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = topBar

-- Кнопка закрытия/сворачивания
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 26, 0, 26)
closeBtn.Position = UDim2.new(1, -33, 0, 12)
closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.Text = "-"
closeBtn.AutoButtonColor = false
closeBtn.Parent = topBar

local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 6)
closeCorner.Parent = closeBtn

-- Контентная область с скроллом
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, -30, 1, -70)
scrollFrame.Position = UDim2.new(0, 15, 0, 55)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 120)
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 380)
scrollFrame.Parent = mainContainer

-- Функция создания карточек с переключателями
local function createToggleCard(yPos, icon, titleText, description, defaultValue, callback)
    local card = Instance.new("Frame")
    card.Size = UDim2.new(1, 0, 0, 72)
    card.Position = UDim2.new(0, 0, 0, yPos)
    card.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    card.BorderSizePixel = 0
    card.Parent = scrollFrame
    
    local cardCorner = Instance.new("UICorner")
    cardCorner.CornerRadius = UDim.new(0, 10)
    cardCorner.Parent = card
    
    -- Анимация при наведении
    card.MouseEnter:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(30, 30, 45)
        }):Play()
    end)
    
    card.MouseLeave:Connect(function()
        TweenService:Create(card, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        }):Play()
    end)
    
    -- Иконка
    local iconLabel = Instance.new("TextLabel")
    iconLabel.Size = UDim2.new(0, 36, 0, 36)
    iconLabel.Position = UDim2.new(0, 12, 0, 18)
    iconLabel.BackgroundTransparency = 1
    iconLabel.Text = icon
    iconLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    iconLabel.Font = Enum.Font.GothamBold
    iconLabel.TextSize = 18
    iconLabel.Parent = card
    
    -- Заголовок
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(0.6, -50, 0, 22)
    titleLabel.Position = UDim2.new(0, 55, 0, 15)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = titleText
    titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    titleLabel.Font = Enum.Font.GothamSemibold
    titleLabel.TextSize = 14
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = card
    
    -- Описание
    local descLabel = Instance.new("TextLabel")
    descLabel.Size = UDim2.new(0.6, -50, 0, 32)
    descLabel.Position = UDim2.new(0, 55, 0, 35)
    descLabel.BackgroundTransparency = 1
    descLabel.Text = description
    descLabel.TextColor3 = Color3.fromRGB(160, 160, 180)
    descLabel.Font = Enum.Font.Gotham
    descLabel.TextSize = 11
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.TextWrapped = true
    descLabel.Parent = card
    
    -- Переключатель
    local toggleBg = Instance.new("TextButton")
    toggleBg.Size = UDim2.new(0, 48, 0, 24)
    toggleBg.Position = UDim2.new(1, -60, 0, 24)
    toggleBg.BackgroundColor3 = defaultValue and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(70, 70, 90)
    toggleBg.Text = ""
    toggleBg.AutoButtonColor = false
    toggleBg.Parent = card
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(1, 0)
    toggleCorner.Parent = toggleBg
    
    local toggleKnob = Instance.new("Frame")
    toggleKnob.Size = UDim2.new(0, 18, 0, 18)
    toggleKnob.Position = defaultValue and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 3, 0, 3)
    toggleKnob.BackgroundColor3 = Color3.new(1, 1, 1)
    toggleKnob.BorderSizePixel = 0
    toggleKnob.Parent = toggleBg
    
    local knobCorner = Instance.new("UICorner")
    knobCorner.CornerRadius = UDim.new(1, 0)
    knobCorner.Parent = toggleKnob
    
    -- Анимация переключателя
    toggleBg.MouseButton1Click:Connect(function()
        defaultValue = not defaultValue
        local newPos = defaultValue and UDim2.new(1, -20, 0, 3) or UDim2.new(0, 3, 0, 3)
        local newColor = defaultValue and Color3.fromRGB(76, 175, 80) or Color3.fromRGB(70, 70, 90)
        
        TweenService:Create(toggleKnob, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            Position = newPos
        }):Play()
        
        TweenService:Create(toggleBg, TweenInfo.new(0.15, Enum.EasingStyle.Quad), {
            BackgroundColor3 = newColor
        }):Play()
        
        callback(defaultValue)
    end)
    
    return card
end

-- Создание карточек функций
createToggleCard(0, "💰", "Auto Farm Coins", "Automatically collect coins during rounds", autoFarmEnabled, function(value) 
    autoFarmEnabled = value 
end)

createToggleCard(82, "🔄", "Auto Reset", "Reset character when bag is full", autoResetEnabled, function(value) 
    autoResetEnabled = value 
end)

createToggleCard(164, "👁️", "Disable Render", "Improve performance by disabling graphics", disableRenderEnabled, function(value)
    disableRenderEnabled = value
    if RunService:IsClient() then
        RunService:Set3dRenderingEnabled(not disableRenderEnabled)
    end
end)

-- Кнопка Anti-AFK
local afkCard = Instance.new("Frame")
afkCard.Size = UDim2.new(1, 0, 0, 62)
afkCard.Position = UDim2.new(0, 0, 0, 246)
afkCard.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
afkCard.BorderSizePixel = 0
afkCard.Parent = scrollFrame

local afkCardCorner = Instance.new("UICorner")
afkCardCorner.CornerRadius = UDim.new(0, 10)
afkCardCorner.Parent = afkCard

local afkIcon = Instance.new("TextLabel")
afkIcon.Size = UDim2.new(0, 36, 0, 36)
afkIcon.Position = UDim2.new(0, 12, 0, 13)
afkIcon.BackgroundTransparency = 1
afkIcon.Text = "⏰"
afkIcon.TextColor3 = Color3.fromRGB(180, 180, 200)
afkIcon.Font = Enum.Font.GothamBold
afkIcon.TextSize = 18
afkIcon.Parent = afkCard

local afkTitle = Instance.new("TextLabel")
afkTitle.Size = UDim2.new(0.6, -50, 0, 22)
afkTitle.Position = UDim2.new(0, 55, 0, 13)
afkTitle.BackgroundTransparency = 1
afkTitle.Text = "Anti-AFK System"
afkTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
afkTitle.Font = Enum.Font.GothamSemibold
afkTitle.TextSize = 14
afkTitle.TextXAlignment = Enum.TextXAlignment.Left
afkTitle.Parent = afkCard

local afkDesc = Instance.new("TextLabel")
afkDesc.Size = UDim2.new(0.6, -50, 0, 20)
afkDesc.Position = UDim2.new(0, 55, 0, 33)
afkDesc.BackgroundTransparency = 1
afkDesc.Text = "Prevent being kicked for inactivity"
afkDesc.TextColor3 = Color3.fromRGB(160, 160, 180)
afkDesc.Font = Enum.Font.Gotham
afkDesc.TextSize = 11
afkDesc.TextXAlignment = Enum.TextXAlignment.Left
afkDesc.Parent = afkCard

local afkBtn = Instance.new("TextButton")
afkBtn.Size = UDim2.new(0, 90, 0, 28)
afkBtn.Position = UDim2.new(1, -60, 0, 17)
afkBtn.BackgroundColor3 = antiAFKUsed and Color3.fromRGB(67, 160, 71) or Color3.fromRGB(106, 90, 255)
afkBtn.Text = antiAFKUsed and "ACTIVE" or "ENABLE"
afkBtn.TextColor3 = Color3.new(1, 1, 1)
afkBtn.Font = Enum.Font.GothamBold
afkBtn.TextSize = 11
afkBtn.AutoButtonColor = false
afkBtn.Parent = afkCard

local afkBtnCorner = Instance.new("UICorner")
afkBtnCorner.CornerRadius = UDim.new(0, 6)
afkBtnCorner.Parent = afkBtn

-- Анимация кнопки Anti-AFK
afkBtn.MouseButton1Click:Connect(function()
    if not antiAFKUsed then
        antiAFKUsed = true
        TweenService:Create(afkBtn, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(67, 160, 71),
            Text = "ACTIVE"
        }):Play()
        -- Простой Anti-AFK вместо внешнего скрипта
        player.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
    end
end)

-- Таймер игры
local startTime = tick()
local timeCard = Instance.new("Frame")
timeCard.Size = UDim2.new(1, 0, 0, 42)
timeCard.Position = UDim2.new(0, 0, 0, 318)
timeCard.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
timeCard.BorderSizePixel = 0
timeCard.Parent = scrollFrame

local timeCardCorner = Instance.new("UICorner")
timeCardCorner.CornerRadius = UDim.new(0, 10)
timeCardCorner.Parent = timeCard

local timeIcon = Instance.new("TextLabel")
timeIcon.Size = UDim2.new(0, 30, 0, 30)
timeIcon.Position = UDim2.new(0, 10, 0, 6)
timeIcon.BackgroundTransparency = 1
timeIcon.Text = "⏱️"
timeIcon.TextColor3 = Color3.fromRGB(180, 180, 200)
timeIcon.Font = Enum.Font.GothamBold
timeIcon.TextSize = 16
timeIcon.Parent = timeCard

local timeLabel = Instance.new("TextLabel")
timeLabel.Size = UDim2.new(1, -50, 1, 0)
timeLabel.Position = UDim2.new(0, 45, 0, 0)
timeLabel.BackgroundTransparency = 1
timeLabel.Text = "Session Time: 00:00:00"
timeLabel.TextColor3 = Color3.fromRGB(200, 200, 220)
timeLabel.Font = Enum.Font.GothamSemibold
timeLabel.TextSize = 12
timeLabel.TextXAlignment = Enum.TextXAlignment.Left
timeLabel.Parent = timeCard

-- Обновление таймера
task.spawn(function()
    while gui.Parent do
        local delta = math.floor(tick() - startTime)
        local hours = math.floor(delta / 3600)
        local minutes = math.floor((delta % 3600) / 60)
        local seconds = delta % 60
        timeLabel.Text = string.format("Session Time: %02d:%02d:%02d", hours, minutes, seconds)
        task.wait(1)
    end
end)

-- Обновляем размер скролла
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 370)

-- Функционал перетаскивания
local dragging, dragInput, dragStart, startPos
local function updateFramePosition(input)
    local delta = input.Position - dragStart
    mainContainer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

topBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainContainer.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

topBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        updateFramePosition(input)
    end
end)

-- Сворачивание/разворачивание
local isMinimized = false
closeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    local targetSize = isMinimized and UDim2.new(0, 360, 0, 50) or UDim2.new(0, 360, 0, 420)
    local targetText = isMinimized and "+" or "-"
    
    TweenService:Create(mainContainer, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
        Size = targetSize
    }):Play()
    
    TweenService:Create(closeBtn, TweenInfo.new(0.2), {
        Rotation = isMinimized and 180 or 0
    }):Play()
    
    scrollFrame.Visible = not isMinimized
    closeBtn.Text = targetText
end)

-- Анимация кнопки закрытия
closeBtn.MouseEnter:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    }):Play()
end)

closeBtn.MouseLeave:Connect(function()
    TweenService:Create(closeBtn, TweenInfo.new(0.1), {
        BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    }):Play()
end)

-- Auto Farm Coins функционал
local success, remotes = pcall(function()
    return ReplicatedStorage.Remotes
end)

if not success then
    warn("Remotes not found! Auto Farm will not work.")
else
    local CoinCollected = remotes.Gameplay.CoinCollected
    local RoundStart = remotes.Gameplay.RoundStart
    local RoundEnd = remotes.Gameplay.RoundEndFade

    local farming = false
    local bag_full = false
    local resetting = false
    local start_position = nil

    -- Anti-AFK
    player.Idled:Connect(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)

    local function getCharacter() 
        return player.Character or player.CharacterAdded:Wait() 
    end

    local function getHRP() 
        local character = getCharacter()
        local hrp = character:WaitForChild("HumanoidRootPart", 10)
        return hrp
    end

    CoinCollected.OnClientEvent:Connect(function(_, current, max)
        if current == max and not resetting and autoResetEnabled then
            resetting = true
            bag_full = true
            local hrp = getHRP()
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

    RoundStart.OnClientEvent:Connect(function()
        farming = true
        local hrp = getHRP()
        if hrp then
            start_position = hrp.CFrame
        end
    end)

    RoundEnd.OnClientEvent:Connect(function()
        farming = false
    end)

    local function get_nearest_coin()
        local hrp = getHRP()
        if not hrp then return nil, math.huge end
        
        local closest, dist = nil, math.huge
        for _, m in pairs(Workspace:GetChildren()) do
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

    -- Основной цикл фарма
    task.spawn(function()
        while gui.Parent do
            if autoFarmEnabled and farming and not bag_full then
                local coin, dist = get_nearest_coin()
                if coin then
                    local hrp = getHRP()
                    if hrp then
                        if dist > 150 then
                            hrp.CFrame = coin.CFrame
                        else
                            local tween = TweenService:Create(hrp, TweenInfo.new(dist / 25, Enum.EasingStyle.Linear), {CFrame = coin.CFrame})
                            tween:Play()
                            repeat 
                                task.wait() 
                            until not coin:FindFirstChild("TouchInterest") or not farming or not autoFarmEnabled or not gui.Parent
                            tween:Cancel()
                        end
                    end
                end
            end
            task.wait(0.1)
        end
    end)
end

print("MM2 UI loaded successfully!")
