-- Gui to Lua
-- Version: 3.2

-- Instances:

local Spawner = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local BackgroundEffect = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIGradient = Instance.new("UIGradient")
local MainContent = Instance.new("Frame")
local TopBar = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local CloseButton = Instance.new("ImageButton")
local UICorner_2 = Instance.new("UICorner")
local Content = Instance.new("Frame")
local PetTypeSection = Instance.new("Frame")
local SectionTitle = Instance.new("TextLabel")
local ButtonContainer = Instance.new("Frame")
local FRButton = Instance.new("TextButton")
local ButtonIcon1 = Instance.new("ImageLabel")
local UICorner_3 = Instance.new("UICorner")
local UIStroke1 = Instance.new("UIStroke")
local NFRButton = Instance.new("TextButton")
local ButtonIcon2 = Instance.new("ImageLabel")
local UICorner_4 = Instance.new("UICorner")
local UIStroke2 = Instance.new("UIStroke")
local MFRButton = Instance.new("TextButton")
local ButtonIcon3 = Instance.new("ImageLabel")
local UICorner_5 = Instance.new("UICorner")
local UIStroke3 = Instance.new("UIStroke")
local InputSection = Instance.new("Frame")
local NameBox = Instance.new("TextBox")
local TextBoxIcon = Instance.new("ImageLabel")
local UICorner_6 = Instance.new("UICorner")
local UIStroke4 = Instance.new("UIStroke")
local SpawnButton = Instance.new("TextButton")
local SpawnIcon = Instance.new("ImageLabel")
local UICorner_7 = Instance.new("UICorner")
local UIStroke5 = Instance.new("UIStroke")
local UIGradient2 = Instance.new("UIGradient")
local BottomDecoration = Instance.new("Frame")
local UICorner_8 = Instance.new("UICorner")
local UIGradient3 = Instance.new("UIGradient")
local ParticleEffect = Instance.new("Frame")
local UICorner_9 = Instance.new("UICorner")

local petType = "NFR"

local function duplicatePet(petName)
    local Loads = require(game.ReplicatedStorage.Fsys).load
    local ClientData = Loads("ClientData")
    local InventoryDB = Loads("InventoryDB")
    local Inventory = ClientData.get("inventory")

    local function generate_prop()
        return {
            flyable = true,
            rideable = true,
            neon = petType == "NFR" or petType == "MFR",
            mega_neon = petType == "MFR",
            age = 1
        }
    end

    local function cloneTable(original)
        local copy = {}
        for key, value in pairs(original) do
            if type(value) == "table" then
                copy[key] = cloneTable(value)
            else
                copy[key] = value
            end
        end
        return copy
    end

    for category_name, category_table in pairs(InventoryDB) do
        for id, item in pairs(category_table) do
            if category_name == "pets" and item.name == petName then
                local fake_uuid = game.HttpService:GenerateGUID()
                local n_item = cloneTable(item)

                n_item["unique"] = "uuid_" .. fake_uuid
                n_item["category"] = "pets"
                n_item["properties"] = generate_prop()
                n_item["newness_order"] = math.random(1, 900000)

                if not Inventory[category_name] then
                    Inventory[category_name] = {}
                end

                Inventory[category_name][fake_uuid] = n_item
                return
            end
        end
    end
end

-- Properties:

Spawner.Name = "UltraSpawner"
Spawner.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
Spawner.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Spawner.ResetOnSpawn = false

-- Main Background with Effects
Main.Name = "Main"
Main.Parent = Spawner
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Position = UDim2.new(0.5, 0, 0.5, 0)
Main.Size = UDim2.new(0, 420, 0, 380)
Main.ClipsDescendants = true

BackgroundEffect.Name = "BackgroundEffect"
BackgroundEffect.Parent = Main
BackgroundEffect.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
BackgroundEffect.BorderSizePixel = 0
BackgroundEffect.Size = UDim2.new(1, 0, 1, 0)

UICorner.CornerRadius = UDim.new(0, 16)
UICorner.Parent = BackgroundEffect

UIGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(30, 30, 40)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(20, 20, 25))
}
UIGradient.Rotation = 45
UIGradient.Parent = BackgroundEffect

-- Main Content
MainContent.Name = "MainContent"
MainContent.Parent = Main
MainContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
MainContent.BackgroundTransparency = 1.000
MainContent.Size = UDim2.new(1, 0, 1, 0)

-- Top Bar with Glass Effect
TopBar.Name = "TopBar"
TopBar.Parent = MainContent
TopBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TopBar.BackgroundTransparency = 0.95
TopBar.BorderSizePixel = 0
TopBar.Size = UDim2.new(1, 0, 0, 50)

