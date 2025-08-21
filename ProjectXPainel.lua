--[[
ProjectX Painel - By Liphyr
- Painel de senha no início (dono: 3040igor)
- Agora busca keys do arquivo online!
]]

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local placeId = 109983668079237 -- Seu PlaceId
local webhook = "https://discord.com/api/webhooks/1407948499747864718/Km1wkh23xYYFMheEtH4yi5PC5R9eOgKwZLeCIeohUCGd_nSi1UMV_OlILErk3kJSJdzV"

local painelNome = "BrainrotPanel"
local searching = false

-- Senha principal (dono)
local DONO_SENHA = "3040igor"

-- URL do arquivo de keys
local keysURL = "https://raw.githubusercontent.com/igorphelipefreitas-bit/Meu-hub-Roblox/main/keys.txt"

-- Função para buscar keys online e verificar senha
local function senhaValida(senha)
    if senha == DONO_SENHA then return true end
    local ok, todasKeys = pcall(function()
        return game:HttpGet(keysURL)
    end)
    if ok and todasKeys then
        for key in string.gmatch(todasKeys, "[^\r\n]+") do
            if senha == key then
                return true
            end
        end
    end
    return false
end

-- Função para notificação no canto inferior direito
local function notify(text, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "PROJECTX";
        Text = text;
        Duration = duration or 3;
    })
end

