_G.Settings = {

    Main = {
        ["Auto Farm Level"] = true;
        ["Skip Level"] = true;
    },

    Setting = {
        ["Select Team"] = {"Pirate"}, --{Pirate,Marine}
    },
}

_G.Kai = {
	["Check Swords"] = {
		["Enabled Check"] = true,
	},
	["Check Fighting Style"] = {
		["Enabled Check"] = true,
	},
	["Check Awakening Fruits"] = {
		["Enabled Check"] = true,
	},
	["Check Fruits"] = {
		["Enabled Check"] = true,
	},
}





--------------------------------------------------------------------------------------------------------------------------------

-- Place ID
local GameId = game.PlaceId
if GameId == 2753915549 then
	FirstSea = true
elseif GameId == 4442272183 then
	SecondSea = true
elseif GameId == 7449423635 then
	ThirdSea = true
else
	game.Players.LocalPlayer:Kick("Game No Support!")
end

-- Join Team
repeat wait()
	if game.Players.LocalPlayer.Team == nil and game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Visible == true then
		if _G.Settings.Setting["Select Team"] == "Pirate" then
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		elseif _G.Settings.Setting["Select Team"] == "Marine" then
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		else
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Size = UDim2.new(0, 10000, 0, 10000)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Position = UDim2.new(-4, 0, -5, 0)
			game:GetService("Players")["LocalPlayer"].PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.BackgroundTransparency = 1
			wait(.5)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, true, game, 1)
			game:service'VirtualInputManager':SendMouseButtonEvent(500,500, 0, false, game, 1)
		end
	end     
until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded() 

wait(1)

-- Anti AFK

game:GetService("Players").LocalPlayer.Idled:connect(function()
	game:GetService("VirtualUser"):Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
	wait(1)
	game:GetService("VirtualUser"):Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)

-- Equip Weapon
function EquipWeapon(Tool)
	pcall(function()
		if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then 
			local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) 
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
		end
	end)
end

function EquipWeaponSword()
	pcall(function()
		for i,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
			if v.ToolTip == "Sword" and v:IsA('Tool') then
				local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(v.Name) 
				game.Players.LocalPlayer.Character.Humanoid:EquipTool(ToolHumanoid) 
			end
		end
	end)
end

task.spawn(function()
	game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
			if _G.Settings.Main["Auto Farm Level"] or 
			_G.Settings.Main["Mob Aura"] then
				if game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
					game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)
					if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit == true then
						game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Sit = false
					end
					local BodyVelocity = Instance.new("BodyVelocity")
					BodyVelocity.Name = "BodyVelocity1"
					BodyVelocity.Parent =  game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
					BodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
					BodyVelocity.Velocity = Vector3.new(0, 0, 0)
					end
				for _, v in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			else
				if game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1") then
					game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyVelocity1"):Destroy();
				end
			end
		end)
	end)
end)

-- Bring Mob

task.spawn(function()
	while true do wait()
		if setscriptable then
			setscriptable(game.Players.LocalPlayer, "SimulationRadius", true)
		end
		if sethiddenproperty then
			sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
		end
	end
end)

task.spawn(function()
	while task.wait() do
		pcall(function()
			if StartMagnet then
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if not string.find(v.Name,"Boss") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 500 then
						if InMyNetWork(v.HumanoidRootPart) then
							v.HumanoidRootPart.CFrame = PosMon
							v.Humanoid.JumpPower = 0
							v.Humanoid.WalkSpeed = 0
							v.HumanoidRootPart.Size = Vector3.new(5,5,5)
							v.HumanoidRootPart.Transparency = 1
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							if v.Humanoid:FindFirstChild("Animator") then
								v.Humanoid.Animator:Destroy()
							end
							v.Humanoid:ChangeState(11)
							v.Humanoid:ChangeState(14)
						end
					end
				end
			end
		end)
	end
end)

-- No Stun

task.spawn(function()
	if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
		game.Players.LocalPlayer.Character.Stun.Changed:connect(function()
			pcall(function()
				if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
					game.Players.LocalPlayer.Character.Stun.Value = 0
				end
			end)
		end)
	end
end)

-- Deleted Effect Auto

task.spawn(function()
	while wait() do
		for i,v in pairs(game:GetService("Workspace")["_WorldOrigin"]:GetChildren()) do
			pcall(function()
				if v.Name == ("CurvedRing") or v.Name == ("SlashHit") or v.Name == ("SwordSlash") or v.Name == ("SlashTail") or v.Name == ("Sounds") then
					v:Destroy()
				end
			end)
		end
	end
end)

-- Require Module

local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework"))
local CombatFrameworkR = getupvalues(CombatFramework)[2]
local RigController = require(game:GetService("Players")["LocalPlayer"].PlayerScripts.CombatFramework.RigController)
local RigControllerR = getupvalues(RigController)[2]
local realbhit = require(game.ReplicatedStorage.CombatFramework.RigLib)
local cooldownfastattack = tick()


-- Camera Shaker
function CameraShaker()
	task.spawn(function()
		local Camera = require(game.Players.LocalPlayer.PlayerScripts.CombatFramework.CameraShaker)
		while wait() do
			pcall(function()
				if _G.Settings.Setting["Camera Shaker"] then
					Camera.CameraShakeInstance.CameraShakeState.Inactive = 0
				else
					Camera.CameraShakeInstance.CameraShakeState.Inactive = 3
				end
			end)
		end
	end)
end

-- Fast Attack

function CurrentWeapon()
	local ac = CombatFrameworkR.activeController
	local ret = ac.blades[1]
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	pcall(function()
		while ret.Parent~=game.Players.LocalPlayer.Character do ret=ret.Parent end
	end)
	if not ret then return game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name end
	return ret
end

function getAllBladeHitsPlayers(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Characters = game:GetService("Workspace").Characters:GetChildren()
	for i=1,#Characters do local v = Characters[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if v.Name ~= game.Players.LocalPlayer.Name and Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end

function getAllBladeHits(Sizes)
	local Hits = {}
	local Client = game.Players.LocalPlayer
	local Enemies = game:GetService("Workspace").Enemies:GetChildren()
	for i=1,#Enemies do local v = Enemies[i]
		local Human = v:FindFirstChildOfClass("Humanoid")
		if Human and Human.RootPart and Human.Health > 0 and Client:DistanceFromCharacter(Human.RootPart.Position) < Sizes+5 then
			table.insert(Hits,Human.RootPart)
		end
	end
	return Hits
end

function AttackFunction()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHits(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
					game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
				end
			end
		end
	end
end

function AttackPlayers()
	local ac = CombatFrameworkR.activeController
	if ac and ac.equipped then
		for indexincrement = 1, 1 do
			local bladehit = getAllBladeHitsPlayers(60)
			if #bladehit > 0 then
				local AcAttack8 = debug.getupvalue(ac.attack, 5)
				local AcAttack9 = debug.getupvalue(ac.attack, 6)
				local AcAttack7 = debug.getupvalue(ac.attack, 4)
				local AcAttack10 = debug.getupvalue(ac.attack, 7)
				local NumberAc12 = (AcAttack8 * 798405 + AcAttack7 * 727595) % AcAttack9
				local NumberAc13 = AcAttack7 * 798405
				(function()
					NumberAc12 = (NumberAc12 * AcAttack9 + NumberAc13) % 1099511627776
					AcAttack8 = math.floor(NumberAc12 / AcAttack9)
					AcAttack7 = NumberAc12 - AcAttack8 * AcAttack9
				end)()
				AcAttack10 = AcAttack10 + 1
				debug.setupvalue(ac.attack, 5, AcAttack8)
				debug.setupvalue(ac.attack, 6, AcAttack9)
				debug.setupvalue(ac.attack, 4, AcAttack7)
				debug.setupvalue(ac.attack, 7, AcAttack10)
				for k, v in pairs(ac.animator.anims.basic) do
					v:Play(0.01,0.01,0.01)
				end
				if game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") and ac.blades and ac.blades[1] then 
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurrentWeapon()))
					game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(NumberAc12 / 1099511627776 * 16777215), AcAttack10)
					game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, 2, "")
					game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
				end
			end
		end
	end
end

-- Hop Sever
function Hop()
	local PlaceID = game.PlaceId
	local AllIDs = {}
	local foundAnything = ""
	local actualHour = os.date("!*t").hour
	local Deleted = false
	function TPReturner()
		local Site;
		if foundAnything == "" then
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
		else
			Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
		end
		local ID = ""
		if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
			foundAnything = Site.nextPageCursor
		end
		local num = 0;
		for i,v in pairs(Site.data) do
			local Possible = true
			ID = tostring(v.id)
			if tonumber(v.maxPlayers) > tonumber(v.playing) then
				for _,Existing in pairs(AllIDs) do
					if num ~= 0 then
						if ID == tostring(Existing) then
							Possible = false
						end
					else
						if tonumber(actualHour) ~= tonumber(Existing) then
							local delFile = pcall(function()
								AllIDs = {}
								table.insert(AllIDs, actualHour)
							end)
						end
					end
					num = num + 1
				end
				if Possible == true then
					table.insert(AllIDs, ID)
					wait()
					pcall(function()
						wait()
						game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
					end)
					wait(4)
				end
			end
		end
	end
	function Teleport() 
		while wait() do
			pcall(function()
				TPReturner()
				if foundAnything ~= "" then
					TPReturner()
				end
			end)
		end
	end
	Teleport()
end

-- Anti Kick
local gt = getrawmetatable(game)
local old = gt.__namecall
	setreadonly(gt, false)
	gt.__namecall = newcclosure(function(self, ...)
	local method = getnamecallmethod()
		if method == "Kick" or method == "kick" then
    		print(...)
			wait(9e9)
			return
		end
	return old(self,...)
end)

-- Anti Cheat

spawn(function()
    CheckAntiCheatBypass()
    setfflag("AbuseReportScreenshot", "False")
    setfflag("AbuseReportScreenshotPercentage", "0")
end)

function CheckAntiCheatBypass()
    for i,v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "General" or v.Name == "Shiftlock"  or v.Name == "FallDamage" or v.Name == "4444" or v.Name == "CamBob" or v.Name == "JumpCD" or v.Name == "Looking" or v.Name == "Run" then
                v:Destroy()
            end
        end
    end
    for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerScripts:GetDescendants()) do
        if v:IsA("LocalScript") then
            if v.Name == "RobloxMotor6DBugFix" or v.Name == "Clans"  or v.Name == "Codes" or v.Name == "CustomForceField" or v.Name == "MenuBloodSp"  or v.Name == "PlayerList" then
                v:Destroy()
            end
        end
    end
end

-- Isnetwork Owner

function InMyNetWork(object)
	if isnetworkowner then
		return isnetworkowner(object)
	else
		if (object.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 200 then 
			return true
		end
		return false
	end
end

-- Abandoned Quest

function Com(com,...)
	local Remote = game:GetService('ReplicatedStorage').Remotes:FindFirstChild("Comm"..com)
	if Remote:IsA("RemoteEvent") then
		Remote:FireServer(...)
	elseif Remote:IsA("RemoteFunction") then
		Remote:InvokeServer(...)
	end
end

-- Tween Functions

local function GetIsLand(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = targetPos
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos.Position
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
		RealTarget = RealTarget.p
	end

	local ReturnValue
	local CheckInOut = math.huge;
	if game.Players.LocalPlayer.Team then
		for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(game.Players.LocalPlayer.Team)):GetChildren()) do 
			local ReMagnitude = (RealTarget - v:GetModelCFrame().p).Magnitude;
			if ReMagnitude < CheckInOut then
				CheckInOut = ReMagnitude;
				ReturnValue = v.Name
			end
		end
		if ReturnValue then
			return ReturnValue
		end 
	end
end

--BTP

function BTP(Position)
	game.Players.LocalPlayer.Character.Head:Destroy()
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	wait(1)
	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Position
	game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
end

-- Tween Functions (toTarget)

local function toTarget(...)
	local RealtargetPos = {...}
	local targetPos = RealtargetPos[1]
	local RealTarget
	if type(targetPos) == "vector" then
		RealTarget = CFrame.new(targetPos)
	elseif type(targetPos) == "userdata" then
		RealTarget = targetPos
	elseif type(targetPos) == "number" then
		RealTarget = CFrame.new(unpack(RealtargetPos))
	end

	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health == 0 then if tween then tween:Cancel() end repeat wait() until game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health > 0; wait(0.2) end

	local tweenfunc = {}
	local Distance = (RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude
	if Distance < 1000 then
		Speed = 350
	elseif Distance >= 1000 then
		Speed = 370
	end
	if _G.Settings.Setting["Bypass TP"] then
		if Distance > 3000 and not _G.Settings.Main["Auto Holy Torch"] and not _G.Settings.Main["Auto Saber"] and not AutoFarmMaterial and not _G.Settings.FightingStyle["Auto God Human"] and not _G.Settings.Raids["Auto Raids"] and not (game.Players.LocalPlayer.Backpack:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Character:FindFirstChild("Special Microchip") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Hallow Essence") or game.Players.LocalPlayer.Character:FindFirstChild("Sweet Chalice") or game.Players.LocalPlayer.Backpack:FindFirstChild("Sweet Chalice")) then
			pcall(function()
				tween:Cancel()
				fkwarp = false
				if game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("SpawnPoint").Value == tostring(GetIsLand(RealTarget)) then 
					wait(0.01)
					Com("F_","TeleportToSpawn")
				elseif game:GetService("Players")["LocalPlayer"].Data:FindFirstChild("LastSpawnPoint").Value == tostring(GetIsLand(RealTarget)) then
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					wait(0.01)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
				else
					if game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 then
						if fkwarp == false then
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = RealTarget
						end
						fkwarp = true
					end
					wait(0.01)
					game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
					repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0
					wait(0.01)
					Com("F_","SetSpawnPoint")
				end
				wait(0.2)
				return
			end)
		end
	end

	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((RealTarget.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).Magnitude/Speed, Enum.EasingStyle.Linear)
	local tweenw, err = pcall(function()
		tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = RealTarget})
		tween:Play()
	end)

	function tweenfunc:Stop()
		tween:Cancel()
	end 

	function tweenfunc:Wait()
		tween.Completed:Wait()
	end 

	return tweenfunc
end

function toTargetP(CFgo)
	if game.Players.LocalPlayer.Character:WaitForChild("Humanoid").Health <= 0 or not game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") then tween:Cancel() repeat wait() until game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid") and game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").Health > 0 wait(7) return end
	if (game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude <= 150 then
		pcall(function()
			tween:Cancel()

			game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.CFrame = CFgo

			return
		end)
	end
	local tween_s = game:service"TweenService"
	local info = TweenInfo.new((game:GetService("Players")["LocalPlayer"].Character.HumanoidRootPart.Position - CFgo.Position).Magnitude/325, Enum.EasingStyle.Linear)
	tween = tween_s:Create(game.Players.LocalPlayer.Character["HumanoidRootPart"], info, {CFrame = CFgo})
	tween:Play()

	local tweenfunc = {}

	function tweenfunc:Stop()
		tween:Cancel()
	end

	return tweenfunc
end

-- Get Players Character

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function r15(plr)
	if plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15 then
		return true
	end
end

-- Functions Click

function ClickCamera()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):ClickButton1(Vector2.new(851, 158), game:GetService("Workspace").Camera.CFrame)
end
function Click()
	game:GetService("VirtualUser"):CaptureController()
	game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
end

-- Remove Text Fruits

function RemoveFruit(str)
	return str:gsub(" Fruit", "")
end

-- Comma Value

function comma_value(p1)
	local v1 = p1;
	while true do
		local v2, v3 = string.gsub(v1, "^(-?%d+)(%d%d%d)", "%1,%2");
		v1 = v2;
		if v3 ~= 0 then else
			break;
		end;	
	end;
	return v1;
end;

-- Check Fruit 1M


_G.CheckFruitLocal1M = false
function CheckFruit1M()
	for i,v in pairs(game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("getInventoryFruits")) do
		if v.Price >= 1000000 then 
			_G.CheckFruitLocal1M = true
		end
	end
end

-- Get FightingStyle

function GetFightingStyle(Style)
	ReturnText = ""
	for i ,v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	for i ,v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
		if v:IsA("Tool") then
			if v.ToolTip == Style then
				ReturnText = v.Name
			end
		end
	end
	if ReturnText ~= "" then
		return ReturnText
	else
		return "Not Have"
	end
end

-- CheckMasteryWeapon

function CheckMasteryWeapon(NameWe,MasNum)
	if game.Players.LocalPlayer.Backpack:FindFirstChild(NameWe) then
		if tonumber(game.Players.LocalPlayer.Backpack:FindFirstChild(NameWe).Level.Value) < tonumber(MasNum) then
			return "true DownTo"
		elseif tonumber(game.Players.LocalPlayer.Backpack:FindFirstChild(NameWe).Level.Value) >= tonumber(MasNum) then
			return "true UpTo"
		end
	end
	if game.Players.LocalPlayer.Character:FindFirstChild(NameWe) then
		if tonumber(game.Players.LocalPlayer.Character:FindFirstChild(NameWe).Level.Value) < tonumber(MasNum) then
			return "true DownTo"
		elseif tonumber(game.Players.LocalPlayer.Character:FindFirstChild(NameWe).Level.Value) >= tonumber(MasNum) then
			return "true UpTo"
		end
	end
	return "else"
end

--GetWeaponInventory

function GetWeaponInventory(Weaponname)
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v) == "table" then
			if v.Type == "Sword" then
				if v.Name == Weaponname then
					return true
				end
			end
		end
	end
	return false
end

-- GetMaterial

function GetMaterial(matname)
	for i,v in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
		if type(v) == "table" then
			if v.Type == "Material" then
				if v.Name == matname then
					return v.Count
				end
			end
		end
	end
	return 0
end

local AllMaterial
if FirstSea then
	AllMaterial = {
		"Magma Ore",
		"Leather",
		"Scrap Metal",
		"Angel Wings",
		"Fish Tail"
	}
elseif SecondSea then
	AllMaterial = {
		"Magma Ore",
		"Scrap Metal",
		"Radioactive Material",
		"Vampire Fang",
		"Mystic Droplet",
	}
elseif ThirdSea then
	AllMaterial = {
		"Mini Tusk",
		"Fish Tail",
		"Scrap Metal",
		"Dragon Scale",
		"Conjured Cocoa",
		"Demonic Wisp",
		"Gunpowder",
	}
end

table.sort(AllMaterial)

-- CustomFindFirstChild

local function CustomFindFirstChild(tablename)
	for i,v in pairs(tablename) do
		if game:GetService("Workspace").Enemies:FindFirstChild(v) then
			return true
		end
	end
	return false
end

-- IsNumber

function isNumber(str)
	if tonumber(str) ~= nil or str == 'inf' then
		return true
	end
end

-- CheckMaterial

