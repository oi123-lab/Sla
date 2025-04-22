local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Kiwilegazin/Orion-mobile-v2/refs/heads/main/README.md')))()
local Window = OrionLib:MakeWindow({Name = "MATRIX HUB🎩|ERA DE ATAQUES🎩|BY TEAM CARTOLA CENTER🎩", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})

--[[
Name = <string> - The name of the UI.
HidePremium = <bool> - Whether or not the user details shows Premium status or not.
SaveConfig = <bool> - Toggles the config saving in the UI.
ConfigFolder = <string> - The name of the folder where the configs are saved.
IntroEnabled = <bool> - Whether or not to show the intro animation.
IntroText = <string> - Text to show in the intro animation.
IntroIcon = <string> - URL to the image you want to use in the intro animation.
Icon = <string> - URL to the image you want displayed on the window.
CloseCallback = <function> - Function to execute when the window is closed.
]]

local Tab = Window:MakeTab({
	Name = "Bem vindo",
	Icon = "rbxassetid://10734898355",
	PremiumOnly = false
})


Tab:AddParagraph("BEM-VINDO MEU NOBRE ESTAMOS NA ERA DE ATAQUES🎩,PRA VOCE QUE NÃO SABE OQ E ERA DE ATAQUES E A ERA QUE NOS MAIS ATACAMOS MANDRAKES","")


Tab:AddButton({
	Name = "Infinity Yield(Obrigatório)",
	Callback = function()
      	loadstring(game:HttpGet("https://rawscripts.net/raw/Infinite-Yield_500"))()
	print("button pressed")
  	end    
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
Name = "House",
Icon = "rbxassetid://10734898355",
PremiumOnly = false
})


local casaNumbers = {}
for i = 1, 35 do
if i ~= 8 and i ~= 9 and i ~= 10 then
table.insert(casaNumbers, tostring(i))
end
end

local selectedCasaNumber = nil

Tab:AddDropdown({
Name = "Escolha o número da casa",
Options = casaNumbers,
Callback = function(number)
selectedCasaNumber = tonumber(number)
end
})

Tab:AddButton({
Name = "Pegar Permissão",
Callback = function()
if selectedCasaNumber then
local args = {
[1] = "GivePermissionLoopToServer",
[2] = game:GetService("Players").LocalPlayer,
[3] = selectedCasaNumber
}
game:GetService("ReplicatedStorage").RE:FindFirstChild("1Playe1rTrigge1rEven1t"):FireServer(unpack(args))

else
print("Nenhum número de casa selecionado.")
end
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