UICorner_2.CornerRadius = UDim.new(0, 16)
UICorner_2.Parent = TopBar

Title.Name = "Title"
Title.Parent = TopBar
Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1.000
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Font = Enum.Font.GothamBlack
Title.Text = "✨ PET SPAWNER"
Title.TextColor3 = Color3.fromRGB(220, 220, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left

CloseButton.Name = "CloseButton"
CloseButton.Parent = TopBar
CloseButton.AnchorPoint = Vector2.new(1, 0.5)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(1, -15, 0.5, 0)
CloseButton.Size = UDim2.new(0, 24, 0, 24)
CloseButton.Image = "rbxassetid://3926305904"
CloseButton.ImageRectOffset = Vector2.new(284, 4)
CloseButton.ImageRectSize = Vector2.new(24, 24)
CloseButton.ScaleType = Enum.ScaleType.Fit
CloseButton.MouseButton1Click:Connect(function()
    game:GetService("TweenService"):Create(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
    wait(0.3)
    Spawner:Destroy()
end)

-- Content Area
Content.Name = "Content"
Content.Parent = MainContent
Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Content.BackgroundTransparency = 1.000
Content.Position = UDim2.new(0, 0, 0, 50)
Content.Size = UDim2.new(1, 0, 1, -50)

-- Pet Type Section
PetTypeSection.Name = "PetTypeSection"
PetTypeSection.Parent = Content
PetTypeSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
PetTypeSection.BackgroundTransparency = 1.000
PetTypeSection.Position = UDim2.new(0, 25, 0, 20)
PetTypeSection.Size = UDim2.new(1, -50, 0, 120)

SectionTitle.Name = "SectionTitle"
SectionTitle.Parent = PetTypeSection
SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SectionTitle.BackgroundTransparency = 1.000
SectionTitle.Size = UDim2.new(1, 0, 0, 25)
SectionTitle.Font = Enum.Font.GothamSemibold
SectionTitle.Text = "SELECT PET TYPE"
SectionTitle.TextColor3 = Color3.fromRGB(180, 180, 220)
SectionTitle.TextSize = 12
SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

ButtonContainer.Name = "ButtonContainer"
ButtonContainer.Parent = PetTypeSection
ButtonContainer.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ButtonContainer.BackgroundTransparency = 1.000
ButtonContainer.Position = UDim2.new(0, 0, 0, 30)
ButtonContainer.Size = UDim2.new(1, 0, 0, 80)

-- FR Button
FRButton.Name = "FRButton"
FRButton.Parent = ButtonContainer
FRButton.AnchorPoint = Vector2.new(0, 0.5)
FRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
FRButton.BorderSizePixel = 0
FRButton.Position = UDim2.new(0, 0, 0.5, 0)
FRButton.Size = UDim2.new(0.32, -8, 1, 0)
FRButton.Font = Enum.Font.GothamBold
FRButton.Text = "FR"
FRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
FRButton.TextSize = 14
FRButton.TextTransparency = 0.2

ButtonIcon1.Name = "ButtonIcon1"
ButtonIcon1.Parent = FRButton
ButtonIcon1.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonIcon1.BackgroundTransparency = 1
ButtonIcon1.Position = UDim2.new(0.5, 0, 0.3, 0)
ButtonIcon1.Size = UDim2.new(0, 24, 0, 24)
ButtonIcon1.Image = "rbxassetid://3926305904"
ButtonIcon1.ImageRectOffset = Vector2.new(964, 324)
ButtonIcon1.ImageRectSize = Vector2.new(36, 36)
ButtonIcon1.ImageColor3 = Color3.fromRGB(180, 180, 220)

UICorner_3.CornerRadius = UDim.new(0, 12)
UICorner_3.Parent = FRButton

UIStroke1.Thickness = 2
UIStroke1.Color = Color3.fromRGB(80, 80, 120)
UIStroke1.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke1.Parent = FRButton

-- NFR Button (Active by default)
NFRButton.Name = "NFRButton"
NFRButton.Parent = ButtonContainer
NFRButton.AnchorPoint = Vector2.new(0.5, 0.5)
NFRButton.BackgroundColor3 = Color3.fromRGB(70, 100, 200)
NFRButton.BorderSizePixel = 0
NFRButton.Position = UDim2.new(0.5, 0, 0.5, 0)
NFRButton.Size = UDim2.new(0.32, -8, 1, 0)
NFRButton.Font = Enum.Font.GothamBold
NFRButton.Text = "NFR"
NFRButton.TextColor3 = Color3.fromRGB(255, 255, 255)
NFRButton.TextSize = 14

ButtonIcon2.Name = "ButtonIcon2"
ButtonIcon2.Parent = NFRButton
ButtonIcon2.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonIcon2.BackgroundTransparency = 1
ButtonIcon2.Position = UDim2.new(0.5, 0, 0.3, 0)
ButtonIcon2.Size = UDim2.new(0, 28, 0, 28)
ButtonIcon2.Image = "rbxassetid://3926305904"
ButtonIcon2.ImageRectOffset = Vector2.new(964, 204)
ButtonIcon2.ImageRectSize = Vector2.new(36, 36)
ButtonIcon2.ImageColor3 = Color3.fromRGB(255, 255, 255)

UICorner_4.CornerRadius = UDim.new(0, 12)
UICorner_4.Parent = NFRButton

UIStroke2.Thickness = 2
UIStroke2.Color = Color3.fromRGB(100, 150, 255)
UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke2.Parent = NFRButton

-- MFR Button
MFRButton.Name = "MFRButton"
MFRButton.Parent = ButtonContainer
MFRButton.AnchorPoint = Vector2.new(1, 0.5)
MFRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
MFRButton.BorderSizePixel = 0
MFRButton.Position = UDim2.new(1, 0, 0.5, 0)
MFRButton.Size = UDim2.new(0.32, -8, 1, 0)
MFRButton.Font = Enum.Font.GothamBold
MFRButton.Text = "MFR"
MFRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
MFRButton.TextSize = 14
MFRButton.TextTransparency = 0.2

ButtonIcon3.Name = "ButtonIcon3"
ButtonIcon3.Parent = MFRButton
ButtonIcon3.AnchorPoint = Vector2.new(0.5, 0.5)
ButtonIcon3.BackgroundTransparency = 1
ButtonIcon3.Position = UDim2.new(0.5, 0, 0.3, 0)
ButtonIcon3.Size = UDim2.new(0, 26, 0, 26)
ButtonIcon3.Image = "rbxassetid://3926305904"
ButtonIcon3.ImageRectOffset = Vector2.new(324, 364)
ButtonIcon3.ImageRectSize = Vector2.new(36, 36)
ButtonIcon3.ImageColor3 = Color3.fromRGB(180, 180, 220)

UICorner_5.CornerRadius = UDim.new(0, 12)
UICorner_5.Parent = MFRButton

UIStroke3.Thickness = 2
UIStroke3.Color = Color3.fromRGB(80, 80, 120)
UIStroke3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke3.Parent = MFRButton

-- Input Section
InputSection.Name = "InputSection"
InputSection.Parent = Content
InputSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
InputSection.BackgroundTransparency = 1.000
InputSection.Position = UDim2.new(0, 25, 0, 160)
InputSection.Size = UDim2.new(1, -50, 0, 140)

NameBox.Name = "NameBox"
NameBox.Parent = InputSection
NameBox.BackgroundColor3 = Color3.fromRGB(35, 35, 50)
NameBox.BorderSizePixel = 0
NameBox.Position = UDim2.new(0, 0, 0, 30)
NameBox.Size = UDim2.new(1, 0, 0, 50)
NameBox.Font = Enum.Font.Gotham
NameBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 160)
NameBox.PlaceholderText = "Enter Pet Name Here..."
NameBox.Text = ""
NameBox.TextColor3 = Color3.fromRGB(220, 220, 255)
NameBox.TextSize = 14
NameBox.ClearTextOnFocus = false

TextBoxIcon.Name = "TextBoxIcon"
TextBoxIcon.Parent = NameBox
TextBoxIcon.AnchorPoint = Vector2.new(0, 0.5)
TextBoxIcon.BackgroundTransparency = 1
TextBoxIcon.Position = UDim2.new(0, 15, 0.5, 0)
TextBoxIcon.Size = UDim2.new(0, 20, 0, 20)
TextBoxIcon.Image = "rbxassetid://3926305904"
TextBoxIcon.ImageRectOffset = Vector2.new(964, 44)
TextBoxIcon.ImageRectSize = Vector2.new(36, 36)
TextBoxIcon.ImageColor3 = Color3.fromRGB(120, 120, 160)

UICorner_6.CornerRadius = UDim.new(0, 12)
UICorner_6.Parent = NameBox

UIStroke4.Thickness = 2
UIStroke4.Color = Color3.fromRGB(70, 70, 100)
UIStroke4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke4.Parent = NameBox

-- Spawn Button
SpawnButton.Name = "SpawnButton"
SpawnButton.Parent = InputSection
SpawnButton.AnchorPoint = Vector2.new(0.5, 0)
SpawnButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
SpawnButton.BorderSizePixel = 0
SpawnButton.Position = UDim2.new(0.5, 0, 0, 95)
SpawnButton.Size = UDim2.new(1, 0, 0, 55)
SpawnButton.Font = Enum.Font.GothamBlack
SpawnButton.Text = "SPAWN PET"
SpawnButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnButton.TextSize = 16

SpawnIcon.Name = "SpawnIcon"
SpawnIcon.Parent = SpawnButton
SpawnIcon.AnchorPoint = Vector2.new(0, 0.5)
SpawnIcon.BackgroundTransparency = 1
SpawnIcon.Position = UDim2.new(0, 20, 0.5, 0)
SpawnIcon.Size = UDim2.new(0, 24, 0, 24)
SpawnIcon.Image = "rbxassetid://3926305904"
SpawnIcon.ImageRectOffset = Vector2.new(124, 364)
SpawnIcon.ImageRectSize = Vector2.new(36, 36)
SpawnIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)

