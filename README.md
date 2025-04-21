local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Sc-Rhyan57/ThisSxHub/refs/heads/main/Library/OrionLibrary.lua')))()


local Window = OrionLib:MakeWindow({
    Name = "MATRIX HUB V2🎩",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "Pb",
    IntroText = "Team Cartola Center🎩"
})


local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ScreenGui"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

local Toggle = Instance.new("ImageButton")
Toggle.Name = "Toggle"
Toggle.Parent = ScreenGui
Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Toggle.BackgroundTransparency = 0.5
Toggle.Position = UDim2.new(0, 0, 0.454706937, 0)
Toggle.Size = UDim2.new(0, 50, 0, 50)
Toggle.Image = "rbxassetid://86898373680592"
Toggle.Draggable = true

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0.1, 0)
Corner.Parent = Toggle

local isOn = false
local selectedPlayerName = nil

local function onButtonClicked()
    if gethui():FindFirstChild("Orion") then
        gethui().Orion.Enabled = not gethui().Orion.Enabled
    end
end

local function offButtonClicked()
    if gethui():FindFirstChild("Orion") then
        gethui().Orion.Enabled = not gethui().Orion.Enabled
    end
end

Toggle.MouseButton1Click:Connect(function()
    isOn = not isOn
    if isOn then
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        onButtonClicked()
    else
        Toggle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        offButtonClicked()
    end
end)


local Tab = Window:MakeTab({
	Name = "Bem vindo",
	Icon = "rbxassetid://10734898355",
	PremiumOnly = false
})


Tab:AddParagraph("Olá Soldados","")


Tab:AddButton({
	Name = "Infinity Yield(Obrigatório)",
	Callback = function()
      	loadstring(game:HttpGet("https://rawscripts.net/raw/Infinite-Yield_500"))()
	print("button pressed")
  	end    
})

