-- Steal An Egg | DivineUI Edition
-- By Ryanab | Convertido de WindUI -> DivineUI v1.1.2
-- DivineUI: https://github.com/Ryanabcraft/DivineUI

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LP = Players.LocalPlayer
if not game:IsLoaded() then game.Loaded:Wait() end
repeat task.wait() until LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")

local IsMobile = UserInputService.TouchEnabled and not UserInputService.MouseEnabled

-- DivineUI
local DivineUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Ryanabcraft/DivineUI/3b0b9845310cfdb2f72361772baf0fd3072b135e/DivineUI.lua"))()

local Window = DivineUI:CreateWindow({
    Title = "Steal an egg",
    Subtitle = "By Ryanab • DivineUI",
    Size = UDim2.fromOffset(560, 460),
    ConfigName = "StealAnEgg_Divine",
})

local function notify(t,c) pcall(function() Window:Notify({ Title=t, Desc=c, Duration=2 }) end) end
local function getHRP() return LP.Character and LP.Character:FindFirstChild("HumanoidRootPart") end
local function getHum() return LP.Character and LP.Character:FindFirstChildOfClass("Humanoid") end

-- Toggle UI com K (substitui Window:SetToggleKey)
do
    UserInputService.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.KeyCode == Enum.KeyCode.K then
            Window:Toggle(not Window.Gui.Enabled)
        end
    end)
end

-- Bypass auto 600 (sem UI)
do
 pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", false) end)
 pcall(function()
  local ps = LP:FindFirstChild("PlayerScripts")
  local s = ps and ps:FindFirstChild("Game") and ps.Game:FindFirstChild("ObbyAntiTPClient")
  if s then s.Disabled=true end
 end)
 local char = LP.Character
 local old = char and char:FindFirstChildOfClass("Humanoid")
 if false and old then
  local clone = old:Clone()
  clone.Name="Humanoid"
  old.Name="_OLD_HUMANOID"
  clone.Parent=char
  pcall(function()
   clone.MaxHealth = old.MaxHealth
   clone.Health = old.Health > 0 and old.Health or 100
   clone.WalkSpeed=600
   clone:ChangeState(Enum.HumanoidStateType.Running)
  end)
  if typeof(sethiddenproperty)=="function" then pcall(function() sethiddenproperty(clone,"WalkSpeed",600) end) end
  pcall(function() old.Parent=nil end)
  if old.Parent==char then pcall(function() old.Parent=Workspace end) end
  pcall(function() Workspace.CurrentCamera.CameraSubject=clone end)
  task.delay(0.1, function() pcall(function() if clone.Health<=0 then clone.Health=100 clone:ChangeState(Enum.HumanoidStateType.GettingUp) end end) end)
  local hum = clone
  RunService.Heartbeat:Connect(function()
   if hum and hum.Parent==char then
    if hum.Health<=0 then pcall(function() hum.Health=100 end) end
    if hum.WalkSpeed~=600 then pcall(function() hum.WalkSpeed=600 end) end
   end
  end)
  if typeof(clone.GetPropertyChangedSignal)=="function" then
   clone:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if clone.WalkSpeed~=600 then task.wait() pcall(function() clone.WalkSpeed=600 end) end
   end)
  end
  pcall(function() clone.UseJumpPower = old.UseJumpPower clone.JumpPower = old.JumpPower clone.JumpHeight = old.JumpHeight clone:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end)
  UserInputService.JumpRequest:Connect(function() local hh=getHum() if hh then hh:ChangeState(Enum.HumanoidStateType.Jumping) end end)
  LP.CharacterAdded:Connect(function(c)
   c:WaitForChild("HumanoidRootPart") task.wait(0.5)
   if not CFG.autoFarm then return end
   local oh = c:FindFirstChildOfClass("Humanoid")
   if oh then
    local cl = oh:Clone() cl.Name="Humanoid" oh.Name="_OLD_HUMANOID" cl.Parent=c pcall(function() cl.MaxHealth=oh.MaxHealth cl.Health=oh.Health>0 and oh.Health or 100 cl.WalkSpeed=600 cl.UseJumpPower=true cl.JumpPower=50 cl.JumpHeight=7.2 cl:ChangeState(Enum.HumanoidStateType.Running) cl:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end) pcall(function() oh.Parent=nil end) pcall(function() Workspace.CurrentCamera.CameraSubject=cl end) task.delay(0.1, function() pcall(function() if cl.Health<=0 then cl.Health=100 end end) end)
    RunService.Heartbeat:Connect(function() if cl and cl.Parent==c then if cl.Health<=0 then pcall(function() cl.Health=100 end) end if cl.WalkSpeed~=600 then pcall(function() cl.WalkSpeed=600 end) end if not cl:GetStateEnabled(Enum.HumanoidStateType.Jumping) then pcall(function() cl:SetStateEnabled(Enum.HumanoidStateType.Jumping, true) end) end end end)
   end
   pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", false) end)
  end)
 end
end

