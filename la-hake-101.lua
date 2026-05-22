-- [[ LA HAKE ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- [[ MASTER CONFIG ]]
local Settings = {
    Aimbot = true,
    AimPart = "Head", -- Head or Body
    Box = true,
    Skel = true,
    Lines = true,
    Power = 0.55
}

-- [[ EXPIRY SYSTEM CONFIG ]]
local ExpiryDate = os.time({year = 2026, month = 5, day = 22, hour = 18, min = 18, sec = 0}) -- 10 Days Expiry
local isExpired = os.time() > ExpiryDate

local function FormatTime(seconds)
    if seconds <= 0 then return "EXPIRED" end
    local days = math.floor(seconds / 86400)
    local hours = math.floor((seconds % 86400) / 3600)
    local mins = math.floor((seconds % 3600) / 60)
    local secs = seconds % 60
    return string.format("%dD %02dH %02dM %02dS", days, hours, mins, secs)
end

-- [[ HAKER UI SYSTEM ]]
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "LA_HAKE"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Panel
local TargetSize = UDim2.new(0, 220, 0, 380)
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.new(0, 0, 0, 0) -- Starts at 0 for animation
Main.Position = UDim2.new(0.02, 110, 0.25, 190) -- Centered for scale animation
Main.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
Main.BorderSizePixel = 0
Main.Draggable = true
Main.Active = true
Main.ClipsDescendants = true
Main.BackgroundTransparency = 1

local mainCorner = Instance.new("UICorner", Main)
mainCorner.CornerRadius = UDim.new(0, 8)

-- Short Welcome / Startup Animation
spawn(function()
    wait(0.2)
    local expandTween = TweenService:Create(Main, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = TargetSize,
        Position = UDim2.new(0.02, 0, 0.25, 0),
        BackgroundTransparency = 0
    })
    expandTween:Play()
end)

-- Expiry Block Screen
if isExpired then
    Main.Size = UDim2.new(0, 300, 0, 150)
    Main.Position = UDim2.new(0.5, -150, 0.5, -75)
    Main.BackgroundTransparency = 0
    
    local ExpiredMsg = Instance.new("TextLabel", Main)
    ExpiredMsg.Size = UDim2.new(1, 0, 1, 0)
    ExpiredMsg.BackgroundTransparency = 1
    ExpiredMsg.Text = "THIS MODE IS EXPIRED\nPLEASE DOWNLOAD NEW MOD\nFROM OUR DISCORD"
    ExpiredMsg.TextColor3 = Color3.fromRGB(255, 50, 50)
    ExpiredMsg.Font = Enum.Font.GothamBlack
    ExpiredMsg.TextSize = 14
    ExpiredMsg.ZIndex = 10
    
    -- Stop script execution
    return
end

-- Outer Glow Border
local BorderGlow = Instance.new("UIStroke", Main)
BorderGlow.Color = Color3.fromRGB(200, 0, 0)
BorderGlow.Thickness = 1.5
BorderGlow.Transparency = 1 -- Hidden during anim

spawn(function()
    wait(0.7) -- wait for intro
    while Main and Main.Parent do
        TweenService:Create(BorderGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.6}):Play()
        wait(1.5)
        TweenService:Create(BorderGlow, TweenInfo.new(1.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {Transparency = 0.2}):Play()
        wait(1.5)
    end
end)

-- Top Accent Bar (red stripe)
local AccentBar = Instance.new("Frame", Main)
AccentBar.Size = UDim2.new(1, 0, 0, 3)
AccentBar.Position = UDim2.new(0, 0, 0, 0)
AccentBar.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
AccentBar.BorderSizePixel = 0
AccentBar.ZIndex = 5

-- Title Section
local TitleBar = Instance.new("Frame", Main)
TitleBar.Size = UDim2.new(1, 0, 0, 44)
TitleBar.Position = UDim2.new(0, 0, 0, 3)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
TitleBar.BorderSizePixel = 0

local TitleIcon = Instance.new("TextLabel", TitleBar)
TitleIcon.Size = UDim2.new(0, 30, 1, 0)
TitleIcon.Position = UDim2.new(0, 8, 0, 0)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "☠"
TitleIcon.TextColor3 = Color3.fromRGB(255, 40, 40)
TitleIcon.Font = Enum.Font.GothamBlack
TitleIcon.TextSize = 20

local Title = Instance.new("TextLabel", TitleBar)
Title.Size = UDim2.new(1, -44, 1, 0)
Title.Position = UDim2.new(0, 38, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "LA HAKE"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 16
Title.TextXAlignment = Enum.TextXAlignment.Left

-- Title glow pulse
spawn(function()
    wait(0.7)
    while Title and Title.Parent do
        TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 100, 100)}):Play()
        wait(2)
        TweenService:Create(Title, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
        wait(2)
    end
end)

