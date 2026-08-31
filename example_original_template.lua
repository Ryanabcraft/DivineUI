-- =====================================================================
-- DivineUI | Recriação EXATA do seu template original (315x275)
-- Só trocar o paste antigo por este arquivo
-- =====================================================================

local DivineUI = loadstring(readfile("DivineUI.lua"))()
-- ou se for via executor direto, cole o conteúdo de DivineUI.lua antes

local Window = DivineUI:CreateWindow({
    Title = "Divine Hub",
    Subtitle = "iOS 18 EDITION • TEMPLATE",
    Size = UDim2.new(0, 315, 0, 275),
})

local Tab = Window:Tab({Title = "Geral"})

Tab:Toggle({
    Title = "Teleguiado",
    Desc = "Descrição da função 1",
    Callback = function(s) print("Teleguiado:", s) end
})

Tab:Divider()

Tab:Toggle({
    Title = "Speed Bypass",
    Desc = "Descrição da função 2",
    Callback = function(s) print("Speed Bypass:", s) end
})

Tab:Divider()

Tab:Slider({
    Title = "Ajustar Velocidade",
    Min = 16,
    Max = 600,
    Default = 600,
    Suffix = " WS",
    Callback = function(v) print("Velocidade definida para:", v) end
})