-- Fix pulo leve (sem noclip pesado)
do
 RunService.Heartbeat:Connect(function()
  local h=getHum()
  if h then pcall(function() if h.UseJumpPower==false then h.UseJumpPower=true end if h.JumpPower<50 then h.JumpPower=50 end end) end
 end)
 UserInputService.JumpRequest:Connect(function() local hh=getHum() if hh then pcall(function() hh:ChangeState(Enum.HumanoidStateType.Jumping) end) end end)
end

-- Remotes
local Remotes = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("Networking")
local RF = {
 Carry = Remotes:FindFirstChild("RF/EggWorld/AskFieldEggCarry"),
 Snapshot = Remotes:FindFirstChild("RF/EggWorld/AskFieldEggSnapshot"),
 Place = Remotes:FindFirstChild("RF/EggWorld/AskPlaceEgg"),
 Hatch = Remotes:FindFirstChild("RF/EggWorld/AskHatch"),
 FinishHatch = Remotes:FindFirstChild("RF/EggWorld/AskFinishHatch"),
 Skip = Remotes:FindFirstChild("RF/EggWorld/AskSkipGrowth"),
 Wear = Remotes:FindFirstChild("RF/EggWorld/AskWearTool"),
 Doff = Remotes:FindFirstChild("RF/EggWorld/AskDoffTool"),
 WearBest = Remotes:FindFirstChild("RF/Haul/WearBest"),
 WriteAutoSell = Remotes:FindFirstChild("RF/Haul/WriteAutoSell"),
 Away = Remotes:FindFirstChild("RF/AwayEarnings/AskCollect"),
 BloomeryLoad = Remotes:FindFirstChild("RF/Bloomery/AskLoadEgg"),
 BloomeryMutate = Remotes:FindFirstChild("RF/Bloomery/AskMutate"),
 BloomeryGather = Remotes:FindFirstChild("RF/Bloomery/AskGatherPetal"),
 FuseBegin = Remotes:FindFirstChild("RF/Fusery/BeginFuse"),
 FuseLoad = Remotes:FindFirstChild("RF/Fusery/LoadPet"),
 FuseReveal = Remotes:FindFirstChild("RF/Fusery/FinishReveal"),
 TreadmillRaise = Remotes:FindFirstChild("RF/Treadmill/AskTierRaise"),
}
local RE = {
 SellPet = Remotes:FindFirstChild("RE/PetSatchel/SellPet"),
 SellEvery = Remotes:FindFirstChild("RE/PetSatchel/SellEveryPet"),
}
local EggState = nil
pcall(function() EggState = require(ReplicatedStorage.Client:WaitForChild("EggState")) end)
local AreaId = nil
pcall(function() AreaId = require(ReplicatedStorage.Shared.Util:WaitForChild("AreaEggSlotIdentity")) end)

-- Meio atualizado
local MIDDLE_CF = CFrame.new(510.08, 70.43, -365.58)
local function isNight()
 local ok,mod=pcall(function() return require(ReplicatedStorage.Shared.Util.AreaEggCycle) end)
 if ok and mod and mod.IsNightPhase then
  local ok2,res=pcall(function() return mod.IsNightPhase(Workspace:GetServerTimeNow()) end)
  if ok2 then return res end
 end
 local ct=game.Lighting.ClockTime
 return ct<6 or ct>18
end

-- Config
local CFG = { autoFarm=false, farmArea="All", espEggs=false, espRaro=false, espPlayers=false, espChest=false, espGuards=false, espTrap=false, espBloomery=false, infJump=false, autoPlace=false, autoHatch=false, autoSkip=false, autoWear=false, treadmillAuto=false, charSpeed=600, charSpeedEnabled=false }

-- Trap avoidance
local function isTrapNearby(pos, rad)
 rad = rad or 12
 for _,v in ipairs(Workspace:GetDescendants()) do
  if v:IsA("BasePart") then
   local n = v.Name:lower()
   if n:find("trap") or v:GetAttribute("IsTrap") then
    if (v.Position - pos).Magnitude < rad then return true end
   end
  end
  if v:IsA("ProximityPrompt") and v.ObjectText:lower():find("trap") then
   if v.Parent and v.Parent:IsA("BasePart") and (v.Parent.Position - pos).Magnitude < rad then return true end
  end
 end
 for _,m in ipairs(Workspace:GetChildren()) do
  if m.Name:lower():find("trap") and m:IsA("Model") then
   local pp = m.PrimaryPart or m:FindFirstChildWhichIsA("BasePart")
   if pp and (pp.Position - pos).Magnitude < rad then return true end
  end
 end
 return false
end

local function safeCFrame(cf)
 local pos = Vector3.new(cf.X, cf.Y, cf.Z)
 if isTrapNearby(pos, 14) then
  for _,off in ipairs({Vector3.new(8,0,0), Vector3.new(-8,0,0), Vector3.new(0,0,8), Vector3.new(0,0,-8)}) do
   if not isTrapNearby(pos+off, 10) then
    return cf + off
   end
  end
  return nil
 end
 return cf