local function CheckMaterial(v1)
	if FirstSea then 
		if (v1=="Magma Ore") then 
			MaterialMob={"Military Soldier [Lv. 300]","Military Spy [Lv. 325]"};
			CFrameMon=CFrame.new( -5815,84,8820);
		elseif ((v1=="Leather") or (v1=="Scrap Metal")) then 
			MaterialMob={"Brute [Lv. 45]"};
			CFrameMon=CFrame.new( -1145,15,4350);
		elseif (v1=="Angel Wings") then 
			MaterialMob={"God's Guard [Lv. 450]"};
			CFrameMon=CFrame.new( -4698,845, -1912);
		elseif (v1=="Fish Tail") then 
			MaterialMob={"Fishman Warrior [Lv. 375]","Fishman Commando [Lv. 400]"};
			CFrameMon=CFrame.new(61123,19,1569);
		end 
	end 
	if SecondSea then 
		if (v1=="Magma Ore") then 
			MaterialMob={"Magma Ninja [Lv. 1175]"};
			CFrameMon=CFrame.new( -5428,78, -5959);
		elseif (v1=="Scrap Metal") then
			MaterialMob={"Swan Pirate [Lv. 775]"};
			CFrameMon=CFrame.new(878,122,1235);
		elseif (v1=="Radioactive Material") then 
			MaterialMob={"Factory Staff [Lv. 800]"};
			CFrameMon=CFrame.new(295,73, -56);
		elseif (v1=="Vampire Fang") then 
			MaterialMob={"Vampire [Lv. 975]"};
			CFrameMon=CFrame.new( -6033,7, -1317);
		elseif (v1=="Mystic Droplet") then 
			MaterialMob={"Water Fighter [Lv. 1450]","Sea Soldier [Lv. 1425]"};
			CFrameMon=CFrame.new( -3385,239, -10542);
		end 
	end 
	if ThirdSea then 
		if (v1=="Mini Tusk") then 
			MaterialMob={"Mythological Pirate [Lv. 1850]"};
			CFrameMon=CFrame.new( -13545,470, -6917);
		elseif (v1=="Fish Tail") then 
			MaterialMob={"Fishman Raider [Lv. 1775]","Fishman Captain [Lv. 1800]"};
			CFrameMon=CFrame.new( -10993,332, -8940);
		elseif (v1=="Scrap Metal") then 
			MaterialMob={"Jungle Pirate [Lv. 1900]"};
			CFrameMon=CFrame.new( -12107,332, -10549);
		elseif (v1=="Dragon Scale") then 
			MaterialMob={"Dragon Crew Archer [Lv. 1600]","Dragon Crew Warrior [Lv. 1575]"};
			CFrameMon=CFrame.new(6594,383,139);
		elseif (v1=="Conjured Cocoa") then 
			MaterialMob={"Cocoa Warrior [Lv. 2300]","Chocolate Bar Battler [Lv. 2325]","Sweet Thief [Lv. 2350]","Candy Rebel [Lv. 2375]"};
			CFrameMon=CFrame.new(620.6344604492188,78.93644714355469, -12581.369140625);
		elseif (v1=="Demonic Wisp") then MaterialMob={"Demonic Soul [Lv. 2025]"};
			CFrameMon=CFrame.new( -9507,172,6158);
		elseif (v1=="Gunpowder") then MaterialMob={"Pistol Billionaire [Lv. 1525]"};
			CFrameMon=CFrame.new( -469,74,5904);
		end 
	end 
end

-- Check Quest

