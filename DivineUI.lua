-- =====================================================================
-- DivineUI | iOS 18 Dark Glass - Biblioteca Completa v1.1
-- Autor: Divine Hub
-- Base: Template iOS 18 Dark Glass -> Evoluido para lib WindUI-like
-- Uso: local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua"))()
-- =====================================================================

local DivineUI = {}
DivineUI.__index = DivineUI
DivineUI.Version = "1.1.0"
DivineUI.ConfigFolder = "DivineUI_Configs"

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LP = Players.LocalPlayer

local Theme = {
    Bg = Color3.fromRGB(24, 20, 32),
    BgTrans = 0.12,
    Card = Color3.fromRGB(36, 30, 48),
    CardTrans = 0.38,
    CardStroke = Color3.fromRGB(75, 60, 95),
    Accent = Color3.fromRGB(175, 82, 222),
    Accent2 = Color3.fromRGB(147, 51, 234),
    AccentLight = Color3.fromRGB(216, 180, 254),
    Text = Color3.fromRGB(255, 255, 255),
    SubText = Color3.fromRGB(180, 175, 195),
    Muted = Color3.fromRGB(120, 115, 135),
    SwitchOff = Color3.fromRGB(58, 52, 70),
    Separator = Color3.fromRGB(60, 50, 80),
    Success = Color3.fromRGB(52, 211, 153),
    Warning = Color3.fromRGB(251, 191, 36),
    Error = Color3.fromRGB(248, 113, 113),
}

local function getGuiParent()
    if gethui then return gethui() end
    local ok, core = pcall(function() return game:GetService("CoreGui") end)
    if ok and core then return core end
    return LP:WaitForChild("PlayerGui")
end

local function corner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = radius
    c.Parent = parent
    return c
end

local function stroke(parent, color, thickness, trans)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = trans or 0
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function padding(parent, l, t, r, b)
    local p = Instance.new("UIPadding")
    p.PaddingLeft = UDim.new(0, l or 0)
    p.PaddingTop = UDim.new(0, t or 0)
    p.PaddingRight = UDim.new(0, r or 0)
    p.PaddingBottom = UDim.new(0, b or 0)
    p.Parent = parent
    return p
end

local function tween(obj, info, props)
    pcall(function()
        TweenService:Create(obj, info, props):Play()
    end)
end

local function toHex(c)
    return string.format("#%02X%02X%02X", math.floor(c.R*255), math.floor(c.G*255), math.floor(c.B*255))
end

local function fromHex(hex)
    hex = hex:gsub("#","")
    if #hex ~= 6 then return nil end
    local r = tonumber(hex:sub(1,2),16)
    local g = tonumber(hex:sub(3,4),16)
    local b = tonumber(hex:sub(5,6),16)
    if r and g and b then return Color3.fromRGB(r,g,b) end
    return nil
end

local function keyToString(key)
    if typeof(key) == "EnumItem" then return key.Name end
    return tostring(key)
end

local function ensureFolder(folder)
    if makefolder and not pcall(function() return isfolder(folder) end) then
        pcall(makefolder, folder)
    elseif makefolder then
        local ok, exists = pcall(isfolder, folder)
        if ok and not exists then pcall(makefolder, folder) end
    end
end

