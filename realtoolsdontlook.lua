local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Hold = Instance.new("Tool")
Hold.Name = "[Hold]"
Hold.RequiresHandle = false
Hold.CanBeDropped = false
Hold.Parent = player.Backpack

local blockedAnims = { ["11075367458"] = true }

local function setupAnimationBlock()
	local char = player.Character or player.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")
	humanoid.AnimationPlayed:Connect(function(track)
		local id = track.Animation.AnimationId:match("%d+")
		if blockedAnims[id] then
			track:Stop()
		end
	end)
end

setupAnimationBlock()

local grabAnimation = Instance.new("Animation")
grabAnimation.AnimationId = "rbxassetid://3135389157"
local grabTrack = nil

local function playGrabAnimation(humanoid)
	if not humanoid then return end
	grabTrack = humanoid:LoadAnimation(grabAnimation)
	grabTrack.Looped = true
	grabTrack:Play()
	task.wait(0.5)
	grabTrack:AdjustSpeed(0)
end

Hold.Activated:Connect(function()
	local char = player.Character
	if not char then return end

	local humanoid = char:FindFirstChildOfClass("Humanoid")
	if not humanoid then return end

	ReplicatedStorage.MainEvent:FireServer("Grabbing", true)

	task.spawn(function()
		task.wait(0.1)

		local bodyEffects = char:FindFirstChild("BodyEffects")
		if not bodyEffects then return end

		local grabbed = bodyEffects:FindFirstChild("Grabbed")
		if not grabbed then return end

		local grabbedChar = grabbed.Value
		if not grabbedChar or not grabbedChar:IsA("Model") then return end

		local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
		if ragdoll then
			for _, c in ipairs(ragdoll:GetDescendants()) do
				if c:IsA("BallSocketConstraint") then
					c.TwistLowerAngle = 0
					c.TwistUpperAngle = 0
					c.UpperAngle = 0
					c.Restitution = 0
				end
			end
		end

		task.wait(0.2)

		local grabCon = grabbedChar:FindFirstChild("GRABBING_CONSTRAINT")
		if grabCon and grabCon:IsA("Weld") then
			local rope = grabCon:FindFirstChild("H")
			if rope and rope:IsA("RopeConstraint") then
				rope.Length = 0
			end
		end

		task.wait(0.2)

		playGrabAnimation(humanoid)

		while true do
			if not grabbed.Value or not grabbed.Value:IsA("Model") then
				if grabTrack and grabTrack.IsPlaying then
					grabTrack:Stop()
				end
				break
			end
			task.wait(0.1)
		end
	end)
end)

local half = Instance.new("Tool")
half.Name = "[Half Rip]"
half.RequiresHandle = false
half.CanBeDropped = false
half.Parent = player.Backpack

half.Activated:Connect(function()
	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	task.wait(0.5)

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	local targetNames = {
		RULLT = true,
		RUAUT = true,
		LULLT = true,
		LUAUT = true,
		LTUP = true
	}

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") and targetNames[constraint.Name] then
			constraint.Enabled = false
		end
	end
end)

local repairhalf = Instance.new("Tool")
repairhalf.Name = "[Repair Rip]"
repairhalf.RequiresHandle = false
repairhalf.CanBeDropped = false
repairhalf.Parent = player.Backpack

repairhalf.Activated:Connect(function()
	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	local targetNames = {
		RULLT = true,
		RUAUT = true,
		LULLT = true,
		LUAUT = true,
		LTUP = true
	}

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") and targetNames[constraint.Name] then
			constraint.Enabled = true
		end
	end
end)

local spin = Instance.new("Tool")
spin.Name = "[Spin Constraints]"
spin.RequiresHandle = false
spin.CanBeDropped = false
spin.Parent = player.Backpack

spin.Activated:Connect(function()
	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") then
			constraint.TwistLowerAngle = 180
			constraint.TwistUpperAngle = 180
			constraint.UpperAngle = 180
			constraint.Restitution = 1
		end
	end
end)

local unspin = Instance.new("Tool")
unspin.Name = "[Unspin Constraints]"
unspin.RequiresHandle = false
unspin.CanBeDropped = false
unspin.Parent = player.Backpack

unspin.Activated:Connect(function()
	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") then
			constraint.TwistLowerAngle = 0
			constraint.TwistUpperAngle = 0
			constraint.UpperAngle = 0
			constraint.Restitution = 0
		end
	end
end)