function CheckQuest()
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value
	if FirstSea then
		if MyLevel == 1 or MyLevel <= 9 then -- Bandit
			LevelFarm = 1

			Name = "Bandit [Lv. 5]"
			QuestName = "BanditQuest1"

			LevelQuest = 1
			NameMon = "Bandit"

			CFrameMon = CFrame.new(1145, 17, 1634)
			VectorMon = Vector3.new(1145, 17, 1634)

			CFrameQuest = CFrame.new(1060, 17, 1547)
			VectorQuest = Vector3.new(1060, 17, 1547)
		elseif MyLevel == 10 or MyLevel <= 14 then -- Monkey
			LevelFarm = 2

			Name = "Monkey [Lv. 14]"
			QuestName = "JungleQuest"

			LevelQuest = 1
			NameMon = "Monkey"

			CFrameMon = CFrame.new(-1496, 39, 35)
			VectorMon = Vector3.new(-1496, 39, 35)

			CFrameQuest = CFrame.new(-1602, 37, 152)
			VectorQuest = Vector3.new(-1602, 37, 152)
		elseif MyLevel == 15 or MyLevel <= 29 then -- Gorilla
			LevelFarm = 3

			Name = "Gorilla [Lv. 20]"
			QuestName = "JungleQuest"

			LevelQuest = 2
			NameMon = "Gorilla"

			CFrameMon = CFrame.new(-1237, 6, -486)
			VectorMon = Vector3.new(-1237, 7, -486)

			CFrameQuest = CFrame.new(-1602, 37, 152)
			VectorQuest = Vector3.new(-1602, 37, 152)
		elseif MyLevel == 30 or MyLevel <= 39 then -- Pirate
			LevelFarm = 4

			Name = "Pirate [Lv. 35]"
			QuestName = "BuggyQuest1"

			LevelQuest = 1
			NameMon = "Pirate"

			CFrameMon = CFrame.new(-1115, 14, 3938)
			VectorMon = Vector3.new(-1115, 14, 3938)

			CFrameQuest = CFrame.new(-1140, 5, 3828)
			VectorQuest = Vector3.new(-1140, 5, 3828)
		elseif MyLevel == 40 or MyLevel <= 59 then -- Brute
			LevelFarm = 5

			Name = "Brute [Lv. 45]"
			QuestName = "BuggyQuest1"

			LevelQuest = 2
			NameMon = "Brute"

			CFrameMon = CFrame.new(-1145, 15, 4350)
			VectorMon = Vector3.new(-1146, 15, 4350)

			CFrameQuest = CFrame.new(-1140, 5, 3828)
			VectorQuest = Vector3.new(-1140, 5, 3828)
		elseif MyLevel == 60 or MyLevel <= 74 then -- Desert Bandit
			LevelFarm = 6

			Name = "Desert Bandit [Lv. 60]"
			QuestName = "DesertQuest"

			LevelQuest = 1
			NameMon = "Desert Bandit"

			CFrameMon = CFrame.new(932, 7, 4484)
			VectorMon = Vector3.new(932, 7, 4484)

			CFrameQuest = CFrame.new(897, 7, 4388)
			VectorQuest = Vector3.new(897, 7, 4388)
		elseif MyLevel == 75 or MyLevel <= 89 then -- Desert Officre
			LevelFarm = 7

			Name = "Desert Officer [Lv. 70]"
			QuestName = "DesertQuest"

			LevelQuest = 2
			NameMon = "Desert Officer"

			CFrameMon = CFrame.new(1572, 10, 4373)
			VectorMon = Vector3.new(1572, 10, 4373)

			CFrameQuest = CFrame.new(897, 7, 4388)
			VectorQuest = Vector3.new(897, 7, 4388)
		elseif MyLevel == 90 or MyLevel <= 99 then -- Snow Bandits
			LevelFarm = 8

			Name = "Snow Bandit [Lv. 90]"
			QuestName = "SnowQuest"

			LevelQuest = 1
			NameMon = "Snow Bandits"

			CFrameMon = CFrame.new(1289, 150, -1442)
			VectorMon = Vector3.new(1289, 106, -1442)

			CFrameQuest = CFrame.new(1386, 87, -1297)
			VectorQuest = Vector3.new(1386, 87, -1297)
		elseif MyLevel == 100 or MyLevel <= 119 then -- Snowman
			LevelFarm = 9

			Name = "Snowman [Lv. 100]"
			QuestName = "SnowQuest"

			LevelQuest = 2
			NameMon = "Snowman"

			CFrameMon = CFrame.new(1289, 150, -1442)
			VectorMon = Vector3.new(1289, 106, -1442)

			CFrameQuest = CFrame.new(1386, 87, -1297)
			VectorQuest = Vector3.new(1386, 87, -1297)
		elseif MyLevel == 120 or MyLevel <= 149 then -- Chief Petty Officer
			LevelFarm = 10

			Name = "Chief Petty Officer [Lv. 120]"
			QuestName = "MarineQuest2"

			LevelQuest = 1
			NameMon = "Chief Petty Officer"

			CFrameMon = CFrame.new(-4855, 23, 4308)
			VectorMon = Vector3.new(-4855, 23, 4308)

			CFrameQuest = CFrame.new(-5036, 29, 4325)
			VectorQuest = Vector3.new(-5036, 29, 4325)
		elseif MyLevel == 150 or MyLevel <= 174 then -- Sky Bandit
			LevelFarm = 11

			Name = "Sky Bandit [Lv. 150]"
			QuestName = "SkyQuest"

			LevelQuest = 1
			NameMon = "Sky Bandit"

			CFrameMon = CFrame.new(-4981, 278, -2830)
			VectorMon = Vector3.new(-4981, 278, -2830)

			CFrameQuest = CFrame.new(-4842, 718, -2623)
			VectorQuest = Vector3.new(-4842, 718, -2623)
		elseif MyLevel == 175 or MyLevel <= 189 then -- Dark Master
			LevelFarm = 12

			Name = "Dark Master [Lv. 175]"
			QuestName = "SkyQuest"

			LevelQuest = 2
			NameMon = "Dark Master"

			CFrameMon = CFrame.new(-5250, 389, -2272)
			VectorMon = Vector3.new(-5250, 389, -2272)

			CFrameQuest = CFrame.new(-4842, 718, -2623)
			VectorQuest = Vector3.new(-4842, 718, -2623)
		elseif MyLevel == 190 or MyLevel <= 209 then -- Dark Master
			LevelFarm = 13

			Name = "Prisoner [Lv. 190]"
			QuestName = "PrisonerQuest"

			LevelQuest = 1
			NameMon = "Prisoner"

			CFrameMon = CFrame.new(5411, 96, 690)
			VectorMon = Vector3.new(5411, 96, 690)

			CFrameQuest = CFrame.new(5308, 2, 474)
			VectorQuest = Vector3.new(5308, 2, 474)
		elseif MyLevel == 210 or MyLevel <= 249 then -- Dark Master
			LevelFarm = 14

			Name = "Dangerous Prisoner [Lv. 210]"
			QuestName = "PrisonerQuest"

			LevelQuest = 2
			NameMon = "Dangerous Prisoner"

			CFrameMon = CFrame.new(5411, 96, 690)
			VectorMon = Vector3.new(5411, 96, 690)

			CFrameQuest = CFrame.new(5308, 2, 474)
			VectorQuest = Vector3.new(5308, 2, 474)
		elseif MyLevel == 250 or MyLevel <= 299 then -- Toga Warrior
			LevelFarm = 15

			Name = "Toga Warrior [Lv. 250]"
			QuestName = "ColosseumQuest"

			LevelQuest = 1
			NameMon = "Toga Warrior"

			CFrameMon = CFrame.new(-1824, 50, -2743)
			VectorMon = Vector3.new(-1824, 50, -2743)

			CFrameQuest = CFrame.new(-1576, 8, -2985)
			VectorQuest = Vector3.new(-1576, 8, -2985)
		elseif MyLevel == 300 or MyLevel <= 324 then -- Military Soldier
			LevelFarm = 16

			Name = "Military Soldier [Lv. 300]"
			QuestName = "MagmaQuest"

			LevelQuest = 1
			NameMon = "Military Soldier"

			CFrameMon = CFrame.new(-5408, 11, 8447)
			VectorMon = Vector3.new(-5408, 11, 8447)

			CFrameQuest = CFrame.new(-5316, 12, 8517)
			VectorQuest = Vector3.new(-5316, 12, 8517)
		elseif MyLevel == 325 or MyLevel <= 374 then -- Military Spy
			LevelFarm = 17

			Name = "Military Spy [Lv. 325]"
			QuestName = "MagmaQuest"

			LevelQuest = 2
			NameMon = "Military Spy"

			CFrameMon = CFrame.new(-5815, 84, 8820)
			VectorMon = Vector3.new(-5815, 84, 8820)

			CFrameQuest = CFrame.new(-5316, 12, 8517)
			VectorQuest = Vector3.new(-5316, 12, 8517)
		elseif MyLevel == 375 or MyLevel <= 399 then -- Fishman Warrior
			LevelFarm = 18

			Name = "Fishman Warrior [Lv. 375]"
			QuestName = "FishmanQuest"

			LevelQuest = 1
			NameMon = "Fishman Warrior"

			CFrameMon = CFrame.new(60859, 19, 1501)
			VectorMon = Vector3.new(60859, 19, 1501)

			CFrameQuest = CFrame.new(61123, 19, 1569)
			VectorQuest = Vector3.new(61123, 19, 1569)
		elseif MyLevel == 400 or MyLevel <= 449 then -- Fishman Commando
			LevelFarm = 19

			Name = "Fishman Commando [Lv. 400]"
			QuestName = "FishmanQuest"

			LevelQuest = 2
			NameMon = "Fishman Commando"

			CFrameMon = CFrame.new(61891, 19, 1470)
			VectorMon = Vector3.new(61891, 19, 1470)

			CFrameQuest = CFrame.new(61123, 19, 1569)
			VectorQuest = Vector3.new(61123, 19, 1569)
		elseif MyLevel == 450 or MyLevel <= 474 then -- God's Guards
			LevelFarm = 20

			Name = "God's Guard [Lv. 450]"
			QuestName = "SkyExp1Quest"

			LevelQuest = 1
			NameMon = "God's Guards"

			CFrameMon = CFrame.new(-4698, 845, -1912)
			VectorMon = Vector3.new(-4698, 845, -1912)

			CFrameQuest = CFrame.new(-4722, 845, -1954)
			VectorQuest = Vector3.new(-4722, 846, -1954)
		elseif MyLevel == 475 or MyLevel <= 524 then -- Shandas
			LevelFarm = 21

			Name = "Shanda [Lv. 475]"
			QuestName = "SkyExp1Quest"

			LevelQuest = 2
			NameMon = "Shandas"

			CFrameMon = CFrame.new(-7685, 5567, -502)
			VectorMon = Vector3.new(-7685, 5567, -502)

			CFrameQuest = CFrame.new(-7862, 5546, -380)
			VectorQuest = Vector3.new(-7862, 5546, -380)
		elseif MyLevel == 525 or MyLevel <= 549 then -- Royal Squad
			LevelFarm = 22

			Name = "Royal Squad [Lv. 525]"
			QuestName = "SkyExp2Quest"

			LevelQuest = 1
			NameMon = "Royal Squad"

			CFrameMon = CFrame.new(-7670, 5607, -1460)
			VectorMon = Vector3.new(-7670, 5607, -1460)

			CFrameQuest = CFrame.new(-7904, 5636, -1412)
			VectorQuest = Vector3.new(-7904, 5636, -1412)
		elseif MyLevel == 550 or MyLevel <= 624 then -- Royal Soldier
			LevelFarm = 23

			Name = "Royal Soldier [Lv. 550]"
			QuestName = "SkyExp2Quest"

			LevelQuest = 2
			NameMon = "Royal Soldier"

			CFrameMon = CFrame.new(-7828, 5607, -1744)
			VectorMon = Vector3.new(-7828, 5607, -1744)

			CFrameQuest = CFrame.new(-7904, 5636, -1412)
			VectorQuest = Vector3.new(-7904, 5636, -1412)
		elseif MyLevel == 625 or MyLevel <= 649 then -- Galley Pirate
			LevelFarm = 24

			Name = "Galley Pirate [Lv. 625]"
			QuestName = "FountainQuest"

			LevelQuest = 1
			NameMon = "Galley Pirate"

			CFrameMon = CFrame.new(5589, 45, 3996)
			VectorMon = Vector3.new(5589, 45, 3996)

			CFrameQuest = CFrame.new(5256, 39, 4050)
			VectorQuest = Vector3.new(5256, 39, 4050)
		elseif MyLevel >= 650 then -- Galley Captain
			LevelFarm = 25

			Name = "Galley Captain [Lv. 650]"
			QuestName = "FountainQuest"

			LevelQuest = 2
			NameMon = "Galley Captain"

			CFrameMon = CFrame.new(5649, 39, 4936)
			VectorMon = Vector3.new(5649, 39, 4936)

			CFrameQuest = CFrame.new(5256, 39, 4050)
			VectorQuest = Vector3.new(5256, 39, 4050)
		end
	end
	if SecondSea then
		if MyLevel == 700 or MyLevel <= 724 then -- Raider [Lv. 700]
			LevelFarm = 1

			Name = "Raider [Lv. 700]"
			QuestName = "Area1Quest"

			LevelQuest = 1
			NameMon = "Raider"

			CFrameQuest = CFrame.new(-425, 73, 1837)
			VectorQuest = Vector3.new(-425, 73, 1837)

			CFrameMon = CFrame.new(-746, 39, 2390)
			VectorMon = Vector3.new(-746, 39, 2389)
		elseif MyLevel == 725 or MyLevel <= 774 then -- Mercenary [Lv. 725]
			LevelFarm = 2

			Name = "Mercenary [Lv. 725]"
			QuestName = "Area1Quest"

			LevelQuest = 2
			NameMon = "Mercenary"

			CFrameQuest = CFrame.new(-425, 73, 1837)
			VectorQuest = Vector3.new(-425, 73, 1837)

			CFrameMon = CFrame.new(-874, 141, 1312)
			VectorMon = Vector3.new(-874, 141, 1312)
		elseif MyLevel == 775 or MyLevel <= 799 then -- Swan Pirate [Lv. 775]
			LevelFarm = 3

			Name = "Swan Pirate [Lv. 775]"
			QuestName = "Area2Quest"

			LevelQuest = 1
			NameMon = "Swan Pirate"

			CFrameQuest = CFrame.new(634, 73, 918)
			VectorQuest = Vector3.new(634, 73, 918)

			CFrameMon = CFrame.new(878, 122, 1235)
			VectorMon = Vector3.new(878, 122, 1235)
		elseif MyLevel == 800 or MyLevel <= 874 then -- Factory Staff [Lv. 800]
			LevelFarm = 4

			Name = "Factory Staff [Lv. 800]"
			QuestName = "Area2Quest"

			LevelQuest = 2
			NameMon = "Factory Staff"

			CFrameQuest = CFrame.new(634, 73, 918)
			VectorQuest = Vector3.new(634, 73, 918)

			CFrameMon = CFrame.new(295, 73, -56)
			VectorMon = Vector3.new(295, 73, -56)
		elseif MyLevel == 875 or MyLevel <= 899 then -- Marine Lieutenant [Lv. 875]
			LevelFarm = 5

			Name = "Marine Lieutenant [Lv. 875]"
			QuestName = "MarineQuest3"

			LevelQuest = 1
			NameMon = "Marine Lieutenant"

			CFrameMon = CFrame.new(-2806, 73, -3038)
			VectorMon = Vector3.new(-2806, 73, -3038)

			CFrameQuest = CFrame.new(-2443, 73, -3219)
			VectorQuest = Vector3.new(-2443, 73, -3219)
		elseif MyLevel == 900 or MyLevel <= 949 then -- Marine Captain [Lv. 900]
			LevelFarm = 6

			Name = "Marine Captain [Lv. 900]"
			QuestName = "MarineQuest3"

			LevelQuest = 2
			NameMon = "Marine Captain"

			CFrameMon = CFrame.new(-1869, 73, -3320)
			VectorMon = Vector3.new(-1869, 73, -3320)

			CFrameQuest = CFrame.new(-2443, 73, -3219)
			VectorQuest = Vector3.new(-2443, 73, -3219)
		elseif MyLevel == 950 or MyLevel <= 974 then -- Zombie [Lv. 950]
			LevelFarm = 7

			Name = "Zombie [Lv. 950]"
			QuestName = "ZombieQuest"

			LevelQuest = 1
			NameMon = "Zombie"

			CFrameMon = CFrame.new(-5736, 126, -728)
			VectorMon = Vector3.new(-5736, 126, -728)

			CFrameQuest = CFrame.new(-5494, 49, -795)
			VectorQuest = Vector3.new(-5494, 49, -794)
		elseif MyLevel == 975 or MyLevel <= 999 then -- Vampire [Lv. 975]
			LevelFarm = 8

			Name = "Vampire [Lv. 975]"
			QuestName = "ZombieQuest"

			LevelQuest = 2
			NameMon = "Vampire"

			CFrameMon = CFrame.new(-6033, 7, -1317)
			VectorMon = Vector3.new(-6033, 7, -1317)

			CFrameQuest = CFrame.new(-5494, 49, -795)
			VectorQuest = Vector3.new(-5494, 49, -795)
		elseif MyLevel == 1000 or MyLevel <= 1049 then -- Snow Trooper [Lv. 1000] **
			LevelFarm = 9

			Name = "Snow Trooper [Lv. 1000]"
			QuestName = "SnowMountainQuest"

			LevelQuest = 1
			NameMon = "Snow Trooper"

			CFrameMon = CFrame.new(478, 402, -5362)
			VectorMon = Vector3.new(478, 402, -5362)

			CFrameQuest = CFrame.new(605, 402, -5371)
			VectorQuest = Vector3.new(605, 402, -5371)
		elseif MyLevel == 1050 or MyLevel <= 1099 then -- Winter Warrior [Lv. 1050]
			LevelFarm = 10

			Name = "Winter Warrior [Lv. 1050]"
			QuestName = "SnowMountainQuest"

			LevelQuest = 2
			NameMon = "Winter Warrior"

			CFrameMon = CFrame.new(1157, 430, -5188)
			VectorMon = Vector3.new(1157, 430, -5188)

			CFrameQuest = CFrame.new(605, 402, -5371)
			VectorQuest = Vector3.new(605, 402, -5371)
		elseif MyLevel == 1100 or MyLevel <= 1124 then -- Lab Subordinate [Lv. 1100]
			LevelFarm = 11

			Name = "Lab Subordinate [Lv. 1100]"
			QuestName = "IceSideQuest"

			LevelQuest = 1
			NameMon = "Lab Subordinate"

			CFrameMon = CFrame.new(-5782, 42, -4484)
			VectorMon = Vector3.new(-5782, 42, -4484)

			CFrameQuest = CFrame.new(-6060, 16, -4905)
			VectorQuest = Vector3.new(-6060, 16, -4905)
		elseif MyLevel == 1125 or MyLevel <= 1174 then -- Horned Warrior [Lv. 1125]
			LevelFarm = 12

			Name = "Horned Warrior [Lv. 1125]"
			QuestName = "IceSideQuest"

			LevelQuest = 2
			NameMon = "Horned Warrior"

			CFrameMon = CFrame.new(-6406, 24, -5805)
			VectorMon = Vector3.new(-6406, 24, -5805)

			CFrameQuest = CFrame.new(-6060, 16, -4905)
			VectorQuest = Vector3.new(-6060, 16, -4905)
		elseif MyLevel == 1175 or MyLevel <= 1199 then -- Magma Ninja [Lv. 1175]
			LevelFarm = 13

			Name = "Magma Ninja [Lv. 1175]"
			QuestName = "FireSideQuest"
			LevelQuest = 1
			NameMon = "Magma Ninja"

			CFrameMon = CFrame.new(-5428, 78, -5959)
			VectorMon = Vector3.new(-5428, 78, -5959)

			CFrameQuest = CFrame.new(-5430, 16, -5295)
			VectorQuest = Vector3.new(-5430, 16, -5296)
		elseif MyLevel == 1200 or MyLevel <= 1249 then -- Lava Pirate [Lv. 1200]
			LevelFarm = 14

			Name = "Lava Pirate [Lv. 1200]"
			QuestName = "FireSideQuest"

			LevelQuest = 2
			NameMon = "Lava Pirate"

			CFrameMon = CFrame.new(-5270, 42, -4800)
			VectorMon = Vector3.new(-5270, 42, -4800)

			CFrameQuest = CFrame.new(-5430, 16, -5295)
			VectorQuest = Vector3.new(-5430, 16, -5296)
		elseif MyLevel == 1250 or MyLevel <= 1274 then -- Ship Deckhand [Lv. 1250]
			LevelFarm = 15

			Name = "Ship Deckhand [Lv. 1250]"
			QuestName = "ShipQuest1"

			LevelQuest = 1
			NameMon = "Ship Deckhand"

			CFrameMon = CFrame.new(1198, 126, 33031)
			VectorMon = Vector3.new(1198, 126, 33031)

			CFrameQuest = CFrame.new(1038, 125, 32913)
			VectorQuest = Vector3.new(1038, 125, 32913)
		elseif MyLevel == 1275 or MyLevel <= 1299 then -- Ship Engineer [Lv. 1275]
			LevelFarm = 16

			Name = "Ship Engineer [Lv. 1275]"
			QuestName = "ShipQuest1"

			LevelQuest = 2
			NameMon = "Ship Engineer"

			CFrameMon = CFrame.new(918, 44, 32787)
			VectorMon = Vector3.new(918, 44, 32787)

			CFrameQuest = CFrame.new(1038, 125, 32913)
			VectorQuest = Vector3.new(1038, 125, 32913)
		elseif MyLevel == 1300 or MyLevel <= 1324 then -- Ship Steward [Lv. 1300]
			LevelFarm = 17

			Name = "Ship Steward [Lv. 1300]"
			QuestName = "ShipQuest2"

			LevelQuest = 1
			NameMon = "Ship Steward"

			CFrameMon = CFrame.new(915, 130, 33419)
			VectorMon = Vector3.new(915, 130, 33419)

			CFrameQuest = CFrame.new(969, 125, 33245)
			VectorQuest = Vector3.new(969, 125, 33245)
		elseif MyLevel == 1325 or MyLevel <= 1349 then -- Ship Officer [Lv. 1325]
			LevelFarm = 18

			Name = "Ship Officer [Lv. 1325]"
			QuestName = "ShipQuest2"

			LevelQuest = 2
			NameMon = "Ship Officer"

			CFrameMon = CFrame.new(916, 181, 33335)
			VectorMon = Vector3.new(916, 181, 33335)

			CFrameQuest = CFrame.new(969, 125, 33245)
			VectorQuest = Vector3.new(969, 125, 33245)
		elseif MyLevel == 1350 or MyLevel <= 1374 then -- Arctic Warrior [Lv. 1350]
			LevelFarm = 19

			Name = "Arctic Warrior [Lv. 1350]"
			QuestName = "FrostQuest"

			LevelQuest = 1
			NameMon = "Arctic Warrior"

			CFrameMon = CFrame.new(6038, 29, -6231)
			VectorMon = Vector3.new(6038, 29, -6231)

			VectorQuest = Vector3.new(5669, 28, -6482)
			CFrameQuest = CFrame.new(5669, 28, -6482)
		elseif MyLevel == 1375 or MyLevel <= 1424 then -- Snow Lurker [Lv. 1375]
			LevelFarm = 20

			Name = "Snow Lurker [Lv. 1375]"
			QuestName = "FrostQuest"

			LevelQuest = 2
			NameMon = "Snow Lurker"

			CFrameMon = CFrame.new(5560, 42, -6826)
			VectorMon = Vector3.new(5560, 42, -6826)

			VectorQuest = Vector3.new(5669, 28, -6482)
			CFrameQuest = CFrame.new(5669, 28, -6482)
		elseif MyLevel == 1425 or MyLevel <= 1449 then -- Sea Soldier [Lv. 1425]
			LevelFarm = 21
			Name = "Sea Soldier [Lv. 1425]"
			QuestName = "ForgottenQuest"

			LevelQuest = 1
			NameMon = "Sea Soldier"

			CFrameMon = CFrame.new(-3022, 16, -9722)
			VectorMon = Vector3.new(-3022, 16, -9722)

			CFrameQuest = CFrame.new(-3054, 237, -10148)
			VectorQuest = Vector3.new(-3054, 237, -10148)
		elseif MyLevel >= 1450 then -- Water Fighter [Lv. 1450]
			LevelFarm = 22
			Name = "Water Fighter [Lv. 1450]"
			QuestName = "ForgottenQuest"

			LevelQuest = 2
			NameMon = "Water Fighter"

			CFrameMon = CFrame.new(-3385, 239, -10542)
			VectorMon = Vector3.new(-3385, 239, -10542)

			CFrameQuest = CFrame.new(-3054, 237, -10148)
			VectorQuest = Vector3.new(-3054, 237, -10148)
		end
	end
	if ThirdSea then
		if MyLevel == 1500 or MyLevel <= 1524 then
			LevelFarm = 1

			Name = "Pirate Millionaire [Lv. 1500]"
			QuestName = "PiratePortQuest"

			LevelQuest = 1
			NameMon = "Pirate"

			CFrameMon = CFrame.new(-373, 75, 5550)
			VectorMon = Vector3.new(-373, 75, 5550)

			CFrameQuest = CFrame.new(-288, 44, 5576)
			VectorQuest = Vector3.new(-288, 44, 5576)
		elseif MyLevel == 1525 or MyLevel <= 1574 then
			LevelFarm = 2

			Name = "Pistol Billionaire [Lv. 1525]"
			QuestName = "PiratePortQuest"

			LevelQuest = 2
			NameMon = "Pistol"

			CFrameMon = CFrame.new(-469, 74, 5904)
			VectorMon = Vector3.new(-469, 74, 5904)

			CFrameQuest = CFrame.new(-288, 44, 5576)
			VectorQuest = Vector3.new(-288, 44, 5576)
		elseif MyLevel == 1575 or MyLevel <= 1599 then
			LevelFarm = 3

			Name = "Dragon Crew Warrior [Lv. 1575]"
			QuestName = "AmazonQuest"

			LevelQuest = 1
			NameMon = "Warrior"

			CFrameMon = CFrame.new(6339, 52, -1213)
			VectorMon = Vector3.new(6338, 52, -1213)

			CFrameQuest = CFrame.new(5835, 52, -1105)
			VectorQuest = Vector3.new(5835, 52, -1105)
		elseif MyLevel == 1600 or MyLevel <= 1624 then
			LevelFarm = 4

			Name = "Dragon Crew Archer [Lv. 1600]"
			QuestName = "AmazonQuest"

			LevelQuest = 2
			NameMon = "Archer"

			CFrameMon = CFrame.new(6594, 383, 139)
			VectorMon = Vector3.new(6594, 383, 139)

			CFrameQuest = CFrame.new(5835, 52, -1105)
			VectorQuest = Vector3.new(5835, 52, -1105)
		elseif MyLevel == 1625 or MyLevel <= 1649 then
			LevelFarm = 5

			Name = "Female Islander [Lv. 1625]"
			QuestName = "AmazonQuest2"

			LevelQuest = 1
			NameMon = "Female"

			CFrameMon = CFrame.new(5308, 819, 1047)
			VectorMon = Vector3.new(5308, 819, 1047)

			CFrameQuest = CFrame.new(5443, 602, 751)
			VectorQuest = Vector3.new(5443, 602, 751)
		elseif MyLevel == 1650 or MyLevel <= 1699 then
			LevelFarm = 6

			Name = "Giant Islander [Lv. 1650]"
			QuestName = "AmazonQuest2"

			LevelQuest = 2
			NameMon = "Giant Islanders"

			CFrameMon = CFrame.new(4951, 602, -68)
			VectorMon = Vector3.new(4951, 602, -68)

			CFrameQuest = CFrame.new(5443, 602, 751)
			VectorQuest = Vector3.new(5443, 602, 751)
		elseif MyLevel == 1700 or MyLevel <= 1724 then
			LevelFarm = 7

			Name = "Marine Commodore [Lv. 1700]"
			QuestName = "MarineTreeIsland"

			LevelQuest = 1
			NameMon = "Marine Commodore"

			CFrameMon = CFrame.new(2447, 73, -7470)
			VectorMon = Vector3.new(2447, 73, -7470)

			CFrameQuest = CFrame.new(2180, 29, -6737)
			VectorQuest = Vector3.new(2180, 29, -6737)
		elseif MyLevel == 1725 or MyLevel <= 1774 then
			LevelFarm = 8

			Name = "Marine Rear Admiral [Lv. 1725]"
			QuestName = "MarineTreeIsland"

			LevelQuest = 2
			NameMon = "Marine Rear Admiral"

			CFrameMon = CFrame.new(3671, 161, -6932)
			VectorMon = Vector3.new(3671, 161, -6932)

			CFrameQuest = CFrame.new(2180, 29, -6737)
			VectorQuest = Vector3.new(2180, 29, -6737)
		elseif MyLevel == 1775 or MyLevel <= 1800 then
			LevelFarm = 9

			Name = "Fishman Raider [Lv. 1775]"
			QuestName = "DeepForestIsland3"

			LevelQuest = 1
			NameMon = "Fishman Raider"

			CFrameMon = CFrame.new(-10560, 332, -8466)
			VectorMon = Vector3.new(-10560, 332, -8466)

			CFrameQuest = CFrame.new(-10584, 332, -8758)
			VectorQuest = Vector3.new(-10584, 332, -8758)
		elseif MyLevel == 1800 or MyLevel <= 1824 then
			LevelFarm = 10

			Name = "Fishman Captain [Lv. 1800]"
			QuestName = "DeepForestIsland3"

			LevelQuest = 2
			NameMon = "Fishman Captain"

			CFrameMon = CFrame.new(-10993, 332, -8940)
			VectorMon = Vector3.new(-10993, 332, -8940)

			CFrameQuest = CFrame.new(-10584, 332, -8758)
			VectorQuest = Vector3.new(-10584, 332, -8758)
		elseif MyLevel == 1825 or MyLevel <= 1849 then
			LevelFarm = 11

			Name = "Forest Pirate [Lv. 1825]"
			QuestName = "DeepForestIsland"

			LevelQuest = 1
			NameMon = "Forest Pirate"

			CFrameMon = CFrame.new(-13479, 333, -7905)
			VectorMon = Vector3.new(-13479, 333, -7905)

			CFrameQuest = CFrame.new(-13232, 333, -7627)
			VectorQuest = Vector3.new(-13232, 333, -7627)
		elseif MyLevel == 1850 or MyLevel <= 1899 then
			LevelFarm = 12

			Name = "Mythological Pirate [Lv. 1850]"
			QuestName = "DeepForestIsland"

			LevelQuest = 2
			NameMon = "Mythological Pirate"

			CFrameMon = CFrame.new(-13545, 470, -6917)
			VectorMon = Vector3.new(-13545, 470, -6917)

			CFrameQuest = CFrame.new(-13232, 333, -7627)
			VectorQuest = Vector3.new(-13232, 333, -7627)
		elseif MyLevel == 1900 or MyLevel <= 1924 then
			LevelFarm = 13

			Name = "Jungle Pirate [Lv. 1900]"
			QuestName = "DeepForestIsland2"

			LevelQuest = 1
			NameMon = "Jungle Pirate"

			CFrameMon = CFrame.new(-12107, 332, -10549)
			VectorMon = Vector3.new(-12106, 332, -10549)

			CFrameQuest = CFrame.new(-12684, 391, -9902)
			VectorQuest = Vector3.new(-12684, 391, -9902)
		elseif MyLevel == 1925 or MyLevel <= 1974 then
			LevelFarm = 14

			Name = "Musketeer Pirate [Lv. 1925]"
			QuestName = "DeepForestIsland2"

			LevelQuest = 2
			NameMon = "Musketeer Pirate"

			CFrameMon = CFrame.new(-13286, 392, -9769)
			VectorMon = Vector3.new(-13286, 392, -9768)

			CFrameQuest = CFrame.new(-12684, 391, -9902)
			VectorQuest = Vector3.new(-12684, 391, -9902)
		elseif MyLevel == 1975 or MyLevel <= 1999 then
			LevelFarm = 15
			Name = "Reborn Skeleton [Lv. 1975]"
			QuestName = "HauntedQuest1"

			LevelQuest = 1
			NameMon = "Reborn Skeleton"

			CFrameMon = CFrame.new(-8760, 142, 6039)
			VectorMon = Vector3.new(-8760, 142, 6039)

			CFrameQuest = CFrame.new(-9482, 142, 5567)
			VectorQuest = Vector3.new(-9482, 142, 5567)
		elseif MyLevel == 2000 or MyLevel <= 2024 then
			LevelFarm = 16

			Name = "Living Zombie [Lv. 2000]"
			QuestName = "HauntedQuest1"

			LevelQuest = 2
			NameMon = "Living Zombie"

			CFrameMon = CFrame.new(-10144, 140, 5932)
			VectorMon = Vector3.new(-10144, 140, 5932)

			CFrameQuest = CFrame.new(-9482, 142, 5567)
			VectorQuest = Vector3.new(-9482, 142, 5567)
		elseif MyLevel == 2025 or MyLevel <= 2049 then
			LevelFarm = 17

			Name = "Demonic Soul [Lv. 2025]"
			QuestName = "HauntedQuest2"

			LevelQuest = 1
			NameMon = "Demonic Soul"

			CFrameMon = CFrame.new(-9507, 172, 6158)
			VectorMon = Vector3.new(-9506, 172, 6158)

			CFrameQuest = CFrame.new(-9513, 172, 6079)
			VectorQuest = Vector3.new(-9513, 172, 6079)
		elseif MyLevel == 2050 or MyLevel <= 2074 then
			LevelFarm = 18

			Name = "Posessed Mummy [Lv. 2050]"
			QuestName = "HauntedQuest2"

			LevelQuest = 2
			NameMon = "Posessed Mummy"

			CFrameMon = CFrame.new(-9577, 6, 6223)
			VectorMon = Vector3.new(-9577, 6, 6223)

			CFrameQuest = CFrame.new(-9513, 172, 6079)
			VectorQuest = Vector3.new(-9513, 172, 6079)

		elseif MyLevel == 2075 or MyLevel <= 2099 then
			LevelFarm = 19

			Name = "Peanut Scout [Lv. 2075]"
			QuestName = "NutsIslandQuest"

			LevelQuest = 1
			NameMon = "Peanut Scout"

			CFrameMon = CFrame.new(-2124, 123, -10435)
			VectorMon = Vector3.new(-2124, 123, -10435)

			CFrameQuest = CFrame.new(-2104, 38, -10192)
			VectorQuest = Vector3.new(-2104, 38, -10192)
		elseif MyLevel == 2100 or MyLevel <= 2124 then
			LevelFarm = 20

			Name = "Peanut President [Lv. 2100]"
			QuestName = "NutsIslandQuest"

			LevelQuest = 2
			NameMon = "Peanut President"

			CFrameMon = CFrame.new(-2124, 123, -10435)
			VectorMon = Vector3.new(-2124, 123, -10435)

			CFrameQuest = CFrame.new(-2104, 38, -10192)
			VectorQuest = Vector3.new(-2104, 38, -10192)
		elseif MyLevel == 2125 or MyLevel <= 2149 then
			LevelFarm = 21

			Name = "Ice Cream Chef [Lv. 2125]"
			QuestName = "IceCreamIslandQuest"

			LevelQuest = 1
			NameMon = "Ice Cream Chef"

			CFrameMon = CFrame.new(-641, 127, -11062)
			VectorMon = Vector3.new(-641, 127, -11062)

			CFrameQuest = CFrame.new(-822, 66, -10965)
			VectorQuest = Vector3.new(-822, 66, -10965)
		elseif MyLevel == 2150 or MyLevel <= 2199 then
			LevelFarm = 22

			Name = "Ice Cream Commander [Lv. 2150]"
			QuestName = "IceCreamIslandQuest"

			LevelQuest = 2
			NameMon = "Ice Cream Commander"

			CFrameMon = CFrame.new(-641, 127, -11062)
			VectorMon = Vector3.new(-641, 127, -11062)

			CFrameQuest = CFrame.new(-822, 66, -10965)
			VectorQuest = Vector3.new(-822, 66, -10965)
		elseif MyLevel == 2200 or MyLevel <= 2224 then
			LevelFarm = 23

			Name = "Cookie Crafter [Lv. 2200]"
			QuestName = "CakeQuest1"

			LevelQuest = 1
			NameMon = "Cookie Crafter"

			CFrameMon = CFrame.new(-2365, 38, -12099)
			VectorMon = Vector3.new(-2365, 38, -12099)

			CFrameQuest = CFrame.new(-2020, 38, -12025)
			VectorQuest = Vector3.new(-2020, 38, -12025)
		elseif MyLevel == 2225 or MyLevel <= 2249 then
			LevelFarm = 24

			Name = "Cake Guard [Lv. 2225]"
			QuestName = "CakeQuest1"

			LevelQuest = 2
			NameMon = "Cake Guard"

			CFrameMon = CFrame.new(-1651, 38, -12308)
			VectorMon = Vector3.new(-1651, 38, -12308)

			CFrameQuest = CFrame.new(-2020, 38, -12025)
			VectorQuest = Vector3.new(-2020, 38, -12025)
		elseif MyLevel == 2250 or MyLevel <= 2274 then
			LevelFarm = 25

			Name = "Baking Staff [Lv. 2250]"
			QuestName = "CakeQuest2"

			LevelQuest = 1
			NameMon = "Baking Staff"

			CFrameMon = CFrame.new(-1870, 38, -12938)
			VectorMon = Vector3.new(-1870, 38, -12938)

			CFrameQuest = CFrame.new(-1926, 38, -12850)
			VectorQuest = Vector3.new(-1926, 38, -12850)
		elseif MyLevel == 2275 or MyLevel <= 2299 then
			LevelFarm = 26

			Name = "Head Baker [Lv. 2275]"
			QuestName = "CakeQuest2"

			LevelQuest = 2
			NameMon = "Head Baker"

			CFrameMon = CFrame.new(-1926, 88, -12850)
			VectorMon = CFrame.new(-1870, 38, -12938)

			CFrameQuest = CFrame.new(-1926, 38, -12850)
			VectorQuest = Vector3.new(-1926, 38, -12850)
		elseif MyLevel == 2300 or MyLevel <= 2324 then
			LevelFarm = 27

			Name = "Cocoa Warrior [Lv. 2300]"
			QuestName = "ChocQuest1"

			LevelQuest = 1
			NameMon = "Cocoa Warrior"

			CFrameMon = CFrame.new(231, 23, -12194)
			VectorMon = CFrame.new(231, 23, -12194)

			CFrameQuest = CFrame.new(231, 23, -12194)
			VectorQuest = Vector3.new(231, 23, -12194)
		elseif MyLevel == 2325 or MyLevel <= 2349 then
			LevelFarm = 28

			Name = "Chocolate Bar Battler [Lv. 2325]"
			QuestName = "ChocQuest1"

			LevelQuest = 2
			NameMon = "Chocolate Bar Battler"

			CFrameMon = CFrame.new(231, 23, -12194)
			VectorMon = CFrame.new(231, 23, -12194)

			CFrameQuest = CFrame.new(231, 23, -12194)
			VectorQuest = Vector3.new(231, 23, -12194)
		elseif MyLevel == 2350 or MyLevel <= 2374 then
			LevelFarm = 29

			Name = "Sweet Thief [Lv. 2350]"
			QuestName = "ChocQuest2"

			LevelQuest = 1
			NameMon = "Sweet Thief"

			CFrameMon = CFrame.new(71, 77, -12632)
			VectorMon = CFrame.new(71, 77, -12632)

			CFrameQuest = CFrame.new(151, 23, -12774)
			VectorQuest = Vector3.new(151, 23, -12774)
		elseif MyLevel >= 2375 then
			LevelFarm = 30

			Name = "Candy Rebel [Lv. 2375]"
			QuestName = "ChocQuest2"

			LevelQuest = 2
			NameMon = "Candy Rebel"

			CFrameMon = CFrame.new(134, 77, -12882)
			VectorMon = CFrame.new(134, 77, -12882)

			CFrameQuest = CFrame.new(151, 23, -12774)
			VectorQuest = Vector3.new(151, 23, -12774)
		end
	end
