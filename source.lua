----// Services & Variables
local ContextActionService = game:GetService('ContextActionService')
local HttpService = game:GetService('HttpService')
local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer

local Enabled = false

local ESPEnabled = false
local ESPFolder = Instance.new("Folder", game:GetService('CoreGui'))
local PlayerFolder = Instance.new("Folder", ESPFolder)

local FFA = false
local Aiming = false

local DefaultOptions = {}
local UserOptions = {}

local CharacterEvents = {}
----// Announcements Screen
local AnnouncementsGui = Instance.new('ScreenGui', game:GetService('CoreGui'))
local AnnouncementsFrame = Instance.new('Frame', AnnouncementsGui)
local AnnouncementsConstraint = Instance.new('UIAspectRatioConstraint')
local AnnouncementsTitle = Instance.new('TextLabel', AnnouncementsFrame)
local AnnouncementsText = Instance.new('TextLabel', AnnouncementsFrame)
local AnnouncementsClose = Instance.new('ImageButton', AnnouncementsFrame)
----// Debug Screen
local DebugGui = Instance.new('ScreenGui', game:GetService('CoreGui'))
local DebugFrame = Instance.new('Frame', DebugGui)
local DebugConstraint = Instance.new('UIAspectRatioConstraint')

local StatusLabel = Instance.new('TextLabel', DebugFrame)
local UsernameLabel = Instance.new('TextLabel', DebugFrame)
local DistanceLabel = Instance.new('TextLabel', DebugFrame)
local HealthLabel = Instance.new('TextLabel', DebugFrame)
local OffsetLabel = Instance.new('TextLabel', DebugFrame)
local BodyPartLabel = Instance.new('TextLabel', DebugFrame)
----// Main Screen
local UserInputService = game:GetService("UserInputService")
local ScreenGui = Instance.new('ScreenGui', game:GetService('CoreGui'))
local MainFrame = Instance.new('Frame', ScreenGui)

local EnableBtn = Instance.new('TextButton', MainFrame)
local ESPBtn = Instance.new('TextButton', MainFrame)
local FFABtn = Instance.new('TextButton', MainFrame)
local SettingsBtn = Instance.new('TextButton', MainFrame)

local Title = Instance.new('TextLabel', MainFrame)
local Footer = Instance.new('TextLabel', MainFrame)

local RatioConstraint = Instance.new('UIAspectRatioConstraint')
local TextConstraint = Instance.new('UITextSizeConstraint', Footer)

local Settings = Instance.new('Frame', ScreenGui)
local Scrolling = Instance.new('ScrollingFrame', Settings)
local Title2 = Instance.new('TextLabel', Settings)

----// User Setting Screen
local SettingOptions = Instance.new("Frame", Scrolling)
local Restore = Instance.new("TextButton", SettingOptions)
local Save = Instance.new("TextButton", SettingOptions)

local ListLayout = Instance.new('UIListLayout', Scrolling)
local Padding = Instance.new('UIPadding', Scrolling)

local TextConstraint2 = Instance.new('UITextSizeConstraint', Title2)
local TextConstraint3 = Instance.new('UITextSizeConstraint', Save)
local TextConstraint4 = Instance.new('UITextSizeConstraint', Restore)
local RatioConstraint2 = Instance.new('UIAspectRatioConstraint')

----// Internal Output Function
local function output(output, r, g, b)
	if printconsole and r and g and b then
		printconsole(output, r, g, b)
	else
		print(output)
	end	
end
----
if pcall(function() loadstring(game:HttpGet('https://raw.githubusercontent.com/quantumrealities/fkt_aimbot/main/version.lua'))() end) then
	if announcements and announcements ~= ''  then
		AnnouncementsGui.Name = "announcements"

		AnnouncementsFrame.Size = UDim2.new(0.15, 0, 0.177, 0)
		AnnouncementsFrame.AnchorPoint = Vector2.new(0.5, 0.5)
		AnnouncementsFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
		AnnouncementsFrame.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
		AnnouncementsFrame.BorderSizePixel = 0

		AnnouncementsTitle.Size = UDim2.new(1, 0, 0.15, 0)
		AnnouncementsTitle.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
		AnnouncementsTitle.Text = 'Announcements'
		AnnouncementsTitle.TextColor3 = Color3.fromRGB(158, 158, 158)
		AnnouncementsTitle.TextScaled = true
		AnnouncementsTitle.BorderSizePixel = 0
		AnnouncementsTitle.Font = Enum.Font.GothamSemibold

		AnnouncementsText.Size = UDim2.new(1, 0, 0.85, 0)
		AnnouncementsText.Text = announcements
		AnnouncementsText.TextColor3 = Color3.fromRGB(158, 158, 158)
		AnnouncementsText.TextScaled = true
		AnnouncementsText.BorderSizePixel = 0
		AnnouncementsText.BackgroundTransparency = 1
		AnnouncementsText.Position = UDim2.new(0, 0, 0.15, 0)
		AnnouncementsText.Font = Enum.Font.GothamSemibold

		AnnouncementsClose.AnchorPoint = Vector2.new(1, 0)
		AnnouncementsClose.BackgroundTransparency = 1
		AnnouncementsClose.Size = UDim2.new(0.073, 0, 0.15, 0)
		AnnouncementsClose.Image = 'http://www.roblox.com/asset/?id=6031094678'
		AnnouncementsClose.Position = UDim2.new(1, 0, 0, 0)
		AnnouncementsClose.ZIndex = 2

		AnnouncementsClose.MouseButton1Up:Connect(function()
			wait()
			AnnouncementsGui.Enabled = false
			AnnouncementsGui:Destroy()
		end)
	end