-- Version Tag
local VerTag = Instance.new("TextLabel", TitleBar)
VerTag.Size = UDim2.new(0, 40, 0, 14)
VerTag.Position = UDim2.new(1, -48, 0, 6)
VerTag.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
VerTag.TextColor3 = Color3.fromRGB(0, 0, 0)
VerTag.Font = Enum.Font.GothamBlack
VerTag.TextSize = 9
VerTag.Text = "v1.0"
local verCorner = Instance.new("UICorner", VerTag)
verCorner.CornerRadius = UDim.new(0, 4)

-- Divider Line
local Div1 = Instance.new("Frame", Main)
Div1.Size = UDim2.new(0.88, 0, 0, 1)
Div1.Position = UDim2.new(0.06, 0, 0, 48)
Div1.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
Div1.BackgroundTransparency = 0.6
Div1.BorderSizePixel = 0

-- Section Label: COMBAT
local SectionCombat = Instance.new("TextLabel", Main)
SectionCombat.Size = UDim2.new(0.9, 0, 0, 16)
SectionCombat.Position = UDim2.new(0.05, 0, 0, 54)
SectionCombat.BackgroundTransparency = 1
SectionCombat.Text = "⚔ COMBAT"
SectionCombat.TextColor3 = Color3.fromRGB(150, 150, 160)
SectionCombat.Font = Enum.Font.GothamBold
SectionCombat.TextSize = 10
SectionCombat.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Button Factory
local function CreateToggle(text, yOffset, var, isPartSwitch)
    local holder = Instance.new("Frame", Main)
    holder.Size = UDim2.new(0.88, 0, 0, 32)
    holder.Position = UDim2.new(0.06, 0, 0, yOffset)
    holder.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
    holder.BorderSizePixel = 0
    local hCorner = Instance.new("UICorner", holder)
    hCorner.CornerRadius = UDim.new(0, 6)

    local btnStroke = Instance.new("UIStroke", holder)
    btnStroke.Thickness = 1
    btnStroke.Color = Color3.fromRGB(40, 40, 50)
    btnStroke.Transparency = 0.5

    local dot = Instance.new("Frame", holder)
    dot.Size = UDim2.new(0, 8, 0, 8)
    dot.Position = UDim2.new(0, 10, 0.5, -4)
    dot.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
    dot.BorderSizePixel = 0
    local dotCorner = Instance.new("UICorner", dot)
    dotCorner.CornerRadius = UDim.new(1, 0)

    local btn = Instance.new("TextButton", holder)
    btn.Size = UDim2.new(1, -26, 1, 0)
    btn.Position = UDim2.new(0, 24, 0, 0)
    btn.BackgroundTransparency = 1
    btn.TextColor3 = Color3.fromRGB(220, 220, 230)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 11
    btn.TextXAlignment = Enum.TextXAlignment.Left

    local function update()
        if isPartSwitch then
            local isHead = Settings.AimPart == "Head"
            btn.Text = "TARGET → " .. (isHead and "HEAD" or "BODY")
            dot.BackgroundColor3 = isHead and Color3.fromRGB(255, 80, 80) or Color3.fromRGB(80, 150, 255)
            btnStroke.Color = isHead and Color3.fromRGB(120, 40, 40) or Color3.fromRGB(40, 80, 120)
        else
            local on = Settings[var]
            btn.Text = text .. "  " .. (on and "[ ON ]" or "[ OFF ]")
            dot.BackgroundColor3 = on and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 60, 60)
            btnStroke.Color = on and Color3.fromRGB(0, 100, 60) or Color3.fromRGB(100, 30, 30)
        end
    end

    btn.MouseButton1Click:Connect(function()
        if isPartSwitch then
            Settings.AimPart = (Settings.AimPart == "Head") and "Body" or "Head"
        else
            Settings[var] = not Settings[var]
        end
        TweenService:Create(holder, TweenInfo.new(0.1), {BackgroundColor3 = Color3.fromRGB(40, 40, 55)}):Play()
        wait(0.1)
        TweenService:Create(holder, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        update()
    end)

    holder.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(holder, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}):Play()
        end
    end)
    holder.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            TweenService:Create(holder, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(25, 25, 35)}):Play()
        end
    end)

    update()