end

function CheckOldQuest(LevelFarm)
	if FirstSea then
		if LevelFarm == 1 then -- Bandit
			Name = "Bandit [Lv. 5]"
			QuestName = "BanditQuest1"

			LevelQuest = 1
			NameMon = "Bandit"

			CFrameMon = CFrame.new(1145, 17, 1634)
			VectorMon = Vector3.new(1145, 17, 1634)

			CFrameQuest = CFrame.new(1060, 17, 1547)
			VectorQuest = Vector3.new(1060, 17, 1547)
		elseif LevelFarm == 2 then -- Monkey
			Name = "Monkey [Lv. 14]"
			QuestName = "JungleQuest"

			LevelQuest = 1
			NameMon = "Monkey"

			CFrameMon = CFrame.new(-1496, 39, 35)
			VectorMon = Vector3.new(-1496, 39, 35)

			CFrameQuest = CFrame.new(-1602, 37, 152)
			VectorQuest = Vector3.new(-1602, 37, 152)
		elseif LevelFarm == 3 then -- Gorilla
			Name = "Gorilla [Lv. 20]"
			QuestName = "JungleQuest"

			LevelQuest = 2
			NameMon = "Gorilla"

			CFrameMon = CFrame.new(-1237, 6, -486)
			VectorMon = Vector3.new(-1237, 7, -486)

			CFrameQuest = CFrame.new(-1602, 37, 152)
			VectorQuest = Vector3.new(-1602, 37, 152)
		elseif LevelFarm == 4 then -- Pirate
			Name = "Pirate [Lv. 35]"
			QuestName = "BuggyQuest1"

			LevelQuest = 1
			NameMon = "Pirate"

			CFrameMon = CFrame.new(-1115, 14, 3938)
			VectorMon = Vector3.new(-1115, 14, 3938)

			CFrameQuest = CFrame.new(-1140, 5, 3828)
			VectorQuest = Vector3.new(-1140, 5, 3828)
		elseif LevelFarm == 5 then -- Brute
			Name = "Brute [Lv. 45]"
			QuestName = "BuggyQuest1"

			LevelQuest = 2
			NameMon = "Brute"

			CFrameMon = CFrame.new(-1145, 15, 4350)
			VectorMon = Vector3.new(-1146, 15, 4350)

			CFrameQuest = CFrame.new(-1140, 5, 3828)
			VectorQuest = Vector3.new(-1140, 5, 3828)
		elseif LevelFarm == 6 then -- Desert Bandit
			Name = "Desert Bandit [Lv. 60]"
			QuestName = "DesertQuest"

			LevelQuest = 1
			NameMon = "Desert Bandit"

			CFrameMon = CFrame.new(932, 7, 4484)
			VectorMon = Vector3.new(932, 7, 4484)

			CFrameQuest = CFrame.new(897, 7, 4388)
			VectorQuest = Vector3.new(897, 7, 4388)
		elseif LevelFarm == 7 then -- Desert Officre
			Name = "Desert Officer [Lv. 70]"
			QuestName = "DesertQuest"

			LevelQuest = 2
			NameMon = "Desert Officer"

			CFrameMon = CFrame.new(1572, 10, 4373)
			VectorMon = Vector3.new(1572, 10, 4373)

			CFrameQuest = CFrame.new(897, 7, 4388)
			VectorQuest = Vector3.new(897, 7, 4388)
		elseif LevelFarm == 8 then -- Snow Bandits
			Name = "Snow Bandit [Lv. 90]"
			QuestName = "SnowQuest"

			LevelQuest = 1
			NameMon = "Snow Bandits"

			CFrameMon = CFrame.new(1289, 150, -1442)
			VectorMon = Vector3.new(1289, 106, -1442)

			CFrameQuest = CFrame.new(1386, 87, -1297)
			VectorQuest = Vector3.new(1386, 87, -1297)
		elseif LevelFarm == 9 then -- Snowman
			Name = "Snowman [Lv. 100]"
			QuestName = "SnowQuest"

			LevelQuest = 2
			NameMon = "Snowman"

			CFrameMon = CFrame.new(1289, 150, -1442)
			VectorMon = Vector3.new(1289, 106, -1442)

			CFrameQuest = CFrame.new(1386, 87, -1297)
			VectorQuest = Vector3.new(1386, 87, -1297)
		elseif LevelFarm == 10 then -- Chief Petty Officer
			Name = "Chief Petty Officer [Lv. 120]"
			QuestName = "MarineQuest2"

			LevelQuest = 1
			NameMon = "Chief Petty Officer"

			CFrameMon = CFrame.new(-4855, 23, 4308)
			VectorMon = Vector3.new(-4855, 23, 4308)

			CFrameQuest = CFrame.new(-5036, 29, 4325)
			VectorQuest = Vector3.new(-5036, 29, 4325)
		elseif LevelFarm == 11 then -- Sky Bandit
			Name = "Sky Bandit [Lv. 150]"
			QuestName = "SkyQuest"

			LevelQuest = 1
			NameMon = "Sky Bandit"

			CFrameMon = CFrame.new(-4981, 278, -2830)
			VectorMon = Vector3.new(-4981, 278, -2830)

			CFrameQuest = CFrame.new(-4842, 718, -2623)
			VectorQuest = Vector3.new(-4842, 718, -2623)
		elseif LevelFarm == 12 then -- Dark Master
			Name = "Dark Master [Lv. 175]"
			QuestName = "SkyQuest"

			LevelQuest = 2
			NameMon = "Dark Master"

			CFrameMon = CFrame.new(-5250, 389, -2272)
			VectorMon = Vector3.new(-5250, 389, -2272)

			CFrameQuest = CFrame.new(-4842, 718, -2623)
			VectorQuest = Vector3.new(-4842, 718, -2623)
		elseif LevelFarm == 13 then -- Dark Master
			Name = "Prisoner [Lv. 190]"
			QuestName = "PrisonerQuest"

			LevelQuest = 1
			NameMon = "Prisoner"

			CFrameMon = CFrame.new(5411, 96, 690)
			VectorMon = Vector3.new(5411, 96, 690)

			CFrameQuest = CFrame.new(5308, 2, 474)
			VectorQuest = Vector3.new(5308, 2, 474)
		elseif LevelFarm == 14 then -- Dark Master
			Name = "Dangerous Prisoner [Lv. 210]"
			QuestName = "PrisonerQuest"

			LevelQuest = 2
			NameMon = "Dangerous Prisoner"

			CFrameMon = CFrame.new(5411, 96, 690)
			VectorMon = Vector3.new(5411, 96, 690)

			CFrameQuest = CFrame.new(5308, 2, 474)
			VectorQuest = Vector3.new(5308, 2, 474)
		elseif LevelFarm == 15 then -- Toga Warrior
			Name = "Toga Warrior [Lv. 250]"
			QuestName = "ColosseumQuest"

			LevelQuest = 1
			NameMon = "Toga Warrior"

			CFrameMon = CFrame.new(-1770, 8, -2777)
			VectorMon = Vector3.new(-1770, 8, -2777)

			CFrameQuest = CFrame.new(-1576, 8, -2985)
			VectorQuest = Vector3.new(-1576, 8, -2985)
		elseif LevelFarm == 16 then -- Military Soldier
			Name = "Military Soldier [Lv. 300]"
			QuestName = "MagmaQuest"

			LevelQuest = 1
			NameMon = "Military Soldier"

			CFrameMon = CFrame.new(-5408, 11, 8447)
			VectorMon = Vector3.new(-5408, 11, 8447)

			CFrameQuest = CFrame.new(-5316, 12, 8517)
			VectorQuest = Vector3.new(-5316, 12, 8517)
		elseif LevelFarm == 17 then -- Military Spy
			Name = "Military Spy [Lv. 325]"
			QuestName = "MagmaQuest"

			LevelQuest = 2
			NameMon = "Military Spy"

			CFrameMon = CFrame.new(-5815, 84, 8820)
			VectorMon = Vector3.new(-5815, 84, 8820)

			CFrameQuest = CFrame.new(-5316, 12, 8517)
			VectorQuest = Vector3.new(-5316, 12, 8517)
		elseif LevelFarm == 18 then -- Fishman Warrior
			Name = "Fishman Warrior [Lv. 375]"
			QuestName = "FishmanQuest"

			LevelQuest = 1
			NameMon = "Fishman Warrior"

			CFrameMon = CFrame.new(60859, 19, 1501)
			VectorMon = Vector3.new(60859, 19, 1501)

			CFrameQuest = CFrame.new(61123, 19, 1569)
			VectorQuest = Vector3.new(61123, 19, 1569)
		elseif LevelFarm == 19 then -- Fishman Commando
			Name = "Fishman Commando [Lv. 400]"
			QuestName = "FishmanQuest"

			LevelQuest = 2
			NameMon = "Fishman Commando"

			CFrameMon = CFrame.new(61891, 19, 1470)
			VectorMon = Vector3.new(61891, 19, 1470)

			CFrameQuest = CFrame.new(61123, 19, 1569)
			VectorQuest = Vector3.new(61123, 19, 1569)
		elseif LevelFarm == 20 then -- God's Guards
			Name = "God's Guard [Lv. 450]"
			QuestName = "SkyExp1Quest"

			LevelQuest = 1
			NameMon = "God's Guards"

			CFrameMon = CFrame.new(-4698, 845, -1912)
			VectorMon = Vector3.new(-4698, 845, -1912)

			CFrameQuest = CFrame.new(-4722, 845, -1954)
			VectorQuest = Vector3.new(-4722, 846, -1954)
		elseif LevelFarm == 21 then -- Shandas
			Name = "Shanda [Lv. 475]"
			QuestName = "SkyExp1Quest"

			LevelQuest = 2
			NameMon = "Shandas"

			CFrameMon = CFrame.new(-7685, 5567, -502)
			VectorMon = Vector3.new(-7685, 5567, -502)

			CFrameQuest = CFrame.new(-7862, 5546, -380)
			VectorQuest = Vector3.new(-7862, 5546, -380)
		elseif LevelFarm == 22 then -- Royal Squad
			Name = "Royal Squad [Lv. 525]"
			QuestName = "SkyExp2Quest"

			LevelQuest = 1
			NameMon = "Royal Squad"

			CFrameMon = CFrame.new(-7670, 5607, -1460)
			VectorMon = Vector3.new(-7670, 5607, -1460)

			CFrameQuest = CFrame.new(-7904, 5636, -1412)
			VectorQuest = Vector3.new(-7904, 5636, -1412)
		elseif LevelFarm == 23 then -- Royal Soldier
			Name = "Royal Soldier [Lv. 550]"
			QuestName = "SkyExp2Quest"

			LevelQuest = 2
			NameMon = "Royal Soldier"

			CFrameMon = CFrame.new(-7828, 5607, -1744)
			VectorMon = Vector3.new(-7828, 5607, -1744)

			CFrameQuest = CFrame.new(-7904, 5636, -1412)
			VectorQuest = Vector3.new(-7904, 5636, -1412)
		elseif LevelFarm == 24 then -- Galley Pirate
			Name = "Galley Pirate [Lv. 625]"
			QuestName = "FountainQuest"

			LevelQuest = 1
			NameMon = "Galley Pirate"

			CFrameMon = CFrame.new(5589, 45, 3996)
			VectorMon = Vector3.new(5589, 45, 3996)

			CFrameQuest = CFrame.new(5256, 39, 4050)
			VectorQuest = Vector3.new(5256, 39, 4050)
		elseif LevelFarm == 25 then -- Galley Captain
			Name = "Galley Captain [Lv. 650]"
			QuestName = "FountainQuest"

			LevelQuest = 2
			NameMon = "Galley Captain"

			CFrameMon = CFrame.new(5649, 39, 4936)
			VectorMon = Vector3.new(5649, 39, 4936)

			CFrameQuest = CFrame.new(5256, 39, 4050)
			VectorQuest = Vector3.new(5256, 39, 4050)
		end
	end
	if SecondSea then
		if LevelFarm == 1 then -- Raider [Lv. 700]
			Name = "Raider [Lv. 700]"
			QuestName = "Area1Quest"

			LevelQuest = 1
			NameMon = "Raider"

			CFrameQuest = CFrame.new(-425, 73, 1837)
			VectorQuest = Vector3.new(-425, 73, 1837)

			CFrameMon = CFrame.new(-746, 39, 2390)
			VectorMon = Vector3.new(-746, 39, 2389)
		elseif LevelFarm == 2 then -- Mercenary [Lv. 725]
			Name = "Mercenary [Lv. 725]"
			QuestName = "Area1Quest"

			LevelQuest = 2
			NameMon = "Mercenary"

			CFrameQuest = CFrame.new(-425, 73, 1837)
			VectorQuest = Vector3.new(-425, 73, 1837)

			CFrameMon = CFrame.new(-874, 141, 1312)
			VectorMon = Vector3.new(-874, 141, 1312)
		elseif LevelFarm == 3 then -- Swan Pirate [Lv. 775]
			Name = "Swan Pirate [Lv. 775]"
			QuestName = "Area2Quest"

			LevelQuest = 1
			NameMon = "Swan Pirate"

			CFrameQuest = CFrame.new(634, 73, 918)
			VectorQuest = Vector3.new(634, 73, 918)

			CFrameMon = CFrame.new(878, 122, 1235)
			VectorMon = Vector3.new(878, 122, 1235)
		elseif LevelFarm == 4 then -- Factory Staff [Lv. 800]
			Name = "Factory Staff [Lv. 800]"
			QuestName = "Area2Quest"

			LevelQuest = 2
			NameMon = "Factory Staff"

			CFrameQuest = CFrame.new(634, 73, 918)
			VectorQuest = Vector3.new(634, 73, 918)

			CFrameMon = CFrame.new(295, 73, -56)
			VectorMon = Vector3.new(295, 73, -56)
		elseif LevelFarm == 5 then -- Marine Lieutenant [Lv. 875]
			Name = "Marine Lieutenant [Lv. 875]"
			QuestName = "MarineQuest3"

			LevelQuest = 1
			NameMon = "Marine Lieutenant"

			CFrameMon = CFrame.new(-2806, 73, -3038)
			VectorMon = Vector3.new(-2806, 73, -3038)

			CFrameQuest = CFrame.new(-2443, 73, -3219)
			VectorQuest = Vector3.new(-2443, 73, -3219)
		elseif LevelFarm == 6 then -- Marine Captain [Lv. 900]
			Name = "Marine Captain [Lv. 900]"
			QuestName = "MarineQuest3"

			LevelQuest = 2
			NameMon = "Marine Captain"

			CFrameMon = CFrame.new(-1869, 73, -3320)
			VectorMon = Vector3.new(-1869, 73, -3320)

			CFrameQuest = CFrame.new(-2443, 73, -3219)
			VectorQuest = Vector3.new(-2443, 73, -3219)
		elseif LevelFarm == 7 then -- Zombie [Lv. 950]
			Name = "Zombie [Lv. 950]"
			QuestName = "ZombieQuest"

			LevelQuest = 1
			NameMon = "Zombie"

			CFrameMon = CFrame.new(-5736, 126, -728)
			VectorMon = Vector3.new(-5736, 126, -728)

			CFrameQuest = CFrame.new(-5494, 49, -795)
			VectorQuest = Vector3.new(-5494, 49, -794)
		elseif LevelFarm == 8 then -- Vampire [Lv. 975]
			Name = "Vampire [Lv. 975]"
			QuestName = "ZombieQuest"

			LevelQuest = 2
			NameMon = "Vampire"

			CFrameMon = CFrame.new(-6033, 7, -1317)
			VectorMon = Vector3.new(-6033, 7, -1317)

			CFrameQuest = CFrame.new(-5494, 49, -795)
			VectorQuest = Vector3.new(-5494, 49, -795)
		elseif LevelFarm == 9 then -- Snow Trooper [Lv. 1000] **
			Name = "Snow Trooper [Lv. 1000]"
			QuestName = "SnowMountainQuest"

			LevelQuest = 1
			NameMon = "Snow Trooper"

			CFrameMon = CFrame.new(478, 402, -5362)
			VectorMon = Vector3.new(478, 402, -5362)

			CFrameQuest = CFrame.new(605, 402, -5371)
			VectorQuest = Vector3.new(605, 402, -5371)
		elseif LevelFarm == 10 then -- Winter Warrior [Lv. 1050]
			Name = "Winter Warrior [Lv. 1050]"
			QuestName = "SnowMountainQuest"

			LevelQuest = 2
			NameMon = "Winter Warrior"

			CFrameMon = CFrame.new(1157, 430, -5188)
			VectorMon = Vector3.new(1157, 430, -5188)

			CFrameQuest = CFrame.new(605, 402, -5371)
			VectorQuest = Vector3.new(605, 402, -5371)
		elseif LevelFarm == 11 then -- Lab Subordinate [Lv. 1100]
			Name = "Lab Subordinate [Lv. 1100]"
			QuestName = "IceSideQuest"

			LevelQuest = 1
			NameMon = "Lab Subordinate"

			CFrameMon = CFrame.new(-5782, 42, -4484)
			VectorMon = Vector3.new(-5782, 42, -4484)

			CFrameQuest = CFrame.new(-6060, 16, -4905)
			VectorQuest = Vector3.new(-6060, 16, -4905)
		elseif LevelFarm == 12 then -- Horned Warrior [Lv. 1125]
			Name = "Horned Warrior [Lv. 1125]"
			QuestName = "IceSideQuest"

			LevelQuest = 2
			NameMon = "Horned Warrior"

			CFrameMon = CFrame.new(-6406, 24, -5805)
			VectorMon = Vector3.new(-6406, 24, -5805)

			CFrameQuest = CFrame.new(-6060, 16, -4905)
			VectorQuest = Vector3.new(-6060, 16, -4905)
		elseif LevelFarm == 13 then -- Magma Ninja [Lv. 1175]
			Name = "Magma Ninja [Lv. 1175]"
			QuestName = "FireSideQuest"
			LevelQuest = 1
			NameMon = "Magma Ninja"

			CFrameMon = CFrame.new(-5428, 78, -5959)
			VectorMon = Vector3.new(-5428, 78, -5959)

			CFrameQuest = CFrame.new(-5430, 16, -5295)
			VectorQuest = Vector3.new(-5430, 16, -5296)
		elseif LevelFarm == 14 then -- Lava Pirate [Lv. 1200]
			Name = "Lava Pirate [Lv. 1200]"
			QuestName = "FireSideQuest"

			LevelQuest = 2
			NameMon = "Lava Pirate"

			CFrameMon = CFrame.new(-5270, 42, -4800)
			VectorMon = Vector3.new(-5270, 42, -4800)

			CFrameQuest = CFrame.new(-5430, 16, -5295)
			VectorQuest = Vector3.new(-5430, 16, -5296)
		elseif LevelFarm == 15 then -- Ship Deckhand [Lv. 1250]
			Name = "Ship Deckhand [Lv. 1250]"
			QuestName = "ShipQuest1"

			LevelQuest = 1
			NameMon = "Ship Deckhand"

			CFrameMon = CFrame.new(1198, 126, 33031)
			VectorMon = Vector3.new(1198, 126, 33031)

			CFrameQuest = CFrame.new(1038, 125, 32913)
			VectorQuest = Vector3.new(1038, 125, 32913)
		elseif LevelFarm == 16 then -- Ship Engineer [Lv. 1275]
			Name = "Ship Engineer [Lv. 1275]"
			QuestName = "ShipQuest1"

			LevelQuest = 2
			NameMon = "Ship Engineer"

			CFrameMon = CFrame.new(918, 44, 32787)
			VectorMon = Vector3.new(918, 44, 32787)

			CFrameQuest = CFrame.new(1038, 125, 32913)
			VectorQuest = Vector3.new(1038, 125, 32913)
		elseif LevelFarm == 17 then -- Ship Steward [Lv. 1300]
			Name = "Ship Steward [Lv. 1300]"
			QuestName = "ShipQuest2"

			LevelQuest = 1
			NameMon = "Ship Steward"

			CFrameMon = CFrame.new(915, 130, 33419)
			VectorMon = Vector3.new(915, 130, 33419)

			CFrameQuest = CFrame.new(969, 125, 33245)
			VectorQuest = Vector3.new(969, 125, 33245)
		elseif LevelFarm == 18 then -- Ship Officer [Lv. 1325]
			Name = "Ship Officer [Lv. 1325]"
			QuestName = "ShipQuest2"

			LevelQuest = 2
			NameMon = "Ship Officer"

			CFrameMon = CFrame.new(916, 181, 33335)
			VectorMon = Vector3.new(916, 181, 33335)

			CFrameQuest = CFrame.new(969, 125, 33245)
			VectorQuest = Vector3.new(969, 125, 33245)
		elseif LevelFarm == 19 then -- Arctic Warrior [Lv. 1350]
			Name = "Arctic Warrior [Lv. 1350]"
			QuestName = "FrostQuest"

			LevelQuest = 1
			NameMon = "Arctic Warrior"

			CFrameMon = CFrame.new(6038, 29, -6231)
			VectorMon = Vector3.new(6038, 29, -6231)

			VectorQuest = Vector3.new(5669, 28, -6482)
			CFrameQuest = CFrame.new(5669, 28, -6482)
		elseif LevelFarm == 20 then -- Snow Lurker [Lv. 1375]
			Name = "Snow Lurker [Lv. 1375]"
			QuestName = "FrostQuest"

			LevelQuest = 2
			NameMon = "Snow Lurker"

			CFrameMon = CFrame.new(5560, 42, -6826)
			VectorMon = Vector3.new(5560, 42, -6826)

			VectorQuest = Vector3.new(5669, 28, -6482)
			CFrameQuest = CFrame.new(5669, 28, -6482)
		elseif LevelFarm == 21 then -- Sea Soldier [Lv. 1425]
			Name = "Sea Soldier [Lv. 1425]"
			QuestName = "ForgottenQuest"

			LevelQuest = 1
			NameMon = "Sea Soldier"

			CFrameMon = CFrame.new(-3022, 16, -9722)
			VectorMon = Vector3.new(-3022, 16, -9722)

			CFrameQuest = CFrame.new(-3054, 237, -10148)
			VectorQuest = Vector3.new(-3054, 237, -10148)
		elseif LevelFarm == 22 then -- Water Fighter [Lv. 1450]
			Name = "Water Fighter [Lv. 1450]"
			QuestName = "ForgottenQuest"

			LevelQuest = 2
			NameMon = "Water Fighter"

			CFrameMon = CFrame.new(-3385, 239, -10542)
			VectorMon = Vector3.new(-3385, 239, -10542)

			CFrameQuest = CFrame.new(-3054, 237, -10148)
			VectorQuest = Vector3.new(-3054, 237, -10148)
		end
	end
	if ThirdSea then
		if LevelFarm == 1 then
			Name = "Pirate Millionaire [Lv. 1500]"
			QuestName = "PiratePortQuest"

			LevelQuest = 1
			NameMon = "Pirate"

			CFrameMon = CFrame.new(-373, 75, 5550)
			VectorMon = Vector3.new(-373, 75, 5550)

			CFrameQuest = CFrame.new(-288, 44, 5576)
			VectorQuest = Vector3.new(-288, 44, 5576)
		elseif LevelFarm == 2 then
			Name = "Pistol Billionaire [Lv. 1525]"
			QuestName = "PiratePortQuest"

			LevelQuest = 2
			NameMon = "Pistol"

			CFrameMon = CFrame.new(-469, 74, 5904)
			VectorMon = Vector3.new(-469, 74, 5904)

			CFrameQuest = CFrame.new(-288, 44, 5576)
			VectorQuest = Vector3.new(-288, 44, 5576)
		elseif LevelFarm == 3 then
			Name = "Dragon Crew Warrior [Lv. 1575]"
			QuestName = "AmazonQuest"

			LevelQuest = 1
			NameMon = "Warrior"

			CFrameMon = CFrame.new(6339, 52, -1213)
			VectorMon = Vector3.new(6338, 52, -1213)

			CFrameQuest = CFrame.new(5835, 52, -1105)
			VectorQuest = Vector3.new(5835, 52, -1105)
		elseif LevelFarm == 4 then
			Name = "Dragon Crew Archer [Lv. 1600]"
			QuestName = "AmazonQuest"

			LevelQuest = 2
			NameMon = "Archer"

			CFrameMon = CFrame.new(6594, 383, 139)
			VectorMon = Vector3.new(6594, 383, 139)

			CFrameQuest = CFrame.new(5835, 52, -1105)
			VectorQuest = Vector3.new(5835, 52, -1105)
		elseif LevelFarm == 5 then
			Name = "Female Islander [Lv. 1625]"
			QuestName = "AmazonQuest2"

			LevelQuest = 1
			NameMon = "Female"

			CFrameMon = CFrame.new(5308, 819, 1047)
			VectorMon = Vector3.new(5308, 819, 1047)

			CFrameQuest = CFrame.new(5443, 602, 751)
			VectorQuest = Vector3.new(5443, 602, 751)
		elseif LevelFarm == 6 then
			Name = "Giant Islander [Lv. 1650]"
			QuestName = "AmazonQuest2"

			LevelQuest = 2
			NameMon = "Giant Islanders"

			CFrameMon = CFrame.new(4951, 602, -68)
			VectorMon = Vector3.new(4951, 602, -68)

			CFrameQuest = CFrame.new(5443, 602, 751)
			VectorQuest = Vector3.new(5443, 602, 751)
		elseif LevelFarm == 7 then
			Name = "Marine Commodore [Lv. 1700]"
			QuestName = "MarineTreeIsland"

			LevelQuest = 1
			NameMon = "Marine Commodore"

			CFrameMon = CFrame.new(2447, 73, -7470)
			VectorMon = Vector3.new(2447, 73, -7470)

			CFrameQuest = CFrame.new(2180, 29, -6737)
			VectorQuest = Vector3.new(2180, 29, -6737)
		elseif LevelFarm == 8 then
			Name = "Marine Rear Admiral [Lv. 1725]"
			QuestName = "MarineTreeIsland"

			LevelQuest = 2
			NameMon = "Marine Rear Admiral"

			CFrameMon = CFrame.new(3671, 161, -6932)
			VectorMon = Vector3.new(3671, 161, -6932)

			CFrameQuest = CFrame.new(2180, 29, -6737)
			VectorQuest = Vector3.new(2180, 29, -6737)
		elseif LevelFarm == 9 then
			Name = "Fishman Raider [Lv. 1775]"
			QuestName = "DeepForestIsland3"

			LevelQuest = 1
			NameMon = "Fishman Raider"

			CFrameMon = CFrame.new(-10560, 332, -8466)
			VectorMon = Vector3.new(-10560, 332, -8466)

			CFrameQuest = CFrame.new(-10584, 332, -8758)
			VectorQuest = Vector3.new(-10584, 332, -8758)
		elseif LevelFarm == 10 then
			Name = "Fishman Captain [Lv. 1800]"
			QuestName = "DeepForestIsland3"

			LevelQuest = 2
			NameMon = "Fishman Captain"

			CFrameMon = CFrame.new(-10993, 332, -8940)
			VectorMon = Vector3.new(-10993, 332, -8940)

			CFrameQuest = CFrame.new(-10584, 332, -8758)
			VectorQuest = Vector3.new(-10584, 332, -8758)
		elseif LevelFarm == 11 then
			Name = "Forest Pirate [Lv. 1825]"
			QuestName = "DeepForestIsland"

			LevelQuest = 1
			NameMon = "Forest Pirate"

			CFrameMon = CFrame.new(-13479, 333, -7905)
			VectorMon = Vector3.new(-13479, 333, -7905)

			CFrameQuest = CFrame.new(-13232, 333, -7627)
			VectorQuest = Vector3.new(-13232, 333, -7627)
		elseif LevelFarm == 12 then
			Name = "Mythological Pirate [Lv. 1850]"
			QuestName = "DeepForestIsland"

			LevelQuest = 2
			NameMon = "Mythological Pirate"

			CFrameMon = CFrame.new(-13545, 470, -6917)
			VectorMon = Vector3.new(-13545, 470, -6917)

			CFrameQuest = CFrame.new(-13232, 333, -7627)
			VectorQuest = Vector3.new(-13232, 333, -7627)
		elseif LevelFarm == 13 then
			Name = "Jungle Pirate [Lv. 1900]"
			QuestName = "DeepForestIsland2"

			LevelQuest = 1
			NameMon = "Jungle Pirate"

			CFrameMon = CFrame.new(-12107, 332, -10549)
			VectorMon = Vector3.new(-12106, 332, -10549)

			CFrameQuest = CFrame.new(-12684, 391, -9902)
			VectorQuest = Vector3.new(-12684, 391, -9902)
		elseif LevelFarm == 14 then
			Name = "Musketeer Pirate [Lv. 1925]"
			QuestName = "DeepForestIsland2"

			LevelQuest = 2
			NameMon = "Musketeer Pirate"

			CFrameMon = CFrame.new(-13286, 392, -9769)
			VectorMon = Vector3.new(-13286, 392, -9768)

			CFrameQuest = CFrame.new(-12684, 391, -9902)
			VectorQuest = Vector3.new(-12684, 391, -9902)
		elseif LevelFarm == 15 then
			Name = "Reborn Skeleton [Lv. 1975]"
			QuestName = "HauntedQuest1"

			LevelQuest = 1
			NameMon = "Reborn Skeleton"

			CFrameMon = CFrame.new(-8760, 142, 6039)
			VectorMon = Vector3.new(-8760, 142, 6039)

			CFrameQuest = CFrame.new(-9482, 142, 5567)
			VectorQuest = Vector3.new(-9482, 142, 5567)
		elseif LevelFarm == 16 then
			Name = "Living Zombie [Lv. 2000]"
			QuestName = "HauntedQuest1"

			LevelQuest = 2
			NameMon = "Living Zombie"

			CFrameMon = CFrame.new(-10144, 140, 5932)
			VectorMon = Vector3.new(-10144, 140, 5932)

			CFrameQuest = CFrame.new(-9482, 142, 5567)
			VectorQuest = Vector3.new(-9482, 142, 5567)
		elseif LevelFarm == 17 then
			Name = "Demonic Soul [Lv. 2025]"
			QuestName = "HauntedQuest2"

			LevelQuest = 1
			NameMon = "Demonic Soul"

			CFrameMon = CFrame.new(-9507, 172, 6158)
			VectorMon = Vector3.new(-9506, 172, 6158)

			CFrameQuest = CFrame.new(-9513, 172, 6079)
			VectorQuest = Vector3.new(-9513, 172, 6079)
		elseif LevelFarm == 18 then
			Name = "Posessed Mummy [Lv. 2050]"
			QuestName = "HauntedQuest2"

			LevelQuest = 2
			NameMon = "Posessed Mummy"

			CFrameMon = CFrame.new(-9577, 6, 6223)
			VectorMon = Vector3.new(-9577, 6, 6223)

			CFrameQuest = CFrame.new(-9513, 172, 6079)
			VectorQuest = Vector3.new(-9513, 172, 6079)

		elseif LevelFarm == 19 then
			Name = "Peanut Scout [Lv. 2075]"
			QuestName = "NutsIslandQuest"

			LevelQuest = 1
			NameMon = "Peanut Scout"

			CFrameMon = CFrame.new(-2124, 123, -10435)
			VectorMon = Vector3.new(-2124, 123, -10435)

			CFrameQuest = CFrame.new(-2104, 38, -10192)
			VectorQuest = Vector3.new(-2104, 38, -10192)
		elseif LevelFarm == 20 then
			Name = "Peanut President [Lv. 2100]"
			QuestName = "NutsIslandQuest"

			LevelQuest = 2
			NameMon = "Peanut President"

			CFrameMon = CFrame.new(-2124, 123, -10435)
			VectorMon = Vector3.new(-2124, 123, -10435)

			CFrameQuest = CFrame.new(-2104, 38, -10192)
			VectorQuest = Vector3.new(-2104, 38, -10192)
		elseif LevelFarm == 21 then
			Name = "Ice Cream Chef [Lv. 2125]"
			QuestName = "IceCreamIslandQuest"

			LevelQuest = 1
			NameMon = "Ice Cream Chef"

			CFrameMon = CFrame.new(-641, 127, -11062)
			VectorMon = Vector3.new(-641, 127, -11062)

			CFrameQuest = CFrame.new(-822, 66, -10965)
			VectorQuest = Vector3.new(-822, 66, -10965)
		elseif LevelFarm == 22 then
			Name = "Ice Cream Commander [Lv. 2150]"
			QuestName = "IceCreamIslandQuest"

			LevelQuest = 2
			NameMon = "Ice Cream Commander"

			CFrameMon = CFrame.new(-641, 127, -11062)
			VectorMon = Vector3.new(-641, 127, -11062)

			CFrameQuest = CFrame.new(-822, 66, -10965)
			VectorQuest = Vector3.new(-822, 66, -10965)
		elseif LevelFarm == 23 then
			Name = "Cookie Crafter [Lv. 2200]"
			QuestName = "CakeQuest1"

			LevelQuest = 1
			NameMon = "Cookie Crafter"

			CFrameMon = CFrame.new(-2365, 38, -12099)
			VectorMon = Vector3.new(-2365, 38, -12099)

			CFrameQuest = CFrame.new(-2020, 38, -12025)
			VectorQuest = Vector3.new(-2020, 38, -12025)
		elseif LevelFarm == 24 then
			Name = "Cake Guard [Lv. 2225]"
			QuestName = "CakeQuest1"

			LevelQuest = 2
			NameMon = "Cake Guard"

			CFrameMon = CFrame.new(-1651, 38, -12308)
			VectorMon = Vector3.new(-1651, 38, -12308)

			CFrameQuest = CFrame.new(-2020, 38, -12025)
			VectorQuest = Vector3.new(-2020, 38, -12025)
		elseif LevelFarm == 25 then
			Name = "Baking Staff [Lv. 2250]"
			QuestName = "CakeQuest2"

			LevelQuest = 1
			NameMon = "Baking Staff"

			CFrameMon = CFrame.new(-1870, 38, -12938)
			VectorMon = Vector3.new(-1870, 38, -12938)

			CFrameQuest = CFrame.new(-1926, 38, -12850)
			VectorQuest = Vector3.new(-1926, 38, -12850)
		elseif LevelFarm == 26 then
			Name = "Head Baker [Lv. 2275]"
			QuestName = "CakeQuest2"

			LevelQuest = 2
			NameMon = "Head Baker"

			CFrameMon = CFrame.new(-1926, 88, -12850)
			VectorMon = CFrame.new(-1870, 38, -12938)

			CFrameQuest = CFrame.new(-1926, 38, -12850)
			VectorQuest = Vector3.new(-1926, 38, -12850)
		elseif LevelFarm == 27 then
			Name = "Cocoa Warrior [Lv. 2300]"
			QuestName = "ChocQuest1"

			LevelQuest = 1
			NameMon = "Cocoa Warrior"

			CFrameMon = CFrame.new(231, 23, -12194)
			VectorMon = CFrame.new(231, 23, -12194)

			CFrameQuest = CFrame.new(231, 23, -12194)
			VectorQuest = Vector3.new(231, 23, -12194)
		elseif LevelFarm == 28 then				
			Name = "Chocolate Bar Battler [Lv. 2325]"
			QuestName = "ChocQuest1"

			LevelQuest = 2
			NameMon = "Chocolate Bar Battler"

			CFrameMon = CFrame.new(231, 23, -12194)
			VectorMon = CFrame.new(231, 23, -12194)

			CFrameQuest = CFrame.new(231, 23, -12194)
			VectorQuest = Vector3.new(231, 23, -12194)
		elseif LevelFarm == 29 then				
			Name = "Sweet Thief [Lv. 2350]"
			QuestName = "ChocQuest2"

			LevelQuest = 1
			NameMon = "Sweet Thief"

			CFrameMon = CFrame.new(71, 77, -12632)
			VectorMon = CFrame.new(71, 77, -12632)

			CFrameQuest = CFrame.new(151, 23, -12774)
			VectorQuest = Vector3.new(151, 23, -12774)
		elseif LevelFarm == 30 then				
			Name = "Candy Rebel [Lv. 2375]"
			QuestName = "ChocQuest2"

			LevelQuest = 2
			NameMon = "Candy Rebel"

			CFrameMon = CFrame.new(134, 77, -12882)
			VectorMon = CFrame.new(134, 77, -12882)

			CFrameQuest = CFrame.new(151, 23, -12774)
			VectorQuest = Vector3.new(151, 23, -12774)
		end
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------
do  local ui =  game:GetService("CoreGui"):FindFirstChild("Ui Native Hub")  if ui then ui:Destroy() end end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()



