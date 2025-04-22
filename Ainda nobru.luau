-- Carregar a biblioteca Orion
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

-- Configurações do Hub
local Window = OrionLib:MakeWindow({
    Name = "MATRIX HUB🎩|BY NOT LEGITTY,MINI PUMPKIN",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "LeitonhoHubConfig",
    IntroText = "Bem-vindo ao MATRIX HUB🎩",
    IntroEnabled = true,
    Theme = {
        MainColor = Color3.fromRGB(255, 0, 0) -- Cinza
    }
})
local Tab = Window:MakeTab({
	Name = "pegar sofa",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

Tab:AddButton({
	Name = "sofa",
	Callback = function()
	local args = {
    [1] = "PickingTools",
    [2] = "Couch"
}
 
game:GetService("ReplicatedStorage").RE:FindFirstChild("1Too1l"):InvokeServer(unpack(args))
      		print("button pressed")
  	end    
})

local Tab = Window:MakeTab({
    Name = "Casas",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

local a = 0

Tab:AddTextbox({
    Name = "Numero",
    Default = "11",
    TextDisappear = true,
    Callback = function(Value)
        a = tonumber(Value) or 0  -- Converte o valor para nÃƒÂºmero ou define como 0 se nÃƒÂ£o for um nÃƒÂºmero vÃƒÂ¡lido
    end      
})

Tab:AddButton({
    Name = "pegar permissao",
    Callback = function()
        local args = {
            "GivePermissionLoopToServer",
            game.Players.LocalPlayer,
            a
        }

        game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))
    end    
})

local Tab = Window:MakeTab({
	Name = "Scripts universais",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

--[[
Name = <string> - The name of the tab.
Icon = <string> - The icon of the tab.
PremiumOnly = <bool> - Makes the tab accessible to Sirus Premium users only.
]]

Tab:AddButton({
	Name = "infinite yield",
	Callback = function()
	loadstring(game:HttpGet('https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source'))()
      		print("button pressed")
  	end    
})

--[[
Name = <string> - The name of the button.
Callback = <function> - The function of the button.
]]


Tab:AddButton({
	Name = "Nameles Loopfling",
	Callback = function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/FilteringEnabled/NamelessAdmin/main/Source"))()
      		print("button pressed")
  	end  
  
})Tab:AddButton({
	Name = "fly v3",
	Callback = function()
	loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Fly-v3-7412"))()
      		print("button pressed")
  	end 
  })

-- Iniciar a interface
OrionLib:Init()

-- VariÃƒÂ¡veis de controle
local teleporting = false
local flingEnabled = false
local viewEnabled = false
local selectedPlayer = nil
local flingSpeed = 9000  -- Aumentando a velocidade para um Fling mais forte

-- FunÃƒÂ§ÃƒÂ£o para teleporte contÃƒÂ­nuo
local function startTeleport()
    teleporting = true
    while teleporting do
        task.wait(0.05)

        local targetCharacter = selectedPlayer.Character
        if not targetCharacter then
            teleporting = false
            OrionLib:MakeNotification({
                Name = "Erro",
                Content = "Jogador invÃƒÂ¡lido ou nÃƒÂ£o carregado!",
                Time = 3
            })
            return
        end

        local targetHRP = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetHRP then
            teleporting = false
            OrionLib:MakeNotification({
                Name = "Erro",
                Content = "HumanoidRootPart nÃƒÂ£o encontrado!",
                Time = 3
            })
            return
        end

        -- Teleporte contÃƒÂ­nuo
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = targetHRP.CFrame

        -- Aplica Fling mais forte se estiver ativado
        if flingEnabled then
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(
                math.random(-flingSpeed, flingSpeed), 
                flingSpeed * 2,  -- Dando um impulso mais forte no eixo Y
                math.random(-flingSpeed, flingSpeed)
            )
            game.Players.LocalPlayer.Character.HumanoidRootPart.RotVelocity = Vector3.new(flingSpeed * 1.5, flingSpeed * 1.5, flingSpeed * 1.5)  -- Maior rotaÃƒÂ§ÃƒÂ£o
        end
    end
end

-- FunÃƒÂ§ÃƒÂ£o para parar o teleporte
local function stopTeleport()
    teleporting = false
end

-- FunÃƒÂ§ÃƒÂ£o para atualizar a lista de jogadores
local function updatePlayerList()
    local playerNames = {}
    for _, player in ipairs(game.Players:GetPlayers()) do
        if player ~= game.Players.LocalPlayer then
            table.insert(playerNames, player.Name)
        end
    end
    return playerNames
end

-- FunÃƒÂ§ÃƒÂ£o para ativar/desativar o View
local function enableView(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then return end

    local camera = workspace.CurrentCamera
    camera.CameraSubject = targetPlayer.Character:FindFirstChild("Humanoid") or targetPlayer.Character
    camera.CameraType = Enum.CameraType.Custom
end

local function disableView()
    local camera = workspace.CurrentCamera
    camera.CameraSubject = game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")
    camera.CameraType = Enum.CameraType.Custom
end

-- Reconectar View apÃƒÂ³s morte
game.Players.LocalPlayer.CharacterAdded:Connect(function()
    if viewEnabled and selectedPlayer then
        enableView(selectedPlayer)
    end
end)

-- Criar a aba "Fling"
local FlingTab = Window:MakeTab({
    Name = "Flingar ",
    Icon = "rbxassetid://109334249980199",
    PremiumOnly = false
})

-- Dropdown de SeleÃƒÂ§ÃƒÂ£o de Jogador
local dropdown = FlingTab:AddDropdown({
    Name = "Selecionar Jogador",
    Default = "",
    Options = updatePlayerList(),
    Callback = function(value)
        selectedPlayer = game.Players:FindFirstChild(value)
    end
})

-- Atualizar lista de jogadores
FlingTab:AddButton({
    Name = "Atualizar Lista de Jogadores",
    Callback = function()
        dropdown:Refresh(updatePlayerList(), true)
        OrionLib:MakeNotification({
            Name = "Lista Atualizada",
            Content = "Jogadores atualizados com sucesso!",
            Time = 3
        })
    end
})

-- Alternador para Iniciar/Parar o Fling
FlingTab:AddToggle({
    Name = "Iniciar Fling",
    Default = false,
    Callback = function(value)
        flingEnabled = value
        if flingEnabled then
            startTeleport()
        else
            stopTeleport()
        end
    end
})

-- Alternador para Ativar/Desativar o View
FlingTab:AddToggle({
    Name = "View Jogador",
    Default = false,
    Callback = function(value)
        viewEnabled = value
        if viewEnabled then
            enableView(selectedPlayer)
        else
            disableView()
        end
    end
})
