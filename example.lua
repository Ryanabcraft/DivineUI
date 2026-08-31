-- =====================================================================
-- DivineUI | Exemplo de uso completo
-- Recria o template original + demo de todos os componentes
-- =====================================================================

local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/seu-repo/DivineUI/main/DivineUI.lua"))()
-- DEV local: local DivineUI = loadstring(readfile("DivineUI.lua"))()  ou  require
-- Se estiver testando local no executor, use:
-- local DivineUI = loadstring(readfile("D:\\SISTEMAS\\Projetos-DEV\\Projetos\\Opencode\\divineui\\DivineUI.lua"))()

-- Cria janela (mesmo visual iOS 18 Dark Glass)
local Window = DivineUI:CreateWindow({
    Title = "Divine Hub",
    Subtitle = "iOS 18 EDITION • TEMPLATE",
    Size = UDim2.new(0, 540, 0, 400),
})

Window:Notify({Title = "DivineUI", Desc = "UI carregada com sucesso!", Duration = 3})

-- =====================================================================
-- ABA 1: Recriação fiel do template original (Teleguiado + Speed)
-- =====================================================================
local MainTab = Window:Tab({Title = "Principal"})
MainTab:Section({Title = "Funções principais"})

local teleguiado = MainTab:Toggle({
    Title = "Teleguiado",
    Desc = "Descrição da função 1",
    Default = false,
    Callback = function(v)
        print("Teleguiado:", v)
        Window:Notify({Title = "Teleguiado", Desc = v and "Ativado" or "Desativado"})
        -- coloque sua lógica aqui
        -- ex: getgenv().Teleguiado = v
    end
})

MainTab:Divider()

local speedBypass = MainTab:Toggle({
    Title = "Speed Bypass",
    Desc = "Descrição da função 2",
    Default = false,
    Callback = function(v)
        print("Speed Bypass:", v)
        -- lógica bypass
    end
})

MainTab:Divider()

local speedSlider = MainTab:Slider({
    Title = "Ajustar Velocidade",
    Min = 16,
    Max = 600,
    Default = 600,
    Suffix = " WS",
    Callback = function(v)
        print("Velocidade:", v)
        local hum = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

-- =====================================================================
-- ABA 2: Demonstração completa (todos os componentes)
-- =====================================================================
local DemoTab = Window:Tab({Title = "Demo"})

DemoTab:Section({Title = "Ações"})
DemoTab:Button({
    Title = "Executar ação",
    Callback = function()
        Window:Notify({Title = "Botão", Desc = "Clicado!"})
    end
})

DemoTab:Divider()

DemoTab:Section({Title = "Inputs"})
DemoTab:Input({
    Title = "Nome do jogador",
    Placeholder = "Digite aqui...",
    Default = "",
    Callback = function(text, enter)
        print("Input:", text, "Enter:", enter)
    end
})

DemoTab:Dropdown({
    Title = "Modo",
    Options = {"Legit", "Rage", "Silent"},
    Default = "Legit",
    Callback = function(v)
        print("Modo selecionado:", v)
    end
})

DemoTab:Divider()

DemoTab:Section({Title = "Info"})
DemoTab:Label({Text = "DivineUI v1.0", Desc = "Biblioteca iOS 18 Dark Glass completa - pronta para reusar em qualquer hub futuro."})
DemoTab:Paragraph({Text = "Dica", Desc = "Use Window:Notify() para feedback e Tab:Toggle/Slider/Button para criar funções rapidamente."})

-- =====================================================================
-- ABA 3: Configurações
-- =====================================================================
local ConfigTab = Window:Tab({Title = "Config"})
ConfigTab:Section({Title = "Janela"})
ConfigTab:Button({
    Title = "Fechar UI",
    Callback = function() Window:Destroy() end
})
ConfigTab:Label({Text = "Tema", Desc = "iOS 18 Dark Glass • Purple #AF52DE • Glassmorphism"})
ConfigTab:Slider({
    Title = "Transparência (demo)",
    Min = 0,
    Max = 100,
    Default = 12,
    Suffix = "%",
    Callback = function(v) print("Transp:", v) end
})

print("[DivineUI] Example carregado. Tabs:", #Window.Tabs)