local function Tween(instance, properties,style,wa)
	if style == nil or "" then
		return Back
	end
	tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
end

local ActualTypes = {
	RoundFrame = "ImageLabel",
	Shadow = "ImageLabel",
	Circle = "ImageLabel",
	CircleButton = "ImageButton",
	Frame = "Frame",
	Label = "TextLabel",
	Button = "TextButton",
	SmoothButton = "ImageButton",
	Box = "TextBox",
	ScrollingFrame = "ScrollingFrame",
	Menu = "ImageButton",
	NavBar = "ImageButton"
}

local Properties = {
	RoundFrame = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	SmoothButton = {
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554237731",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(3,3,297,297)
	},
	Shadow = {
		Name = "Shadow",
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554236805",
		ScaleType = Enum.ScaleType.Slice,
		SliceCenter = Rect.new(23,23,277,277),
		Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
		Position = UDim2.fromOffset(-15,-15)
	},
	Circle = {
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	CircleButton = {
		BackgroundTransparency = 1,
		AutoButtonColor = false,
		Image = "http://www.roblox.com/asset/?id=5554831670"
	},
	Frame = {
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.fromScale(1,1)
	},
	Label = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Button = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	Box = {
		BackgroundTransparency = 1,
		Position = UDim2.fromOffset(5,0),
		Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left
	},
	ScrollingFrame = {
		BackgroundTransparency = 1,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.fromScale(0,0),
		Size = UDim2.fromScale(1,1)
	},
	Menu = {
		Name = "More",
		AutoButtonColor = false,
		BackgroundTransparency = 1,
		Image = "http://www.roblox.com/asset/?id=5555108481",
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
	},
	NavBar = {
		Name = "SheetToggle",
		Image = "http://www.roblox.com/asset/?id=5576439039",
		BackgroundTransparency = 1,
		Size = UDim2.fromOffset(20,20),
		Position = UDim2.fromOffset(5,5),
		AutoButtonColor = false
	}
}

local Types = {
	"RoundFrame",
	"Shadow",
	"Circle",
	"CircleButton",
	"Frame",
	"Label",
	"Button",
	"SmoothButton",
	"Box",
	"ScrollingFrame",
	"Menu",
	"NavBar"
}

function FindType(String)
	for _, Type in next, Types do
		if Type:sub(1, #String):lower() == String:lower() then
			return Type
		end
	end
	return false
end

local Objects = {}

function Objects.new(Type)
	local TargetType = FindType(Type)
	if TargetType then
		local NewImage = Instance.new(ActualTypes[TargetType])
		if Properties[TargetType] then
			for Property, Value in next, Properties[TargetType] do
				NewImage[Property] = Value
			end
		end
		return NewImage
	else
		return Instance.new(Type)
	end
end

local function GetXY(GuiObject)
	local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
	local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
	return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
	local PX, PY = GetXY(GuiObject)
	local Circle = Objects.new("Circle")
	Circle.Size = UDim2.fromScale(0,0)
	Circle.Position = UDim2.fromScale(PX,PY)
	Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
	Circle.ZIndex = 200
	Circle.Parent = GuiObject
	local Size = GuiObject.AbsoluteSize.X
	TweenService:Create(Circle, TweenInfo.new(0.4), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
	spawn(function()
		wait(0.4)
		Circle:Destroy()
	end)
end


local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil	
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
        local Tween = TweenService:Create(object, TweenInfo.new(0.2), {Position = pos})
        Tween:Play()
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                input.UserInputType == Enum.UserInputType.Touch
            then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end


local Lib = {}

function Lib:Window(text)
    local UiNativeHub = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICornerMain = Instance.new("UICorner")
    local Top = Instance.new("Frame")
    local UICornerTop = Instance.new("UICorner")
    local logo = Instance.new("ImageLabel")
    local Tab = Instance.new("Frame")
    local ScrollingTab = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local UIPadding = Instance.new("UIPadding")
    local NameReal = Instance.new("TextLabel")
    local ImageTab = Instance.new("ImageLabel")
    local MainPage = Instance.new("Frame")
    local UICornerPage = Instance.new("UICorner")
    local PageFolder = Instance.new("Folder")
    local UIPageLayout = Instance.new("UIPageLayout")
    local Tabtoggle = false
    local abc = false

    UiNativeHub.Name = "Ui Native Hub"
    UiNativeHub.Parent = game.CoreGui
    UiNativeHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Main.Name = "Main"
    Main.Parent = UiNativeHub
    Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Main.BorderSizePixel = 0
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.240740746, 0, 0.286585361, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)

    pcall(Main:TweenSize(UDim2.new(0, 700, 0, 380),"Out","Back",0.4,true))

    UICornerMain.CornerRadius = UDim.new(0, 4)
    UICornerMain.Name = "UICornerMain"
    UICornerMain.Parent = Main
    
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 700, 0, 38)
    
    UICornerTop.CornerRadius = UDim.new(0, 4)
    UICornerTop.Name = "UICornerTop"
    UICornerTop.Parent = Top
    
    logo.Name = "logo"
    logo.Parent = Top
    logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    logo.BackgroundTransparency = 1.000
    logo.Position = UDim2.new(0.0157142859, 0, 0, 0)
    logo.Size = UDim2.new(0, 43, 0, 38)
    logo.Image = "rbxassetid://11269540857"
    
    NameReal.Name = "NameReal"
    NameReal.Parent = Top
    NameReal.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NameReal.BackgroundTransparency = 1.000
    NameReal.Position = UDim2.new(0.0900000036, 0, 0, 0)
    NameReal.Size = UDim2.new(0, 170, 0, 38)
    NameReal.Font = Enum.Font.GothamBold
    NameReal.Text = text
    NameReal.TextColor3 = Color3.fromRGB(255,255,255)
    NameReal.TextSize = 16.000
    NameReal.TextXAlignment = Enum.TextXAlignment.Left
    
    ImageTab.Name = "ImageTab"
    ImageTab.Parent = Top
    ImageTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageTab.BackgroundTransparency = 1.000
    ImageTab.Position = UDim2.new(0.940000057, 0, 0.105263151, 0)
    ImageTab.Size = UDim2.new(0, 30, 0, 30)
    ImageTab.Image = "http://www.roblox.com/asset/?id=11271966220"
    
    local TabButtonnnn = Instance.new("TextButton")
    TabButtonnnn.Parent = ImageTab
    TabButtonnnn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabButtonnnn.BackgroundTransparency = 1.000
    TabButtonnnn.Size = UDim2.new(0, 30, 0, 30)
    TabButtonnnn.Font = Enum.Font.SourceSans
    TabButtonnnn.Text = ""
    TabButtonnnn.TextColor3 = Color3.fromRGB(0, 0, 0)
    TabButtonnnn.TextSize = 14.000
    
    Tab.Name = "Tab"
    Tab.Parent = Main
    Tab.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Tab.BorderSizePixel = 0
    Tab.ClipsDescendants = true
    Tab.Position = UDim2.new(0, 0, 0.100000001, 0)
    Tab.Size = UDim2.new(0, 0, 0, 342)
    Tab.ZIndex = 2

    ScrollingTab.Name = "ScrollingTab"
    ScrollingTab.Parent = Tab
    ScrollingTab.Active = true
    ScrollingTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingTab.BackgroundTransparency = 1.000
    ScrollingTab.BorderSizePixel = 0
    ScrollingTab.Size = UDim2.new(0, 247, 0, 342)
    ScrollingTab.ScrollBarThickness = 4
    ScrollingTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingTab.ClipsDescendants = true

    TabList.Name = "TabList"
    TabList.Parent = ScrollingTab
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 3)



    UIPadding.Parent = ScrollingTab
    UIPadding.PaddingTop = UDim.new(0, 5)
    
    MainPage.Name = "MainPage"
    MainPage.Parent = Main
    MainPage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    MainPage.BorderSizePixel = 0
    MainPage.Position = UDim2.new(0.0157142859, 0, 0.126315787, 0)
    MainPage.Size = UDim2.new(0, 677, 0, 318)
    MainPage.ClipsDescendants = true
    
    UICornerPage.CornerRadius = UDim.new(0, 4)
    UICornerPage.Name = "UICornerPage"
    UICornerPage.Parent = MainPage
    
    PageFolder.Name = "PageFolder"
    PageFolder.Parent = MainPage
    
    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.GamepadInputEnabled = false
    UIPageLayout.ScrollWheelInputEnabled = false
    UIPageLayout.TouchInputEnabled = false
    UIPageLayout.TweenTime = 0.300



    local Black = Instance.new("Frame")
    Black.Name = "Black"
    Black.Parent = Main
    Black.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Black.BackgroundTransparency = .3
    Black.BorderSizePixel = 0
    Black.Position = UDim2.new(0, 0, 0.086585361, 0)
    Black.Size = UDim2.new(0, 0, 0, 342)
    
    
    UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.P then
			if uihide == false then
				uihide = true
                pcall(Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true))
			else
				uihide = false
				pcall(Main:TweenSize(UDim2.new(0, 700, 0, 380),"Out","Back",0.4,true))
			end
		end
	end)
    
    TabButtonnnn.MouseButton1Click:Connect(function()
        if Tabtoggle == false then
            Tabtoggle = true
            TweenService:Create(
                Tab,
                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 247, 0, 342)}
            ):Play()
            TweenService:Create(
                Black,
                TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 700, 0, 342)}
            ):Play()
            TweenService:Create(
                ImageTab,
                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {ImageColor3 = Color3.fromRGB(32,143,252)}
            ):Play()
        else
            Tabtoggle = false
            TweenService:Create(
                Tab,
                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 342)}
            ):Play()
            TweenService:Create(
                Black,
                TweenInfo.new(0,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {Size = UDim2.new(0, 0, 0, 342)}
            ):Play()
            TweenService:Create(
                ImageTab,
                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {ImageColor3 = Color3.fromRGB(255, 255, 255)}
            ):Play()
        end
    end)

    local Ui = {}

    function Ui:Tab(text)
        local TabFrame = Instance.new("Frame")
        local Tabb = Instance.new("Frame")
        local UICornerTabb = Instance.new("UICorner")
        local UIGradientTabb = Instance.new("UIGradient")
        local TextTab = Instance.new("TextLabel")
        local TextButton = Instance.new("TextButton")
        local MainFramePage = Instance.new("Frame")
        local UICornerMainFramePage = Instance.new("UICorner")

        TabFrame.Name = "TabFrame"
        TabFrame.Parent = ScrollingTab
        TabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabFrame.BackgroundTransparency = 1.000
        TabFrame.Size = UDim2.new(0, 247, 0, 40)
        
        Tabb.Name = "Tabb"
        Tabb.Parent = TabFrame
        Tabb.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tabb.ClipsDescendants = true
        Tabb.Position = UDim2.new(0.0445344113, 0, 0.125, 0)
        Tabb.Size = UDim2.new(0, 222, 0, 30)
        
        UICornerTabb.CornerRadius = UDim.new(0, 4)
        UICornerTabb.Name = "UICornerTabb"
        UICornerTabb.Parent = Tabb
        
        UIGradientTabb.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(32,143,252)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(160, 212, 255))}
        UIGradientTabb.Name = "UIGradientTabb"
        UIGradientTabb.Parent = Tabb
        
        TextTab.Name = "TextTab"
        TextTab.Parent = Tabb
        TextTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextTab.BackgroundTransparency = 1.000
        TextTab.Size = UDim2.new(0, 222, 0, 30)
        TextTab.Font = Enum.Font.GothamBold
        TextTab.Text = text
        TextTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextTab.TextSize = 15.000
        
        TextButton.Parent = TabFrame
        TextButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextButton.BackgroundTransparency = 1.000
        TextButton.Size = UDim2.new(0, 247, 0, 40)
        TextButton.Font = Enum.Font.SourceSans
        TextButton.Text = ""
        TextButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        TextButton.TextSize = 14.000
        
        MainFramePage.Name = "MainFramePage"
        MainFramePage.Parent = PageFolder
        MainFramePage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        MainFramePage.BorderSizePixel = 0
        MainFramePage.Position = UDim2.new(0.0925237387, 0, 0.132605091, 0)
        MainFramePage.Size = UDim2.new(0, 677, 0, 318)
        MainFramePage.ClipsDescendants = true
        
        UICornerMainFramePage.CornerRadius = UDim.new(0, 4)
        UICornerMainFramePage.Name = "UICornerMainFramePage"
        UICornerMainFramePage.Parent = MainFramePage

        local ScrollMainPage = Instance.new("ScrollingFrame")
        local UIListLayoutPage = Instance.new("UIListLayout")
        
        ScrollMainPage.Name = "ScrollMainPage"
        ScrollMainPage.Parent = MainFramePage
        ScrollMainPage.Active = true
        ScrollMainPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ScrollMainPage.BackgroundTransparency = 1.000
        ScrollMainPage.BorderSizePixel = 0
        ScrollMainPage.Size = UDim2.new(0, 677, 0, 318)
        ScrollMainPage.CanvasSize = UDim2.new(0, 0, 0, 0)
        ScrollMainPage.ScrollBarThickness = 0
        
        UIListLayoutPage.Name = "UIListLayoutPage"
        UIListLayoutPage.Parent = ScrollMainPage
        UIListLayoutPage.FillDirection = Enum.FillDirection.Horizontal
        UIListLayoutPage.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutPage.Padding = UDim.new(0, 7)

        local UIPaddingPage = Instance.new("UIPadding")
        
        UIPaddingPage.Name = "UIPaddingPage"
        UIPaddingPage.Parent = ScrollMainPage
        UIPaddingPage.PaddingLeft = UDim.new(0, 7)
        UIPaddingPage.PaddingTop = UDim.new(0, 12)

        MakeDraggable(Top,Main)


        TextButton.MouseButton1Click:Connect(function()
            CircleAnim(Tabb, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
            TextTab.TextSize = 0
            TweenService:Create(
                TextTab,
                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                {TextSize = 15}
            ):Play()
            for i,v in next, PageFolder:GetChildren() do 
                if v.Name == "MainFramePage" then
                    currenttab = v.Name
                end
                UIPageLayout:JumpTo(MainFramePage)
                
            end
		end)

		if abc == false then
            UIPageLayout:JumpToIndex(1)
			abc = true
		end

        local Tab = {}

        function Tab:Page()

            local MainFramePage_2 = Instance.new("Frame")
            local UICornerMainFramePage_2 = Instance.new("UICorner")
            local ScrollingMainFramePage = Instance.new("ScrollingFrame")
            local UIListLayoutMainFramePage = Instance.new("UIListLayout")



            MainFramePage_2.Name = "MainFramePage"
            MainFramePage_2.Parent = ScrollMainPage
            MainFramePage_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
            MainFramePage_2.BorderSizePixel = 0
            MainFramePage_2.ClipsDescendants = true
            MainFramePage_2.Position = UDim2.new(-0.010447761, 0, -0.00326797389, 0)
            MainFramePage_2.Size = UDim2.new(0, 328, 0, 296)

            UICornerMainFramePage_2.CornerRadius = UDim.new(0, 4)
            UICornerMainFramePage_2.Name = "UICornerMainFramePage"
            UICornerMainFramePage_2.Parent = MainFramePage_2

            ScrollingMainFramePage.Name = "ScrollingMainFramePage"
            ScrollingMainFramePage.Parent = MainFramePage_2
            ScrollingMainFramePage.Active = true
            ScrollingMainFramePage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ScrollingMainFramePage.BackgroundTransparency = 1.000
            ScrollingMainFramePage.BorderSizePixel = 0
            ScrollingMainFramePage.Size = UDim2.new(0, 328, 0, 296)
            ScrollingMainFramePage.CanvasSize = UDim2.new(0, 0, 0, 0)
            ScrollingMainFramePage.ScrollBarThickness = 0

            UIListLayoutMainFramePage.Name = "UIListLayoutMainFramePage"
            UIListLayoutMainFramePage.Parent = ScrollingMainFramePage
            UIListLayoutMainFramePage.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayoutMainFramePage.Padding = UDim.new(0, 8)


            local UIPaddingMainFramePage = Instance.new("UIPadding")

            UIPaddingMainFramePage.Name = "UIPaddingMainFramePage"
            UIPaddingMainFramePage.Parent = ScrollingMainFramePage
            UIPaddingMainFramePage.PaddingTop = UDim.new(0, 9)
            
            
            game:GetService("RunService").Stepped:Connect(function()
                pcall(function()
                    ScrollingMainFramePage.CanvasSize = UDim2.new(0,0,0,UIListLayoutMainFramePage.AbsoluteContentSize.Y + 26)
                    ScrollingTab.CanvasSize = UDim2.new(0,0,0,TabList.AbsoluteContentSize.Y + 10)
                end)
            end)

            local main = {}
            function main:Toggle2(text,default,callback)
                local ToggleFrame2 = Instance.new("Frame")
                local TextToggle2 = Instance.new("TextLabel")
                local Toggle_2 = Instance.new("Frame")
                local UICornerToggle2 = Instance.new("UICorner")
                local Tgle2 = Instance.new("ImageLabel")
                local ButtonTgle2 = Instance.new("TextButton")
                local toggle2 = false
                local lock2 = false

                ToggleFrame2.Name = "ToggleFrame2"
                ToggleFrame2.Parent = ScrollingMainFramePage
                ToggleFrame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleFrame2.BackgroundTransparency = 1.000
                ToggleFrame2.ClipsDescendants = true
                ToggleFrame2.Size = UDim2.new(0, 328, 0, 32)

                TextToggle2.Name = "TextToggle2"
                TextToggle2.Parent = ToggleFrame2
                TextToggle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextToggle2.BackgroundTransparency = 1.000
                TextToggle2.Position = UDim2.new(0.23780489, 0, 0, 0)
                TextToggle2.Size = UDim2.new(0, 192, 0, 32)
                TextToggle2.Font = Enum.Font.GothamBold
                TextToggle2.Text = "Auto Farm Level"
                TextToggle2.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextToggle2.TextSize = 14.000
                TextToggle2.TextXAlignment = Enum.TextXAlignment.Left

                Toggle_2.Name = "Toggle"
                Toggle_2.Parent = ToggleFrame2
                Toggle_2.BackgroundColor3 = Color3.fromRGB(39, 39, 39)
                Toggle_2.BorderSizePixel = 0
                Toggle_2.Position = UDim2.new(0.103658535, 0, 0.0625, 0)
                Toggle_2.Size = UDim2.new(0, 28, 0, 28)

                UICornerToggle2.CornerRadius = UDim.new(0, 4)
                UICornerToggle2.Name = "UICornerToggle2"
                UICornerToggle2.Parent = Toggle_2

                Tgle2.Name = "Tgle2"
                Tgle2.Parent = Toggle_2
                Tgle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Tgle2.BackgroundTransparency = 1.000
                Tgle2.Position = UDim2.new(0.0357142873, 0, 0.0357142873, 0)
                Tgle2.Size = UDim2.new(0, 26, 0, 26)
                Tgle2.Image = "rbxassetid://6031068421"
                Tgle2.ImageColor3 = Color3.fromRGB(32,143,252)

                ButtonTgle2.Name = "ButtonTgle2"
                ButtonTgle2.Parent = ToggleFrame2
                ButtonTgle2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonTgle2.BackgroundTransparency = 1.000
                ButtonTgle2.Size = UDim2.new(0, 328, 0, 32)
                ButtonTgle2.Font = Enum.Font.SourceSans
                ButtonTgle2.Text = ""
                ButtonTgle2.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonTgle2.TextSize = 14.000

                
                if default == false then
                    toggle_lol = false
                    TweenService:Create(
                        Tgle2,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {ImageTransparency = 1}
                    ):Play()
                    callback(toggle_lol)
                end
                if default == true then
                    toggle_lol = true
                    TweenService:Create(
                        Tgle2,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {ImageTransparency = 0}
                    ):Play()
                    callback(toggle_lol)
                end
                ButtonTgle2.MouseButton1Click:Connect(function()
                    if Tabtoggle == false then
                        if toggle_lol == false and lock2 == false then
                            toggle_lol = true
                            TweenService:Create(
                                Tgle2,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {ImageTransparency = 0}
                            ):Play()
                            callback(toggle_lol)
                        elseif toggle_lol == true and lock2 == false then
                            toggle_lol = false
                            TweenService:Create(
                                Tgle2,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {ImageTransparency = 1}
                            ):Play()
                            callback(toggle_lol)
                        end
                    end
                end
                )
            end

            function main:Button(text,callback)
                local FrameButton = Instance.new("Frame")
                local Btn = Instance.new("Frame")
                local UICornerBtn = Instance.new("UICorner")
                local UIGradientBtn = Instance.new("UIGradient")
                
                local TextLabelBtn = Instance.new("TextLabel")
                local ButtonBtn = Instance.new("TextButton")

                FrameButton.Name = "FrameButton"
                FrameButton.Parent = ScrollingMainFramePage
                FrameButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                FrameButton.BackgroundTransparency = 1.000
                FrameButton.Size = UDim2.new(0, 328, 0, 32)
                
                Btn.Name = "Btn"
                Btn.Parent = FrameButton
                Btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Btn.BorderSizePixel = 0
                Btn.Position = UDim2.new(0.0487804897, 0, 0.03125, 0)
                Btn.Size = UDim2.new(0, 296, 0, 30)
                Btn.ClipsDescendants = true

                UICornerBtn.CornerRadius = UDim.new(0, 4)
                UICornerBtn.Name = "UICornerBtn"
                UICornerBtn.Parent = Btn
                



                UIGradientBtn.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(32,143,252)), ColorSequenceKeypoint.new(0.50, Color3.fromRGB(101, 185, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(32,143,252))}
                UIGradientBtn.Name = "UIGradientBtn"
                UIGradientBtn.Parent = Btn
                
                TextLabelBtn.Name = "TextLabelBtn"
                TextLabelBtn.Parent = Btn
                TextLabelBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelBtn.BackgroundTransparency = 1.000
                TextLabelBtn.Size = UDim2.new(0, 296, 0, 30)
                TextLabelBtn.Font = Enum.Font.GothamBold
                TextLabelBtn.Text = text
                TextLabelBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextLabelBtn.TextSize = 14.000
                
                ButtonBtn.Name = "ButtonBtn"
                ButtonBtn.Parent = FrameButton
                ButtonBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonBtn.BackgroundTransparency = 1.000
                ButtonBtn.Size = UDim2.new(0, 328, 0, 31)
                ButtonBtn.Font = Enum.Font.SourceSans
                ButtonBtn.Text = ""
                ButtonBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonBtn.TextSize = 14.000
                
                ButtonBtn.MouseButton1Click:Connect(function()
                    if Tabtoggle == false then
                        CircleAnim(Btn, Color3.fromRGB(255,255,255), Color3.fromRGB(255,255,255))
                        TextLabelBtn.TextSize = 0
                        TweenService:Create(
                            TextLabelBtn,
                            TweenInfo.new(0.4,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {TextSize = 14}
                        ):Play()
                        callback()
                    end
                end)
            end
            function main:Line()
                local LineFrame = Instance.new("Frame")
				local Line = Instance.new("Frame")
				local LineUIGradient = Instance.new("UIGradient")

				LineFrame.Name = "LineFrame"
				LineFrame.Parent = ScrollingMainFramePage
				LineFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				LineFrame.BackgroundTransparency = 1.000
				LineFrame.Size = UDim2.new(0, 328, 0, 21)

				Line.Name = "LineMain"
				Line.Parent = LineFrame
				Line.AnchorPoint = Vector2.new(0.5, 0.5)
				Line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Line.BorderSizePixel = 0
				Line.Position = UDim2.new(0.5, 0, 0.428571433, 0)
				Line.Size = UDim2.new(0, 296, 0, 2)

				LineUIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(15, 15, 15)), ColorSequenceKeypoint.new(0.16, Color3.fromRGB(0,90,165)), ColorSequenceKeypoint.new(0.51, Color3.fromRGB(32,143,252)), ColorSequenceKeypoint.new(0.85, Color3.fromRGB(0,90,165)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(15, 15, 15))}
				LineUIGradient.Name = "LineUIGradient"
				LineUIGradient.Parent = Line
            end
            function main:Label(text)
                local LabelFrame = Instance.new("Frame")
                local textlabel = Instance.new("TextLabel")
                local labelfunc = {}


                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = ScrollingMainFramePage
                LabelFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelFrame.BackgroundTransparency = 1.000
                LabelFrame.ClipsDescendants = true
                LabelFrame.Size = UDim2.new(0, 328, 0, 32)

                textlabel.Name = "TextToggle"
                textlabel.Parent = LabelFrame
                textlabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                textlabel.BackgroundTransparency = 1.000
                textlabel.Position = UDim2.new(0.090, 0, 0, 0)
                textlabel.Size = UDim2.new(0, 192, 0, 32)
                textlabel.Font = Enum.Font.GothamBold
                textlabel.Text = text
                textlabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                textlabel.TextSize = 14.000
                textlabel.TextXAlignment = Enum.TextXAlignment.Left

                function labelfunc:Refresh(newtext)
                    textlabel.Text = newtext
                end

                return labelfunc
            end
            function main:Toggle(text,default,callback)
                local ToggleFrame = Instance.new("Frame")
                local TextToggle = Instance.new("TextLabel")
                local Toggle = Instance.new("Frame")
                local UICornerToggle = Instance.new("UICorner")
                local Tgle = Instance.new("Frame")
                local UICornerTgle = Instance.new("UICorner")
                local ButtonToggle = Instance.new("TextButton")
                default = default or false
                local toggle = default
                local RetrunStatsToggle = {}
                local lock = false

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = ScrollingMainFramePage
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ToggleFrame.BackgroundTransparency = 1.000
                ToggleFrame.ClipsDescendants = true
                ToggleFrame.Size = UDim2.new(0, 328, 0, 32)

                TextToggle.Name = "TextToggle"
                TextToggle.Parent = ToggleFrame
                TextToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextToggle.BackgroundTransparency = 1.000
                TextToggle.Position = UDim2.new(0.104, 0, 0, 0)
                TextToggle.Size = UDim2.new(0, 192, 0, 32)
                TextToggle.Font = Enum.Font.GothamBold
                TextToggle.Text = text
                TextToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextToggle.TextSize = 14.000
                TextToggle.TextXAlignment = Enum.TextXAlignment.Left

                Toggle.Name = "Toggle"
                Toggle.Parent = ToggleFrame
                Toggle.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Toggle.BorderSizePixel = 0
                Toggle.Position = UDim2.new(0.713414609, 0, 0.09375, 0)
                Toggle.Size = UDim2.new(0, 56, 0, 25)

                UICornerToggle.CornerRadius = UDim.new(0, 9999)
                UICornerToggle.Name = "UICornerToggle"
                UICornerToggle.Parent = Toggle

                Tgle.Name = "Tgle"
                Tgle.Parent = Toggle
                Tgle.BackgroundColor3 = Color3.fromRGB(32,143,252)
                Tgle.Position = UDim2.new(0, 1, 0, 2)
                Tgle.Size = UDim2.new(0, 22, 0, 22)

                UICornerTgle.CornerRadius = UDim.new(0, 9999)
                UICornerTgle.Name = "UICornerTgle"
                UICornerTgle.Parent = Tgle

                ButtonToggle.Name = "ButtonToggle"
                ButtonToggle.Parent = ToggleFrame
                ButtonToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonToggle.BackgroundTransparency = 1.000
                ButtonToggle.Size = UDim2.new(0, 328, 0, 32)
                ButtonToggle.Font = Enum.Font.SourceSans
                ButtonToggle.Text = ""
                ButtonToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonToggle.TextSize = 14.000


                if default == false then
                    toggle = false
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 1.5, 0, 2)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 32, 0, 22)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 22, 0, 22)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 1, 0, 2)}
                    ):Play()
                    callback(toggle)
                end
                if default == true then
                    toggle = true
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 32, 0, 22)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 30, 0, 2)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 22, 0, 22)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Tgle,
                        TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0, 33, 0, 2)}
                    ):Play()
                    callback(toggle)
                end

                ButtonToggle.MouseButton1Click:Connect(function()
                    if Tabtoggle == false then
                        if toggle == false and lock == false then
                            toggle = true
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 32, 0, 22)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Position = UDim2.new(0, 30, 0, 2)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 22, 0, 22)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Position = UDim2.new(0, 33, 0, 2)}
                            ):Play()
                            callback(toggle)
                        elseif toggle == true and lock == false then
                            toggle = false
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Position = UDim2.new(0, 1.5, 0, 2)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 32, 0, 22)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 22, 0, 22)}
                            ):Play()
                            wait()
                            TweenService:Create(
                                Tgle,
                                TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                                {Position = UDim2.new(0, 1, 0, 2)}
                            ):Play()
                            callback(toggle)
                        end
                    end
                end
                )

                local lockerframe = Instance.new("Frame")

                lockerframe.Name = "lockerframe"
                lockerframe.Parent = ToggleFrame
                lockerframe.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
                lockerframe.BackgroundTransparency = 1
                lockerframe.BorderSizePixel = 0
                lockerframe.Size = UDim2.new(0, 300, 0, 32)
                lockerframe.Position = UDim2.new(0.5, 0, 0.5, 0)
                lockerframe.AnchorPoint = Vector2.new(0.5, 0.5)
    
                local LockerImageLabel = Instance.new("ImageLabel")
    
                LockerImageLabel.Parent = lockerframe
                LockerImageLabel.BackgroundTransparency = 1.000
                LockerImageLabel.BorderSizePixel = 0
                LockerImageLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
                LockerImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
                LockerImageLabel.Size = UDim2.new(0, 0, 0, 0)
                LockerImageLabel.Image = "http://www.roblox.com/asset/?id=3926305904"
                LockerImageLabel.ImageRectOffset = Vector2.new(404, 364)
                LockerImageLabel.ImageRectSize = Vector2.new(36, 36)
                LockerImageLabel.ImageColor3 = Color3.fromRGB(255,25,25)

                function RetrunStatsToggle:Lock()
                    TweenService:Create(
                        lockerframe,
                        TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {BackgroundTransparency = 0.7}
                    ):Play()
                    TweenService:Create(
                        LockerImageLabel,
                        TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {Size = UDim2.new(0, 30, 0, 30)}
                    ):Play()
                    lock = true
                end

                function RetrunStatsToggle:ChangeStateTrue()
                    if toggle == false and lock == false then
                        toggle = true
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 32, 0, 22)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 30, 0, 2)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 22, 0, 22)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 33, 0, 2)}
                        ):Play()
                        callback(toggle)
                    end
                end

                function RetrunStatsToggle:ChangeStateFalse()
                    if toggle == true and lock == false then
                        toggle = false
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 1.5, 0, 2)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 32, 0, 22)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 22, 0, 22)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Tgle,
                            TweenInfo.new(0.2,Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0, 1, 0, 2)}
                        ):Play()
                        callback(toggle)
                    end
                end
                function RetrunStatsToggle:Unlock()
                    TweenService:Create(
                        lockerframe,
                        TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {BackgroundTransparency = 1}
                    ):Play()
                    TweenService:Create(
                        LockerImageLabel,
                        TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {Size = UDim2.new(0, 0, 0, 0)}
                    ):Play()
                    lock = false
                end
                return RetrunStatsToggle
            end
            function main:Slider(text,min,max,set,callback)
                local sliderfunc = {}
                local SliderFrame = Instance.new("Frame")
                local ClickHere = Instance.new("TextButton")
                local Bar = Instance.new("Frame")
                local UICornerBar = Instance.new("UICorner")
                local BarValue = Instance.new("Frame")
                local UICornerBarValue = Instance.new("UICorner")
                local TextSlider = Instance.new("TextLabel")

                
                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = ScrollingMainFramePage
                SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                SliderFrame.BackgroundTransparency = 1.000
                SliderFrame.Position = UDim2.new(0, 0, 0.292682916, 0)
                SliderFrame.Size = UDim2.new(0, 328, 0, 56)

                ClickHere.Name = "ClickHere"
                ClickHere.Parent = SliderFrame
                ClickHere.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ClickHere.BackgroundTransparency = 1.000
                ClickHere.ClipsDescendants = true
                ClickHere.Position = UDim2.new(0.0853658542, 0, 0.642857134, 0)
                ClickHere.Size = UDim2.new(0, 271, 0, 5)
                ClickHere.Font = Enum.Font.SourceSans
                ClickHere.Text = ""
                ClickHere.TextColor3 = Color3.fromRGB(0, 0, 0)
                ClickHere.TextSize = 14.000

                Bar.Name = "Bar"
                Bar.Parent = ClickHere
                Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Bar.ClipsDescendants = true
                Bar.Size = UDim2.new(0, 271, 0, 5)

                UICornerBar.CornerRadius = UDim.new(0, 99)
                UICornerBar.Name = "UICornerBar"
                UICornerBar.Parent = Bar

                BarValue.Name = "BarValue"
                BarValue.Parent = ClickHere
                BarValue.BackgroundColor3 = Color3.fromRGB(32,143,252)
                BarValue.Size = UDim2.new((set or 0) / max, 0, 0, 5)

                UICornerBarValue.CornerRadius = UDim.new(0, 99)
                UICornerBarValue.Name = "UICornerBarValue"
                UICornerBarValue.Parent = BarValue

                TextSlider.Name = "TextSlider"
                TextSlider.Parent = SliderFrame
                TextSlider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextSlider.BackgroundTransparency = 1.000
                TextSlider.Position = UDim2.new(0.0792682916, 0, 0.196428567, 0)
                TextSlider.Size = UDim2.new(0, 200, 0, 21)
                TextSlider.Font = Enum.Font.GothamBold
                TextSlider.Text = text.." : "..tostring(set and math.floor( (set / max) * (max - min) + min) or 0)
                TextSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
                TextSlider.TextSize = 14.000
                TextSlider.TextXAlignment = Enum.TextXAlignment.Left


                
                local mouse = game.Players.LocalPlayer:GetMouse()
                local uis = game:GetService("UserInputService")


                if Value == nil then
                    Value = set
                    pcall(function()
                        callback(Value)
                    end)
                end

                
                ClickHere.MouseButton1Down:Connect(function()
                    if Tabtoggle == false then
                        Value = math.floor((((tonumber(max) - tonumber(min)) / 271) * BarValue.AbsoluteSize.X) + tonumber(min)) or 0
                        TweenService:Create(
                            BarValue,
                            TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, math.clamp(mouse.X - BarValue.AbsolutePosition.X, 0, 271), 0, 5)}
                        ):Play()
                        moveconnection = mouse.Move:Connect(function()
                            TextSlider.Text = text.." : "..Value
                            Value = math.floor((((tonumber(max) - tonumber(min)) / 271) * BarValue.AbsoluteSize.X) + tonumber(min))
                            TweenService:Create(
                                BarValue,
                                TweenInfo.new(0.1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, math.clamp(mouse.X - BarValue.AbsolutePosition.X, 0, 271), 0, 5)}
                            ):Play()
                        end)
                        releaseconnection = uis.InputEnded:Connect(function(Mouse)
                            if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
                                Value = math.floor((((tonumber(max) - tonumber(min)) / 271) * BarValue.AbsoluteSize.X) + tonumber(min))
                                pcall(function()
                                    callback(Value)
                                    TextSlider.Text = text.." : "..Value
                                end)
                                TweenService:Create(
                                    BarValue,
                                    TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                    {Size = UDim2.new(0, math.clamp(mouse.X - BarValue.AbsolutePosition.X, 0, 271), 0, 5)}
                                ):Play()
                                moveconnection:Disconnect()
                                releaseconnection:Disconnect()
                            end
                        end)
                    end
                end)

                function sliderfunc:Update(value)
                    TextSlider.Text = text.." : "..value
                    BarValue:TweenSize(UDim2.new((value or 0) / max, 0, 0, 5), "Out", "Sine", 0.2, true)
                    pcall(function()
                        callback(value)
                    end)
                end
                return sliderfunc
            end  
            function main:Dropdown(text,option,set,callback)
                local DropFrame = Instance.new("Frame")
                local Text = Instance.new("TextLabel")
                local DropImage = Instance.new("ImageLabel")
                local DownFrame = Instance.new("Frame")
                local ScrollingDown = Instance.new("ScrollingFrame")
                local ItemList = Instance.new("UIListLayout")
                local Frame = Instance.new("Frame")
                local CornerFrae = Instance.new("UICorner")
                local ButtonDrop = Instance.new("TextButton")
                local DropToggle = false
                local RetrunDrop = {}

                DropFrame.Name = "DropFrame"
                DropFrame.Parent = ScrollingMainFramePage
                DropFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropFrame.BackgroundTransparency = 1.000
                DropFrame.Position = UDim2.new(0, 0, 0.522648096, 0)
                DropFrame.Size = UDim2.new(0, 328, 0, 35)
                
                Frame.Parent = DropFrame
                Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                Frame.BorderSizePixel = 0
                Frame.Position = UDim2.new(0.0457317084, 0, 0.0285714287, 0)
                Frame.Size = UDim2.new(0, 296, 0, 32)
                Frame.ClipsDescendants = true

                DropImage.Name = "DropImage"
                DropImage.Parent = Frame
                DropImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropImage.BackgroundTransparency = 1.000
                DropImage.Position = UDim2.new(0.871374369, 0, -0.012, 0)
                DropImage.Rotation = 180.000
                DropImage.Size = UDim2.new(0, 32, 0, 32)
                DropImage.Image = "rbxassetid://6031094670"
                
                Text.Name = "Text"
                Text.Parent = Frame
                Text.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Text.BackgroundTransparency = 1.000
                Text.Position = UDim2.new(0.0354317725, 0, -0.012, 0)
                Text.Size = UDim2.new(0, 221, 0, 32)
                Text.Font = Enum.Font.GothamBold
                Text.Text = text.." : "..set
                Text.TextColor3 = Color3.fromRGB(255, 255, 255)
                Text.TextSize = 14.000
                Text.TextXAlignment = Enum.TextXAlignment.Left
                
                CornerFrae.CornerRadius = UDim.new(0, 4)
                CornerFrae.Name = "CornerFrae"
                CornerFrae.Parent = Frame

                ButtonDrop.Name = "ButtonToggle"
                ButtonDrop.Parent = DropFrame
                ButtonDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ButtonDrop.BackgroundTransparency = 1.000
                ButtonDrop.Size = UDim2.new(0, 328, 0, 40)
                ButtonDrop.Font = Enum.Font.SourceSans
                ButtonDrop.Text = ""
                ButtonDrop.TextColor3 = Color3.fromRGB(0, 0, 0)
                ButtonDrop.TextSize = 14.000


                DownFrame.Name = "DownFrame"
                DownFrame.Parent = ScrollingMainFramePage
                DownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DownFrame.BackgroundTransparency = 1.000
                DownFrame.BorderColor3 = Color3.fromRGB(27, 42, 53)
                DownFrame.ClipsDescendants = true
                DownFrame.Position = UDim2.new(0, 0, 0.1, 0)
                DownFrame.Size = UDim2.new(0, 328, 0, 0)

                ScrollingDown.Name = "ScrollingDown"
                ScrollingDown.Parent = DownFrame
                ScrollingDown.Active = true
                ScrollingDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingDown.BackgroundTransparency = 1.000
                ScrollingDown.BorderSizePixel = 0
                ScrollingDown.Size = UDim2.new(0, 328, 0, 98)
                ScrollingDown.CanvasSize = UDim2.new(0, 0, 0, 0)
                ScrollingDown.ScrollBarThickness = 0
                ScrollingDown.BottomImage = ""
                ScrollingDown.TopImage = ""

                ItemList.Name = "ItemList"
                ItemList.Parent = ScrollingDown
                ItemList.SortOrder = Enum.SortOrder.LayoutOrder
                ItemList.Padding = UDim.new(0, 3)

                local SelectionScrollingUIPadding = Instance.new("UIPadding")
                SelectionScrollingUIPadding.Name = "SelectionScrollingUIPadding"
                SelectionScrollingUIPadding.Parent = ScrollingDown

                if set ~= nil then
                    callback(set)
                end

                for i,v in pairs(option) do
                    local ItemFrame = Instance.new("Frame")
                    local ItemButton = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")


                    ItemFrame.Name = "ItemFrame"
                    ItemFrame.Parent = ScrollingDown
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemFrame.BackgroundTransparency = 1.000
                    ItemFrame.Size = UDim2.new(0, 328, 0, 24)
    
                    ItemButton.Name = "ItemButton"
                    ItemButton.Parent = ItemFrame
                    ItemButton.BackgroundColor3 = Color3.fromRGB(32,143,252)
                    ItemButton.BorderSizePixel = 0
                    ItemButton.Position = UDim2.new(0.0701219514, 0, 0, 0)
                    ItemButton.Size = UDim2.new(0, 282, 0, 24)
                    ItemButton.AutoButtonColor = false
                    ItemButton.Font = Enum.Font.GothamBold
                    ItemButton.Text = tostring(v)
                    ItemButton.ClipsDescendants = true
                    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemButton.TextSize = 14.000
    
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = ItemButton

                    ItemButton.MouseButton1Down:Connect(function()
                        if Tabtoggle == false then
                            ItemButton.TextSize = 0
                            TweenService:Create(
                                ItemButton,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                                {TextSize = 12}
                            ):Play()
                            Text.Text = tostring(text.." : "..v)
                            CircleAnim(ItemButton,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                            
                            callback(v)
                            DropToggle = false
                            TweenService:Create(
                                DownFrame,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 328, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                DropImage,
                                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                        end         
                    end)
                end 

                ScrollingDown.CanvasSize = UDim2.new(0,0,0,ItemList.AbsoluteContentSize.Y + 10)
                ButtonDrop.MouseButton1Click:Connect(function()
                    if Tabtoggle == false then
                        if DropToggle == false then
                            DropToggle = true
                            TweenService:Create(
                                DownFrame,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 328, 0, 98)}
                            ):Play()
                            TweenService:Create(
                                DropImage,
                                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 270}
                            ):Play()
                            CircleAnim(Frame,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                        elseif DropToggle == true then
                            DropToggle = false
                            TweenService:Create(
                                DownFrame,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 328, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                DropImage,
                                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                            CircleAnim(Frame,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                        end
                    end
                end
                )

                function RetrunDrop:Add(newtext)
                    local ItemFrame = Instance.new("Frame")
                    local ItemButton = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")


                    ItemFrame.Name = "ItemFrame"
                    ItemFrame.Parent = ScrollingDown
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemFrame.BackgroundTransparency = 1.000
                    ItemFrame.Size = UDim2.new(0, 328, 0, 24)
    
                    ItemButton.Name = "ItemButton"
                    ItemButton.Parent = ItemFrame
                    ItemButton.BackgroundColor3 = Color3.fromRGB(32,143,252)
                    ItemButton.BorderSizePixel = 0
                    ItemButton.Position = UDim2.new(0.0701219514, 0, 0, 0)
                    ItemButton.Size = UDim2.new(0, 282, 0, 24)
                    ItemButton.AutoButtonColor = false
                    ItemButton.Font = Enum.Font.GothamBold
                    ItemButton.Text = tostring(newtext)
                    ItemButton.ClipsDescendants = true
                    ItemButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ItemButton.TextSize = 14.000
    
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = ItemButton

                    ItemButton.MouseButton1Down:Connect(function()
                        if Tabtoggle == false then
                            ItemButton.TextSize = 0
                            TweenService:Create(
                                ItemButton,
                                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                                {TextSize = 12}
                            ):Play()
                            Text.Text = tostring(text.." : "..newtext)
                            CircleAnim(ItemButton,Color3.fromRGB(255,255,255),Color3.fromRGB(255,255,255))
                            
                            callback(newtext)
                            DropToggle = false
                            TweenService:Create(
                                DownFrame,
                                TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Size = UDim2.new(0, 328, 0, 0)}
                            ):Play()
                            TweenService:Create(
                                DropImage,
                                TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                                {Rotation = 180}
                            ):Play()
                        end
                    end)

                    ScrollingDown.CanvasSize = UDim2.new(0,0,0,ItemList.AbsoluteContentSize.Y + 10)
                end

                function RetrunDrop:Clear()
                    Text.Text = tostring(text).." : "
                    DropToggle = false
                    TweenService:Create(
                        DownFrame,
                        TweenInfo.new(0.2,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 328, 0, 0)}
                    ):Play()
                    TweenService:Create(
                        DropImage,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Rotation = 180}
                    ):Play()
                    for i, v in next, ScrollingDown:GetChildren() do
                        if v:IsA("Frame") then
                            v:Destroy()
                        end
                    end
                    ScrollingDown.CanvasSize = UDim2.new(0,0,0,ItemList.AbsoluteContentSize.Y + 10)
                end
                return RetrunDrop
            end
            return main
        end
        return Tab
    end
    return Ui
