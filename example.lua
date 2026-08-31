-- =====================================================================
-- DivineUI v1.1 | Exemplo completo
-- Demo de Toggle, Slider, Button, Input, Dropdown, Keybind, ColorPicker e Config
-- =====================================================================

local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua"))()
-- DEV local: local DivineUI = loadstring(readfile("DivineUI.lua"))()

local Window = DivineUI:CreateWindow({
    Title = "Divine Hub",
    Subtitle = "iOS 18 EDITION • v1.1",
    Size = UDim2.new(0, 560, 0, 460),
    ConfigName = "divine_main",
    AutoSave = false,
})

Window:Notify({Title = "DivineUI v1.1", Desc = "UI carregada!", Duration = 3})

-- ABA 1: Principal (template original)
local MainTab = Window:Tab({Title = "Principal"})
MainTab:Section({Title = "Funções principais"})

MainTab:Toggle({
    Title = "Teleguiado",
    Desc = "Descrição da função 1",
    Default = false,
    Flag = "Teleguiado",
    Callback = function(v)
        print("Teleguiado:", v)
        Window:Notify({Title="Teleguiado", Desc=v and "Ativado" or "Desativado"})
    end
})
MainTab:Divider()

MainTab:Toggle({
    Title = "Speed Bypass",
    Desc = "Descrição da função 2",
    Default = false,
    Flag = "SpeedBypass",
    Callback = function(v) print("Speed Bypass:", v) end
})
MainTab:Divider()

MainTab:Slider({
    Title = "Ajustar Velocidade",
    Min = 16, Max = 600, Default = 600, Suffix = " WS",
    Flag = "WalkSpeed",
    Callback = function(v)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

MainTab:Divider()
MainTab:Section({Title = "Atalhos & Visual v1.1"})

MainTab:Keybind({
    Title = "Tecla teleguiado",
    Desc = "Pressione para ativar",
    Default = Enum.KeyCode.Q,
    Flag = "TeleguiadoKey",
    Callback = function(k) print("Keybind pressionado:", k) end
})

MainTab:ColorPicker({
    Title = "Cor do destaque",
    Desc = "Afeta tema (demo)",
    Default = Color3.fromRGB(175,82,222),
    Flag = "AccentColor",
    Callback = function(c) print("Cor:", c) end
})

-- ABA 2: Demo completo
local DemoTab = Window:Tab({Title = "Demo"})
DemoTab:Section({Title = "Ações"})
DemoTab:Button({
    Title = "Notificar",
    Callback = function() Window:Notify({Title="Botão", Desc="Clicado!"}) end
})
DemoTab:Divider()
DemoTab:Section({Title = "Inputs"})
DemoTab:Input({
    Title = "Nome", Placeholder="Digite...", Default="",
    Flag="PlayerName",
    Callback=function(t) print("Input:", t) end
})
DemoTab:Dropdown({
    Title="Modo", Options={"Legit","Rage","Silent"}, Default="Legit",
    Flag="Modo",
    Callback=function(v) print("Modo:", v) end
})
DemoTab:Divider()
DemoTab:Section({Title="Keybind & Color"})
DemoTab:Keybind({
    Title="Abrir/Fechar UI", Desc="Toggle UI", Default=Enum.KeyCode.RightShift,
    Flag="ToggleUIKey",
    Callback=function() Window:Toggle(not Window.Gui.Enabled) end
})
DemoTab:ColorPicker({
    Title="Cor do ESP", Default=Color3.fromRGB(52,211,153),
    Flag="ESPColor",
    Callback=function(c) print("ESP Color:", c) end
})
DemoTab:Divider()
DemoTab:Section({Title="Info"})
DemoTab:Label({Text="DivineUI v1.1.0", Desc="iOS 18 Dark Glass • Keybind + ColorPicker + Config Save"})
DemoTab:Paragraph({Text="Dica", Desc="Use Flag em cada elemento e Window:SaveConfig() para salvar."})

-- ABA 3: Config
local ConfigTab = Window:Tab({Title = "Config"})
ConfigTab:Section({Title="Gerenciamento"})
ConfigTab:Button({
    Title="Salvar Config",
    Callback=function() Window:SaveConfig("divine_main") end
})
ConfigTab:Button({
    Title="Carregar Config",
    Callback=function() Window:LoadConfig("divine_main") end
})
ConfigTab:Divider()
ConfigTab:Section({Title="Janela"})
ConfigTab:Button({Title="Fechar UI", Callback=function() Window:Destroy() end})
ConfigTab:Label({Text="Tema", Desc="iOS 18 Dark Glass • Purple #AF52DE"})
ConfigTab:Slider({
    Title="Transparência demo", Min=0, Max=100, Default=12, Suffix="%",
    Callback=function(v) print("Transp:", v) end
})
ConfigTab:ColorPicker({
    Title="Preview Accent", Default=Color3.fromRGB(175,82,222),
    Callback=function(c) print("Preview:", c) end
})
ConfigTab:Keybind({
    Title="Atalho menu", Default=Enum.KeyCode.M,
    Callback=function() print("M pressionado") end
})

print("[DivineUI] Example v1.1 carregado. Flags:", Window.Flags)
