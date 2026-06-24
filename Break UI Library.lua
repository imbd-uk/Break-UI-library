local UI = {}


--local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService('UserInputService')
local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local WorkSpace = game:GetService('Workspace')
local TweenService = game:GetService('TweenService')

local viewport = workspace.CurrentCamera.ViewportSize
local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Exponential, Enum.EasingDirection.InOut)

local player = Players.LocalPlayer
local mouse  = player:GetMouse()

local Connections = {}

function UI:tween(object, goal, callback)
	local tween = TweenService:Create(object, tweenInfo, goal)
	tween.Completed:Connect(callback or function() end)
	tween:Play()
end


function UI:Validate(defaults, options)
	for i,v in pairs(defaults)do
		if options[i] == nil then
			options[i] = v
		end
	end
	return options
end

function UI:Create(Info)

	Info = UI:Validate({
		Name = "Untitled",
		Key = Enum.KeyCode.RightShift,
	}, Info or {})
	
	local GUI = {
		CurrentTab = nil
	}
	
	--Render
	do
	GUI.screenUI = Instance.new("ScreenGui")
	GUI.screenUI.Name = "Break UI LIBRARY"
	GUI.screenUI.Parent = Players.LocalPlayer.PlayerGui --CHANGE BACK TO COREGUI WHEN NOT USING IN STUDIO
	GUI.screenUI.ResetOnSpawn = false
    GUI.screenUI.ZIndexBehavior = Enum.ZIndexBehavior.Global
		
	GUI.MainFrame = Instance.new("Frame")
	GUI.MainFrame.Name = "MainFrame"
	GUI.MainFrame.Parent = GUI.screenUI
	GUI.MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
	GUI.MainFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 39)
	GUI.MainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUI.MainFrame.BorderSizePixel = 0
	GUI.MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
	GUI.MainFrame.Size = UDim2.new(0, 620, 0, 300)
	GUI.MainFrame.ClipsDescendants = true
	
		
	GUI.DropShadowHolder = Instance.new("Frame")
	GUI.DropShadowHolder.Name = "DropShadowHolder"
	GUI.DropShadowHolder.Parent = GUI.MainFrame
	GUI.DropShadowHolder.BackgroundTransparency = 1.000
	GUI.DropShadowHolder.BorderSizePixel = 0
	GUI.DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	GUI.DropShadowHolder.ZIndex = 0
	
	GUI.DropShadow  = Instance.new("ImageLabel")
	GUI.DropShadow.Name = "DropShadow"
	GUI.DropShadow.Parent = GUI.DropShadowHolder
	GUI.DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	GUI.DropShadow.BackgroundTransparency = 1.000
	GUI.DropShadow.BorderSizePixel = 0
	GUI.DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	GUI.DropShadow.Size = UDim2.new(1, 47, 1, 47)
	GUI.DropShadow.ZIndex = 0
	GUI.DropShadow.Image = "rbxassetid://6014261993"
	GUI.DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	GUI.DropShadow.ImageTransparency = 0.500
	GUI.DropShadow.ScaleType = Enum.ScaleType.Slice
	GUI.DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)
	
	GUI.UICorner = Instance.new("UICorner")
	GUI.UICorner.CornerRadius = UDim.new(0, 2)
	GUI.UICorner.Parent = GUI.MainFrame
	
	GUI.Bar = Instance.new("Frame")
	GUI.Bar.Name = "Bar"
	GUI.Bar.Parent = GUI.MainFrame
	GUI.Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GUI.Bar.BackgroundTransparency = 1.000
	GUI.Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUI.Bar.BorderSizePixel = 0
	GUI.Bar.Size = UDim2.new(1, 0, 0, 30)
	
	GUI.Title = Instance.new("TextLabel")
	GUI.Title.Name = "Title"
	GUI.Title.Parent = GUI.Bar
	GUI.Title.AnchorPoint = Vector2.new(0, 0.5)
	GUI.Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	GUI.Title.BackgroundTransparency = 1.000
	GUI.Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUI.Title.BorderSizePixel = 0
	GUI.Title.Position = UDim2.new(0, 5, 0.5, 0)
	GUI.Title.Size = UDim2.new(0, 200, 1, -10)
	GUI.Title.Font = Enum.Font.SourceSans
	GUI.Title.Text = Info.Name 
	GUI.Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	GUI.Title.TextScaled = true
	GUI.Title.TextSize = 14.000
	GUI.Title.TextWrapped = true
	GUI.Title.TextXAlignment = Enum.TextXAlignment.Left
	
	GUI.TabsHolder = Instance.new("Frame")
	GUI.TabsHolder.Name = "TabsHolder"
	GUI.TabsHolder.Parent = GUI.MainFrame
	GUI.TabsHolder.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	GUI.TabsHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GUI.TabsHolder.BorderSizePixel = 0
	GUI.TabsHolder.Position = UDim2.new(0, 5, 0, 30)
	GUI.TabsHolder.Size = UDim2.new(1, -10, 0, 30)
	
	GUI.UIStroke = Instance.new("UIStroke")
	GUI.UIStroke.Parent = GUI.MainFrame
	GUI.UIStroke.Color = Color3.fromRGB(255, 139, 7)
	GUI.UIStroke.Thickness = 1
	GUI.UIStroke.Transparency = 0.25
	GUI.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	
	GUI.UIListLayout = Instance.new("UIListLayout")
	GUI.UIListLayout.Parent = GUI.TabsHolder
	GUI.UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	GUI.UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	GUI.UIListLayout.Padding = UDim.new(0, 1)
	end
	