end

-------------------------------------------------------------------------------------------
Type = 1
spawn(function()
    while wait(.1) do
        if Type == 1 then
            Farm_Mode = CFrame.new(0, 40, 40)
        elseif Type == 2 then
            Farm_Mode = CFrame.new(-40, 40, 0)
        elseif Type == 3 then
            Farm_Mode = CFrame.new(0, 40, -40)
        elseif Type == 4 then
            Farm_Mode = CFrame.new(40, 40, 0)
        elseif Type == 5 then
            Farm_Mode = CFrame.new(0, 40, 0) * CFrame.Angles(math.rad(-90),0,0)
        end
    end
end)

spawn(function()
    while wait(0.2) do
        Type = 1
        wait(0.2)
        Type = 2
        wait(0.2)
        Type = 3
        wait(0.2)
        Type = 4
        wait(0.2)
        Type = 5
        wait(0.2)
    end
end)
----------------------------------------------------------------------------------------------------------------------
local Win = Lib:Window("Moon Hub | PREMIUM",Enum.KeyCode.P)
local Main = Win:Tab("General")

local General = Main.Page()
General:Toggle("Auto Farm Level",false,function(value)
    _G.Settings.Main["Auto Farm Level"] = value
    SaveSettings()
end)

AttackRandomType = 1
spawn(function()
	while wait() do 
		AttackRandomType = math.random(1,5)
		wait(0.1)
	end
end)

