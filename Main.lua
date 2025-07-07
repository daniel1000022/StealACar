local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MovableGUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainWindow"
mainFrame.Size = UDim2.new(0, 500, 0, 250)
mainFrame.Position = UDim2.new(0.5, -250, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = screenGui

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

local titleText = Instance.new("TextLabel")
titleText.Size = UDim2.new(1, -40, 1, 0)
titleText.Position = UDim2.new(0, 10, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Epic Cars!"
titleText.TextColor3 = Color3.new(1, 1, 1)
titleText.Font = Enum.Font.SourceSansBold
titleText.TextSize = 20
titleText.TextXAlignment = Enum.TextXAlignment.Left
titleText.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 1, 0)
closeButton.Position = UDim2.new(1, -35, 0, 0)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.new(1, 0, 0)
closeButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
closeButton.Font = Enum.Font.SourceSansBold
closeButton.TextSize = 20
closeButton.Parent = titleBar

local leftPanel = Instance.new("Frame")
leftPanel.Name = "SelectionsPanel"
leftPanel.Size = UDim2.new(0, 120, 1, -30)
leftPanel.Position = UDim2.new(0, 0, 0, 30)
leftPanel.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
leftPanel.BorderSizePixel = 0
leftPanel.Parent = mainFrame

local autoLockButton = Instance.new("TextButton")
autoLockButton.Size = UDim2.new(1, -10, 0, 40)
autoLockButton.Position = UDim2.new(0, 5, 0, 10)
autoLockButton.Text = "Auto Lock"
autoLockButton.TextColor3 = Color3.new(1, 1, 1)
autoLockButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
autoLockButton.Font = Enum.Font.SourceSansBold
autoLockButton.TextSize = 18
autoLockButton.Parent = leftPanel

local autoLockPanel = Instance.new("Frame")
autoLockPanel.Name = "AutoLockPanel"
autoLockPanel.Size = UDim2.new(0, 200, 1, -40)
autoLockPanel.Position = UDim2.new(0, 300, 0, 40)
autoLockPanel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
autoLockPanel.BorderSizePixel = 0
autoLockPanel.Visible = false
autoLockPanel.Parent = mainFrame

local lockWaitTextBox = Instance.new("TextBox")
lockWaitTextBox.PlaceholderText = "How long do I wait"
lockWaitTextBox.Text = "10"
lockWaitTextBox.Size = UDim2.new(1, -20, 0, 30)
lockWaitTextBox.Position = UDim2.new(0, 10, 0, 10)
lockWaitTextBox.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
lockWaitTextBox.TextColor3 = Color3.new(1, 1, 1)
lockWaitTextBox.Font = Enum.Font.SourceSans
lockWaitTextBox.TextSize = 16
lockWaitTextBox.ClearTextOnFocus = false
lockWaitTextBox.Parent = autoLockPanel

local lockToggleButton = Instance.new("TextButton")
lockToggleButton.Size = UDim2.new(1, -20, 0, 30)
lockToggleButton.Position = UDim2.new(0, 10, 0, 50)
lockToggleButton.Text = "AutoLock: OFF"
lockToggleButton.TextColor3 = Color3.new(1, 1, 1)
lockToggleButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
lockToggleButton.Font = Enum.Font.SourceSansBold
lockToggleButton.TextSize = 16
lockToggleButton.Parent = autoLockPanel

autoLockButton.MouseButton1Click:Connect(function()
    autoLockPanel.Visible = true
end)

local autoLockEnabled = false
local autoLockThread = nil

lockToggleButton.MouseButton1Click:Connect(function()
    autoLockEnabled = not autoLockEnabled
    lockToggleButton.Text = autoLockEnabled and "AutoLock: ON" or "AutoLock: OFF"

    if autoLockEnabled then
        autoLockThread = task.spawn(function()
            while autoLockEnabled do
                local delay = tonumber(lockWaitTextBox.Text) or 10
                loadstring(game:HttpGet("https://raw.githubusercontent.com/daniel1000022/StealACar/main/Scripts/CloseGate.lua", true))()
                wait(delay)
            end
        end)
    end
end)

local function cleanUp()
    autoLockEnabled = false
    screenGui.Enabled = false
end

closeButton.MouseButton1Click:Connect(cleanUp)