end

local function tweenTo(cf)
 local hrp=getHRP() if not hrp then return end
 local target = safeCFrame(cf)
 if not target then return false end
 local dist=(hrp.Position - Vector3.new(target.X,target.Y,target.Z)).Magnitude
 local t = TweenService:Create(hrp, TweenInfo.new(dist/600, Enum.EasingStyle.Linear), {CFrame = target + Vector3.new(0,3,0)})
 t:Play() t.Completed:Wait()
 return true
end

local function eggScore(rec)
 local s=0
 if type(rec.Mutations)=="table" then s+=#rec.Mutations*80 end
 if rec.IsRare then s+=300 end
 if type(rec.Rarity)=="number" then s+=rec.Rarity*20 end
 if type(rec.AssetScale)=="number" then s+=rec.AssetScale*150 end
 if type(rec.NestScale)=="number" then s+=rec.NestScale*80 end
 return s
end

-- Auto Farm
local farmThread
local function startFarm()
 if farmThread then task.cancel(farmThread) end
 farmThread=task.spawn(function()
  while CFG.autoFarm do
   if isNight() then
    notify("Noite","Pausado até abrir")
    repeat task.wait(2) until not isNight() or not CFG.autoFarm
    if not CFG.autoFarm then break end
    notify("Dia","Voltando farm")
   end
   local ok,snap = pcall(function() if EggState then return EggState.ReadFieldEggs() else return {Records={}} end end)
   if not ok or not snap or not snap.Records or #snap.Records==0 then
    if RF.Snapshot then local ok2,res=pcall(function() return RF.Snapshot:InvokeServer() end) if ok2 and res then snap={Records=res.Records or res or {}} ok=true end end
   end
   if ok and snap and #snap.Records>0 then
    local hrp=getHRP() if not hrp then task.wait(0.5) continue end
    if (hrp.Position - Vector3.new(MIDDLE_CF.X, MIDDLE_CF.Y, MIDDLE_CF.Z)).Magnitude > 15 then
     tweenTo(MIDDLE_CF)
     task.wait(0.1)
     hrp=getHRP()
    end
    local dropped={}
    for _,r in ipairs(snap.Records) do
     if r.State=="Dropped" and r.BottomCFrame then
      local d=(Vector3.new(r.BottomCFrame.X,r.BottomCFrame.Y,r.BottomCFrame.Z)-hrp.Position).Magnitude
      if d<60 then table.insert(dropped,{rec=r, dist=d}) end
     end
    end
    local top=nil
    if #dropped>0 then
     table.sort(dropped, function(a,b)
      local aIsLast = a.rec.Uid==_G.lastEggUid
      local bIsLast = b.rec.Uid==_G.lastEggUid
      if aIsLast~=bIsLast then return aIsLast end
      return a.dist<b.dist
     end)
     top=dropped[1].rec
     notify("Drop!","Pegando de volta "..(top.AssetCategory or "ovo"))
    else
     local cand={}
     for _,r in ipairs(snap.Records) do
      if r.State~="Slot" then continue end
      if CFG.farmArea~="All" and r.AreaId~=CFG.farmArea then continue end
      if r.BottomCFrame then
       local d=(Vector3.new(r.BottomCFrame.X,r.BottomCFrame.Y,r.BottomCFrame.Z)-hrp.Position).Magnitude
       table.insert(cand,{rec=r, dist=d, score=eggScore(r)})
      end
     end
     table.sort(cand, function(a,b) if a.score~=b.score then return a.score>b.score end return a.dist<b.dist end)
     top=cand[1] and cand[1].rec or nil
     if top and top.BottomCFrame and isTrapNearby(Vector3.new(top.BottomCFrame.X,top.BottomCFrame.Y,top.BottomCFrame.Z), 10) then
      table.remove(cand,1)
      top=cand[1] and cand[1].rec or nil
      if not top then task.wait(0.5) continue end
     end
    end
    if top and top.BottomCFrame then
     local base=MIDDLE_CF
     local okMove = tweenTo(top.BottomCFrame)
     if not okMove then task.wait(0.3) continue end
     task.wait(0.1)
     local sk=nil
     if AreaId and AreaId.LooksLikeFirstAreaUid(top.Uid) then sk=AreaId.SlotKey(top.AreaId, top.NestId) end
     local picked=false
     if EggState and EggState.CarryFieldEgg then local okc,res=pcall(EggState.CarryFieldEgg, top.Uid, sk) picked=okc and res end
     if not picked and RF.Carry then local okc=pcall(function() return RF.Carry:InvokeServer({Uid=top.Uid, FirstAreaSlotKey=sk}) end) picked=okc end
     if picked then _G.lastEggUid=top.Uid end
     task.wait(0.08)
     if base then tweenTo(base) end
     task.wait(0.3)
    else task.wait(0.6) end
   else task.wait(0.8) end
  end
  end)
end