end
----
DebugGui.Enabled = false

DebugFrame.AnchorPoint = Vector2.new(0, 1)
DebugFrame.Size = UDim2.new(0.2, 0, 0.15, 0)
DebugFrame.Position = UDim2.new(0, 10, 1, 0)
DebugFrame.BackgroundTransparency = 1

StatusLabel.Size = UDim2.new(1, 0, 0.15, 0)
StatusLabel.TextColor3 = Color3.new(255, 255, 255)
StatusLabel.Text = "enabled: False"
StatusLabel.TextScaled = true
StatusLabel.BackgroundTransparency = 1
StatusLabel.TextXAlignment = Enum.TextXAlignment.Left
StatusLabel.Font = Enum.Font.GothamSemibold

UsernameLabel.Size = UDim2.new(1, 0, 0.15, 0)
UsernameLabel.Position = UDim2.new(0, 0, 0.15, 0)
UsernameLabel.TextColor3 = Color3.new(255, 255, 255)
UsernameLabel.Text = "username: n/a (n/a)"
UsernameLabel.TextScaled = true
UsernameLabel.BackgroundTransparency = 1
UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
UsernameLabel.Font = Enum.Font.GothamSemibold

DistanceLabel.Size = UDim2.new(1, 0, 0.15, 0)
DistanceLabel.Position = UDim2.new(0, 0, 0.3, 0)
DistanceLabel.TextColor3 = Color3.new(255, 255, 255)
DistanceLabel.Text = "distance: 0"
DistanceLabel.TextScaled = true
DistanceLabel.BackgroundTransparency = 1
DistanceLabel.TextXAlignment = Enum.TextXAlignment.Left
DistanceLabel.Font = Enum.Font.GothamSemibold

HealthLabel.Size = UDim2.new(1, 0, 0.15, 0)
HealthLabel.Position = UDim2.new(0, 0, 0.45, 0)
HealthLabel.TextColor3 = Color3.new(255, 255, 255)
HealthLabel.Text = "health: 100"
HealthLabel.TextScaled = true
HealthLabel.BackgroundTransparency = 1
HealthLabel.TextXAlignment = Enum.TextXAlignment.Left
HealthLabel.Font = Enum.Font.GothamSemibold

OffsetLabel.Size = UDim2.new(1, 0, 0.15, 0)
OffsetLabel.Position = UDim2.new(0, 0, 0.6, 0)
OffsetLabel.TextColor3 = Color3.new(255, 255, 255)
OffsetLabel.Text = "offset: 0, 0"
OffsetLabel.TextScaled = true
OffsetLabel.BackgroundTransparency = 1
OffsetLabel.TextXAlignment = Enum.TextXAlignment.Left
OffsetLabel.Font = Enum.Font.GothamSemibold

BodyPartLabel.Size = UDim2.new(1, 0, 0.15, 0)
BodyPartLabel.Position = UDim2.new(0, 0, 0.75, 0)
BodyPartLabel.TextColor3 = Color3.new(255, 255, 255)
BodyPartLabel.Text = "body part: "
BodyPartLabel.TextScaled = true
BodyPartLabel.BackgroundTransparency = 1
BodyPartLabel.TextXAlignment = Enum.TextXAlignment.Left
BodyPartLabel.Font = Enum.Font.GothamSemibold

DebugConstraint.AspectRatio = 3.655
DebugConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
DebugConstraint.DominantAxis = Enum.DominantAxis.Width

output("[SUCCESS: Debug Graphical User Interface Created]", 132, 214, 247)
----

local function checkTeam(player)
	if FFA == true then
		return false
	elseif player.TeamColor == LocalPlayer.TeamColor then
		return true
	end
	return false, player.Team, player.TeamColor
end

local function getESPColor(player)
	if FFA == true then
		return Color3.fromRGB(225, 50, 50)
	elseif  player.Team == nil or player.Team.Name == "Neutral" then
		return Color3.fromRGB(200, 200, 200)
	elseif checkTeam(player) == true then
		return Color3.fromRGB(0, 225, 0)
	else
		return Color3.fromRGB(225, 50, 50)
	end
end