local orbit = Instance.new("Tool")
orbit.Name = "[Orbit Limbs]"
orbit.RequiresHandle = false
orbit.CanBeDropped = false
orbit.Parent = player.Backpack

local angle = 0

orbit.Activated:Connect(function()
	if shared.SpinningLimbs then
		if shared.OrbitConnection then
			shared.OrbitConnection:Disconnect()
			shared.OrbitConnection = nil
		end
		
		if shared.OriginalOrbitPositions then
			for a0, pos in pairs(shared.OriginalOrbitPositions) do
				if a0 and a0.Parent then
					a0.WorldPosition = pos
				end
			end
			shared.OriginalOrbitPositions = nil
		end
		
		shared.SpinningLimbs = false
		return
	end

	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	local constraints = {}

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") then
			table.insert(constraints, constraint)
		end
	end

	local originalPositions = {}
	for _, con in ipairs(constraints) do
		local a0 = con.Attachment0
		if a0 and a0.Parent then
			originalPositions[a0] = a0.WorldPosition
		end
	end
	shared.OriginalOrbitPositions = originalPositions

	shared.SpinningLimbs = true
	angle = 0

	shared.OrbitConnection = RunService.RenderStepped:Connect(function(dt)
		if not shared.SpinningLimbs then return end

		local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
		if not root then return end

		angle += dt * math.pi

		for i, constraint in ipairs(constraints) do
			local a0 = constraint.Attachment0
			if a0 then
				local radius = 5 + (i % 4)
				local offset = Vector3.new(math.cos(angle + i) * radius, 2, math.sin(angle + i) * radius)
				a0.WorldPosition = root.Position + offset
			end
		end
	end)

	local grabbedHum = grabbedChar:FindFirstChildOfClass("Humanoid")
	if grabbedHum then
		local conn
		conn = grabbedHum.StateChanged:Connect(function(old, new)
			if new == Enum.HumanoidStateType.GettingUp or
			   new == Enum.HumanoidStateType.Running or
			   new == Enum.HumanoidStateType.RunningNoPhysics or
			   new == Enum.HumanoidStateType.Landed then

				if shared.OrbitConnection then
					shared.OrbitConnection:Disconnect()
					shared.OrbitConnection = nil
				end
				if shared.OriginalOrbitPositions then
					for a0, pos in pairs(shared.OriginalOrbitPositions) do
						if a0 and a0.Parent then
							a0.WorldPosition = pos
						end
					end
					shared.OriginalOrbitPositions = nil
				end
				shared.SpinningLimbs = false

				conn:Disconnect()
			end
		end)
	end
end)

local unorbit = Instance.new("Tool")
unorbit.Name = "[Unorbit Limbs]"
unorbit.RequiresHandle = false
unorbit.CanBeDropped = false
unorbit.Parent = player.Backpack

