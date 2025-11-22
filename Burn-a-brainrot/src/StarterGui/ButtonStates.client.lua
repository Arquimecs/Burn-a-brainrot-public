local cs = game:GetService("CollectionService")

local function setup(button: ImageButton)
	if not button:IsA("ImageButton") then warn(("%s is not an ImageButton")) return end
	
	local function checkEnabled()
		if button:GetAttribute("Enabled") then return true end
		button.Image = button:GetAttribute("disabled") or button:GetAttribute("Id") 
	end
	
	local function hover()
		if not checkEnabled() then return end
		button.Image = button:GetAttribute("hover") or button:GetAttribute("Id")
	end

	local function hoverStop()
		if not checkEnabled() then return end
		button.Image = button:GetAttribute("toggled") and button:GetAttribute("clicked") or button:GetAttribute("Id")
	end
	
	local function mouseDown()
		if not checkEnabled() then return end
		button.Image = button:GetAttribute("clicked") or button:GetAttribute("Id")
	end
	
	local function mouseUp()
		if not checkEnabled() then return end
		button.Image = button:GetAttribute("Id")
	end
	
	local function click()
		if not checkEnabled() then return end
		button:SetAttribute("mode", not button:GetAttribute("toggled"))
		button.Image = button:GetAttribute("mode") and button:GetAttribute("clicked") or button:GetAttribute("Id")
	end

	local function loadImages()
		button.Image = button:GetAttribute("disabled") or ""
		button.Image = button:GetAttribute("clicked") or ""
		button.Image = button:GetAttribute("hover") or ""
		button.Image = button:GetAttribute("Id") or ""
	end

	loadImages()
	button:SetAttribute("Enabled", true)
	button.MouseButton1Down:Connect(mouseDown)
	button.MouseButton1Up:Connect(mouseUp)
	button.MouseButton1Click:Connect(click)
	button.MouseEnter:Connect(hover)
	button.MouseLeave:Connect(hoverStop)
	button:GetAttributeChangedSignal("Enabled"):Connect(checkEnabled)
end

for _, button in cs:GetTagged("Button") do
	setup(button)
end
cs:GetInstanceAddedSignal("Button"):Connect(setup)