end

-- COMBAT toggles
CreateToggle("AIMBOT", 74, "Aimbot", false)
CreateToggle("", 110, "AimPart", true)

-- Divider
local Div2 = Instance.new("Frame", Main)
Div2.Size = UDim2.new(0.88, 0, 0, 1)
Div2.Position = UDim2.new(0.06, 0, 0, 150)
Div2.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
Div2.BackgroundTransparency = 0.6
Div2.BorderSizePixel = 0

-- Section Label: VISUALS
local SectionVisuals = Instance.new("TextLabel", Main)
SectionVisuals.Size = UDim2.new(0.9, 0, 0, 16)
SectionVisuals.Position = UDim2.new(0.05, 0, 0, 156)
SectionVisuals.BackgroundTransparency = 1
SectionVisuals.Text = "👁 VISUALS"
SectionVisuals.TextColor3 = Color3.fromRGB(150, 150, 160)
SectionVisuals.Font = Enum.Font.GothamBold
SectionVisuals.TextSize = 10
SectionVisuals.TextXAlignment = Enum.TextXAlignment.Left

-- VISUAL toggles
CreateToggle("BOX ESP", 176, "Box", false)
CreateToggle("SKELETON", 212, "Skel", false)
CreateToggle("ESP LINES", 248, "Lines", false)

-- Bottom Divider
local Div3 = Instance.new("Frame", Main)
Div3.Size = UDim2.new(0.88, 0, 0, 1)
Div3.Position = UDim2.new(0.06, 0, 0, 290)
Div3.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
Div3.BackgroundTransparency = 0.6
Div3.BorderSizePixel = 0

-- Section Label: LICENSE
local SectionLicense = Instance.new("TextLabel", Main)
SectionLicense.Size = UDim2.new(0.9, 0, 0, 16)
SectionLicense.Position = UDim2.new(0.05, 0, 0, 296)
SectionLicense.BackgroundTransparency = 1
SectionLicense.Text = "📅 LICENSE STATUS"
SectionLicense.TextColor3 = Color3.fromRGB(150, 150, 160)
SectionLicense.Font = Enum.Font.GothamBold
SectionLicense.TextSize = 10
SectionLicense.TextXAlignment = Enum.TextXAlignment.Left

-- Lifetime Label
local LifetimeLabel = Instance.new("TextLabel", Main)
LifetimeLabel.Size = UDim2.new(0.88, 0, 0, 14)
LifetimeLabel.Position = UDim2.new(0.06, 0, 0, 314)
LifetimeLabel.BackgroundTransparency = 1
LifetimeLabel.TextColor3 = Color3.fromRGB(200, 200, 210)
LifetimeLabel.Font = Enum.Font.GothamBold
LifetimeLabel.TextSize = 9
LifetimeLabel.TextXAlignment = Enum.TextXAlignment.Left
LifetimeLabel.Text = "LIFETIME: " .. os.date("%Y-%m-%d")

-- Expiry Label
local ExpiryLabel = Instance.new("TextLabel", Main)
ExpiryLabel.Size = UDim2.new(0.88, 0, 0, 14)
ExpiryLabel.Position = UDim2.new(0.06, 0, 0, 328)
ExpiryLabel.BackgroundTransparency = 1
ExpiryLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
ExpiryLabel.Font = Enum.Font.GothamBold
ExpiryLabel.TextSize = 9
ExpiryLabel.TextXAlignment = Enum.TextXAlignment.Left
ExpiryLabel.Text = "EXPIRES IN: " .. FormatTime(ExpiryDate - os.time())

spawn(function()
    while Main and Main.Parent do
        local now = os.time()
        LifetimeLabel.Text = "LIFETIME: " .. os.date("%Y-%m-%d %X")
        ExpiryLabel.Text = "EXPIRES IN: " .. FormatTime(ExpiryDate - now)
        if now > ExpiryDate then
            ExpiryLabel.Text = "EXPIRES IN: EXPIRED"
            ExpiryLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
        wait(1)
    end
end)

-- Status Footer
local Footer = Instance.new("TextLabel", Main)
Footer.Size = UDim2.new(1, 0, 0, 24)
Footer.Position = UDim2.new(0, 0, 1, -20)
Footer.BackgroundColor3 = Color3.fromRGB(12, 12, 18)
Footer.BorderSizePixel = 0
Footer.TextColor3 = Color3.fromRGB(100, 100, 110)
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 9