-- Ovos: Place precisa estar no plot e ter ovo não plantado; Hatch precisa ovo plantado e pronto; Skip precisa crescer
local eggThread
local function getMyPlot()
 for _,p in ipairs(Workspace.Plots:GetChildren()) do
  local sign=p:FindFirstChild("PlotSign")
  local pp=sign and sign:FindFirstChild("PlayerPlotSign")
  local frame=pp and pp:FindFirstChild("Frame")
  local n=frame and frame:FindFirstChild("PlayerName")
  if n and (n.Text==LP.DisplayName or n.Text==LP.Name) then return p end
 end
 local closest,cd=nil,1e9
 for _,p in ipairs(Workspace.Plots:GetChildren()) do local cp=p:FindFirstChild("CenterPoint") if cp and getHRP() then local d=(cp.Position-getHRP().Position).Magnitude if d<cd then cd=d closest=p end end end
 return closest
end
local function getOwnedPlaceableUid()
 if not EggState then return _G.lastEggUid end
 local ok,res=pcall(EggState.ReadOwnedEggs)
 if not ok or not res then return _G.lastEggUid end
 for _,entry in ipairs(res) do
  if entry.OwnerUserId==LP.UserId then
   for _,rec in ipairs(entry.Records or {}) do
    if rec.Uid and not rec.Placement then return rec.Uid end
   end
  end
 end
 return _G.lastEggUid
end
local function getHatchableUid()
 if not EggState then return _G.lastEggUid end
 local ok,res=pcall(EggState.ReadOwnedEggs)
 if not ok or not res then return nil end
 for _,entry in ipairs(res) do
  if entry.OwnerUserId==LP.UserId then
   for _,rec in ipairs(entry.Records or {}) do
    if rec.Uid and rec.Placement and EggState.IsReadyToHatch and EggState.IsReadyToHatch(rec.Uid) then return rec.Uid end
   end
  end
 end
 return nil
end
local function startEggLoop()
 if eggThread then task.cancel(eggThread) end
 eggThread=task.spawn(function()
  while CFG.autoPlace or CFG.autoHatch or CFG.autoSkip do
   if CFG.autoPlace and RF.Place then
    local uid=getOwnedPlaceableUid()
    if uid then
     local plot=getMyPlot()
     if plot and plot:FindFirstChild("CenterPoint") then
      local hrp=getHRP()
      if hrp and (hrp.Position - plot.CenterPoint.Position).Magnitude > 25 then
       tweenTo(plot.CenterPoint.CFrame + Vector3.new(0,5,0))
       task.wait(0.3)
      end
      local placed=false
      for attempt=1,5 do
       local cf=CFrame.new(math.random(-8,8),0,math.random(-8,8))
       local worldPos = plot.CenterPoint.CFrame:PointToWorldSpace(Vector3.new(cf.X, cf.Y, cf.Z))
       if not isTrapNearby(worldPos, 8) then
        local ok2,res2=false,nil
        if EggState and EggState.PlantEgg then ok2,res2=pcall(function() return EggState.PlantEgg(uid, cf) end) end
        if not ok2 or not res2 then ok2,res2=pcall(function() return RF.Place:InvokeServer({Uid=uid, LocalCFrame=cf}) end) end
        if ok2 and res2 then notify("Place","Plantado "..uid:sub(1,6)) placed=true break else task.wait(0.2) end
       end
      end
      if not placed then notify("Place","Sem espaço sem trap") end
     end
    end
   end
   if CFG.autoHatch then
    local uid=getHatchableUid()
    if uid then
     local ok2,res2,petUid=pcall(function() return EggState.BeginHatch(uid) end)
     if ok2 and res2 then
      task.wait(0.5)
      local ok3,res3=pcall(function() return EggState.FinishHatch(uid) end)
      if ok3 and res3 then notify("Hatch","Chocou "..petUid) else notify("Hatch","Begin ok, Finish "..tostring(res3)) end
     end
    end
   end
   if CFG.autoSkip then
    local skipUid=nil
    if EggState and EggState.ReadOwnedEggs then
     local ok,res=pcall(EggState.ReadOwnedEggs)
     if ok then for _,e in ipairs(res) do if e.OwnerUserId==LP.UserId then for _,r in ipairs(e.Records or {}) do if r.Uid and r.Placement and not (EggState.IsReadyToHatch and EggState.IsReadyToHatch(r.Uid)) then skipUid=r.Uid break end end end end end
    end
    skipUid=skipUid or _G.lastEggUid
    if skipUid and RF.Skip then
     local ok2,res2,prod=pcall(function() return EggState.BeginSkipGrowth(skipUid) end)
     if ok2 and res2 then notify("Skip","Skip "..skipUid:sub(1,6)) end
    end
   end
   task.wait(1)
  end
 end)
end

-- Pets
local petsThread
local function startPetsLoop()
 if petsThread then task.cancel(petsThread) end
 petsThread=task.spawn(function()
  while CFG.autoWear do
   if RF.WearBest then pcall(function() RF.WearBest:InvokeServer() end) end
   task.wait(8)
  end
 end)