-- Painel de Senha
local function criarPainelSenha(callback)
    if playerGui:FindFirstChild("ProjectXPanel") then
        playerGui.ProjectXPanel:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ProjectXPanel"
    ScreenGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 340, 0, 220)
    frame.Position = UDim2.new(0.5, -170, 0.5, -110)
    frame.BackgroundColor3 = Color3.fromRGB(35, 40, 70)
    frame.BorderSizePixel = 0
    frame.Parent = ScreenGui

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 40)
    title.Position = UDim2.new(0, 0, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = "Script ProjectX By Liphyr"
    title.TextColor3 = Color3.fromRGB(255,255,255)
    title.Font = Enum.Font.GothamBold
    title.TextScaled = true
    title.Parent = frame

    local senhaLabel = Instance.new("TextLabel")
    senhaLabel.Size = UDim2.new(1, -40, 0, 24)
    senhaLabel.Position = UDim2.new(0, 20, 0, 60)
    senhaLabel.BackgroundTransparency = 1
    senhaLabel.Text = "Digite sua key:"
    senhaLabel.TextColor3 = Color3.fromRGB(200,200,200)
    senhaLabel.Font = Enum.Font.Gotham
    senhaLabel.TextScaled = true
    senhaLabel.TextXAlignment = Enum.TextXAlignment.Left
    senhaLabel.Parent = frame

    local input = Instance.new("TextBox")
    input.Size = UDim2.new(1, -40, 0, 32)
    input.Position = UDim2.new(0, 20, 0, 90)
    input.BackgroundColor3 = Color3.fromRGB(50, 55, 100)
    input.BorderSizePixel = 0
    input.Text = ""
    input.PlaceholderText = "Insira a senha"
    input.TextColor3 = Color3.fromRGB(255,255,255)
    input.Font = Enum.Font.Gotham
    input.TextScaled = true
    input.Parent = frame

    local result = Instance.new("TextLabel")
    result.Size = UDim2.new(1, -40, 0, 20)
    result.Position = UDim2.new(0, 20, 0, 130)
    result.BackgroundTransparency = 1
    result.Text = ""
    result.TextColor3 = Color3.fromRGB(255,100,100)
    result.Font = Enum.Font.GothamBold
    result.TextScaled = true
    result.Parent = frame

    local submit = Instance.new("TextButton")
    submit.Size = UDim2.new(1, -40, 0, 36)
    submit.Position = UDim2.new(0, 20, 0, 160)
    submit.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
    submit.TextColor3 = Color3.new(1,1,1)
    submit.Text = "Entrar"
    submit.Font = Enum.Font.GothamBold
    submit.TextScaled = true
    submit.Parent = frame

    local getKeyBtn = Instance.new("TextButton")
    getKeyBtn.Size = UDim2.new(1, -40, 0, 24)
    getKeyBtn.Position = UDim2.new(0, 20, 1, -32)
    getKeyBtn.BackgroundColor3 = Color3.fromRGB(75, 75, 255)
    getKeyBtn.TextColor3 = Color3.new(1,1,1)
    getKeyBtn.Text = "Get Key - Discord"
    getKeyBtn.Font = Enum.Font.GothamSemibold
    getKeyBtn.TextScaled = true
    getKeyBtn.Parent = frame

    getKeyBtn.MouseButton1Click:Connect(function()
        setclipboard("https://discord.gg/3Dh2greW")
        getKeyBtn.Text = "Link copiado!"
        wait(2)
        getKeyBtn.Text = "Get Key - Discord"
    end)

    submit.MouseButton1Click:Connect(function()
        local senha = input.Text
        if senhaValida(senha) then
            result.Text = "Acesso Liberado!"
            result.TextColor3 = Color3.fromRGB(100,255,100)
            wait(1)
            ScreenGui:Destroy()
            callback()
        else
            result.Text = "Key inválida!"
            result.TextColor3 = Color3.fromRGB(255,100,100)
        end
    end)

    ScreenGui.Parent = playerGui
end

-- Painel principal (Brainrot "P" + busca/discord)
local function criarPainel()
    if playerGui:FindFirstChild(painelNome) then
        playerGui[painelNome]:Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = painelNome
    ScreenGui.ResetOnSpawn = false

    local mainFrame = Instance.new("Frame")
    mainFrame.Size = UDim2.new(0, 120, 0, 120)
    mainFrame.Position = UDim2.new(0.5, -60, 0.2, 0)
    mainFrame.BackgroundTransparency = 1
    mainFrame.Parent = ScreenGui

    local bola = Instance.new("ImageButton")
    bola.Size = UDim2.new(0, 64, 0, 64)
    bola.Position = UDim2.new(0.5, -32, 0, 0)
    bola.BackgroundTransparency = 1
    bola.Image = "rbxassetid://3570695787"
    bola.ImageColor3 = Color3.fromRGB(75, 75, 255)
    bola.Parent = mainFrame

    local pLabel = Instance.new("TextLabel")
    pLabel.Size = UDim2.new(1, 0, 1, 0)
    pLabel.Position = UDim2.new(0, 0, 0, 0)
    pLabel.BackgroundTransparency = 1
    pLabel.Text = "P"
    pLabel.TextColor3 = Color3.new(1, 1, 1)
    pLabel.Font = Enum.Font.GothamBold
    pLabel.TextScaled = true
    pLabel.Parent = bola

    spawn(function()
        while ScreenGui.Parent do
            bola.Position = UDim2.new(0.5, -32, 0, math.sin(tick()*2)*8)
            wait(0.03)
        end
    end)

    bola.MouseButton1Click:Connect(function()
        if searching then return end
        searching = true
        pLabel.Text = "..."
        bola.ImageColor3 = Color3.fromRGB(255, 195, 0)
        notify("PROCURANDO BRAINROT", 6)
        spawn(function()
            local found = false
            local function getMostRareBrainrot()
                local mostRare = nil
                local highestValue = -math.huge
                for _, obj in pairs(workspace:GetChildren()) do
                    if obj:IsA("Model") and obj.Name == "Brainrot" and obj:FindFirstChild("Value") then
                        local val = obj.Value.Value
                        if val > highestValue then
                            highestValue = val
                            mostRare = obj
                        end
                    end
                end
                return mostRare, highestValue
            end

            local function sendToDiscord(serverId, brainName, brainValue)
                local link = string.format("https://www.roblox.com/games/%d?jobId=%s", placeId, serverId)
                local data = {
                    ["content"] = "",
                    ["embeds"] = {{
                        ["title"] = "PROJECTX - Brainrot encontrado!",
                        ["description"] = string.format("**Link do Servidor:** [Clique aqui para entrar](%s)\n**Brainrot mais raro:** `%s` (Valor: %s)\n**JobId:** `%s`", link, brainName, brainValue, serverId),
                        ["color"] = 5814783
                    }}
                }
                local jsonData = HttpService:JSONEncode(data)
                pcall(function()
                    HttpService:PostAsync(webhook, jsonData, Enum.HttpContentType.ApplicationJson)
                end)
            end

            local function hasBrainrot()
                local brain, value = getMostRareBrainrot()
                return brain, value
            end

            local function getServers()
                local url = "https://games.roblox.com/v1/games/"..placeId.."/servers/Public?sortOrder=Asc&limit=100"
                local response = game:HttpGet(url)
                local data = HttpService:JSONDecode(response)
                return data.data
            end

            local triedServers = {}
            while not found do
                local brain, value = hasBrainrot()
                if brain then
                    found = true
                    bola.ImageColor3 = Color3.fromRGB(40, 180, 70)
                    pLabel.Text = "✔"
                    sendToDiscord(game.JobId, brain.Name .. (brain:FindFirstChild("Value") and (" ["..tostring(brain.Value.Value).."]") or ""), value or "N/A")
                    wait(3)
                    pLabel.Text = "P"
                    bola.ImageColor3 = Color3.fromRGB(75, 75, 255)
                    searching = false
                    break
                else
                    local servers = getServers()
                    local teleported = false
                    for _, server in pairs(servers) do
                        if server.id ~= game.JobId and not triedServers[server.id] and server.playing < server.maxPlayers then
                            triedServers[server.id] = true
                            bola.ImageColor3 = Color3.fromRGB(255, 85, 85)
                            pLabel.Text = "→"
                            TeleportService:TeleportToPlaceInstance(placeId, server.id, Players.LocalPlayer)
                            teleported = true
                            break
                        end
                    end
                    if not teleported then
                        wait(5)
                    end
                end
                wait(1)
            end
        end)
    end)

    ScreenGui.Parent = playerGui
end

-- Executa: Primeiro a senha, depois o painel P
criarPainelSenha(criarPainel)
