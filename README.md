# DivineUI — iOS 18 Dark Glass • v1.2.5

Biblioteca própria estilo **WindUI** com visual **iOS 18 Dark Glass** (purple `#AF52DE`, glassmorphism, pill switches). Criada a partir do template `Divine Hub` para ser **reusável em qualquer hub futuro** — PC e Mobile.

> **Versão atual:** `v1.2.5` — `https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua` — testada em `Steal An Egg` PlaceId `107778070777162` via Real MCP.

## Estrutura

```
divineui/
├── DivineUI.lua                  # lib principal v1.2.5 (loadstring)
├── example.lua                   # demo v1.2 (4 tabs + SideBar + HSV)
├── example_original_template.lua # recriação 1:1 do paste 315x275
├── steal_an_egg_divineui.lua     # Steal An Egg completo 7 tabs (WindUI → DivineUI)
└── README.md
```

## Uso

### 1. Executor / Delta (via GitHub - recomendado)
```lua
local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua"))()
-- fixado v1.2.3: https://raw.githubusercontent.com/Ryanabcraft/DivineUI/b8407abee836034bee00b9a038425f9019aa9a46/DivineUI.lua
```

### 2. Local (dev)
```lua
local DivineUI = loadstring(readfile("DivineUI.lua"))()

local Window = DivineUI:CreateWindow({
    Title = "Divine Hub",
    Subtitle = "iOS 18 EDITION",
    Size = UDim2.fromOffset(560, 420), -- mobile auto: 360x380
    SideBarWidth = 150, -- 150 PC / 110 mobile auto
    Resizable = true, -- handle ⋯ no canto
    MinSize = Vector2.new(480, 320),
    MaxSize = Vector2.new(720, 520),
    ConfigName = "default",
    AutoSave = false,
})

local Tab = Window:Tab({Title = "Principal", Icon = "egg"}) -- Icon lucide -> ImageLabel

Tab:Toggle({
    Title = "Teleguiado",
    Desc = "Descrição da função 1",
    Default = false,
    Flag = "teleguiado",
    Callback = function(v) print("Teleguiado", v) end
})

Tab:Divider()

Tab:Slider({
    Title = "Ajustar Velocidade",
    Min = 16, Max = 600, Default = 600, Suffix = " WS",
    Flag = "speed",
    Callback = function(v)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

Tab:ColorPicker({
    Title = "Cor",
    Default = Color3.fromRGB(175,82,222),
    Flag = "accent",
    Callback = function(c) print(c) end
}) -- presets + hex + hue bar HSV

Window:Notify({Title="Pronto", Desc="UI carregada"})
```

## API

### Window
```lua
DivineUI:CreateWindow({
    Title, Subtitle,
    Size = UDim2.fromOffset(560,420), -- auto 360x380 no mobile
    Position,
    SideBarWidth = 150, -- false = top bar horizontal
    Resizable = true, MinSize, MaxSize,
    ConfigName, AutoSave
}) -> Window

Window:Tab({ Title, Icon }) -> Tab -- Icon lucide "egg","eye","paw-print","wrench","user","settings","zap" -> ImageLabel
Window:Notify({ Title, Desc, Duration = 3 })
Window:SetTitle(title, subtitle)
Window:Destroy()
Window:Toggle(bool) -- mostra/esconde
Window:SaveConfig(name) -- DivineUI_Configs/name.json (writefile) suporta Color3 e KeyCode
Window:LoadConfig(name)
Window:GetFlag(flag)
-- Header arrastável (Mouse + Touch), Minimize +/-, Close X, SideBar vertical, ResizeHandle ⋯
```

### Tab
```lua
Tab:Toggle({ Title, Desc, Default, Callback, Flag }) -> Handle { Set, Get, OnChanged, Destroy }
Tab:Slider({ Title, Min, Max, Default, Step, Suffix, Callback, Flag }) -> Handle
Tab:Button({ Title, Callback }) -> Handle
Tab:Input({ Title, Placeholder, Default, Callback, Flag }) -> Handle
Tab:Dropdown({ Title, Options, Default, Callback, Flag }) -> Handle { Set, Get, SetOptions } -- ScrollingFrame 140px com scroll interno
Tab:Keybind({ Title, Desc, Default (KeyCode), Callback, Flag }) -> Handle { Set, Get }
Tab:ColorPicker({ Title, Desc, Default (Color3), Callback, Flag, Presets }) -> Handle { Set, Get } -- presets + hex + hue bar HSV
Tab:Label({ Text, Desc }) / Tab:Paragraph
Tab:Section({ Title })
Tab:Divider()
```