UICorner_7.CornerRadius = UDim.new(0, 14)
UICorner_7.Parent = SpawnButton

UIStroke5.Thickness = 3
UIStroke5.Color = Color3.fromRGB(120, 160, 255)
UIStroke5.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
UIStroke5.Parent = SpawnButton

UIGradient2.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(90, 130, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(70, 110, 235))
}
UIGradient2.Rotation = 90
UIGradient2.Parent = SpawnButton

-- Bottom Decoration
BottomDecoration.Name = "BottomDecoration"
BottomDecoration.Parent = MainContent
BottomDecoration.AnchorPoint = Vector2.new(0.5, 1)
BottomDecoration.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
BottomDecoration.BorderSizePixel = 0
BottomDecoration.Position = UDim2.new(0.5, 0, 1, 0)
BottomDecoration.Size = UDim2.new(1, -50, 0, 3)

UICorner_8.CornerRadius = UDim.new(1, 0)
UICorner_8.Parent = BottomDecoration

UIGradient3.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0.00, Color3.fromRGB(80, 120, 255)),
    ColorSequenceKeypoint.new(0.50, Color3.fromRGB(120, 160, 255)),
    ColorSequenceKeypoint.new(1.00, Color3.fromRGB(80, 120, 255))
}
UIGradient3.Parent = BottomDecoration