-- =====================================================================
-- WINDOW
-- =====================================================================
function DivineUI:CreateWindow(opts)
    opts = opts or {}
    local title = opts.Title or "Divine Hub"
    local subtitle = opts.Subtitle or "iOS 18 EDITION"
    local size = opts.Size or UDim2.new(0, 540, 0, 420)
    local pos = opts.Position or UDim2.new(0.5, -270, 0.5, -210)

    local parent = getGuiParent()
    if parent:FindFirstChild("DivineHub_UI") then
        parent.DivineHub_UI:Destroy()
    end

    local Gui = Instance.new("ScreenGui")
    Gui.Name = "DivineHub_UI"
    Gui.ResetOnSpawn = false
    Gui.IgnoreGuiInset = true
    Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    Gui.DisplayOrder = 999
    pcall(function() Gui.Parent = parent end)
    if not Gui.Parent then Gui.Parent = LP:WaitForChild("PlayerGui") end

    local Main = Instance.new("Frame")
    Main.Name = "MainFrame"
    Main.Size = size
    Main.Position = pos
    Main.BackgroundColor3 = Theme.Bg
    Main.BackgroundTransparency = Theme.BgTrans
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Parent = Gui
    corner(Main, UDim.new(0, 22))
    stroke(Main, Theme.Accent, 1.2, 0.35)

    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Size = UDim2.new(1, 0, 0, 54)
    Header.BackgroundTransparency = 1
    Header.Parent = Main

    local TitleLbl = Instance.new("TextLabel")
    TitleLbl.Name = "Title"
    TitleLbl.Text = title
    TitleLbl.Font = Enum.Font.GothamBold
    TitleLbl.TextSize = 16
    TitleLbl.TextColor3 = Theme.Text
    TitleLbl.BackgroundTransparency = 1
    TitleLbl.Position = UDim2.new(0, 18, 0, 12)
    TitleLbl.Size = UDim2.new(0, 220, 0, 16)
    TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
    TitleLbl.Parent = Header

    local SubLbl = Instance.new("TextLabel")
    SubLbl.Name = "Subtitle"
    SubLbl.Text = string.upper(subtitle)
    SubLbl.Font = Enum.Font.GothamMedium
    SubLbl.TextSize = 9
    SubLbl.TextColor3 = Theme.AccentLight
    SubLbl.BackgroundTransparency = 1
    SubLbl.Position = UDim2.new(0, 18, 0, 30)
    SubLbl.Size = UDim2.new(0, 280, 0, 12)
    SubLbl.TextXAlignment = Enum.TextXAlignment.Left
    SubLbl.Parent = Header

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "Close"
    CloseBtn.Text = "✕"
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.TextSize = 12
    CloseBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
    CloseBtn.BackgroundTransparency = 0.25
    CloseBtn.Position = UDim2.new(1, -38, 0, 14)
    CloseBtn.Size = UDim2.new(0, 26, 0, 26)
    CloseBtn.AutoButtonColor = false
    CloseBtn.Parent = Header
    corner(CloseBtn, UDim.new(1, 0))

    local MinBtn = Instance.new("TextButton")
    MinBtn.Name = "Minimize"
    MinBtn.Text = "—"
    MinBtn.Font = Enum.Font.GothamBold
    MinBtn.TextSize = 12
    MinBtn.TextColor3 = Color3.fromRGB(200, 200, 210)
    MinBtn.BackgroundColor3 = Color3.fromRGB(50, 45, 60)
    MinBtn.BackgroundTransparency = 0.25
    MinBtn.Position = UDim2.new(1, -70, 0, 14)
    MinBtn.Size = UDim2.new(0, 26, 0, 26)
    MinBtn.AutoButtonColor = false
    MinBtn.Parent = Header
    corner(MinBtn, UDim.new(1, 0))

    local TabsBar = Instance.new("Frame")
    TabsBar.Name = "TabsBar"
    TabsBar.Size = UDim2.new(1, -28, 0, 34)
    TabsBar.Position = UDim2.new(0, 14, 0, 56)
    TabsBar.BackgroundColor3 = Theme.Card
    TabsBar.BackgroundTransparency = 0.35
    TabsBar.BorderSizePixel = 0
    TabsBar.Parent = Main
    corner(TabsBar, UDim.new(0, 12))
    stroke(TabsBar, Theme.CardStroke, 1, 0.5)
    padding(TabsBar, 4, 4, 4, 4)

    local TabsLayout = Instance.new("UIListLayout")
    TabsLayout.FillDirection = Enum.FillDirection.Horizontal
    TabsLayout.Padding = UDim.new(0, 4)
    TabsLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabsLayout.Parent = TabsBar

    local ContentWrap = Instance.new("Frame")
    ContentWrap.Name = "ContentWrap"
    ContentWrap.Size = UDim2.new(1, -28, 1, -102)
    ContentWrap.Position = UDim2.new(0, 14, 0, 96)
    ContentWrap.BackgroundColor3 = Theme.Card
    ContentWrap.BackgroundTransparency = Theme.CardTrans
    ContentWrap.BorderSizePixel = 0
    ContentWrap.ClipsDescendants = true
    ContentWrap.Parent = Main
    corner(ContentWrap, UDim.new(0, 16))
    stroke(ContentWrap, Theme.CardStroke, 1, 0.5)

    local NotifRoot = Instance.new("Frame")
    NotifRoot.Name = "Notifications"
    NotifRoot.Size = UDim2.new(0, 260, 1, 0)
    NotifRoot.Position = UDim2.new(1, -272, 0, 0)
    NotifRoot.BackgroundTransparency = 1
    NotifRoot.Parent = Gui
    local NotifLayout = Instance.new("UIListLayout")
    NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifLayout.Padding = UDim.new(0, 8)
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifLayout.Parent = NotifRoot
    padding(NotifRoot, 0, 0, 12, 12)

    local Window = {}
    Window.Gui = Gui
    Window.Main = Main
    Window.Header = Header
    Window.TabsBar = TabsBar
    Window.ContentWrap = ContentWrap
    Window.Tabs = {}
    Window.CurrentTab = nil
    Window.Minimized = false
    Window._notifRoot = NotifRoot
    Window.Flags = {}
    Window.FlagHandles = {}
    Window.ConfigFolder = DivineUI.ConfigFolder
    Window.AutoSave = opts.AutoSave or false
    Window.ConfigName = opts.ConfigName or "default"

    -- Drag
    do
        local dragging, dragInput, dragStart, startPos
        Header.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = Main.Position
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then dragging = false end
                end)
            end
        end)
        Header.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                local delta = input.Position - dragStart
                Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
    end

    local fullSize = size
    local miniSize = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, 54)
    MinBtn.MouseButton1Click:Connect(function()
        Window.Minimized = not Window.Minimized
        if Window.Minimized then
            tween(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = miniSize})
            MinBtn.Text = "+"
        else
            tween(Main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = fullSize})
            MinBtn.Text = "—"
        end
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        tween(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1})
        task.wait(0.18)
        Gui:Destroy()
    end)

    for _, btn in ipairs({CloseBtn, MinBtn}) do
        btn.MouseEnter:Connect(function() tween(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.05}) end)
        btn.MouseLeave:Connect(function() tween(btn, TweenInfo.new(0.15), {BackgroundTransparency = 0.25}) end)
    end

    function Window:Notify(opts2)
        opts2 = opts2 or {}
        local t = opts2.Title or "DivineUI"
        local d = opts2.Desc or opts2.Description or ""
        local dur = opts2.Duration or 3
        local card = Instance.new("Frame")
        card.Size = UDim2.new(1, 0, 0, 62)
        card.BackgroundColor3 = Theme.Bg
        card.BackgroundTransparency = 0.08
        card.BorderSizePixel = 0
        card.Parent = NotifRoot
        corner(card, UDim.new(0, 12))
        stroke(card, Theme.Accent, 1, 0.4)
        card.BackgroundTransparency = 1
        local tl = Instance.new("TextLabel")
        tl.Text = t
        tl.Font = Enum.Font.GothamBold
        tl.TextSize = 12
        tl.TextColor3 = Theme.Text
        tl.BackgroundTransparency = 1
        tl.Position = UDim2.new(0, 12, 0, 10)
        tl.Size = UDim2.new(1, -24, 0, 14)
        tl.TextXAlignment = Enum.TextXAlignment.Left
        tl.Parent = card
        local dl = Instance.new("TextLabel")
        dl.Text = d
        dl.Font = Enum.Font.Gotham
        dl.TextSize = 11
        dl.TextColor3 = Theme.SubText
        dl.BackgroundTransparency = 1
        dl.Position = UDim2.new(0, 12, 0, 28)
        dl.Size = UDim2.new(1, -24, 0, 24)
        dl.TextXAlignment = Enum.TextXAlignment.Left
        dl.TextYAlignment = Enum.TextYAlignment.Top
        dl.TextWrapped = true
        dl.Parent = card
        tween(card, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 0.08})
        task.delay(dur, function()
            tween(card, TweenInfo.new(0.25), {BackgroundTransparency = 1})
            task.wait(0.26)
            if card.Parent then card:Destroy() end
        end)
    end

    function Window:SetTitle(newTitle, newSub)
        TitleLbl.Text = newTitle or TitleLbl.Text
        if newSub then SubLbl.Text = string.upper(newSub) end
    end

    function Window:Destroy() Gui:Destroy() end
    function Window:Toggle(state) Gui.Enabled = state end

    -- Config helpers
    local function serializeValue(v)
        if typeof(v) == "Color3" then return {__type="Color3", hex=toHex(v)}
        elseif typeof(v) == "EnumItem" then return {__type="EnumItem", name=v.Name, enum=tostring(v.EnumType)}
        else return v end
    end

    local function deserializeValue(v)
        if type(v) == "table" and v.__type == "Color3" then return fromHex(v.hex) or Color3.fromRGB(255,255,255)
        elseif type(v) == "table" and v.__type == "EnumItem" then
            local ok, enumType = pcall(function() return Enum[v.enum] end)
            if ok and enumType then
                local ok2, item = pcall(function() return enumType[v.name] end)
                if ok2 then return item end
            end
            return Enum.KeyCode.Q
        else return v end
    end

    function Window:_registerFlag(flag, handle, defaultValue, serializer)
        if not flag then return end
        Window.Flags[flag] = defaultValue
        Window.FlagHandles[flag] = {handle=handle, serializer=serializer}
        -- try autoload if file exists
        if Window.AutoSave then
            local ok, data = pcall(function()
                if not isfile then return nil end
                local path = Window.ConfigFolder.."/"..Window.ConfigName..".json"
                if not isfile(path) then return nil end
                return HttpService:JSONDecode(readfile(path))
            end)
            if ok and data and data[flag] ~= nil then
                local v = deserializeValue(data[flag])
                if handle and handle.Set then pcall(function() handle:Set(v) end) end
                Window.Flags[flag] = v
            end
        end
    end

    function Window:SaveConfig(name)
        name = name or Window.ConfigName
        local out = {}
        for flag, val in pairs(Window.Flags) do
            out[flag] = serializeValue(val)
        end
        -- also collect from handles live values
        for flag, info in pairs(Window.FlagHandles) do
            if info.handle and info.handle.Get then
                local ok, v = pcall(function() return info.handle:Get() end)
                if ok then out[flag] = serializeValue(v) end
            end
        end
        local json = HttpService:JSONEncode(out)
        if writefile then
            ensureFolder(Window.ConfigFolder)
            local path = Window.ConfigFolder.."/"..name..".json"
            pcall(writefile, path, json)
            self:Notify({Title="Config", Desc="Salvo: "..name..".json"})
            return true
        else
            warn("[DivineUI] writefile não disponível")
            return false, json
        end
    end

    function Window:LoadConfig(name)
        name = name or Window.ConfigName
        if not readfile or not isfile then warn("[DivineUI] readfile não disponível"); return false end
        local path = Window.ConfigFolder.."/"..name..".json"
        if not isfile(path) then self:Notify({Title="Config", Desc="Não encontrado: "..name}) return false end
        local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
        if not ok or type(data) ~= "table" then self:Notify({Title="Config", Desc="Erro ao ler "..name}) return false end
        for flag, raw in pairs(data) do
            local v = deserializeValue(raw)
            Window.Flags[flag] = v
            local info = Window.FlagHandles[flag]
            if info and info.handle and info.handle.Set then
                pcall(function() info.handle:Set(v) end)
            end
        end
        self:Notify({Title="Config", Desc="Carregado: "..name})
        return true
    end

    function Window:GetFlag(flag) return Window.Flags[flag] end

    -- TAB CREATION
    function Window:Tab(opts2)
        opts2 = opts2 or {}
        local name = opts2.Title or opts2.Name or ("Tab"..(#self.Tabs+1))
        local icon = opts2.Icon or ""

        local tabBtn = Instance.new("TextButton")
        tabBtn.Name = name
        tabBtn.Text = (icon ~= "" and icon.." " or "") .. name
        tabBtn.Font = Enum.Font.GothamMedium
        tabBtn.TextSize = 11
        tabBtn.TextColor3 = Theme.SubText
        tabBtn.BackgroundColor3 = Color3.fromRGB(58, 52, 70)
        tabBtn.BackgroundTransparency = 1
        tabBtn.Size = UDim2.new(0, 0, 1, 0)
        tabBtn.AutomaticSize = Enum.AutomaticSize.X
        tabBtn.AutoButtonColor = false
        tabBtn.Parent = TabsBar
        corner(tabBtn, UDim.new(0, 8))
        padding(tabBtn, 12, 0, 12, 0)

        local tabContent = Instance.new("ScrollingFrame")
        tabContent.Name = name.."_Content"
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.BackgroundTransparency = 1
        tabContent.BorderSizePixel = 0
        tabContent.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabContent.ScrollBarThickness = 2
        tabContent.ScrollBarImageColor3 = Theme.Accent
        tabContent.Visible = false
        tabContent.Parent = ContentWrap
        padding(tabContent, 8, 8, 8, 8)

        local list = Instance.new("UIListLayout")
        list.SortOrder = Enum.SortOrder.LayoutOrder
        list.Padding = UDim.new(0, 0)
        list.Parent = tabContent

        list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            tabContent.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 16)
        end)

        local Tab = {}
        Tab.Name = name
        Tab.Button = tabBtn
        Tab.Content = tabContent
        Tab.Layout = list
        Tab.Elements = {}

        local function select()
            for _, t in ipairs(Window.Tabs) do
                t.Content.Visible = false
                tween(t.Button, TweenInfo.new(0.2), {BackgroundTransparency = 1, BackgroundColor3 = Color3.fromRGB(58,52,70)})
                t.Button.TextColor3 = Theme.SubText
            end
            tabContent.Visible = true
            tween(tabBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.08, BackgroundColor3 = Theme.Accent})
            tabBtn.TextColor3 = Theme.Text
            Window.CurrentTab = Tab
        end

        tabBtn.MouseButton1Click:Connect(select)
        tabBtn.MouseEnter:Connect(function()
            if Window.CurrentTab ~= Tab then tween(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 0.5}) end
        end)
        tabBtn.MouseLeave:Connect(function()
            if Window.CurrentTab ~= Tab then tween(tabBtn, TweenInfo.new(0.15), {BackgroundTransparency = 1}) end
        end)

        function Tab:Divider()
            local sep = Instance.new("Frame")
            sep.Size = UDim2.new(1, -16, 0, 1)
            sep.BackgroundColor3 = Theme.Separator
            sep.BackgroundTransparency = 0.45
            sep.BorderSizePixel = 0
            sep.Parent = tabContent
            return sep
        end

        function Tab:Section(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Section"
            local lbl = Instance.new("TextLabel")
            lbl.Text = string.upper(title)
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 10
            lbl.TextColor3 = Theme.AccentLight
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(1, -16, 0, 18)
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = tabContent
            padding(lbl, 8, 0, 0, 0)
            return lbl
        end

        function Tab:Label(opts3)
            opts3 = opts3 or {}
            local text = opts3.Text or opts3.Title or ""
            local desc = opts3.Desc or ""
            local f = Instance.new("Frame")
            f.Size = UDim2.new(1, 0, 0, desc ~= "" and 44 or 28)
            f.BackgroundTransparency = 1
            f.Parent = tabContent
            local a = Instance.new("TextLabel")
            a.Text = text
            a.Font = Enum.Font.GothamMedium
            a.TextSize = 12
            a.TextColor3 = Theme.Text
            a.BackgroundTransparency = 1
            a.Position = UDim2.new(0, 8, 0, 4)
            a.Size = UDim2.new(1, -16, 0, 16)
            a.TextXAlignment = Enum.TextXAlignment.Left
            a.Parent = f
            if desc ~= "" then
                local b = Instance.new("TextLabel")
                b.Text = desc
                b.Font = Enum.Font.Gotham
                b.TextSize = 10
                b.TextColor3 = Theme.SubText
                b.BackgroundTransparency = 1
                b.Position = UDim2.new(0, 8, 0, 20)
                b.Size = UDim2.new(1, -16, 0, 18)
                b.TextXAlignment = Enum.TextXAlignment.Left
                b.TextWrapped = true
                b.Parent = f
            end
            return f
        end

        function Tab:Paragraph(opts3) return self:Label(opts3) end

        function Tab:Button(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Button"
            local cb = opts3.Callback or function() end
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 44)
            row.BackgroundTransparency = 1
            row.Parent = tabContent
            local btn = Instance.new("TextButton")
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.Size = UDim2.new(1, -16, 0, 32)
            btn.Position = UDim2.new(0, 8, 0, 6)
            btn.BackgroundColor3 = Theme.Accent
            btn.BorderSizePixel = 0
            btn.Parent = row
            corner(btn, UDim.new(0, 10))
            local lbl = Instance.new("TextLabel")
            lbl.Text = title
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 12
            lbl.TextColor3 = Theme.Text
            lbl.BackgroundTransparency = 1
            lbl.Size = UDim2.new(1, -20, 1, 0)
            lbl.Parent = btn
            btn.MouseButton1Click:Connect(function()
                tween(btn, TweenInfo.new(0.08), {BackgroundColor3 = Theme.Accent2})
                task.wait(0.08)
                tween(btn, TweenInfo.new(0.12), {BackgroundColor3 = Theme.Accent})
                local ok, err = pcall(cb)
                if not ok then warn("[DivineUI] Button error:", err) end
            end)
            btn.MouseEnter:Connect(function() tween(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Accent2}) end)
            btn.MouseLeave:Connect(function() tween(btn, TweenInfo.new(0.15), {BackgroundColor3 = Theme.Accent}) end)
            local handle = {}
            function handle:SetText(t) lbl.Text = t end
            function handle:Destroy() row:Destroy() end
            return handle
        end

        function Tab:Toggle(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Toggle"
            local desc = opts3.Desc or opts3.Description or ""
            local def = opts3.Default or opts3.Value or false
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, desc ~= "" and 58 or 48)
            row.BackgroundTransparency = 1
            row.Parent = tabContent
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 12
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 10)
            tLbl.Size = UDim2.new(0, 170, 0, 16)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row
            if desc ~= "" then
                local dLbl = Instance.new("TextLabel")
                dLbl.Text = desc
                dLbl.Font = Enum.Font.Gotham
                dLbl.TextSize = 10
                dLbl.TextColor3 = Theme.SubText
                dLbl.BackgroundTransparency = 1
                dLbl.Position = UDim2.new(0, 10, 0, 28)
                dLbl.Size = UDim2.new(0, 190, 0, 14)
                dLbl.TextXAlignment = Enum.TextXAlignment.Left
                dLbl.Parent = row
            end
            local bg = Instance.new("TextButton")
            bg.Text = ""
            bg.AutoButtonColor = false
            bg.Size = UDim2.new(0, 48, 0, 26)
            bg.Position = UDim2.new(1, -58, 0.5, -13)
            bg.BackgroundColor3 = def and Theme.Accent or Theme.SwitchOff
            bg.BorderSizePixel = 0
            bg.Parent = row
            corner(bg, UDim.new(1, 0))
            local knob = Instance.new("Frame")
            knob.Size = UDim2.new(0, 22, 0, 22)
            knob.Position = def and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
            knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            knob.BorderSizePixel = 0
            knob.Parent = bg
            corner(knob, UDim.new(1, 0))
            local state = def
            local function set(v, noCB)
                state = v
                if flag then Window.Flags[flag] = v end
                local pos = v and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 2, 0.5, -11)
                local col = v and Theme.Accent or Theme.SwitchOff
                tween(knob, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Position = pos})
                tween(bg, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = col})
                if not noCB then pcall(cb, v) end
            end
            bg.MouseButton1Click:Connect(function() set(not state) end)
            local handle = {}
            function handle:Set(v) set(v) end
            function handle:Get() return state end
            function handle:OnChanged(fn) cb = fn end
            function handle:Destroy() row:Destroy() end
            Window:_registerFlag(flag, handle, def)
            table.insert(Tab.Elements, handle)
            return handle
        end

        function Tab:Slider(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Slider"
            local min = opts3.Min or opts3.Minimum or 0
            local max = opts3.Max or opts3.Maximum or 100
            local def = opts3.Default or opts3.Value or min
            local step = opts3.Step or 1
            local suffix = opts3.Suffix or ""
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 68)
            row.BackgroundTransparency = 1
            row.Parent = tabContent
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 12
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 10)
            tLbl.Size = UDim2.new(0, 180, 0, 14)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row
            local vLbl = Instance.new("TextLabel")
            vLbl.Text = tostring(def)..suffix
            vLbl.Font = Enum.Font.GothamBold
            vLbl.TextSize = 11
            vLbl.TextColor3 = Theme.AccentLight
            vLbl.BackgroundTransparency = 1
            vLbl.Position = UDim2.new(1, -90, 0, 10)
            vLbl.Size = UDim2.new(0, 80, 0, 14)
            vLbl.TextXAlignment = Enum.TextXAlignment.Right
            vLbl.Parent = row
            local track = Instance.new("TextButton")
            track.Text = ""
            track.AutoButtonColor = false
            track.Size = UDim2.new(1, -20, 0, 6)
            track.Position = UDim2.new(0, 10, 0, 38)
            track.BackgroundColor3 = Theme.SwitchOff
            track.BorderSizePixel = 0
            track.Parent = row
            corner(track, UDim.new(1, 0))
            local fill = Instance.new("Frame")
            fill.BackgroundColor3 = Theme.Accent
            fill.BorderSizePixel = 0
            fill.Parent = track
            corner(fill, UDim.new(1, 0))
            local thumb = Instance.new("Frame")
            thumb.Size = UDim2.new(0, 14, 0, 14)
            thumb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            thumb.BorderSizePixel = 0
            thumb.Parent = track
            corner(thumb, UDim.new(1, 0))
            local dragging = false
            local value = def
            local function toScale(v) return math.clamp((v - min) / (max - min), 0, 1) end
            local function apply(v, noCB)
                v = math.clamp(v, min, max)
                if step > 0 then v = math.floor((v / step) + 0.5) * step end
                value = v
                if flag then Window.Flags[flag] = v end
                local s = toScale(v)
                fill.Size = UDim2.new(s, 0, 1, 0)
                thumb.Position = UDim2.new(s, -7, 0.5, -7)
                vLbl.Text = tostring(v)..suffix
                if not noCB then pcall(cb, v) end
            end
            apply(def, true)
            local function update(input)
                local rel = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
                local v = min + rel * (max - min)
                apply(v)
            end
            track.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    update(input)
                end
            end)
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
            end)
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
            end)
            local handle = {}
            function handle:Set(v) apply(v) end
            function handle:Get() return value end
            function handle:OnChanged(fn) cb = fn end
            function handle:Destroy() row:Destroy() end
            Window:_registerFlag(flag, handle, def)
            return handle
        end

        function Tab:Input(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Input"
            local placeholder = opts3.Placeholder or ""
            local def = opts3.Default or ""
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 62)
            row.BackgroundTransparency = 1
            row.Parent = tabContent
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 11
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 6)
            tLbl.Size = UDim2.new(1, -20, 0, 14)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row
            local boxWrap = Instance.new("Frame")
            boxWrap.Size = UDim2.new(1, -20, 0, 32)
            boxWrap.Position = UDim2.new(0, 10, 0, 24)
            boxWrap.BackgroundColor3 = Color3.fromRGB(28, 24, 38)
            boxWrap.BorderSizePixel = 0
            boxWrap.Parent = row
            corner(boxWrap, UDim.new(0, 8))
            stroke(boxWrap, Theme.CardStroke, 1, 0.4)
            local box = Instance.new("TextBox")
            box.Text = def
            box.PlaceholderText = placeholder
            box.Font = Enum.Font.Gotham
            box.TextSize = 12
            box.TextColor3 = Theme.Text
            box.PlaceholderColor3 = Theme.Muted
            box.BackgroundTransparency = 1
            box.Size = UDim2.new(1, -12, 1, 0)
            box.Position = UDim2.new(0, 6, 0, 0)
            box.TextXAlignment = Enum.TextXAlignment.Left
            box.ClearTextOnFocus = false
            box.Parent = boxWrap
            box.FocusLost:Connect(function(enter)
                if flag then Window.Flags[flag] = box.Text end
                pcall(cb, box.Text, enter)
            end)
            local handle = {}
            function handle:Set(v) box.Text = v; if flag then Window.Flags[flag]=v end end
            function handle:Get() return box.Text end
            function handle:Destroy() row:Destroy() end
            Window:_registerFlag(flag, handle, def)
            return handle
        end

        function Tab:Dropdown(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or "Dropdown"
            local options = opts3.Options or opts3.Values or {"Option 1"}
            local def = opts3.Default or options[1]
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 62)
            row.BackgroundTransparency = 1
            row.ClipsDescendants = false
            row.ZIndex = 2
            row.Parent = tabContent
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 11
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 6)
            tLbl.Size = UDim2.new(1, -20, 0, 14)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row
            local btn = Instance.new("TextButton")
            btn.Text = ""
            btn.AutoButtonColor = false
            btn.Size = UDim2.new(1, -20, 0, 32)
            btn.Position = UDim2.new(0, 10, 0, 24)
            btn.BackgroundColor3 = Color3.fromRGB(28, 24, 38)
            btn.BorderSizePixel = 0
            btn.Parent = row
            corner(btn, UDim.new(0, 8))
            stroke(btn, Theme.CardStroke, 1, 0.4)
            local lbl = Instance.new("TextLabel")
            lbl.Text = tostring(def)
            lbl.Font = Enum.Font.Gotham
            lbl.TextSize = 11
            lbl.TextColor3 = Theme.Text
            lbl.BackgroundTransparency = 1
            lbl.Position = UDim2.new(0, 10, 0, 0)
            lbl.Size = UDim2.new(1, -30, 1, 0)
            lbl.TextXAlignment = Enum.TextXAlignment.Left
            lbl.Parent = btn
            local arrow = Instance.new("TextLabel")
            arrow.Text = "▾"
            arrow.Font = Enum.Font.GothamBold
            arrow.TextSize = 12
            arrow.TextColor3 = Theme.SubText
            arrow.BackgroundTransparency = 1
            arrow.Position = UDim2.new(1, -20, 0, 0)
            arrow.Size = UDim2.new(0, 20, 1, 0)
            arrow.Parent = btn
            local listFrame = Instance.new("Frame")
            listFrame.Size = UDim2.new(1, -20, 0, 0)
            listFrame.Position = UDim2.new(0, 10, 0, 58)
            listFrame.BackgroundColor3 = Color3.fromRGB(28, 24, 38)
            listFrame.BorderSizePixel = 0
            listFrame.Visible = false
            listFrame.ClipsDescendants = true
            listFrame.ZIndex = 5
            listFrame.Parent = row
            corner(listFrame, UDim.new(0, 8))
            stroke(listFrame, Theme.CardStroke, 1, 0.3)
            local listLay = Instance.new("UIListLayout")
            listLay.SortOrder = Enum.SortOrder.LayoutOrder
            listLay.Parent = listFrame
            padding(listFrame, 4, 4, 4, 4)
            local open = false
            local selected = def
            local function toggle()
                open = not open
                listFrame.Visible = open
                if open then
                    local h = math.min(#options * 28 + 8, 140)
                    listFrame.Size = UDim2.new(1, -20, 0, h)
                    row.Size = UDim2.new(1, 0, 0, 62 + h + 4)
                    arrow.Text = "▴"
                else
                    row.Size = UDim2.new(1, 0, 0, 62)
                    arrow.Text = "▾"
                end
            end
            for _, opt in ipairs(options) do
                local oBtn = Instance.new("TextButton")
                oBtn.Text = tostring(opt)
                oBtn.Font = Enum.Font.Gotham
                oBtn.TextSize = 11
                oBtn.TextColor3 = Theme.SubText
                oBtn.BackgroundTransparency = 1
                oBtn.Size = UDim2.new(1, -8, 0, 24)
                oBtn.Parent = listFrame
                corner(oBtn, UDim.new(0, 6))
                oBtn.MouseButton1Click:Connect(function()
                    selected = opt
                    lbl.Text = tostring(opt)
                    if flag then Window.Flags[flag]=opt end
                    toggle()
                    pcall(cb, opt)
                end)
            end
            btn.MouseButton1Click:Connect(toggle)
            local handle = {}
            function handle:Set(v) selected=v; lbl.Text=tostring(v); if flag then Window.Flags[flag]=v end end
            function handle:Get() return selected end
            function handle:SetOptions(newOpts)
                options=newOpts
                for _,c in ipairs(listFrame:GetChildren()) do if c:IsA("TextButton") then c:Destroy() end end
                for _,opt in ipairs(newOpts) do
                    local oBtn=Instance.new("TextButton")
                    oBtn.Text=tostring(opt); oBtn.Font=Enum.Font.Gotham; oBtn.TextSize=11; oBtn.TextColor3=Theme.SubText; oBtn.BackgroundTransparency=1; oBtn.Size=UDim2.new(1,-8,0,24); oBtn.Parent=listFrame; corner(oBtn,UDim.new(0,6))
                    oBtn.MouseButton1Click:Connect(function() selected=opt; lbl.Text=tostring(opt); if flag then Window.Flags[flag]=opt end; toggle(); pcall(cb,opt) end)
                end
            end
            function handle:Destroy() row:Destroy() end
            Window:_registerFlag(flag, handle, def)
            return handle
        end

        -- KEYBIND
        function Tab:Keybind(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "Keybind"
            local desc = opts3.Desc or ""
            local def = opts3.Default or Enum.KeyCode.Q
            if type(def) == "string" then
                local ok, k = pcall(function() return Enum.KeyCode[def] end)
                if ok then def = k end
            end
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, desc ~= "" and 58 or 48)
            row.BackgroundTransparency = 1
            row.Parent = tabContent
            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 12
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 10)
            tLbl.Size = UDim2.new(0, 160, 0, 16)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row
            if desc ~= "" then
                local dLbl = Instance.new("TextLabel")
                dLbl.Text = desc
                dLbl.Font = Enum.Font.Gotham
                dLbl.TextSize = 10
                dLbl.TextColor3 = Theme.SubText
                dLbl.BackgroundTransparency = 1
                dLbl.Position = UDim2.new(0, 10, 0, 28)
                dLbl.Size = UDim2.new(0, 180, 0, 14)
                dLbl.TextXAlignment = Enum.TextXAlignment.Left
                dLbl.Parent = row
            end
            local btn = Instance.new("TextButton")
            btn.Text = keyToString(def)
            btn.Font = Enum.Font.GothamBold
            btn.TextSize = 11
            btn.TextColor3 = Theme.Text
            btn.BackgroundColor3 = Color3.fromRGB(28,24,38)
            btn.Size = UDim2.new(0, 90, 0, 28)
            btn.Position = UDim2.new(1, -100, 0.5, -14)
            btn.AutoButtonColor = false
            btn.Parent = row
            corner(btn, UDim.new(0, 8))
            stroke(btn, Theme.CardStroke, 1, 0.4)

            local current = def
            local listening = false
            local conn

            local function setKey(k, noCB)
                current = k
                if flag then Window.Flags[flag]=k end
                btn.Text = k and keyToString(k) or "None"
                if not noCB then pcall(cb, k) end
            end

            btn.MouseButton1Click:Connect(function()
                if listening then return end
                listening = true
                btn.Text = "..."
                local c; c = UserInputService.InputBegan:Connect(function(input, gpe)
                    if gpe then return end
                    if input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == Enum.KeyCode.Escape then
                            listening=false; btn.Text=keyToString(current); c:Disconnect(); return
                        end
                        setKey(input.KeyCode)
                        listening=false
                        c:Disconnect()
                    end
                end)
                task.delay(5, function()
                    if listening then listening=false; btn.Text=keyToString(current); if c then c:Disconnect() end end
                end)
            end)

            -- global listener for callback when key pressed
            conn = UserInputService.InputBegan:Connect(function(input, gpe)
                if gpe or listening then return end
                if input.KeyCode == current then
                    pcall(cb, current)
                end
            end)

            local handle = {}
            function handle:Set(k)
                if type(k)=="string" then local ok, v=pcall(function() return Enum.KeyCode[k] end); if ok then k=v end end
                setKey(k, true)
            end
            function handle:Get() return current end
            function handle:Destroy() row:Destroy(); if conn then conn:Disconnect() end end
            Window:_registerFlag(flag, handle, def)
            return handle
        end

        -- COLORPICKER
        function Tab:ColorPicker(opts3)
            opts3 = opts3 or {}
            local title = opts3.Title or opts3.Text or "ColorPicker"
            local desc = opts3.Desc or ""
            local def = opts3.Default or Color3.fromRGB(175,82,222)
            local cb = opts3.Callback or function() end
            local flag = opts3.Flag
            local presets = opts3.Presets or {
                Color3.fromRGB(175,82,222), Color3.fromRGB(96,165,250), Color3.fromRGB(52,211,153),
                Color3.fromRGB(251,191,36), Color3.fromRGB(248,113,113), Color3.fromRGB(255,255,255),
                Color3.fromRGB(36,30,48), Color3.fromRGB(20,20,30)
            }

            local row = Instance.new("Frame")
            row.Size = UDim2.new(1, 0, 0, 52)
            row.BackgroundTransparency = 1
            row.Parent = tabContent

            local tLbl = Instance.new("TextLabel")
            tLbl.Text = title
            tLbl.Font = Enum.Font.GothamBold
            tLbl.TextSize = 12
            tLbl.TextColor3 = Theme.Text
            tLbl.BackgroundTransparency = 1
            tLbl.Position = UDim2.new(0, 10, 0, 8)
            tLbl.Size = UDim2.new(0, 160, 0, 16)
            tLbl.TextXAlignment = Enum.TextXAlignment.Left
            tLbl.Parent = row

            if desc ~= "" then
                local dLbl = Instance.new("TextLabel")
                dLbl.Text = desc
                dLbl.Font = Enum.Font.Gotham
                dLbl.TextSize = 10
                dLbl.TextColor3 = Theme.SubText
                dLbl.BackgroundTransparency = 1
                dLbl.Position = UDim2.new(0, 10, 0, 26)
                dLbl.Size = UDim2.new(0, 160, 0, 14)
                dLbl.TextXAlignment = Enum.TextXAlignment.Left
                dLbl.Parent = row
            end

            local preview = Instance.new("TextButton")
            preview.Text = ""
            preview.Size = UDim2.new(0, 42, 0, 26)
            preview.Position = UDim2.new(1, -54, 0.5, -13)
            preview.BackgroundColor3 = def
            preview.AutoButtonColor = false
            preview.Parent = row
            corner(preview, UDim.new(0, 8))
            stroke(preview, Theme.CardStroke, 1, 0.3)

            local hexLabel = Instance.new("TextLabel")
            hexLabel.Text = toHex(def)
            hexLabel.Font = Enum.Font.Gotham
            hexLabel.TextSize = 10
            hexLabel.TextColor3 = Theme.SubText
            hexLabel.BackgroundTransparency = 1
            hexLabel.Position = UDim2.new(1, -108, 0.5, -7)
            hexLabel.Size = UDim2.new(0, 50, 0, 14)
            hexLabel.TextXAlignment = Enum.TextXAlignment.Right
            hexLabel.Parent = row

            local current = def
            local expanded = false
            local pickerFrame

            local function apply(c, noCB)
                current = c
                if flag then Window.Flags[flag]=c end
                preview.BackgroundColor3 = c
                hexLabel.Text = toHex(c)
                if not noCB then pcall(cb, c) end
            end

            local function togglePicker()
                expanded = not expanded
                if expanded then
                    row.Size = UDim2.new(1, 0, 0, 110)
                    pickerFrame.Visible = true
                else
                    row.Size = UDim2.new(1, 0, 0, 52)
                    pickerFrame.Visible = false
                end
            end

            pickerFrame = Instance.new("Frame")
            pickerFrame.Size = UDim2.new(1, -20, 0, 52)
            pickerFrame.Position = UDim2.new(0, 10, 0, 52)
            pickerFrame.BackgroundTransparency = 1
            pickerFrame.Visible = false
            pickerFrame.Parent = row

            local grid = Instance.new("Frame")
            grid.Size = UDim2.new(1, 0, 0, 28)
            grid.BackgroundTransparency = 1
            grid.Parent = pickerFrame
            local gl = Instance.new("UIListLayout")
            gl.FillDirection = Enum.FillDirection.Horizontal
            gl.Padding = UDim.new(0, 6)
            gl.Parent = grid

            for _, col in ipairs(presets) do
                local b = Instance.new("TextButton")
                b.Text = ""
                b.Size = UDim2.new(0, 26, 0, 26)
                b.BackgroundColor3 = col
                b.AutoButtonColor = false
                b.Parent = grid
                corner(b, UDim.new(0, 6))
                stroke(b, Theme.CardStroke, 1, 0.3)
                b.MouseButton1Click:Connect(function() apply(col) end)
            end

            local hexBoxWrap = Instance.new("Frame")
            hexBoxWrap.Size = UDim2.new(1, 0, 0, 22)
            hexBoxWrap.Position = UDim2.new(0, 0, 0, 32)
            hexBoxWrap.BackgroundColor3 = Color3.fromRGB(28,24,38)
            hexBoxWrap.Parent = pickerFrame
            corner(hexBoxWrap, UDim.new(0, 6))
            stroke(hexBoxWrap, Theme.CardStroke, 1, 0.3)

            local hexBox = Instance.new("TextBox")
            hexBox.Text = toHex(def)
            hexBox.PlaceholderText = "#AF52DE"
            hexBox.Font = Enum.Font.Gotham
            hexBox.TextSize = 11
            hexBox.TextColor3 = Theme.Text
            hexBox.PlaceholderColor3 = Theme.Muted
            hexBox.BackgroundTransparency = 1
            hexBox.Size = UDim2.new(1, -10, 1, 0)
            hexBox.Position = UDim2.new(0, 5, 0, 0)
            hexBox.ClearTextOnFocus = false
            hexBox.Parent = hexBoxWrap
            hexBox.FocusLost:Connect(function()
                local c = fromHex(hexBox.Text)
                if c then apply(c) else hexBox.Text = toHex(current) end
            end)

            preview.MouseButton1Click:Connect(togglePicker)

            local handle = {}
            function handle:Set(c) apply(c, true) end
            function handle:Get() return current end
            function handle:Destroy() row:Destroy() end
            Window:_registerFlag(flag, handle, def)
            return handle
        end

        table.insert(Window.Tabs, Tab)
        if #Window.Tabs == 1 then task.defer(select) end
        return Tab
    end

    return Window
end

return DivineUI