local function canBeSeen(Character)
	local BodyOption = UserOptions['Body Part'][1]
	local BodyPart, Torso = Character:FindFirstChild(BodyOption), Character:FindFirstChild('HumanoidRootPart')
	local Humanoid = Character:FindFirstChildOfClass('Humanoid')

	if Humanoid.Health <= 0 then return end

	if Humanoid.RigType == Enum.HumanoidRigType.R15 then
		--print(Humanoid.RigType)
		if BodyOption == "Torso" then
			BodyPart = Torso
		elseif BodyOption == "Left Arm" then
			BodyPart = Character:FindFirstChild("LeftLowerArm")
		elseif BodyOption == "Right Arm" then
			BodyPart = Character:FindFirstChild("RightLowerArm")
		elseif BodyOption == "Left Leg" then
			BodyPart = Character:FindFirstChild("LeftLowerLeg")
		elseif BodyOption == "Right Leg" then
			BodyPart = Character:FindFirstChild("RightLowerLeg")
		else
			BodyPart = Character:FindFirstChild("Head")
		end
	end

	if BodyPart then
		local Camera = workspace.CurrentCamera or workspace:FindFirstChildOfClass('Camera')
		local Vector, onScreen = Camera:WorldToViewportPoint(BodyPart.Position)

		if Character:IsA("Model") then
			local Params = RaycastParams.new()
			Params.FilterDescendantsInstances = {LocalPlayer.Character}
			local raycast = workspace:Raycast(Camera.CFrame.Position, (BodyPart.Position-Camera.CFrame.Position).unit * 2048)

			if onScreen then
				if raycast then
					if raycast.Instance:IsDescendantOf(Character) then
						return Vector2.new(Vector.X, Vector.Y), true
					end
				end
			end
			return false
		end
	end
end

local function nearestPlayer()
	local nearestDistance = math.huge
	local nearest, nearestHumanoid = nil, nil
	local vectorPoint = nil

	local Character = LocalPlayer.Character

	for _, Player in pairs(Players:GetPlayers()) do
		local CharacterTwo = Player.Character

		if Player.Name ~= LocalPlayer.Name then
			if Character and CharacterTwo then
				local isAlly = checkTeam(Player)

				if not isAlly then
					if Character:FindFirstChildOfClass('Humanoid') and CharacterTwo:FindFirstChildOfClass('Humanoid') then
						if Character:FindFirstChild('HumanoidRootPart') then
							if not CharacterTwo:FindFirstChildOfClass("ForceField") then
								if Character:FindFirstChildOfClass('Humanoid').Health > 0 and CharacterTwo:FindFirstChildOfClass('Humanoid').Health > 0 and CharacterTwo:FindFirstChildOfClass('Humanoid').Health ~= math.huge then

									local vector, onScreen = canBeSeen(CharacterTwo)

									if onScreen then
										local distance = (CharacterTwo.Head.Position-Character.Head.Position).magnitude

										if distance < nearestDistance then
											nearestDistance = distance
											nearest = CharacterTwo
											nearestHumanoid = CharacterTwo:FindFirstChildOfClass("Humanoid")
											vectorPoint = vector
										end
									end
								end
							end
						end
					end
				end
			end 
		end
	end

	if nearest and UserOptions["Debug Mode"][1] == true then
		UsernameLabel.Text = string.format('username: %s (%s)', nearestHumanoid.DisplayName, nearest.Name)
		DistanceLabel.Text = 'distance: '..nearestDistance
		HealthLabel.Text = 'health: '..tostring(nearestHumanoid.Health)
		BodyPartLabel.Text = 'body part: '..UserOptions['Body Part'][1]
	end

	return nearest, vectorPoint, nearestDistance
end

output("[SUCCESS: Aimlock Initialized]", 132, 214, 247)

local function createESPTag(player)
	if player then
		if player:IsA("Player") and player ~= LocalPlayer then
			if not PlayerFolder:FindFirstChild(player.Name..".fucking_esp") then
				local character = player.Character
				spawn(function()
					local start = tick()

					if not character then
						repeat
							wait()
							character = player.Character
						until character or tick() - start > 5
					end

					if character then
						local humanoid = character:FindFirstChildOfClass('Humanoid')
						local head = character:FindFirstChild('Head')
						if not head then
							local t = tick()

							repeat wait()
								head = character:FindFirstChild('Head')
							until head ~= nil or (tick() - t) >= 10
						end
						if head == nil then return end

						local billboardui = Instance.new('BillboardGui')
						billboardui.Adornee = head
						billboardui.ExtentsOffset = Vector3.new(0, 1, 0)
						billboardui.AlwaysOnTop = true
						billboardui.Size = UDim2.new(0, 5, 0, 5)
						billboardui.StudsOffset = Vector3.new(0, 3)
						billboardui.Name = player.Name..".fucking_esp"
						billboardui.Parent = PlayerFolder

						local espframe = Instance.new("Frame", billboardui)
						espframe.ZIndex = 10
						espframe.BackgroundTransparency = 1
						espframe.Size = UDim2.new(1, 0, 1, 0)

						local espname = Instance.new("TextLabel", espframe)
						espname.Name = "name"
						espname.ZIndex = 10
						espname.Text = player.Name
						espname.BackgroundTransparency = 1
						espname.Position = UDim2.new(0, 0, 0, -45)
						espname.Size = UDim2.new(1, 0, 10, 0)
						espname.Font = Enum.Font.GothamSemibold
						espname.TextSize = 13
						espname.TextColor3 = getESPColor(player)
						espname.TextStrokeTransparency = 0.5

						local espdist = Instance.new("TextLabel", espframe)
						espdist.Name = "dist"
						espdist.ZIndex = 10
						espdist.Text = "Distance: nil"
						espdist.BackgroundTransparency = 1
						espdist.Position = UDim2.new(0, 0, 0, -35)
						espdist.Size = UDim2.new(1, 0, 10, 0)
						espdist.Font = Enum.Font.GothamSemibold
						espdist.TextSize = 13
						espdist.TextColor3 = getESPColor(player)
						espdist.TextStrokeTransparency = 0.5

						local esphealth = Instance.new("TextLabel", espframe)
						esphealth.Name = "health"
						esphealth.ZIndex = 10
						esphealth.Text = "Health: nil"
						esphealth.BackgroundTransparency = 1
						esphealth.Position = UDim2.new(0, 0, 0, -25)
						esphealth.Size = UDim2.new(1, 0, 10, 0)
						esphealth.Font = Enum.Font.GothamSemibold
						esphealth.TextSize = 13
						esphealth.TextColor3 = getESPColor(player)
						esphealth.TextStrokeTransparency = 0.5

						if humanoid then
							if humanoid.DisplayName ~= nil then
								espname = humanoid.DisplayName
							end
						end
					end
				end)
			end
		end
	end
