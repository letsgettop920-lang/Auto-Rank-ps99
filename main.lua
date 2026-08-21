-- [[ PS99 AUTO RANK - CONFIGURABLE SCRIPT ]] --

-- Default configuration if none is provided by the user
getgenv().rankConfig = getgenv().rankConfig or {
    enabled = true,
    openGifts = true,
    openLootboxes = true,
    buyEggSlots = true,
    buyEquipSlots = true,
}

local config = getgenv().rankConfig
if not config.enabled then return end

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Clean up old GUI
if CoreGui:FindFirstChild("PS99Rank_UI") then
    CoreGui.PS99Rank_UI:Destroy()
end

-- Create ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "PS99Rank_UI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Create Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 320, 0, 320)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -160)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 45)
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.TextSize = 16
Title.Font = Enum.Font.GothamBold
Title.Text = "PS99 Auto Rank"
Title.Parent = MainFrame

Instance.new("UICorner", Title).CornerRadius = UDim.new(0, 12)

-- Helper function to create interactive buttons linked to config keys
local function createConfigToggle(name, configKey, yPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.9, 0, 0, 40)
    btn.Position = UDim2.new(0.05, 0, 0, yPos)
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize, btn.Font = 14, Enum.Font.GothamSemibold
    btn.Parent = MainFrame
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    
    local function updateVisual()
        if config[configKey] then
            btn.BackgroundColor3 = Color3.fromRGB(40, 180, 90)
            btn.Text = name .. ": [ON]"
        else
            btn.BackgroundColor3 = Color3.fromRGB(50, 50, 65)
            btn.Text = name .. ": [OFF]"
        end
    end
    
    updateVisual()
    
    btn.MouseButton1Click:Connect(function()
        config[configKey] = not config[configKey]
        updateVisual()
    end)
end

-- Create the toggles based on configuration keys
createConfigToggle("Open Gifts", "openGifts", 60)
createConfigToggle("Open Lootboxes", "openLootboxes", 110)
createConfigToggle("Buy Egg Slots", "buyEggSlots", 160)
createConfigToggle("Buy Equip Slots", "buyEquipSlots", 210)

-- Status label
local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -20, 0, 30)
Status.Position = UDim2.new(0, 10, 0, 265)
Status.BackgroundTransparency = 1
Status.TextColor3 = Color3.fromRGB(160, 160, 180)
Status.TextSize = 12
Status.Font = Enum.Font.Gotham
Status.Text = "Status: Config Loaded Successfully"
Status.Parent = MainFrame
