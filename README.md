# DivineUI — iOS 18 Dark Glass

Biblioteca própria, estilo **WindUI** mas com seu visual **iOS 18 Dark Glass** (purple `#AF52DE`, glassmorphism, pill switches). Criada a partir do seu template `Divine Hub` para ser **reusável em qualquer hub futuro**.

## Estrutura

```
divineui/
├── DivineUI.lua                  # lib principal (cole/loadstring no executor)
├── example.lua                   # demo completo (3 abas + todos os componentes)
├── example_original_template.lua # recriação 1:1 do seu paste 315x275
└── README.md
```

## Uso

### 1. Executor / Delta (via GitHub - recomendado)
```lua
local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua"))()
```

### 2. Local (dev)
```lua
local DivineUI = loadstring(readfile("DivineUI.lua"))()

local Window = DivineUI:CreateWindow({
    Title = "Divine Hub",
    Subtitle = "iOS 18 EDITION",
    Size = UDim2.new(0, 540, 0, 400), -- ou UDim2.new(0,315,0,275) para tamanho original
})

local Tab = Window:Tab({Title = "Principal"})

Tab:Toggle({
    Title = "Teleguiado",
    Desc = "Descrição da função 1",
    Default = false,
    Callback = function(v) print("Teleguiado", v) end
})

Tab:Divider()

Tab:Slider({
    Title = "Ajustar Velocidade",
    Min = 16, Max = 600, Default = 600, Suffix = " WS",
    Callback = function(v)
        local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

Window:Notify({Title="Pronto", Desc="UI carregada"})
```

## API

### Window
```lua
DivineUI:CreateWindow({ Title, Subtitle, Size, Position, ConfigName, AutoSave }) -> Window
Window:Tab({ Title, Icon }) -> Tab
Window:Notify({ Title, Desc, Duration })
Window:SetTitle(title, subtitle)
Window:Destroy()
Window:Toggle(bool) -- mostra/esconde
Window:SaveConfig(name) -- salva Flags em DivineUI_Configs/name.json (writefile)
Window:LoadConfig(name) -- carrega e aplica
Window:GetFlag(flag) -> value
-- Header arrastável, Minimize (—/+), Close (✕), Tabs em pill
```

### Tab
```lua
Tab:Toggle({ Title, Desc, Default, Callback, Flag }) -> Handle { Set, Get, OnChanged, Destroy }
Tab:Slider({ Title, Min, Max, Default, Step, Suffix, Callback, Flag }) -> Handle
Tab:Button({ Title, Callback }) -> Handle
Tab:Input({ Title, Placeholder, Default, Callback, Flag }) -> Handle
Tab:Dropdown({ Title, Options, Default, Callback, Flag }) -> Handle { Set, Get, SetOptions }
Tab:Keybind({ Title, Desc, Default (KeyCode), Callback, Flag }) -> Handle { Set, Get }
Tab:ColorPicker({ Title, Desc, Default (Color3), Callback, Flag, Presets }) -> Handle { Set, Get }
Tab:Label({ Text, Desc }) / Tab:Paragraph
Tab:Section({ Title })
Tab:Divider()
```

Todos os handles expõem `:Set(v)`, `:Get()`, `:Destroy()`.
Use `Flag` para Config Save: `Window:SaveConfig("minhaCfg")` salva todos os Flags automaticamente (Color3 e KeyCode serializados).

## Tema

Editável direto no topo de `DivineUI.lua`:

```lua
local Theme = {
    Bg = Color3.fromRGB(24,20,32),
    Card = Color3.fromRGB(36,30,48),
    Accent = Color3.fromRGB(175,82,222),
    AccentLight = Color3.fromRGB(216,180,254),
    ...
}
```

Troque `Theme.Accent` para mudar toda a lib.

## Changelog

### v1.1.0
- `Keybind` com captura visual (`...` 5s timeout, `Esc` cancela) + listener global
- `ColorPicker` com preview, hex `#RRGGBB`, presets e `TextBox` editável
- `Flag` + `Config Save/Load` (`writefile/readfile` em `DivineUI_Configs/*.json`) com suporte a `Color3` e `Enum.KeyCode`
- `example.lua` atualizado com demo completo v1.1

## Próximos passos sugeridos

- [x] `Toggle` com `Flag` + `Config Save` (writefile/readfile) auto
- [x] `Keybind` e `ColorPicker`
- [ ] `Search` nas tabs
- [x] Hospedar `DivineUI.lua` no GitHub/Pastefy para `HttpGet` → `https://raw.githubusercontent.com/Ryanabcraft/DivineUI/main/DivineUI.lua`

## Compatibilidade

- `gethui()` > `CoreGui` > `PlayerGui` (Delta / Mobile / PC)
- Touch + Mouse
- `TweenService` para switches/sliders