end

local function removeESPTag(player)
	if player then
		if player:IsA("Player") then
			local playeresp = PlayerFolder:FindFirstChild(player.Name..".fucking_esp") 

			if playeresp then
				playeresp:Destroy()
			end
		end
	end
end


local function updateESPTag(player)
	if player then
		if player ~= LocalPlayer then
			local Character = LocalPlayer.Character
			local CharacterTwo = player.Character

			if Character and CharacterTwo then
				local humanoid = Character:FindFirstChildOfClass('Humanoid')
				local humanoidTwo = CharacterTwo:FindFirstChildOfClass('Humanoid')

				if humanoidTwo then
					if Character:FindFirstChild('Head') and CharacterTwo:FindFirstChild('Head') then
						local esptag = PlayerFolder:FindFirstChild(player.Name..'.fucking_esp')

						if esptag then
							local namelabel = esptag.Frame:FindFirstChild('name')
							local distlabel = esptag.Frame:FindFirstChild('dist')
							local healthlabel = esptag.Frame:FindFirstChild('health')

							namelabel.TextColor3 = getESPColor(player)
							distlabel.TextColor3 = getESPColor(player)
							healthlabel.TextColor3 = getESPColor(player)

							distlabel.Text = "Distance: "..math.floor((CharacterTwo.Head.Position-Character.Head.Position).magnitude+0.5)
							healthlabel.Text = "Health: "..humanoidTwo.Health
						else
							--print('no esp tag')
						end
					else
						--print('no humanoid root part')
					end
				else
					--print('no humanoid')
				end	
			else
				--print('no character')
			end
		else
			--print('player ~= localplayer')
		end
	end
end

output("[SUCCESS: ESP Tagging Initialized]", 132, 214, 247)
--------

local function booleanChange(name)
	if name == "Debug Mode" then
		DebugGui.Enabled = UserOptions[name][1]
	end
end

local function valueToType(_type, value)
	if _type == "boolean" then
		if type(value) == 'boolean' then
			return true, "TextButton", value
		elseif value == 'true' then
			return true, "TextButton", true
		elseif value == 'false' then
			return true, "TextButton", false
		end
	elseif _type == "number" then
		if type(value) == 'number' then
			return true, "TextBox", tonumber(value)
		end
	elseif _type == "Vector2" then
		local Vector = value:split(',') or value:split(', ')

		if #Vector == 2 then
			return true, "TextBox", Vector2.new(tonumber(Vector[1]), tonumber(Vector[2]))
		end
	elseif _type == "Vector3" then
		local Vector = value:split(',') or value:split(', ')

		if #Vector == 3 then
			return true, "TextBox", Vector3.new(tonumber(Vector[1]), tonumber(Vector[2]), tonumber(Vector[3]))
		end
	elseif _type == "Color3" then
		local Color = value:split(',') or value:split(', ')

		if #Color == 2 then
			return true, "TextBox", Color3.fromRGB(tonumber(Color[1]), tonumber(Color[2]), tonumber(Color[3]))
		end
	elseif _type == "Dropdown" then
		if type(value) == 'table' then
			return true, "TextButton", value[1]
		elseif type(value) == 'string' then
			print('value: ')
			print(value[1])
			return true, "TextButton", value
		end
	end

	return false
end