spawn(function()
    while Footer and Footer.Parent do
        local ping = math.random(12, 65)
        local aimStatus = Settings.Aimbot and "AIM ✓" or "AIM ✗"
        local espStatus = (Settings.Box or Settings.Skel or Settings.Lines) and "ESP ✓" or "ESP ✗"
        Footer.Text = aimStatus .. "  |  " .. espStatus .. "  |  " .. ping .. "ms"
        wait(2)
    end
end)

-- Bottom Accent Bar
local BottomBar = Instance.new("Frame", Main)
BottomBar.Size = UDim2.new(1, 0, 0, 3)
BottomBar.Position = UDim2.new(0, 0, 1, -3)
BottomBar.BackgroundColor3 = Color3.fromRGB(255, 30, 30)
BottomBar.BorderSizePixel = 0
BottomBar.ZIndex = 5

-- [[ DRAWING ENGINE ]]
local Visuals = {}
local function NewDrawing(type, props)
    local obj = Drawing.new(type)
    for i, v in pairs(props) do obj[i] = v end
    return obj
end

local function CreateESP(p)
    if p == LocalPlayer then return end
    Visuals[p] = {
        Box = NewDrawing("Square", {Color = Color3.new(1, 0, 0), Thickness = 1}),
        Line = NewDrawing("Line", {Color = Color3.fromRGB(0, 255, 200), Thickness = 1}),
        Skel = NewDrawing("Line", {Color = Color3.new(1, 1, 1), Thickness = 1})
    }
end

local function RemoveESP(p)
    if Visuals[p] then
        for _, obj in pairs(Visuals[p]) do
            pcall(function() obj:Remove() end)
        end
        Visuals[p] = nil
    end
end

for _, p in pairs(Players:GetPlayers()) do if p ~= LocalPlayer then CreateESP(p) end end
Players.PlayerAdded:Connect(CreateESP)
Players.PlayerRemoving:Connect(RemoveESP)

-- [[ DYNAMIC TARGETING FUNCTION ]]
local function GetBodyPart(char)
    if Settings.AimPart == "Head" then
        return char:FindFirstChild("Head")
    else
        return char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso") or char:FindFirstChild("HumanoidRootPart")
    end
end

-- [[ MAIN LOOP ]]
RunService.RenderStepped:Connect(function()
    local mouse = UserInputService:GetMouseLocation()
    local isAiming = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
    local targetPart = nil
    local minDist = math.huge

    for p, v in pairs(Visuals) do
        local char = p.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 then
            local part = GetBodyPart(char)
            if part then
                local rootPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                local headPart = char:FindFirstChild("Head")
                local headPos = headPart and Camera:WorldToViewportPoint(headPart.Position) or rootPos

                if onScreen then
                    if Settings.Box then
                        local h = math.abs(headPos.Y - Camera:WorldToViewportPoint(part.Position - Vector3.new(0, 3, 0)).Y)
                        v.Box.Size = Vector2.new(h * 0.6, h)
                        v.Box.Position = Vector2.new(rootPos.X - (h * 0.6 / 2), rootPos.Y - (h / 2))
                        v.Box.Visible = true
                    else
                        v.Box.Visible = false
                    end

                    if Settings.Lines then
                        v.Line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        v.Line.To = Vector2.new(rootPos.X, rootPos.Y)
                        v.Line.Visible = true
                    else
                        v.Line.Visible = false
                    end

                    if Settings.Skel then
                        v.Skel.From = Vector2.new(headPos.X, headPos.Y)
                        v.Skel.To = Vector2.new(rootPos.X, rootPos.Y)
                        v.Skel.Visible = true
                    else
                        v.Skel.Visible = false
                    end

                    if Settings.Aimbot then
                        local dist = (Vector2.new(rootPos.X, rootPos.Y) - mouse).Magnitude
                        if dist < minDist then
                            targetPart = part
                            minDist = dist
                        end
                    end
                else
                    v.Box.Visible = false
                    v.Line.Visible = false
                    v.Skel.Visible = false
                end
            end
        else
            v.Box.Visible = false
            v.Line.Visible = false
            v.Skel.Visible = false
        end
    end

    if Settings.Aimbot and isAiming and targetPart then
        Camera.CFrame = Camera.CFrame:Lerp(CFrame.new(Camera.CFrame.Position, targetPart.Position), Settings.Power)
    end
end)