unorbit.Activated:Connect(function()
	if shared.OrbitConnection then
		shared.OrbitConnection:Disconnect()
		shared.OrbitConnection = nil
	end
	shared.SpinningLimbs = false

	local character = player.Character
	if not character then return end

	local bodyEffects = character:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar or not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	for _, constraint in ipairs(ragdoll:GetDescendants()) do
		if constraint:IsA("BallSocketConstraint") then
			local a0 = constraint.Attachment0
			if a0 and a0.Parent then
				a0.WorldPosition = a0.Parent.Position
			end
		end
	end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local blockedAnims = { ["11075367458"] = true }

local function setupAnimationBlock()
	local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
	local humanoid = char:WaitForChild("Humanoid")
	humanoid.AnimationPlayed:Connect(function(track)
		local id = track.Animation.AnimationId:match("%d+")
		if blockedAnims[id] then
			track:Stop()
		end
	end)
end

setupAnimationBlock()

local punch = Instance.new("Tool")
punch.Name = "[Punch]"
punch.RequiresHandle = false
punch.CanBeDropped = false
punch.Parent = LocalPlayer.Backpack

local pushAnimId = 3354696735

local limbParts = {
	'RightHand', 'RightLowerArm', 'RightUpperArm',
	'LeftHand', 'LeftLowerArm', 'LeftUpperArm',
	'RightFoot', 'RightLowerLeg', 'RightUpperLeg',
	'LeftFoot', 'LeftLowerLeg', 'LeftUpperLeg',
}

local function getGrabbedCharacter()
	local char = LocalPlayer.Character
	if not char then return end

	local effects = char:FindFirstChild('BodyEffects')
	if not effects then return end

	local grabbed = effects:FindFirstChild('Grabbed')
	if grabbed and grabbed.Value and grabbed.Value:IsA('Model') then
		return grabbed.Value
	end
end

punch.Activated:Connect(function()
	local char = LocalPlayer.Character
	if not char then return end

	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	local pushAnim = Instance.new("Animation")
	pushAnim.AnimationId = "rbxassetid://" .. pushAnimId
	local pushTrack = hum:LoadAnimation(pushAnim)
	pushTrack:Play()

	local grabbedChar = getGrabbedCharacter()
	if not grabbedChar then
		warn("No grabbed character to punch.")
		return
	end

	task.delay(1.3, function()
		for _, partName in ipairs(limbParts) do
			local part = grabbedChar:FindFirstChild(partName)
			if part and part:IsA("BasePart") then
				local pos = part.Position
				part.CFrame = CFrame.new(pos.X, -999, pos.Z)
			end
		end
	end)
end)

local kick = Instance.new("Tool")
kick.Name = "[Kick]"
kick.RequiresHandle = false
kick.Parent = player.Backpack

local animation = Instance.new("Animation")
animation.AnimationId = "rbxassetid://2788306916"

local walkFlingActive = false

local function fling(target)
	for _, part in ipairs(target:GetChildren()) do
		if part:IsA("BasePart") then
			part.Velocity = Vector3.new(math.random(-75, 75), 100, math.random(-75, 75))
			part.RotVelocity = Vector3.new(math.random(-50, 50), math.random(-50, 50), math.random(-50, 50))
		end
	end
end

local function walkFling()
	local movel = 0.1
	while walkFlingActive do
		RunService.Heartbeat:Wait()

		while not (humanoidRootPart and humanoidRootPart.Parent) do
			RunService.Heartbeat:Wait()
			humanoidRootPart = character:WaitForChild("HumanoidRootPart")
		end

		local vel = humanoidRootPart.Velocity
		humanoidRootPart.Velocity = vel * 10000 + Vector3.new(0, 10000, 0)

		RunService.RenderStepped:Wait()
		if humanoidRootPart and humanoidRootPart.Parent then
			humanoidRootPart.Velocity = vel
		end

		RunService.Stepped:Wait()
		if humanoidRootPart and humanoidRootPart.Parent then
			humanoidRootPart.Velocity = vel + Vector3.new(0, movel, 0)
			movel = movel * -1
		end
	end
end

humanoidRootPart.Touched:Connect(function(otherPart)
	if not walkFlingActive then return end
	local otherCharacter = otherPart.Parent
	if otherCharacter and otherCharacter ~= character then
		local otherPlayer = Players:GetPlayerFromCharacter(otherCharacter)
		if otherPlayer then
			fling(otherCharacter)
		end
	end
end)

kick.Activated:Connect(function()
	if not humanoid then return end

	local animTrack = humanoid:LoadAnimation(animation)
	animTrack:Play()
	animTrack:AdjustSpeed(1.5)

	walkFlingActive = true
	coroutine.wrap(walkFling)()

	task.delay(1.5, function()
		walkFlingActive = false
	end)
end)

player.CharacterAdded:Connect(function(newChar)
	character = newChar
	humanoid = character:WaitForChild("Humanoid")
	humanoidRootPart = character:WaitForChild("HumanoidRootPart")
end)

local walkover = Instance.new("Tool")
walkover.Name = "[Walk Over]"
walkover.RequiresHandle = false
walkover.CanBeDropped = false
walkover.Parent = player.Backpack

walkover.Activated:Connect(function()
	if shared.WalkOnActive then return end
	shared.WalkOnActive = true

	local char = player.Character
	if not char then return end

	local bodyEffects = char:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	local attachments = {}

	for _, obj in ipairs(ragdoll:GetDescendants()) do
		if obj:IsA("BallSocketConstraint") then
			local a0 = obj.Attachment0
			if a0 then
				table.insert(attachments, a0)
			end
		end
	end

	shared.WalkOnConnection = RunService.RenderStepped:Connect(function()
		if not shared.WalkOnActive then return end

		local root = char:FindFirstChild("HumanoidRootPart")
		if not root then return end

		for i, a0 in ipairs(attachments) do
			local offset = Vector3.new(0, -3, 0) + Vector3.new((i % 2) * 0.5, 0, (i % 3) * 0.5)
			a0.WorldPosition = root.Position + offset
		end
	end)
end)

local resetwalkover = Instance.new("Tool")
resetwalkover.Name = "[Reset Walk Over]"
resetwalkover.RequiresHandle = false
resetwalkover.CanBeDropped = false
resetwalkover.Parent = player.Backpack

resetwalkover.Activated:Connect(function()
	if shared.WalkOnConnection then
		shared.WalkOnConnection:Disconnect()
		shared.WalkOnConnection = nil
	end
	shared.WalkOnActive = false

	local char = player.Character
	if not char then return end

	local bodyEffects = char:FindFirstChild("BodyEffects")
	if not bodyEffects then return end

	local grabbed = bodyEffects:FindFirstChild("Grabbed")
	if not grabbed or not grabbed.Value then return end

	local grabbedChar = grabbed.Value
	if not grabbedChar:IsA("Model") then return end

	local ragdoll = grabbedChar:FindFirstChild("RagdollConstraints")
	if not ragdoll then return end

	for _, con in ipairs(ragdoll:GetDescendants()) do
		if con:IsA("BallSocketConstraint") then
			local a0 = con.Attachment0
			if a0 and a0.Parent then
				a0.WorldPosition = a0.Parent.Position
			end
		end
	end
end)


local riparms = Instance.new('Tool')
riparms.Name = '[RIP Arms]'
riparms.RequiresHandle = false
riparms.CanBeDropped = false
riparms.Parent = player.Backpack

local armParts = {
    'RightHand',
    'RightLowerArm',
    'RightUpperArm',
    'LeftHand',
    'LeftLowerArm',
    'LeftUpperArm',
}

local function getGrabbedCharacterfromriparms()
    local char = player.Character
    if not char then
        return
    end
    local effects = char:FindFirstChild('BodyEffects')
    if not effects then
        return
    end
    local grabbed = effects:FindFirstChild('Grabbed')
    if grabbed and grabbed.Value and grabbed.Value:IsA('Model') then
        return grabbed.Value
    end
end

riparms.Activated:Connect(function()
    local grabbedChar = getGrabbedCharacterfromriparms()
    if not grabbedChar then
        warn('No grabbed character found.')
        return
    end

    for _, partName in ipairs(armParts) do
        local part = grabbedChar:FindFirstChild(partName)
        if part and part:IsA('BasePart') then
            local pos = part.Position
            part.CFrame = CFrame.new(pos.X, -999, pos.Z)
        end
    end
end)

local riplegs = Instance.new('Tool')
riplegs.Name = '[RIP Legs]'
riplegs.RequiresHandle = false
riplegs.CanBeDropped = false
riplegs.Parent = player.Backpack

local legParts = {
    'RightFoot',
    'RightLowerLeg',
    'RightUpperLeg',
    'LeftFoot',
    'LeftLowerLeg',
    'LeftUpperLeg',
}

local function getGrabbedCharacterfromriplegs()
    local char = player.Character
    if not char then
        return
    end
    local effects = char:FindFirstChild('BodyEffects')
    if not effects then
        return
    end
    local grabbed = effects:FindFirstChild('Grabbed')
    if grabbed and grabbed.Value and grabbed.Value:IsA('Model') then
        return grabbed.Value
    end
end

riplegs.Activated:Connect(function()
    local grabbedChar = getGrabbedCharacterfromriplegs()
    if not grabbedChar then
        warn('No grabbed character found.')
        return
    end

    for _, partName in ipairs(legParts) do
        local part = grabbedChar:FindFirstChild(partName)
        if part and part:IsA('BasePart') then
            local pos = part.Position
            part.CFrame = CFrame.new(pos.X, -999, pos.Z)
        end
    end
end)

local riplimbs = Instance.new('Tool')
riplimbs.Name = '[RIP Limbs]'
riplimbs.RequiresHandle = false
riplimbs.CanBeDropped = false
riplimbs.Parent = player.Backpack

local limbParts = {
    -- Arms
    'RightHand',
    'RightLowerArm',
    'RightUpperArm',
    'LeftHand',
    'LeftLowerArm',
    'LeftUpperArm',
    -- Legs
    'RightFoot',
    'RightLowerLeg',
    'RightUpperLeg',
    'LeftFoot',
    'LeftLowerLeg',
    'LeftUpperLeg',
}

local function getGrabbedCharacterfromriplimbs()
    local char = player.Character
    if not char then
        return
    end
    local effects = char:FindFirstChild('BodyEffects')
    if not effects then
        return
    end
    local grabbed = effects:FindFirstChild('Grabbed')
    if grabbed and grabbed.Value and grabbed.Value:IsA('Model') then
        return grabbed.Value
    end
end

riplimbs.Activated:Connect(function()
    local grabbedChar = getGrabbedCharacterfromriplimbs()
    if not grabbedChar then
        warn('No grabbed character found.')
        return
    end

    for _, partName in ipairs(limbParts) do
        local part = grabbedChar:FindFirstChild(partName)
        if part and part:IsA('BasePart') then
            local pos = part.Position
            part.CFrame = CFrame.new(pos.X, -999, pos.Z)
        end
    end
end)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local dashpunch = Instance.new("Tool")
dashpunch.Name = "[Dash Punch]"
dashpunch.RequiresHandle = false
dashpunch.Parent = LocalPlayer.Backpack

dashpunch.Activated:Connect(function()
    local closestPlayer = nil
    local closestDistance = 100
    for _, otherPlayer in ipairs(Players:GetPlayers()) do
        if otherPlayer ~= LocalPlayer and otherPlayer.Character and otherPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local otherHRP = otherPlayer.Character.HumanoidRootPart
            local distance = (HumanoidRootPart.Position - otherHRP.Position).Magnitude

            if distance <= closestDistance then
                local effects = otherPlayer.Character:FindFirstChild("BodyEffects")
                local isKO = effects and effects:FindFirstChild("K.O") and effects["K.O"].Value
                if not isKO then
                    closestDistance = distance
                    closestPlayer = otherPlayer
                end
            end
        end
    end

    if not closestPlayer then
        return
    end

    local effects = Character:FindFirstChild("BodyEffects")
    if effects then
        local grabbed = effects:FindFirstChild("Grabbed")
        if grabbed and grabbed.Value and grabbed.Value:IsA("Model") then
            local grabbedChar = grabbed.Value
            local grabbedPlayer = Players:GetPlayerFromCharacter(grabbedChar)
            if grabbedPlayer and grabbedChar:FindFirstChild("BodyEffects") then
                local ko = grabbedChar.BodyEffects:FindFirstChild("K.O")
                if ko and ko.Value == true then
                    return
                end
            end
        end
    end

    if LocalPlayer.Backpack:FindFirstChild("Combat") then
        LocalPlayer.Backpack.Combat.Parent = Character
    end

    if Character:FindFirstChild("Combat") then
        Character.Combat:Activate()
    else
        return
    end
    task.wait(2)

    if closestPlayer.Character and closestPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local targetHRP = closestPlayer.Character.HumanoidRootPart
        local forwardOffset = targetHRP.CFrame.LookVector * 3
        local newPosition = targetHRP.Position + forwardOffset
        HumanoidRootPart.CFrame = CFrame.new(newPosition, targetHRP.Position)
    end
end)

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local givekorblox = Instance.new('Tool')
givekorblox.Name = '[Give Korblox]'
givekorblox.RequiresHandle = false
givekorblox.CanBeDropped = false
givekorblox.Parent = LocalPlayer.Backpack

local rightlegparts = {
    'RightUpperLeg',
    'RightLowerLeg',
    'RightFoot',
}

local function getGrabbedCharacter()
    local char = LocalPlayer.Character
    if not char then
        return
    end
    local effects = char:FindFirstChild('BodyEffects')
    if not effects then
        return
    end
    local grabbed = effects:FindFirstChild('Grabbed')
    if grabbed and grabbed.Value and grabbed.Value:IsA('Model') then
        return grabbed.Value
    end
end

givekorblox.Activated:Connect(function()
    local grabbedChar = getGrabbedCharacter()
    if not grabbedChar then
        warn('No grabbed character found.')
        return
    end

    for _, partName in ipairs(rightlegparts) do
        local part = grabbedChar:FindFirstChild(partName)
        if part and part:IsA('BasePart') then
            local pos = part.Position
            part.CFrame = CFrame.new(pos.X, -999, pos.Z)
        end
    end
end)