local OptionsCount = 0
local function createOption(name, _type, value)
	local OptionFrame = Instance.new("Frame", Scrolling)
	local Name = Instance.new("TextLabel", OptionFrame)
	local Set
	local SetCheck, SetInstance, SetValue = valueToType(_type, value)

	OptionFrame.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	OptionFrame.BorderSizePixel = 0
	OptionFrame.Size = UDim2.new(1, -11, 0.036, 0)
	OptionFrame.Name = string.char(97 + OptionsCount)
	OptionsCount+=1

	if name and _type then
		if SetCheck then
			Set = Instance.new(SetInstance, OptionFrame)
			Set.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
			Set.BorderSizePixel = 0
			Set.Position = UDim2.new(0.7, 10, 0, 0)
			Set.Size = UDim2.new(0.3, -10, 1, 0)
			Set.Font = Enum.Font.GothamSemibold
			Set.Text = tostring(value)
			Set.TextColor3 = Color3.fromRGB(179, 179, 179)
			Set.TextSize = 14

			---
			if _type == 'boolean' then
				if SetValue == false then
					Set.TextColor3 = Color3.fromRGB(247, 0, 0)
				else
					Set.TextColor3 = Color3.fromRGB(0, 247, 0)
				end
				Set.MouseButton1Up:Connect(function()
					if Set.Text == "false" then
						Set.Text = "true"
						Set.TextColor3 = Color3.fromRGB(0, 247, 0)
						UserOptions[name] = {true, _type}
					else
						Set.Text = "false"
						Set.TextColor3 = Color3.fromRGB(247, 0, 0)
						UserOptions[name] = {false, _type}
					end
					booleanChange(name)
				end)
			elseif _type == 'Vector2' then
				Set.PlaceholderText = "0, 0"
				Set.FocusLost:Connect(function()
					local Vector = Set.Text:split(',') or Set.Text:split(', ')

					if #Vector == 2 then
						UserOptions[name] = {Vector2.new(tonumber(Vector[1]), tonumber(Vector[2])), _type}
					elseif Set.Text == nil or Set.Text == "" then
						UserOptions[name] = {Vector2.new(0, 0), _type}
					end
				end)
			elseif _type == 'Vector3' then
				Set.PlaceholderText = "0, 0, 0"
				Set.FocusLost:Connect(function()
					local Vector = Set.Text:split(',')

					if #Vector == 3 then
						UserOptions[name] = {Vector3.new(Vector[1], Vector[2], Vector[3]), _type}
					elseif Set.Text == nil or Set.Text == "" then
						UserOptions[name] = {Vector3.new(0, 0, 0), _type}
					end
				end)
			elseif _type == 'number' then
				Set.PlaceholderText = "0"
				Set.FocusLost:Connect(function()
					if tonumber(Set.Text) then
						UserOptions[name] = {tonumber(Set.Text), _type}
					elseif Set.Text == nil or Set.Text == "" then
						UserOptions[name] = {0, _type}
					end
				end)
			elseif _type == 'Dropdown' then
				Set.Text = SetValue

				local DropdownFrame = Instance.new('ScrollingFrame', Set)
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
				DropdownFrame.BorderSizePixel = 0
				DropdownFrame.Size = UDim2.new(1, 0, 4, 0)
				DropdownFrame.ZIndex = 2
				DropdownFrame.CanvasSize = UDim2.new(0, 0, 8, 0)
				DropdownFrame.ScrollBarThickness = 6
				DropdownFrame.Visible = false

				local ListLayoutshit = Instance.new("UIListLayout", DropdownFrame)
				ListLayoutshit.Padding = UDim.new(0, 2)
				ListLayoutshit.SortOrder = Enum.SortOrder.Name 

				for i, option in pairs(value) do
					local optionBtn = Instance.new('TextButton', DropdownFrame)
					optionBtn.BackgroundColor3 = Color3.fromRGB(65, 65, 65)
					optionBtn.BorderSizePixel = 0
					optionBtn.Name = tostring(i)
					optionBtn.Size = UDim2.new(1, -6, 0.125, 0)
					optionBtn.Font = Enum.Font.GothamSemibold
					optionBtn.TextColor3 = Color3.fromRGB(187, 179, 178)
					optionBtn.Text = option
					optionBtn.TextSize = 14
					optionBtn.ZIndex = 3

					local TextScaleBuillshit = Instance.new('UITextSizeConstraint', optionBtn)
					TextScaleBuillshit.MaxTextSize = 14
					TextScaleBuillshit.MinTextSize = 1

					optionBtn.MouseButton1Up:Connect(function()
						if DropdownFrame.Visible == true then
							Set.Text = option
							DropdownFrame.Visible = false
							UserOptions[name] = {option, _type}
						end
					end)
				end

				Set.MouseButton1Up:Connect(function()
					if DropdownFrame.Visible == false then
						DropdownFrame.CanvasPosition = Vector2.new(0, 0)
						DropdownFrame.Visible = true
					end
				end)
			end
			---
		else
			output("[WARNING: Could not add "..name.." | Type: ".._type, 255, 115, 21)
			return
		end
	end
	Set.Name = "Set"
	Name.Name = name
	Name.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
	Name.BorderSizePixel = 0
	Name.Position = UDim2.new(0, 10, 0, 0)
	Name.Size = UDim2.new(0.7, 0, 1, 0)
	Name.Font = Enum.Font.GothamSemibold
	Name.Text = name
	Name.TextColor3 = Color3.fromRGB(179, 179, 179)
	Name.TextSize = 14
	Name.TextXAlignment = Enum.TextXAlignment.Left

	DefaultOptions[name] = {SetValue, _type}

	if isfile and readfile then
		if isfile('fuckingOptions.json') then
			local extracted = HttpService:JSONDecode(readfile('fuckingOptions.json'))
			local success, response = pcall(function()
				if extracted[name] then
					output('name: '..name)
					print('value get')
					local _, _, value = valueToType(extracted[name][2], extracted[name][1])
					print(extracted[name][2], extracted[name][1])
					print(value)		
					if value ~= nil then
						print('yes')
						UserOptions[name] = {value, extracted[name][2]}
						Set.Text = tostring(extracted[name][1])

						if value == false then
							Set.TextColor3 = Color3.fromRGB(247, 0, 0)
						elseif value == true then
							Set.TextColor3 = Color3.fromRGB(0, 247, 0)
						end
					end
				else
					UserOptions = DefaultOptions
				end
			end)

			if not success then
				output(string.format('[ERROR LOADING USER OPTIONS: %s]', response), 255, 0, 0)
			end
		else
			UserOptions = DefaultOptions
		end
	end

	if UserOptions['Debug Mode'][1] == true then
		DebugGui.Enabled = true
		if UserOptions[name] then
			output(string.format("[DEBUG: Added new option '%s' | Value: %s]", name, tostring(UserOptions[name][1])), 255, 115, 21)
		end
	end