-- Particle Effect (Optional visual element)
ParticleEffect.Name = "ParticleEffect"
ParticleEffect.Parent = Main
ParticleEffect.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
ParticleEffect.BackgroundTransparency = 0.8
ParticleEffect.BorderSizePixel = 0
ParticleEffect.Position = UDim2.new(0.8, 0, 0.1, 0)
ParticleEffect.Size = UDim2.new(0, 8, 0, 8)
ParticleEffect.ZIndex = 0

UICorner_9.CornerRadius = UDim.new(1, 0)
UICorner_9.Parent = ParticleEffect

-- Button Click Handlers with Enhanced Animations
FRButton.MouseButton1Click:Connect(function()
    petType = "FR"
    
    -- Reset all buttons
    FRButton.BackgroundColor3 = Color3.fromRGB(70, 100, 200)
    NFRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    MFRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    
    FRButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NFRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    MFRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    
    FRButton.TextTransparency = 0
    NFRButton.TextTransparency = 0.2
    MFRButton.TextTransparency = 0.2
    
    -- Animation
    game:GetService("TweenService"):Create(FRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -4, 1, 5)}):Play()
    game:GetService("TweenService"):Create(NFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
    game:GetService("TweenService"):Create(MFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
end)

NFRButton.MouseButton1Click:Connect(function()
    petType = "NFR"
    
    -- Reset all buttons
    FRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    NFRButton.BackgroundColor3 = Color3.fromRGB(70, 100, 200)
    MFRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    
    FRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    NFRButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MFRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    
    FRButton.TextTransparency = 0.2
    NFRButton.TextTransparency = 0
    MFRButton.TextTransparency = 0.2
    
    -- Animation
    game:GetService("TweenService"):Create(NFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -4, 1, 5)}):Play()
    game:GetService("TweenService"):Create(FRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
    game:GetService("TweenService"):Create(MFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
end)

MFRButton.MouseButton1Click:Connect(function()
    petType = "MFR"
    
    -- Reset all buttons
    FRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    NFRButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    MFRButton.BackgroundColor3 = Color3.fromRGB(70, 100, 200)
    
    FRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    NFRButton.TextColor3 = Color3.fromRGB(200, 200, 255)
    MFRButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
    FRButton.TextTransparency = 0.2
    NFRButton.TextTransparency = 0.2
    MFRButton.TextTransparency = 0
    
    -- Animation
    game:GetService("TweenService"):Create(MFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -4, 1, 5)}):Play()
    game:GetService("TweenService"):Create(FRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
    game:GetService("TweenService"):Create(NFRButton, TweenInfo.new(0.3), {Size = UDim2.new(0.32, -8, 1, 0)}):Play()
end)