Todos os handles expõem `:Set(v)`, `:Get()`, `:Destroy()`. Use `Flag` para `SaveConfig`.

## Tema

Editável no topo de `DivineUI.lua`:

```lua
local Theme = {
    Bg = Color3.fromRGB(24,20,32),
    Card = Color3.fromRGB(36,30,48),
    Accent = Color3.fromRGB(175,82,222),
    AccentLight = Color3.fromRGB(216,180,254),
    ...
}
local ICONS = { ["egg"]="rbxassetid://6031075938", ["eye"]="rbxassetid://6031090997", ... }
```

Troque `Theme.Accent` para tema global. `ICONS` mapeia nome lucide → `rbxassetid`.

## Changelog

### v1.2.5 — atual
- `ChatGPT gremlins` fix — `resize+minimize` agora salva `fullSize = Main.Size` antes de minimizar, `ResizeHandle` atualiza `fullSize` e `mobile min 320x280 vs 480x320`, `Keybind` enum `tostring:gsub("Enum%.","")`, `Icon` horizontal também cria `ImageLabel`, `Button` agora `Set/Get` além de `SetText`

### v1.2.4
- `Tema ColorPicker` agora `Window:SetAccent(color)` — `Theme.Accent/Accent2` + `tween` em `MainStroke`, `Slider fill`, `Button`, `ScrollBar`, `Tab` selecionada + `steal_an_egg` `Cor Tema` chama `SetAccent`

### v1.2.3
- `Dropdown` agora `ScrollingFrame` com `Canvas` dinâmico (`listFrame Active=true`) — 12 opções `All→Titan` não clipa mais, scroll interno `140px` + `Canvas 296px`
- `Plataforma adaptativa` — `IsMobile = TouchEnabled and not MouseEnabled` → `PC 560x420 SideBar 150` / `Mobile 360x380 SideBar 110` + `UIScale 0.9` + `Touch drag` em header/slider/hue bar
- `Minimize` agora `TabsBar.Visible=false ContentWrap.Visible=false` — sem sliver no rodapé

### v1.2.2
- `Scroll travado` fix — `ScrollingFrame Active=true ScrollingEnabled=true ScrollBar 4px AutomaticCanvasSize=None` — `Canvas 1242 vs 350` agora rola (`20 toggles` testado `CanvasPosition 0→500`)

### v1.2.1
- `Minimize` hide fix inicial

### v1.2.0
- `SideBar vertical` `150px` (`TabsBar Vertical` + `ContentWrap 1,-178`) + `Resizable handle ⋯` (`Min 480x320 Max 720x520`)
- `Ícones imagem` — `Tab.Icon` vira `ImageLabel` lucide (`ICONS` map) + `Dropdown chevron` `ImageLabel Rotation 0/180`
- `ColorPicker HSV` — `hueBar` `UIGradient` rainbow + `hueThumb` drag `Color3.fromHSV` + `hexBox` sync (presets + hex + hue)

### v1.1.2
- Ícones unicode tofu fix — `✕→X`, `—→-`, `▾→v`, `▴→^` (Gotham compatível)

### v1.1.1
- Fix `Tab.Button` colisão com `Tab:Button` método (`Tab.TabButton`) — crash `attempt to index function with 'TextColor3'` no `select:500`

### v1.1.0
- `Keybind` captura `...` 5s `Esc` cancela + listener global
- `ColorPicker` presets + hex `#RRGGBB`
- `Flag` + `Config Save/Load` (`DivineUI_Configs/*.json`) com `Color3` e `Enum.KeyCode`
- `example.lua` demo 3 tabs

### v1.0.0
- `Window` + `Tabs` + `Toggle iOS pill` + `Slider` + `Button` + `Input` + `Dropdown` + `Label/Section/Divider` + `Notify` + `Drag` + `Minimize/Close`

## Compatibilidade

- `gethui() > CoreGui > PlayerGui` (Delta / Mobile / PC)
- `Touch + Mouse + Keyboard` — `Header drag`, `Slider/HueBar` drag, `Dropdown` scroll, `ScrollingFrame` touch scroll
- `TweenService` para switches/sliders/tabs
- Testado `Steal An Egg` `107778070777162` + `Fly` `v1.2.5` via Real MCP `Chiclete` `FPS 79`