end

output("[SUCCESS: User Setting Internals Initialized]", 132, 214, 247)

MainFrame.AnchorPoint = Vector2.new(0, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.25, 0, 0.44, 0)
MainFrame.Size = UDim2.new(0.175, 0, 0.28, 0)
MainFrame.Draggable = true

EnableBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
EnableBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
EnableBtn.BorderSizePixel = 2
EnableBtn.Position = UDim2.new(0.05, 0, 0.212, 0)
EnableBtn.Size = UDim2.new(0.434, 0, 0.245, 0)
EnableBtn.Font = Enum.Font.GothamSemibold
EnableBtn.Text = "Enable"
EnableBtn.TextColor3 = Color3.fromRGB(179, 179, 179)
EnableBtn.TextSize = 14

ESPBtn.AnchorPoint = Vector2.new(1, 0)
ESPBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
ESPBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
ESPBtn.BorderSizePixel = 2
ESPBtn.Position = UDim2.new(0.95, 0, 0.212, 0)
ESPBtn.Size = UDim2.new(0.434, 0, 0.245, 0)
ESPBtn.Font = Enum.Font.GothamSemibold
ESPBtn.Text = "ESP"
ESPBtn.TextColor3 = Color3.fromRGB(179, 179, 179)
ESPBtn.TextSize = 14

FFABtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
FFABtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
FFABtn.BorderSizePixel = 2
FFABtn.Position = UDim2.new(0.05, 0, 0.534, 0)
FFABtn.Size = UDim2.new(0.434, 0, 0.245, 0)
FFABtn.Font = Enum.Font.GothamSemibold
FFABtn.Text = "Free for All"
FFABtn.TextColor3 = Color3.fromRGB(179, 179, 179)
FFABtn.TextSize = 14

SettingsBtn.AnchorPoint = Vector2.new(1, 0)
SettingsBtn.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
SettingsBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
SettingsBtn.BorderSizePixel = 2
SettingsBtn.Position = UDim2.new(0.95, 0, 0.534, 0)
SettingsBtn.Size = UDim2.new(0.434, 0, 0.245, 0)
SettingsBtn.Font = Enum.Font.GothamSemibold
SettingsBtn.Text = "Settings"
SettingsBtn.TextColor3 = Color3.fromRGB(179, 179, 179)
SettingsBtn.TextSize = 14

Title.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0.15, 0)
Title.Font = Enum.Font.GothamSemibold
Title.Text = "Fuckin' Kill Them\nCreated by thee.#2191"
Title.TextColor3 = Color3.fromRGB(158, 158, 158)
Title.TextScaled = true

Footer.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
Footer.BorderSizePixel = 0
Footer.Position = UDim2.new(0, 0, 0.845, 0)
Footer.Size = UDim2.new(1, 0, 0.15, 0)
Footer.Font = Enum.Font.GothamSemibold
Footer.Text = "have fun motherfucker\n*alt to activate*"
Footer.TextColor3 = Color3.fromRGB(158, 158, 158)
Footer.TextScaled = true

TextConstraint.MaxTextSize = 14
TextConstraint.MinTextSize = 1

RatioConstraint.AspectRatio = 1.712
RatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize
RatioConstraint.DominantAxis = Enum.DominantAxis.Width
RatioConstraint.Parent = MainFrame

Settings.Visible = false
Settings.AnchorPoint = Vector2.new(0, 0.5)
Settings.BackgroundColor3 = Color3.fromRGB(77, 77, 77)
Settings.BorderSizePixel = 0
Settings.Position = UDim2.new(0.431, 0, 0.626, 0)
Settings.Size = UDim2.new(0.175, 0, 0.568, 0)
Settings.Draggable = true

Title2.BackgroundColor3 = Color3.fromRGB(68, 68, 68)
Title2.BorderSizePixel = 0
Title2.Size = UDim2.new(1, 0, 0.08, 0)
Title2.Font = Enum.Font.GothamSemibold
Title2.Text = "Settings"
Title2.TextColor3 = Color3.fromRGB(158, 158, 158)
Title2.TextScaled = true
Title2.TextSize = 16

TextConstraint2.MaxTextSize = 16
TextConstraint2.MinTextSize = 1