function AutoFarmLevel()
	GetQuestTitle = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title
	GetQuest = game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest
	local MyLevel = game.Players.LocalPlayer.Data.Level.Value

	if _G.Settings.Setting["Skip Level"] and (MyLevel >= 30 and MyLevel <= 200 or MyLevel >= 340 and MyLevel <= 350 or MyLevel >= 430 and MyLevel <= 440 or MyLevel >= 490 and MyLevel <= 500 or MyLevel >= 550 and MyLevel <= 560 or MyLevel >= 590 and MyLevel <= 600 or MyLevel >= 640 and MyLevel <= 650 or MyLevel >= 680 and MyLevel <= 690) then
		if MyLevel >= 30 and MyLevel <= 49 then
			local CFrameMon = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4658.3388671875, 872.5684814453125, -1767.7735595703125))
			if game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]") then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if _G.Settings.Setting["Skip Level"] and v.Name == "God's Guard [Lv. 450]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						repeat wait()
							FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
							if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
								if FarmtoTarget then FarmtoTarget:Stop() end
								for i2,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
									if _G.Settings.Setting["Skip Level"] and v2.Name == "God's Guard [Lv. 450]" and v2:FindFirstChild("HumanoidRootPart") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 then
										if InMyNetWork(v2.HumanoidRootPart) then
											v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
											v2.Humanoid.JumpPower = 0
											v2.Humanoid.WalkSpeed = 0
											v2.HumanoidRootPart.Size = Vector3.new(60,60,60)
											v2.HumanoidRootPart.Transparency = 1
											v2.HumanoidRootPart.CanCollide = false
											v2.Head.CanCollide = false
											if v2.Humanoid:FindFirstChild("Animator") then
												v2.Humanoid.Animator:Destroy()
											end
											sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
											v2.Humanoid:ChangeState(14)
											v2.Humanoid:ChangeState(11)
										end
									end
								end
								if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
									game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
									game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
								end
								game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
								FastAttack = true
								EquipWeapon(_G.Settings.Setting["Select Weapon"])
							end
						until not (game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]")) or not (_G.Settings.Setting["Skip Level"] or _G.Settings.General["Starting"]) or v.Humanoid.Health <= 0 or not v.Parent
						FastAttack = false
					end
				end
			else
				Modstween = toTarget(CFrameMon)
				if FirstSea and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 3000 then
					if Modstween then Modstween:Stop() end wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4658.3388671875, 872.5684814453125, -1767.7735595703125))
				elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
					if Modstween then Modstween:Stop() end
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
				end
			end
		elseif MyLevel >= 30 and MyLevel <= 200 or MyLevel >= 340 and MyLevel <= 350 or MyLevel >= 430 and MyLevel <= 440 or MyLevel >= 490 and MyLevel <= 500 or MyLevel >= 550 and MyLevel <= 560 or MyLevel >= 590 and MyLevel <= 600 or MyLevel >= 640 and MyLevel <= 650 or MyLevel >= 680 and MyLevel <= 690 then
			if GetQuest.Visible == false then
				if not tostring(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("PlayerHunter")):find("We heard some") then 
					local CFrameMon = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4658.3388671875, 872.5684814453125, -1767.7735595703125))
					if game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]") then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if _G.Settings.Setting["Skip Level"] and v.Name == "God's Guard [Lv. 450]" and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
									if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
										if FarmtoTarget then FarmtoTarget:Stop() end
										for i2,v2 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do 
											if _G.Settings.Setting["Skip Level"] and v2.Name == "God's Guard [Lv. 450]" and v2:FindFirstChild("HumanoidRootPart") and v2:FindFirstChild("Humanoid") and v2.Humanoid.Health > 0 then
												if InMyNetWork(v2.HumanoidRootPart) then
													v2.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame
													v2.Humanoid.JumpPower = 0
													v2.Humanoid.WalkSpeed = 0
													v2.HumanoidRootPart.Size = Vector3.new(60,60,60)
													v2.HumanoidRootPart.Transparency = 1
													v2.HumanoidRootPart.CanCollide = false
													v2.Head.CanCollide = false
													if v2.Humanoid:FindFirstChild("Animator") then
														v2.Humanoid.Animator:Destroy()
													end
													sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
													v2.Humanoid:ChangeState(14)
													v2.Humanoid:ChangeState(11)
												end
											end
										end
										if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
										game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
										FastAttack = true
										EquipWeapon(_G.Settings.Setting["Select Weapon"])
									end
								until not (game:GetService("Workspace").Enemies:FindFirstChild("God's Guard [Lv. 450]")) or not (_G.Settings.Setting["Skip Level"] or _G.Settings.General["Starting"]) or v.Humanoid.Health <= 0 or not v.Parent
								FastAttack = false
							end
						end
					else
						Modstween = toTarget(CFrameMon)
						if FirstSea and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 300 then
							if Modstween then Modstween:Stop() end wait(.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-4658.3388671875, 872.5684814453125, -1767.7735595703125))
						elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
							if Modstween then Modstween:Stop() end
							game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
						end 
					end
				end
			elseif GetQuest.Visible == true then
				local AllPlayersTableSkipFarm = {}
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
				for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
					table.insert(AllPlayersTableSkipFarm,v.Name)
				end
				if table.find(AllPlayersTableSkipFarm,GetQuestTitle.Text:split(" ")[2]) then
					for i,v in pairs(game:GetService("Workspace").Characters:GetChildren()) do
						if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,v.Name) then
							if _G.Settings.Main["Auto Farm Level"] and _G.Settings.Setting["Skip Level"] and v.Name == GetQuestTitle.Text:split(" ")[2] and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								repeat wait()
									if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
										FarmtoTarget = toTargetP(v.HumanoidRootPart.CFrame)
									elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
										if FarmtoTarget then FarmtoTarget:Stop() end
										if game:GetService("Players")["LocalPlayer"].PlayerGui.Main.PvpDisabled.Visible == true then
											local args = {
												[1] = "EnablePvp"
											}

											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											local args = {
												[1] = "Buso"
											}
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))
										end
										if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
											game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
											game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
										end
										if AttackRandomType == 1 then
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, 30)
										elseif AttackRandomType == 2 then
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(-30, 0, 0)
										elseif AttackRandomType == 3 then
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 0, -30)
										elseif AttackRandomType == 4 then
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(30, 0, 0)
										elseif AttackRandomType == 5 then
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										else
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0)
										end
										EquipWeapon(_G.Settings.Setting["Select Weapon"])
										AttackPlayers()
									end
								until not _G.Settings.Main["Auto Farm Level"] or not string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,v.Name) or v.Humanoid.Health <= 0 or not v.Parent or GetQuest.Visible == false
							end
						end
					end
				else
					if game:GetService("Workspace").Enemies:FindFirstChild(Name) then
						for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
							if _G.Settings.Main["Auto Farm Level"] and v.Name == Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
								if string.find(GetQuestTitle.Text, QuestName) then
									repeat wait()
										if (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude > 150 then
											FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
										elseif v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 150 then
											if FarmtoTarget then FarmtoTarget:Stop() end
											StartMagnet = true
											PosMon = v.HumanoidRootPart.CFrame
											HealthMin = v.Humanoid.MaxHealth * 40/100
											if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
												game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
												game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
											end
											game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
											FastAttack = true
											EquipWeapon(_G.Settings.Setting["Select Weapon"])
										end
									until not game:GetService("Workspace").Enemies:FindFirstChild(Name) or not _G.Settings.General["Starting"] or not string.find(GetQuestTitle.Text, QuestName) or v.Humanoid.Health <= 0 or not v.Parent or GetQuest.Visible == false
									FastAttack = false
									StartMagnet = false
								else
									Com("F_","AbandonQuest");
								end
							end
						end
					else
						StartMagnet = false
						FastAttack = false
						if not string.find(GetQuestTitle.Text, NameMon) then Com("F_","AbandonQuest"); end
						Modstween = toTarget(CFrameMon.Position,CFrameMon)
						if FirstSea and (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
							if Modstween then Modstween:Stop() end wait(.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
						elseif FirstSea and not (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
							if Modstween then Modstween:Stop() end wait(.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.8515625, 6.6796875, -1926.7841796875))
						elseif SecondSea and string.find(Name, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
							if Modstween then Modstween:Stop() end wait(.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
						elseif SecondSea and not string.find(Name, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
							if Modstween then Modstween:Stop() end wait(.5)
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
						elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 500 then
							if Modstween then Modstween:Stop() end
							for i ,v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
								if v.Name == NameMon then
									wait(.3)
									topos(v.CFrame * CFrame.new(0, 10, 0))
								end
							end
						end 
					end
				end
			end
		end
	else
		if not string.find(GetQuestTitle.Text, NameMon) then game.ReplicatedStorage:WaitForChild("Remotes").CommF_:InvokeServer("AbandonQuest"); end
		if GetQuest.Visible == false then
			StartMagnet = false
			FastAttack = false
			Questtween = toTarget(CFrameMon.Position,CFrameMon)
			if FirstSea and (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
				if Questtween then Questtween:Stop() end wait(.5)
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
			elseif FirstSea and not (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
				if Questtween then Questtween:Stop() end wait(.5)
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.8515625, 6.6796875, -1926.7841796875))
			elseif SecondSea and string.find(Name, "Ship") and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
				if Questtween then Questtween:Stop() end
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
			elseif SecondSea and not string.find(Name, "Ship") and (CFrameMon.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
				if Questtween then Questtween:Stop() end
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
			elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 300 then
				if Questtween then Questtween:Stop() end
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrameMon
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
				Com("F_","StartQuest", QuestName, LevelQuest)
			end
		elseif GetQuest.Visible == true then
			if game:GetService("Workspace").Enemies:FindFirstChild(Name) then
				for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if _G.Settings.Main["Auto Farm Level"] and v.Name == Name and v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 then
						if string.find(GetQuestTitle.Text, NameMon) then
							repeat wait()
								FarmtoTarget = toTarget(v.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0))
								if v:FindFirstChild("HumanoidRootPart") and v:FindFirstChild("Humanoid") and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 250 then
									if FarmtoTarget then FarmtoTarget:Stop() end
									if _G.Settings.Setting["Auto Haki"] then
										if not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
											game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
										end
									end
									if not game.Players.LocalPlayer.Character:FindFirstChild(_G.Settings.Setting["Select Weapon"]) then
										wait()
										EquipWeapon(_G.Settings.Setting["Select Weapon"])
									end
									StartMagnet = true
									v.HumanoidRootPart.Size = Vector3.new(60,60,60)
									v.HumanoidRootPart.Transparency = 1
									v.Humanoid.JumpPower = 0
									v.Humanoid.WalkSpeed = 0
									v.HumanoidRootPart.CanCollide = false
									v.Humanoid:ChangeState(11)
									v.Humanoid:ChangeState(14)
									PosMon = v.HumanoidRootPart.CFrame
									if game.Players.LocalPlayer.Character:FindFirstChild("Black Leg") and game.Players.LocalPlayer.Character:FindFirstChild("Black Leg").Level.Value >= 150 then
										game:service('VirtualInputManager'):SendKeyEvent(true, "V", false, game)
										game:service('VirtualInputManager'):SendKeyEvent(false, "V", false, game)
									end
									FastAttack = true
									game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0)
								end
							until not game:GetService("Workspace").Enemies:FindFirstChild(Name) or not _G.Settings.General["Starting"] or not string.find(GetQuestTitle.Text, NameMon) or v.Humanoid.Health <= 0 or not v.Parent or GetQuest.Visible == false
							StartMagnet = false
							FastAttack = false
						else
							Com("F_","AbandonQuest");
						end
					end
				end
			else
				StartMagnet = false
				FastAttack = false
				if not string.find(GetQuestTitle.Text, NameMon) then Com("F_","AbandonQuest"); end
				Modstween = toTarget(CFrameMon.Position,CFrameMon)
				if FirstSea and (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
					if Modstween then Modstween:Stop() end wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(61163.8515625, 11.6796875, 1819.7841796875))
				elseif FirstSea and not (Name == "Fishman Commando [Lv. 400]" or Name == "Fishman Warrior [Lv. 375]") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 50000 then
					if Modstween then Modstween:Stop() end wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(3864.8515625, 6.6796875, -1926.7841796875))
				elseif SecondSea and string.find(Name, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
					if Modstween then Modstween:Stop() end wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(923.21252441406, 126.9760055542, 32852.83203125))
				elseif SecondSea and not string.find(Name, "Ship") and (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart").Position).magnitude > 30000 then
					if Modstween then Modstween:Stop() end wait(.5)
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance",Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422))
				elseif (CFrameMon.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).magnitude <= 500 then
					if Modstween then Modstween:Stop() end
					for i ,v in pairs(game:GetService("Workspace")["_WorldOrigin"].EnemySpawns:GetChildren()) do
						if v.Name == NameMon then
							wait(.3)
							topos(v.CFrame * CFrame.new(0, 10, 0))
						end
					end
				end
			end
		end
	end
end

function CheckNotifyComplete()
	for i, v in pairs(game:GetService("Players")["LocalPlayer"].PlayerGui:FindFirstChild("Notifications"):GetChildren()) do
		if v.Name == "NotificationTemplate" then
			if string.lower(v.Text):find("quest completed") then
				pcall(function()
					v:Destroy()
				end)
				return true
			end
		end
	end
	return false
end

local NoLoopDuplicate = false
local SubQuest = false
local oldmob = Name
local oldcheckquest = NameMon

task.spawn(function()
	while wait() do
		pcall(function()
			if _G.Settings.Main["Auto Farm Level"] then
				if _G.Settings.Setting["Double Quest"] then 
					if SubQuest == true then 
						if LevelFarm then 
							if tonumber(LevelFarm-1) ~= 0 then 
								CheckOldQuest(tonumber(LevelFarm-1))
							end
						end
					else
						CheckQuest()
						oldmob = Name
						oldcheckquest = NameMon
						spawn(function()
							pcall(function()
								if NoLoopDuplicate == false then 
									if CheckNotifyComplete() and _G.Settings.Main["Auto Farm Level"] then
										NoLoopDuplicate = true 
										while wait() do
											SubQuest = true
											if CheckNotifyComplete() or _G.Settings.Main["Auto Farm Level"] == false then
												break;
											end
										end
										SubQuest = false
										NoLoopDuplicate = false
									end
								end
							end)
						end)
						if SubQuest == true then  
							if LevelFarm then 
								if tonumber(LevelFarm-1) ~= 0 then 
									CheckOldQuest(tonumber(LevelFarm-1))
								end
							end
						end
					end
				else
					CheckQuest()
				end
				AutoFarmLevel()
			end
		end)
	end
end)

local Setting = Main.Page()