-- Enhanced Hover Effects
local function setupPremiumButtonHover(button)
    local originalSize = button.Size
    local originalColor = button.BackgroundColor3
    
    button.MouseEnter:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(70, 100, 200) then
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(50, 50, 70),
                Size = originalSize + UDim2.new(0, 0, 0, 3)
            }):Play()
        end
    end)
    
    button.MouseLeave:Connect(function()
        if button.BackgroundColor3 ~= Color3.fromRGB(70, 100, 200) then
            game:GetService("TweenService"):Create(button, TweenInfo.new(0.2), {
                BackgroundColor3 = originalColor,
                Size = originalSize
            }):Play()
        end
    end)
end

setupPremiumButtonHover(FRButton)
setupPremiumButtonHover(NFRButton)
setupPremiumButtonHover(MFRButton)

-- Enhanced Spawn Button
SpawnButton.MouseButton1Click:Connect(function()
    if NameBox.Text ~= "" then
        -- Premium click animation
        local originalSize = SpawnButton.Size
        game:GetService("TweenService"):Create(SpawnButton, TweenInfo.new(0.1), {
            Size = originalSize - UDim2.new(0, 10, 0, 5),
            BackgroundColor3 = Color3.fromRGB(60, 100, 235)
        }):Play()
        
        wait(0.1)
        
        game:GetService("TweenService"):Create(SpawnButton, TweenInfo.new(0.2), {
            Size = originalSize,
            BackgroundColor3 = Color3.fromRGB(80, 120, 255)
        }):Play()
        
        -- Success effect
        game:GetService("TweenService"):Create(SpawnButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(100, 200, 100)
        }):Play()
        
        wait(0.3)
        
        game:GetService("TweenService"):Create(SpawnButton, TweenInfo.new(0.3), {
            BackgroundColor3 = Color3.fromRGB(80, 120, 255)
        }):Play()
        
        -- Call function
        duplicatePet(NameBox.Text)
    else
        -- Error animation
        local originalColor = NameBox.BackgroundColor3
        game:GetService("TweenService"):Create(NameBox, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(100, 40, 40),
            UIStroke4.Color = Color3.fromRGB(255, 80, 80)
        }):Play()
        
        wait(0.5)
        
        game:GetService("TweenService"):Create(NameBox, TweenInfo.new(0.2), {
            BackgroundColor3 = originalColor,
            UIStroke4.Color = Color3.fromRGB(70, 70, 100)
        }):Play()
    end
end)

-- Enhanced NameBox Focus Effects
NameBox.Focused:Connect(function()
    game:GetService("TweenService"):Create(NameBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(45, 45, 65),
        UIStroke4.Color = Color3.fromRGB(100, 150, 255)
    }):Play()
end)

NameBox.FocusLost:Connect(function()
    game:GetService("TweenService"):Create(NameBox, TweenInfo.new(0.2), {
        BackgroundColor3 = Color3.fromRGB(35, 35, 50),
        UIStroke4.Color = Color3.fromRGB(70, 70, 100)
    }):Play()
end)

-- Premium Drag functionality
local UIS = game:GetService('UserInputService')
local frame = Main
local dragToggle = nil
local dragSpeed = 0.25
local dragStart = nil
local startPos = nil

local function updateInput(input)
	local delta = input.Position - dragStart
	local position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
		startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	game:GetService('TweenService'):Create(frame, TweenInfo.new(dragSpeed), {Position = position}):Play()
end

TopBar.InputBegan:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then 
		dragToggle = true
		dragStart = input.Position
		startPos = frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragToggle = false
			end
		end)
	end
end)

UIS.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		if dragToggle then
			updateInput(input)
		end
	end
end)

-- Initial animation
Main.Size = UDim2.new(0, 0, 0, 0)
game:GetService("TweenService"):Create(Main, TweenInfo.new(0.5), {
    Size = UDim2.new(0, 420, 0, 380)
}):Play()