Scrolling.BackgroundTransparency = 1
Scrolling.BorderSizePixel = 0
Scrolling.Position = UDim2.new(0, 0, 0.08, 0)
Scrolling.Size = UDim2.new(1, 0, 0.92, 0)
Scrolling.ScrollBarImageColor3 = Color3.fromRGB(127, 127, 127)
Scrolling.ScrollBarThickness = 11

ListLayout.Padding = UDim.new(0, 2)
ListLayout.SortOrder = Enum.SortOrder.Name

Padding.PaddingTop = UDim.new(0, 2)

SettingOptions.BackgroundTransparency = 1
SettingOptions.BorderSizePixel = 0
SettingOptions.Size = UDim2.new(1, -11, 0.036, 0)
SettingOptions.Name = "z"

Restore.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
Restore.BorderSizePixel = 0
Restore.Position = UDim2.new(0.04, 0, 0, 0)
Restore.Size = UDim2.new(0.45, 0, 1, 0)
Restore.Font = Enum.Font.GothamSemibold
Restore.Text = "Restore Defaults"
Restore.TextColor3 = Color3.fromRGB(179, 179, 179)
Restore.TextScaled = true

Save.AnchorPoint = Vector2.new(1, 0)
Save.BackgroundColor3 = Color3.fromRGB(58, 58, 58)
Save.BorderSizePixel = 0
Save.Position = UDim2.new(0.96, 0, 0, 0)
Save.Size = UDim2.new(0.45, 0, 1, 0)
Save.Font = Enum.Font.GothamSemibold
Save.Text = "Save Settings"
Save.TextColor3 = Color3.fromRGB(179, 179, 179)
Save.TextScaled = true
Save.TextSize = 14

TextConstraint3.MaxTextSize = 14
TextConstraint3.MinTextSize = 1

TextConstraint4.MaxTextSize = 14
TextConstraint4.MinTextSize = 1

RatioConstraint2.AspectRatio = 0.845
RatioConstraint2.AspectType = Enum.AspectType.FitWithinMaxSize
RatioConstraint2.DominantAxis = Enum.DominantAxis.Width
RatioConstraint2.Parent = Settings

--//  Setting Options

createOption("Debug Mode", "boolean", false)
createOption("Realistic Mode", "boolean", false)
createOption("Cursor Offset", "Vector2", "0, 0")
createOption("Body Part", "Dropdown", {'Head', 'Torso', 'Left Arm', 'Right Arm', 'Left Leg', 'Right Leg'})

--// MainFrame Dragging
local selected = nil
local dragging
local dragInput
local dragStart, dragStart2
local startPos, startPos2

local function update(input, gui)
	if gui == MainFrame then
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	elseif gui == Settings then
		local delta = input.Position - dragStart2
		gui.Position = UDim2.new(startPos2.X.Scale, startPos2.X.Offset + delta.X, startPos2.Y.Scale, startPos2.Y.Offset + delta.Y)
	end
end

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		selected = MainFrame
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				selected = nil
				dragging = false
			end
		end)
	end
end)

MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

Settings.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		selected = Settings
		dragging = true
		dragStart2 = input.Position
		startPos2 = Settings.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				selected = nil
				dragging = false
			end
		end)
	end
end)

Settings.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input, selected)
	end
end)
--// Functionality

--[Aimlock Function]

local function Toggle(name, state)
	if name == "Toggle" and state == Enum.UserInputState.Begin then
		if Enabled == false then
			Enabled = true
			StatusLabel.Text = "enabled: True"

			game:GetService('RunService'):BindToRenderStep("AimBinding", Enum.RenderPriority.First.Value, function()
				if Enabled then
					if Aiming ~= true then
						local Target, Vector, Distance = nearestPlayer()

						if Target then
							if mousemoveabs then
								local offset = UserOptions["Cursor Offset"][1]

								if UserOptions['Realistic Mode'][1] == true then
									local random = Random.new()
									local x = 30

									if Distance >= 50 then
										x = 15
									end

									local randomX = random:NextInteger(-x, x)
									local randomY = random:NextInteger(-x, x)

									offset = Vector2.new(randomX, randomY)
								end

								if UserOptions['Debug Mode'][1] == true then
									OffsetLabel.Text = string.format("offset: (%s, %s)", offset.X, offset.Y)
								end

								mousemoveabs(Vector.X + offset.X, Vector.Y + offset.Y)
							end
						end
					end
				end
			end)
			EnableBtn.BorderColor3 = Color3.fromRGB(0, 129, 0)
			EnableBtn.Text = "Disable"
		else
			Enabled = false
			StatusLabel.Text = "enabled: False"

			game:GetService('RunService'):UnbindFromRenderStep("AimBinding")

			EnableBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
			EnableBtn.Text = "Enable"
		end
	end
end

--[ESP Function]