GUI.IsDragging = false 	
local dragInput				
local StartingPoint
local oldPos				

local function update(input)
	local delta = input.Position - StartingPoint
	GUI.MainFrame.Position = UDim2.new(oldPos.X.Scale, oldPos.X.Offset + delta.X, oldPos.Y.Scale, oldPos.Y.Offset + delta.Y)
end

GUI.MainFrame.InputBegan:Connect(function(input)
	-- Check if input target is exactly MainFrame, not any of its children
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		GUI.IsDragging = true
		StartingPoint = input.Position
		oldPos = GUI.MainFrame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
					GUI.IsDragging = false
			end
		end)
	end
end)

GUI.MainFrame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

table.insert(Connections,UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and GUI.IsDragging then
		update(input)
	end
end))

	table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameprocessed)
		if gameprocessed  then
			return
		end
		if input.KeyCode == Info.Key then
			  GUI.MainFrame.Visible = not GUI.MainFrame.Visible
		end
	end))
	
	function GUI:CreateTab(info)
		info = UI:Validate({
			Name = "Tab",
		}, info or {})
		
		local Tab = {
			Hover = false,
			Active = false,
		}
		
	
		--Render
		do
		Tab.Frame = Instance.new('Frame')
		Tab.Frame.Parent = GUI.TabsHolder
		Tab.Frame.Name = info.Name or "Tab"
		Tab.Frame.Size = UDim2.new(0, 100, 1, 0)
		Tab.Frame.BackgroundColor3 = Color3.fromRGB(66, 73, 79)
		Tab.Frame.BorderSizePixel = 0
		Tab.Button = Instance.new("TextLabel")
		Tab.Button.Name = "TabButton"
		Tab.Button.Parent = Tab.Frame
		Tab.Button.Active = false
		Tab.Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Tab.Button.BackgroundTransparency = 1.000
		Tab.Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.Button.BorderSizePixel = 0
		Tab.Button.Size = UDim2.new(1, 0, 1, 0)
		Tab.Button.Font = Enum.Font.SourceSansBold
		Tab.Button.Text = info.Name
		Tab.Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Tab.Button.TextSize = 20.000
		Tab.Button.TextStrokeColor3 = Color3.fromRGB(59, 67, 75)
		Tab.Button.TextWrapped = true
		Tab.Container = Instance.new("Frame")
		Tab.Container.Name = "Container"
		Tab.Container.Parent = GUI.MainFrame
		Tab.Container.BackgroundColor3 = Color3.fromRGB(33, 33, 39) --33, 33, 39
		Tab.Container.BackgroundTransparency = 0
		Tab.Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Tab.Container.BorderSizePixel = 0
		Tab.Container.Size = UDim2.new(1, -10, 1, -75)
		Tab.Container.Position = UDim2.new(0.5,0,0,70)
		Tab.Container.AnchorPoint = Vector2.new(0.5,0)
		Tab.Container.Visible = false
			
			
		Tab.UIListLayout_2 = Instance.new("UIListLayout")
		Tab.UIListLayout_2.Parent = Tab.Container
		Tab.UIListLayout_2.FillDirection = Enum.FillDirection.Horizontal
		Tab.UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		Tab.UIListLayout_2.Padding = UDim.new(0, 5)
	   end
	
		--methods
		do
		function Tab:Activate()
			if not Tab.Active then
				if GUI.CurrentTab ~= nil then
					GUI.CurrentTab:Deactivate()
				end
				
				Tab.Active = true
				UI:tween(Tab.Frame, {BackgroundColor3 = Color3.fromRGB(255, 139, 7)})
				Tab.Container.Visible = true
				GUI.CurrentTab = Tab
			end
		end
		
	   function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
					UI:tween(Tab.Frame, {BackgroundColor3 = Color3.fromRGB(66, 73, 79)})
				Tab.Container.Visible= false
			end
		end
		
		Tab.Frame.MouseEnter:Connect(function()
			Tab.Hover = true
			if Tab.Active then
				UI:tween(Tab.Frame, {BackgroundColor3 = Color3.fromRGB(255, 139, 7)})
			end
		end)

		Tab.Frame.MouseLeave:Connect(function()
			Tab.Hover = false
			if not Tab.Active then
				UI:tween(Tab.Frame, {BackgroundColor3 = Color3.fromRGB(66, 73, 79)})
			end
		end)

		table.insert(Connections,UserInputService.InputBegan:Connect(function(input, gameprocessed)
			if gameprocessed then
				return
			end
			if input.UserInputType == Enum.UserInputType.MouseButton1 and Tab.Hover then
				Tab:Activate()
			end
		end))
		
		if GUI.CurrentTab == nil then
			Tab:Activate()
			end

		end
		
		function Tab:CreateSection()
		    local Section = {}
			Section.Section = Instance.new("Frame")
			Section.Section.Name = "Section"
			Section.Section.Parent = Tab.Container
			Section.Section.BackgroundColor3 = Color3.fromRGB(35, 36, 39)
			Section.Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.Section.BorderSizePixel = 0
			Section.Section.Size = UDim2.new(0, 200, 1, 0)
			
			Section.UIStroke = Instance.new("UIStroke")
			Section.UIStroke.Parent = Section.Section
			Section.UIStroke.Transparency = 0.25
			Section.UIStroke.Color = Color3.fromRGB(255, 139, 7)
			
			Section.UIListLayout_3 = Instance.new("UIListLayout")
			Section.UIListLayout_3.Parent = Section.Section
			Section.UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
			Section.UIListLayout_3.Padding = UDim.new(0, 5)
			
			Section.UIPadding = Instance.new("UIPadding")
			Section.UIPadding.Parent = Section.Section
			Section.UIPadding.PaddingLeft = UDim.new(0,3)
			Section.UIPadding.PaddingRight = UDim.new(0,3)
			Section.UIPadding.PaddingTop = UDim.new(0,3)
			Section.UIPadding.PaddingBottom = UDim.new(0,3)
			
			function Section:Button(info)
				UI:Validate({
					Name = "Button",
					callback = function() end,		
				},info or {})
				
				local Button = {
					Hover = false,
					MouseDown = false,
				}
				
				--Render
				do
					Button.ButtonFrame = Instance.new("Frame")
					Button.ButtonFrame.Name = "ButtonFrame"
					Button.ButtonFrame.Parent = Section.Section
					Button.ButtonFrame.AnchorPoint = Vector2.new(0.5, 0)
					Button.ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 36, 39)
					Button.ButtonFrame.BackgroundTransparency = 0
					Button.ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.ButtonFrame.BorderSizePixel = 0
					Button.ButtonFrame.Position = UDim2.new(0.5, 0, 0, 5)
					Button.ButtonFrame.Size = UDim2.new(1, 0, 0, 30)
					
					Button.ButtonLabel = Instance.new("TextLabel")
					Button.ButtonLabel.Name = "ButtonLabel"
					Button.ButtonLabel.Parent = Button.ButtonFrame
					Button.ButtonLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.ButtonLabel.BackgroundTransparency = 1.000
					Button.ButtonLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.ButtonLabel.BorderSizePixel = 0
					Button.ButtonLabel.Position = UDim2.new(0, 5, 0, 0)
					Button.ButtonLabel.Size = UDim2.new(1, -5, 1, 0)
					Button.ButtonLabel.Font = Enum.Font.SourceSans
					Button.ButtonLabel.Text = info.Name
					Button.ButtonLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					Button.ButtonLabel.TextSize = 20.000
					Button.ButtonLabel.TextXAlignment = Enum.TextXAlignment.Left
					
					Button.ImageLabel = Instance.new("ImageLabel")
					Button.ImageLabel.Parent = Button.ButtonFrame
					Button.ImageLabel.AnchorPoint = Vector2.new(1, 0)
					Button.ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Button.ImageLabel.BackgroundTransparency = 1.000
					Button.ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Button.ImageLabel.BorderSizePixel = 0
					Button.ImageLabel.Position = UDim2.new(1, 0, 0, 0)
					Button.ImageLabel.Size = UDim2.new(0, 30, 1, -5)
					Button.ImageLabel.Image = "rbxassetid://102276835764450"
					
					Button.UIStroke = Instance.new("UIStroke")
					Button.UIStroke.Parent = Button.ButtonFrame
					Button.UIStroke.Color = Color3.fromRGB(86, 95, 104)
					Button.UIStroke.Transparency = 0.25
					Button.UIStroke.Thickness = 1
				end
				
				--method
				function Button:SetText(text)
					Button.ButtonLabel.Text = text	
				end
				
				function Button:SetCallback(fn)
					info.callback = fn
				end
				--logic
				do
					Button.ButtonFrame.MouseEnter:Connect(function()
						Button.Hover = true
						UI:tween(Button.ButtonFrame, {BackgroundColor3 = Color3.fromRGB(50, 52, 56)})
					
					end)
					
					Button.ButtonFrame.MouseLeave:Connect(function()
						Button.Hover = false

						if not Button.MouseDown then
							UI:tween(Button.ButtonFrame, {BackgroundColor3 = Color3.fromRGB(35, 36, 39)})
						end
					end)
					
					table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Button.Hover then
							Button.MouseDown = true
							UI:tween(Button.ButtonFrame, {BackgroundColor3 = Color3.fromRGB(35, 36, 39)})
							info.callback()
						end
					end))
					
					table.insert(Connections,UserInputService.InputEnded:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Button.MouseDown = false
							if Button.Hover then
								--hover state
								UI:tween(Button.ButtonFrame, {BackgroundColor3 = Color3.fromRGB(50, 52, 56)})
							else
								UI:tween(Button.ButtonFrame, {BackgroundColor3 = Color3.fromRGB(35, 36, 39)})
							end
						end
					end))
				end
				
				return Button
			end
			
			function Section:Slider(options)
				UI:Validate({
					Name = "Slider",
					min = 0,
					max = 100,
					default = 50,
					callback = function() end,		
				},options or {})
				
				local Slider = {
					Hover = false,
					MouseDown = false,
	                Connection = nil,
				}
				
				--render
				do
					Slider.SliderFrame = Instance.new("Frame")
					Slider.SliderFrame.Name = "SliderFrame"
					Slider.SliderFrame.Parent = Section.Section
					Slider.SliderFrame.AnchorPoint = Vector2.new(0.5, 0)
					Slider.SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.SliderFrame.BackgroundTransparency = 1.000
					Slider.SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.SliderFrame.BorderSizePixel = 0
					Slider.SliderFrame.Position = UDim2.new(0.5, 0, 0, 5)
					Slider.SliderFrame.Size = UDim2.new(1, 0, 0, 50)
					
					Slider.SlideLabel = Instance.new("TextLabel")
					Slider.SlideLabel.Name = "SlideLabel"
					Slider.	SlideLabel.Parent = Slider.SliderFrame
					Slider.SlideLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Slider.SlideLabel.BackgroundTransparency = 1.000
					Slider.SlideLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.SlideLabel.BorderSizePixel = 0
					Slider.SlideLabel.Position = UDim2.new(0, 1, 0, 0)
					Slider.SlideLabel.Size = UDim2.new(1, -2, 0, 25)
					Slider.SlideLabel.Font = Enum.Font.SourceSans
					Slider.SlideLabel.Text = options.Name
					Slider.SlideLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
					Slider.SlideLabel.TextSize = 20.000
					Slider.SlideLabel.TextWrapped = true
					
					
					Slider.SlideLabel.TextXAlignment = Enum.TextXAlignment.Left
					
					Slider.UIStroke = Instance.new("UIStroke")
					Slider.UIStroke.Parent = Slider.SlideLabel
					Slider.UIStroke.Color = Color3.fromRGB(66, 73, 79)
					Slider.UIStroke.Thickness = 1
					Slider.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
					
                    Slider.SliderBack = Instance.new("Frame")
					Slider.SliderBack.Name = "SliderBack"
					Slider.SliderBack.Parent = Slider.SliderFrame
					Slider.SliderBack.AnchorPoint = Vector2.new(0, 0.5)
					Slider.SliderBack.BackgroundColor3 = Color3.fromRGB(66, 73, 79)
					Slider.SliderBack.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.	SliderBack.BorderSizePixel = 0
					Slider.SliderBack.Position = UDim2.new(0, 0, 1, 0)
					Slider.SliderBack.Size = UDim2.new(1, 0, 1, -30)
					Slider.SliderBack.AnchorPoint = Vector2.new(0,1)
					
					Slider.ValueText = Instance.new("TextLabel")
					Slider.ValueText.Parent = Slider.SliderBack
					Slider.ValueText.BackgroundTransparency = 1
					Slider.ValueText.TextColor3 = Color3.fromRGB(255, 255, 255)
					Slider.ValueText.TextScaled = true
					Slider.ValueText.ZIndex = 2
					
					Slider.ValueText.Size = UDim2.new(1,0,1,0)
					Slider.ValueText.Text = options.default
					
					Slider.UICorner_2 = Instance.new("UICorner")
					Slider.UICorner_2.CornerRadius = UDim.new(0, 3)
					Slider.UICorner_2.Parent = Slider.SliderBack
					
					Slider.SliderMove = Instance.new("Frame")
					Slider.SliderMove.Name = "SliderMove"
					Slider.SliderMove.Parent = Slider.SliderBack
					Slider.SliderMove.BackgroundColor3 = Color3.fromRGB(255, 139, 7)
					Slider.SliderMove.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Slider.SliderMove.BorderSizePixel = 0
					Slider.SliderMove.Size = UDim2.new(0, 0, 1, 0)
					
				end
				
				--method
				function Slider:SetValue(v)
					if v == nil then
						GUI.IsDragging = false
						local percentage = math.clamp((mouse.X - Slider.SliderBack.AbsolutePosition.X)/(Slider.SliderBack.AbsoluteSize.X),0,1 )

						local sliderValue = math.floor(options.min + (options.max - options.min)*  percentage)
						Slider.ValueText.Text = tostring(sliderValue)
						Slider.SliderMove.Size = UDim2.fromScale(percentage, 1)
					else
						Slider.ValueText.Text =   tostring(v)
						Slider.SliderMove.Size = UDim2.fromScale(((v - options.min) / (options.max - options.min)), 1)
					end
                      options.callback(Slider:GetValue())
				end
				
				function Slider:GetValue()
					return tonumber(Slider.ValueText.Text)
				end
				--logic 
				do
					Slider.SliderBack.MouseEnter:Connect(function()
						Slider.Hover = true
						
					end)

					Slider.SliderBack.MouseLeave:Connect(function()
						Slider.Hover = false

						if not Slider.MouseDown then
							
						end
					end)

					table.insert(Connections, UserInputService.InputBegan:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Slider.Hover then
							Slider.MouseDown = true
						
							if not Slider.Connection then
								Slider.Connection = RunService.RenderStepped:Connect(function()
									 Slider:SetValue()
								end)
							end
						end
					end))

					table.insert(Connections, UserInputService.InputEnded:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 then
							Slider.MouseDown = false
					
							if Slider.Connection then
							Slider.Connection:Disconnect()
							Slider.Connection = nil
							end
						end
					end))
					
				end
				
				return Slider
			end
			
			function Section:Toggle(info)
				UI:Validate({
					Name = "Toggle",
					callback = function() end,		
				},info or {})
				local Toggle = {
					Hover = false,
					MouseDown = false,
					State = false,
				}
				
				Toggle.ToggleFrame = Instance.new("Frame")
				Toggle.ToggleFrame.Name = "ToggleFrame"
				Toggle.ToggleFrame.Parent = Section.Section
				Toggle.ToggleFrame.AnchorPoint = Vector2.new(0.5, 0)
				Toggle.ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.ToggleFrame.BackgroundTransparency = 1.000
				Toggle.ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.ToggleFrame.BorderSizePixel = 0
				Toggle.ToggleFrame.Position = UDim2.new(0.5, 0, 0, 5)
				Toggle.ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
				
				Toggle.UIStroke = Instance.new("UIStroke")
				Toggle.UIStroke.Parent  = Toggle.ToggleFrame
				Toggle.UIStroke.Color = Color3.fromRGB(66, 73, 79)
				Toggle.UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Toggle.UIStroke.Thickness = 1
				
				Toggle.ToggleLabel = Instance.new("TextLabel")
				Toggle.ToggleLabel.Name = "ToggleLabel"
				Toggle.ToggleLabel.Parent = 	Toggle.ToggleFrame
				Toggle.ToggleLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.ToggleLabel.BackgroundTransparency = 1.000
				Toggle.ToggleLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.ToggleLabel.BorderSizePixel = 0
				Toggle.ToggleLabel.Size = UDim2.new(1, 0, 1, 0)
				Toggle.ToggleLabel.Font = Enum.Font.SourceSans
				Toggle.ToggleLabel.Text = info.Name
				Toggle.ToggleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.ToggleLabel.TextSize = 20.000
				Toggle.ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
				
				Toggle.ToggleColour = Instance.new("Frame")
				Toggle.ToggleColour.Name = "ToggleButton"
				Toggle.ToggleColour.Parent = Toggle.ToggleFrame
				Toggle.ToggleColour.AnchorPoint = Vector2.new(1, 0.5)
				Toggle.ToggleColour.BackgroundColor3 = Color3.fromRGB(33, 33, 39) -- 255, 139, 7
				Toggle.ToggleColour.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.ToggleColour.BorderSizePixel = 0
				Toggle.ToggleColour.Position = UDim2.new(1, -5, 0.5, 0)
				Toggle.ToggleColour.Size = UDim2.new(1, -170, 1, -10)
				
				Toggle.UIStroke2 = Instance.new("UIStroke")
				Toggle.UIStroke2.Parent  = Toggle.ToggleColour
				Toggle.UIStroke2.Color = Color3.fromRGB(66, 73, 79)
				Toggle.UIStroke2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				Toggle.UIStroke2.Thickness = 1

				--methods
				function Toggle:Toggle(b)
					if b == nil then
						Toggle.State = not Toggle.State
					else
						Toggle.State = b
					end
					info.callback(Toggle.State)
					
					if Toggle.State then
						UI:tween(Toggle.ToggleColour, {BackgroundColor3 = Color3.fromRGB(255, 139, 7)})
					else
						UI:tween(Toggle.ToggleColour, {BackgroundColor3 = Color3.fromRGB(33, 33, 39)})
					end
				end
				
				--logic 
				do
					Toggle.ToggleColour.MouseEnter:Connect(function()
						Toggle.Hover = true
						if not Toggle.State then
						UI:tween(Toggle.ToggleColour, {BackgroundColor3 =Color3.fromRGB(44, 44, 52) })
						end	
						end)

					Toggle.ToggleColour.MouseLeave:Connect(function()
						Toggle.Hover = false
						if not Toggle.State then
						UI:tween(Toggle.ToggleColour, {BackgroundColor3 =Color3.fromRGB(33, 33, 39)})
						end
					end)

					table.insert(Connections,UserInputService.InputBegan:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
							Toggle.MouseDown = true
							--UI:tween(Toggle.ToggleColour, {BackgroundColor3 = Color3.fromRGB(255, 139, 7)})
							Toggle:Toggle()
						end
					end))
					
						table.insert(Connections,UserInputService.InputEnded:Connect(function(input, gameprocessed)
						if gameprocessed then
							return
						end
						if input.UserInputType == Enum.UserInputType.MouseButton1 and Toggle.Hover then
							Toggle.MouseDown = false
							--UI:tween(Toggle.ToggleColour, {BackgroundColor3 = Color3.fromRGB(33, 33, 39)})
						end
					end))
				end
				
		
				
				return Toggle
			end
			
			function Section:TextBox(info)
				UI:Validate({
					Name = "Text",
					callback = function(text) print(text) end,
				},info or {})
				
				local TextBox = {}
				--render
				do	
				TextBox.TextBoxFrame = Instance.new("Frame")
				TextBox.TextBoxFrame.Name = "TextBoxFrame"
				TextBox.TextBoxFrame.Parent = Section.Section
				TextBox.TextBoxFrame.AnchorPoint = Vector2.new(0.5, 0)
				TextBox.TextBoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextBoxFrame.BackgroundTransparency = 1.000
				TextBox.TextBoxFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.TextBoxFrame.BorderSizePixel = 0
				TextBox.TextBoxFrame.Position = UDim2.new(0.5, 0, 0, 5)
				TextBox.TextBoxFrame.Size = UDim2.new(1, 0, 0, 20)
					
				TextBox.TextBox = Instance.new("TextBox")
				TextBox.TextBox.Parent = TextBox.TextBoxFrame
				TextBox.TextBox.BackgroundColor3 = Color3.fromRGB(255, 139, 7)
				TextBox.TextBox.BackgroundTransparency = 1.000
				TextBox.TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextBox.TextBox.BorderSizePixel = 0
				TextBox.TextBox.Size = UDim2.new(1, 0, 1, 0)
				TextBox.TextBox.Font = Enum.Font.SourceSans
				TextBox.TextBox.PlaceholderText = "TextBox"
				TextBox.TextBox.Text = ""
				TextBox.TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextBox.TextSize = 20.000
					
				TextBox.UIStoke = Instance.new("UIStroke")
				TextBox.UIStoke.Parent = TextBox.TextBoxFrame
				TextBox.UIStoke.Color = Color3.fromRGB(86, 95, 104)
				TextBox.UIStoke.Thickness = 1
				TextBox.UIStoke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				end	
				--logic
				do
					function TextBox:GetText()
						return TextBox.TextBox.Text
					end
				end
				
				function TextBox:EnterPressed(text)
					if text == nil then
						return
					else
						 info.callback(text)
					end
				end
				
				--method 
				TextBox.TextBox.FocusLost:Connect(function(enterpressed)
					if enterpressed then
						local text = TextBox:GetText()
						TextBox:EnterPressed(text)
					end
				end)
				
				return TextBox
			end
			
			return Section
		end
		

		
		return Tab
	end

	GUI:Destroy = function()
		for _, connection in pairs(Connections) do
			connection:Disconnect()
		end
		GUI.screenUI:Destroy()
	end
	
	return GUI
end