end

-- Treadmill
local treadThread
local function startTreadLoop()
 if treadThread then task.cancel(treadThread) end
 treadThread=task.spawn(function()
  while CFG.treadmillAuto do
   if RF.TreadmillRaise then pcall(function() RF.TreadmillRaise:InvokeServer() end) end
   task.wait(3)
  end
 end)
end

-- ESP
local espObjs={}
local espThread=nil
local function clearESP() for _,v in ipairs(espObjs) do pcall(function() v:Destroy() end) end espObjs={} if espThread then pcall(function() task.cancel(espThread) end) espThread=nil end end
local function billboard(part, text, color)
 local bg=Instance.new("BillboardGui") bg.Size=UDim2.new(0,130,0,32) bg.StudsOffset=Vector3.new(0,3,0) bg.AlwaysOnTop=true bg.Parent=part
 local l=Instance.new("TextLabel",bg) l.Size=UDim2.new(1,0,1,0) l.BackgroundTransparency=0.35 l.BackgroundColor3=Color3.new(0,0,0) l.TextColor3=color l.TextScaled=true l.Font=Enum.Font.GothamBold l.Text=text l.TextStrokeTransparency=0.2
 table.insert(espObjs,bg) return bg
end
local function startESP()
 if espThread then return end
 espThread=task.spawn(function()
  while CFG.espEggs or CFG.espRaro or CFG.espPlayers or CFG.espChest or CFG.espGuards or CFG.espTrap or CFG.espBloomery do
   for _,v in ipairs(espObjs) do pcall(function() v:Destroy() end) end espObjs={}
   if (CFG.espEggs or CFG.espRaro) and EggState then
     local ok,snap=pcall(EggState.ReadFieldEggs)
     if ok and snap and snap.Records then
      for _,r in ipairs(snap.Records) do
       if r.BottomCFrame and r.State=="Slot" then
        local isRaro = (#(r.Mutations or {})>0) or r.IsRare or (r.AssetScale and r.AssetScale>1.2)
        if CFG.espRaro and not isRaro then continue end
        if not CFG.espEggs and not CFG.espRaro then continue end
        local p=Instance.new("Part") p.Anchored=true p.CanCollide=false p.Transparency=0.7 p.Size=Vector3.new(1,1,1) p.CFrame=r.BottomCFrame p.Parent=Workspace.CurrentCamera
        local col = isRaro and Color3.fromRGB(255,50,50) or Color3.fromRGB(255,221,85)
        local txt = (r.AssetCategory or "Egg")..(isRaro and " ★" or "")..string.format(" %.2f", r.AssetScale or 0)
        billboard(p, txt, col)
        task.delay(1.9, function() pcall(function() p:Destroy() end) end)
       end
      end
     end
    end
   if CFG.espPlayers then
    for _,plr in ipairs(Players:GetPlayers()) do
     if plr~=LP and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
      billboard(plr.Character.HumanoidRootPart, plr.DisplayName, Color3.fromRGB(85,170,255))
     end
    end
   end
   if CFG.espChest then
    local chest=Workspace:FindFirstChild("Chest") or Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS:FindFirstChild("Chest")
    if chest then
     local part=chest:IsA("BasePart") and chest or chest:FindFirstChildWhichIsA("BasePart")
     if part then billboard(part, "Chest", Color3.fromRGB(0,255,100)) end
    end
   end
   if CFG.espGuards then
    local ga=Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS.Areas:FindFirstChild("GuardAreas")
    if ga then for _,m in ipairs(ga:GetChildren()) do local g=m:FindFirstChild("Guard") if g then local hrp=g:FindFirstChild("HumanoidRootPart") or g.PrimaryPart or g:FindFirstChildWhichIsA("BasePart") if hrp then billboard(hrp, "Guard "..m.Name, Color3.fromRGB(255,85,85)) end end end end
   end
   if CFG.espTrap then
    for _,v in ipairs(Workspace:GetDescendants()) do
     if v:IsA("BasePart") and v.Name:lower():find("trap") then
      billboard(v, "Trap", Color3.fromRGB(255,165,0))
     end
    end
   end
   if CFG.espBloomery then
    for _,name in ipairs({"Bloomery","FuseMachine","Treadmill"}) do
     local obj=Workspace:FindFirstChild(name) or Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS:FindFirstChild(name) or Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS:FindFirstChild("Machines") and Workspace.__OBJECTS.Machines:FindFirstChild(name)
     if obj then local p=obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart",true) if p then local col=name=="Bloomery" and Color3.fromRGB(200,100,255) or name=="FuseMachine" and Color3.fromRGB(100,200,255) or Color3.fromRGB(100,255,150) billboard(p, name, col) end end
    end
   end
   task.wait(2)
  end
  clearESP()
 end)
end

-- Inf Jump
local jumpConn=nil
local function setJump(v)
 CFG.infJump=v
 if jumpConn then jumpConn:Disconnect() jumpConn=nil end
 if v then
  jumpConn=UserInputService.JumpRequest:Connect(function() local h=getHum() if h then h:ChangeState(Enum.HumanoidStateType.Jumping) end end)
 end
end

-- UI DivineUI ---------------------------------------------------------------
local TabFarm = Window:Tab({ Title="Farm" })
TabFarm:Section({ Title="Auto Farm" })
TabFarm:Dropdown({
    Title="Área",
    Desc="Filtra eggs por área • All = todas",
    Options={"All","Jungle","Cosmic","Abyss Ocean","Desert","Forest","Snow","Volcano","Lake","Prehistoric","Cherry Blossom","Titan Temple"},
    Default="All",
    Flag="farmArea",
    Callback=function(v) CFG.farmArea=v notify("Área", v) end
})
TabFarm:Toggle({
    Title="Auto Farm Egg",
    Desc="Mais raros primeiro • desvia traps",
    Default=false,
    Flag="autoFarm",
    Callback=function(v)
        CFG.autoFarm=v
        if v then
            pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", false) end)
            local char=LP.Character
            local old=char and char:FindFirstChildOfClass("Humanoid")
            if old and not char:FindFirstChild("_OLD_HUMANOID") and not Workspace:FindFirstChild("_OLD_HUMANOID") then
                local clone=old:Clone()
                clone.Name="Humanoid"
                old.Name="_OLD_HUMANOID"
                clone.Parent=char
                pcall(function()
                    clone.MaxHealth=old.MaxHealth
                    clone.Health=old.Health>0 and old.Health or 100
                    clone.WalkSpeed=600
                    clone.UseJumpPower=true
                    clone.JumpPower=50
                    clone:ChangeState(Enum.HumanoidStateType.Running)
                    clone:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                end)
                if typeof(sethiddenproperty)=="function" then pcall(function() sethiddenproperty(clone,"WalkSpeed",600) end) end
                pcall(function() old.Parent=nil end)
                pcall(function() Workspace.CurrentCamera.CameraSubject=clone end)
                task.delay(0.1, function() pcall(function() if clone.Health<=0 then clone.Health=100 end end) end)
                RunService.Heartbeat:Connect(function()
                    if clone and clone.Parent==char and clone.WalkSpeed~=600 then pcall(function() clone.WalkSpeed=600 end) end
                end)
            end
            startFarm()
            notify("Farm ON","600 fixo • "..CFG.farmArea)
        else
            if farmThread then task.cancel(farmThread) farmThread=nil end
            local char=LP.Character
            local clone=char and char:FindFirstChildOfClass("Humanoid")
            local old=nil
            for _,v in ipairs(getnilinstances and getnilinstances() or {}) do if v.Name=="_OLD_HUMANOID" and v:IsA("Humanoid") then old=v break end end
            if not old then old=Workspace:FindFirstChild("_OLD_HUMANOID") end
            if clone and old and old.Name=="_OLD_HUMANOID" then
                pcall(function() clone:Destroy() old.Name="Humanoid" old.Parent=char Workspace.CurrentCamera.CameraSubject=old old.WalkSpeed=16 old.Health=100 end)
            end
            pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", true) end)
            notify("Farm OFF","")
        end
    end
})

local TabESP = Window:Tab({ Title="Visual" })
TabESP:Section({ Title="ESP" })
TabESP:Toggle({ Title="ESP Eggs", Default=false, Flag="espEggs", Callback=function(v) CFG.espEggs=v if v or CFG.espRaro or CFG.espPlayers or CFG.espChest or CFG.espGuards then startESP() end if not v and not CFG.espRaro and not CFG.espPlayers and not CFG.espChest and not CFG.espGuards then clearESP() end end })
TabESP:Toggle({ Title="ESP Eggs Raro", Desc="Só ★ raros/mutados/grandes", Default=false, Flag="espRaro", Callback=function(v) CFG.espRaro=v if v or CFG.espEggs or CFG.espPlayers or CFG.espChest or CFG.espGuards then startESP() end if not v and not CFG.espEggs and not CFG.espPlayers and not CFG.espChest and not CFG.espGuards then clearESP() end end })
TabESP:Toggle({ Title="ESP Players", Default=false, Flag="espPlayers", Callback=function(v) CFG.espPlayers=v if v or CFG.espEggs or CFG.espRaro or CFG.espChest or CFG.espGuards then startESP() end if not v and not CFG.espEggs and not CFG.espRaro and not CFG.espChest and not CFG.espGuards then clearESP() end end })
TabESP:Toggle({ Title="ESP Chest", Default=false, Flag="espChest", Callback=function(v) CFG.espChest=v if v or CFG.espEggs or CFG.espRaro or CFG.espPlayers or CFG.espGuards then startESP() end if not v and not CFG.espEggs and not CFG.espRaro and not CFG.espPlayers and not CFG.espGuards then clearESP() end end })
TabESP:Toggle({ Title="ESP Guards", Default=false, Flag="espGuards", Callback=function(v) CFG.espGuards=v if v or CFG.espEggs or CFG.espRaro or CFG.espPlayers or CFG.espChest or CFG.espTrap or CFG.espBloomery then startESP() end if not v and not CFG.espEggs and not CFG.espRaro and not CFG.espPlayers and not CFG.espChest and not CFG.espTrap and not CFG.espBloomery then clearESP() end end })
TabESP:Toggle({ Title="ESP Trap", Default=false, Flag="espTrap", Callback=function(v) CFG.espTrap=v if v or CFG.espEggs or CFG.espRaro or CFG.espPlayers or CFG.espChest or CFG.espGuards or CFG.espBloomery then startESP() end if not v and not CFG.espEggs and not CFG.espRaro and not CFG.espPlayers and not CFG.espChest and not CFG.espGuards and not CFG.espBloomery then clearESP() end end })
TabESP:Toggle({ Title="ESP Bloomery/Fuse", Default=false, Flag="espBloomery", Callback=function(v) CFG.espBloomery=v if v or CFG.espEggs or CFG.espRaro or CFG.espPlayers or CFG.espChest or CFG.espGuards or CFG.espTrap then startESP() end if not v and not CFG.espEggs and not CFG.espRaro and not CFG.espPlayers and not CFG.espChest and not CFG.espGuards and not CFG.espTrap then clearESP() end end })

local TabPets = Window:Tab({ Title="Pets" })
TabPets:Section({ Title="Pets" })
TabPets:Button({ Title="Equip Best", Callback=function() if RF.WearBest then pcall(function() RF.WearBest:InvokeServer() end) notify("Pets","Equip Best") end end })
TabPets:Toggle({ Title="Auto Equip Best", Default=false, Flag="autoWear", Callback=function(v) CFG.autoWear=v if v then startPetsLoop() end notify("Auto Wear", v and "ON" or "OFF") end })
TabPets:Button({ Title="Sell Todos", Callback=function() if RE.SellEvery then RE.SellEvery:FireServer() notify("Pets","Sell Todos") end end })
TabPets:Section({ Title="Fuse" })
TabPets:Button({ Title="Fuse 3 Pets", Desc="Funde 3 pets em 1", Callback=function()
    if RF.FuseBegin then
        local ok,res=pcall(function() return RF.FuseBegin:InvokeServer() end)
        notify("Fuse", ok and res and "Fuse iniciado" or "Falha")
    end
end })
TabPets:Button({ Title="Load Pet Slot 1", Callback=function() if RF.FuseLoad then pcall(function() RF.FuseLoad:InvokeServer(1) end) notify("Fuse","Load Slot 1") end end })
TabPets:Button({ Title="Finish Reveal", Callback=function() if RF.FuseReveal then pcall(function() RF.FuseReveal:InvokeServer() end) notify("Fuse","Reveal") end end })

local TabUtil = Window:Tab({ Title="Util" })
TabUtil:Section({ Title="Util" })
TabUtil:Button({ Title="Claim Group Reward", Callback=function() local p=Workspace:FindFirstChild("__OBJECTS") and Workspace.__OBJECTS:FindFirstChild("GroupReward") if p then local pp=p:FindFirstChildWhichIsA("ProximityPrompt",true) if pp then fireproximityprompt(pp) notify("Util","GroupReward") end end end })
TabUtil:Button({ Title="Collect AwayEarnings", Callback=function() if RF.Away then local ok,res=pcall(function() return RF.Away:InvokeServer() end) notify("Away", tostring(res)) end end })
TabUtil:Button({ Title="Rejoin", Callback=function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end })
TabUtil:Button({ Title="Server Hop", Callback=function() local Http=game:GetService("HttpService") local s=Http:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100")) for _,v in ipairs(s.data) do if v.playing<v.maxPlayers and v.id~=game.JobId then game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, v.id) break end end end })

local TabChar = Window:Tab({ Title="Personagem" })
TabChar:Section({ Title="Velocidade" })
TabChar:Toggle({
    Title="Bypass Speed",
    Desc="Clone 600 • mesmo do Farm",
    Default=false,
    Flag="charSpeedEnabled",
    Callback=function(v)
        CFG.charSpeedEnabled=v
        if v then
            pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", false) end)
            local char=LP.Character
            local old=char and char:FindFirstChildOfClass("Humanoid")
            if old and not char:FindFirstChild("_OLD_HUMANOID") and not Workspace:FindFirstChild("_OLD_HUMANOID") then
                local clone=old:Clone()
                clone.Name="Humanoid"
                old.Name="_OLD_HUMANOID"
                clone.Parent=char
                pcall(function()
                    clone.MaxHealth=old.MaxHealth
                    clone.Health=old.Health>0 and old.Health or 100
                    clone.WalkSpeed=CFG.charSpeed
                    clone.UseJumpPower=true
                    clone.JumpPower=50
                    clone:ChangeState(Enum.HumanoidStateType.Running)
                    clone:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
                end)
                if typeof(sethiddenproperty)=="function" then pcall(function() sethiddenproperty(clone,"WalkSpeed",CFG.charSpeed) end) end
                pcall(function() old.Parent=nil end)
                pcall(function() Workspace.CurrentCamera.CameraSubject=clone end)
                RunService.Heartbeat:Connect(function()
                    if clone and clone.Parent==char and clone.WalkSpeed~=CFG.charSpeed then pcall(function() clone.WalkSpeed=CFG.charSpeed end) end
                end)
            else
                local h=getHum() if h then pcall(function() h.WalkSpeed=CFG.charSpeed end) end
            end
            notify("Speed ON", CFG.charSpeed.." clone")
        else
            local char=LP.Character
            local clone=char and char:FindFirstChildOfClass("Humanoid")
            local old=nil for _,v in ipairs(getnilinstances and getnilinstances() or {}) do if v.Name=="_OLD_HUMANOID" and v:IsA("Humanoid") then old=v break end end
            if not old then old=Workspace:FindFirstChild("_OLD_HUMANOID") end
            if clone and old and old.Name=="_OLD_HUMANOID" then
                pcall(function() clone:Destroy() old.Name="Humanoid" old.Parent=char Workspace.CurrentCamera.CameraSubject=old old.WalkSpeed=16 old.Health=100 end)
            end
            pcall(function() Workspace:SetAttribute("ClientObbyAntiTp", true) end)
            notify("Speed OFF","")
        end
    end
})
TabChar:Slider({
    Title="Velocidade",
    Min=16, Max=600, Default=600,
    Suffix=" WS",
    Flag="charSpeed",
    Callback=function(v) CFG.charSpeed=v local h=getHum() if h and CFG.charSpeedEnabled then pcall(function() h.WalkSpeed=v end) if typeof(sethiddenproperty)=="function" then pcall(function() sethiddenproperty(h,"WalkSpeed",v) end) end end end
})
TabChar:Toggle({ Title="Inf Jump", Default=false, Flag="infJump", Callback=function(v) setJump(v) notify("Jump", v and "ON" or "OFF") end })

local TabOvos = Window:Tab({ Title="Ovos" })
TabOvos:Section({ Title="Ovos" })
TabOvos:Toggle({ Title="Auto Place", Default=false, Flag="autoPlace", Callback=function(v) CFG.autoPlace=v if v or CFG.autoHatch or CFG.autoSkip then startEggLoop() end notify("Place", v and "ON" or "OFF") end })
TabOvos:Toggle({ Title="Auto Hatch", Default=false, Flag="autoHatch", Callback=function(v) CFG.autoHatch=v if v or CFG.autoPlace or CFG.autoSkip then startEggLoop() end notify("Hatch", v and "ON" or "OFF") end })
TabOvos:Toggle({ Title="Auto Skip Growth", Default=false, Flag="autoSkip", Callback=function(v) CFG.autoSkip=v if v or CFG.autoPlace or CFG.autoHatch then startEggLoop() end notify("Skip", v and "ON" or "OFF") end })
TabOvos:Toggle({ Title="Auto Treadmill", Default=false, Flag="treadmillAuto", Callback=function(v) CFG.treadmillAuto=v if v then startTreadLoop() end notify("Treadmill", v and "ON" or "OFF") end })

local TabOutros = Window:Tab({ Title="Outros" })
TabOutros:Section({ Title="Outros" })
TabOutros:Button({ Title="Rejoin", Callback=function() game:GetService("TeleportService"):Teleport(game.PlaceId, LP) end })
TabOutros:Button({ Title="Salvar Config", Callback=function() Window:SaveConfig("StealAnEgg_Divine") end })
TabOutros:Button({ Title="Carregar Config", Callback=function() Window:LoadConfig("StealAnEgg_Divine") end })
TabOutros:Label({Text="Atalho", Desc="Pressione K para abrir/fechar"})
TabOutros:Keybind({ Title="Tecla Toggle UI", Default=Enum.KeyCode.K, Callback=function() Window:Toggle(not Window.Gui.Enabled) end })
TabOutros:ColorPicker({ Title="Cor Tema", Desc="Muda o tema ao vivo", Default=Color3.fromRGB(175,82,222), Flag="themeColor", Callback=function(c) Window:SetAccent(c) notify("Tema", "Cor atualizada!") end })

STATE.onCleanup(function()
    if clearESP then pcall(clearESP) end
    if farmThread then pcall(function() task.cancel(farmThread) end) end
    if eggThread then pcall(function() task.cancel(eggThread) end) end
    if petsThread then pcall(function() task.cancel(petsThread) end) end
    if treadThread then pcall(function() task.cancel(treadThread) end) end
    if jumpConn then pcall(function() jumpConn:Disconnect() end) end
    if Window and Window.Destroy then pcall(function() Window:Destroy() end) end
end)

notify("DivineUI","Steal An Egg carregado • K toggle")
print("[DivineUI] Steal An Egg • Tabs:", #Window.Tabs, "Version", DivineUI.Version)