local function ToggleESP()
	if ESPEnabled == false then
		ESPEnabled = true

		for _, player in pairs(Players:GetPlayers()) do
			if player then
				removeESPTag(player)
				createESPTag(player)

				if CharacterEvents[player.Name] == nil then
					CharacterEvents[player.Name] = player.CharacterAdded:Connect(function(char)
						removeESPTag(player)
						createESPTag(player)

						local humanoid = char:FindFirstChildOfClass('Humanoid')

						if humanoid then
							local diedEvent
							diedEvent = char:FindFirstChildOfClass('Humanoid').Died:Connect(function()
								diedEvent:Disconnect()
								diedEvent = nil
								removeESPTag(player)
							end)
						end	
					end)
				end
			end
		end

		game:GetService('RunService'):BindToRenderStep("ESPUpdate", Enum.RenderPriority.Character.Value, function()
			if ESPEnabled then
				for _, player in pairs(Players:GetPlayers()) do
					if player then
						updateESPTag(player)
					end
				end 
			end
		end)

		ESPBtn.BorderColor3 = Color3.fromRGB(0, 129, 0)
	else
		ESPEnabled = false

		game:GetService('RunService'):UnbindFromRenderStep("ESPUpdate")

		for _,player in pairs(Players:GetPlayers()) do
			removeESPTag(player)
			if CharacterEvents[player.Name] then
				CharacterEvents[player.Name]:Disconnect()
				CharacterEvents[player.Name] = nil
			end
		end

		ESPBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
	end
end

EnableBtn.MouseButton1Up:Connect(function()
	Toggle("Toggle", Enum.UserInputState.Begin)
end)

ESPBtn.MouseButton1Up:Connect(function()
	ToggleESP()
end)

FFABtn.MouseButton1Up:Connect(function()
	if FFA == false then
		FFA = true
		FFABtn.BorderColor3 = Color3.fromRGB(0, 129, 0)
	else
		FFA = false
		FFABtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
	end
end)

SettingsBtn.MouseButton1Up:Connect(function()
	if Settings.Visible == false then
		Settings.Visible = true
		SettingsBtn.BorderColor3 = Color3.fromRGB(0, 129, 0)
	else
		Settings.Visible = false
		SettingsBtn.BorderColor3 = Color3.fromRGB(129, 0, 0)
	end
end)

--// Configuration Read/Write

local cooldown = false

local function writefileCooldown(name, data)
	local success, response = pcall(function()
		spawn(function()
			if not cooldown then
				cooldown = true
				writefile(name, data)
				Save.Text = "Saved!"
				wait(3)
				cooldown = false
				Save.Text = "Save Settings"
			end
		end)
	end)

	if success then
		output("[SUCCESS: Saved user settings]", 0, 247, 0)
	else
		output(string.format('[ERROR SAVING USER OPTIONS: %s]', response), 255, 0, 0)
	end
end

local function save()
	if isfile and writefile and readfile then
		local TranslatedTable = {}

		for name, value in pairs(UserOptions) do
			TranslatedTable[name] = {tostring(value[1]), value[2 ]}
		end

		local encoded = HttpService:JSONEncode(TranslatedTable)
		if isfile('fuckingOptions.json') then
			writefileCooldown('fuckingOptions.json', encoded)
		else
			writefileCooldown('fuckingOptions.json', encoded)
		end
	else
		output("[ERROR: Unsupported Executor]", 255, 0, 0)
	end
end

Save.MouseButton1Up:Connect(function()
	save()
end)

Restore.MouseButton1Up:Connect(function()
	UserOptions = DefaultOptions

	for name, value in pairs(DefaultOptions) do
		for _, frame in pairs(Scrolling:GetChildren()) do
			if frame:IsA('Frame') then
				if frame:FindFirstChild(name) then
					frame.Set.Text = tostring(value[1])
					if value[1] == false then
						frame.Set.TextColor3 = Color3.fromRGB(247, 0, 0)
					elseif value[1] == true then
						frame.Set.TextColor3 = Color3.fromRGB(0, 247, 0)
					end
				end
			end
		end
	end
end)

output("[SUCCESS: User Setting Graphical User Interface Created]", 132, 214, 247)
------

local function Visible(name, state)
	if name == "Visible" and state == Enum.UserInputState.Begin then
		if ScreenGui.Enabled == false then
			ScreenGui.Enabled = true
		else
			ScreenGui.Enabled = false
		end
	end
end

Players.PlayerAdded:Connect(function(player)
	if ESPEnabled then
		if CharacterEvents[player.Name] == nil then
			CharacterEvents[player.Name] = player.CharacterAdded:Connect(function()
				removeESPTag(player)
				createESPTag(player)
			end)
		end
	end
end)

Players.PlayerRemoving:Connect(function(player)
	removeESPTag(player)
	if CharacterEvents[player.Name] then
		CharacterEvents[player.Name]:Disconnect()
		CharacterEvents[player.Name] = nil
	end
end)

ContextActionService:BindAction("Visible", Visible, true, Enum.KeyCode.P)
ContextActionService:BindAction("Toggle", Toggle, true, Enum.KeyCode.LeftAlt)

--// Aim (right click) Bind
local Mouse = LocalPlayer:GetMouse()

Mouse.Button2Down:Connect(function()
	Aiming = true
end)

Mouse.Button2Up:Connect(function()
	Aiming = false
end)

output("[SUCCESS: Initialized Right Click Bind]", 132, 214, 247)

--- EOF
output("[SUCCESS: Finalized Script Initialization, EOF reached]", 132, 214, 247)
