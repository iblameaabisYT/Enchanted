
if getgenv().Library then
    getgenv().Library:Unload()
end

local Library do 
    local Workspace = game:GetService("Workspace")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local HttpService = game:GetService("HttpService")
    local RunService = game:GetService("RunService")
    local CoreGui = cloneref and cloneref(game:GetService("CoreGui")) or game:GetService("CoreGui")
    local TweenService = game:GetService("TweenService")
    local Lighting = game:GetService("Lighting")

    gethui = gethui or function()
        return CoreGui
    end

    local LocalPlayer = Players.LocalPlayer
    local CurrentCamera = Workspace.CurrentCamera
    
    local Mouse = LocalPlayer:GetMouse()
    
    local FromRGB = Color3.fromRGB
    local FromHSV = Color3.fromHSV
    local FromHex = Color3.fromHex

    local RGBSequence = ColorSequence.new
    local RGBSequenceKeypoint = ColorSequenceKeypoint.new
    local NumSequence = NumberSequence.new
    local NumSequenceKeypoint = NumberSequenceKeypoint.new

    local UDim2New = UDim2.new
    local UDimNew = UDim.new
    local UDim2FromOffset = UDim2.fromOffset
    local Vector2New = Vector2.new
    local Vector3New = Vector3.new

    local MathClamp = math.clamp
    local MathFloor = math.floor
    local MathAbs = math.abs
    local MathSin = math.sin

    local TableInsert = table.insert
    local TableFind = table.find
    local TableRemove = table.remove
    local TableConcat = table.concat
    local TableClone = table.clone
    local TableUnpack = table.unpack

    local StringFormat = string.format
    local StringFind = string.find
    local StringGSub = string.gsub
    local StringLower = string.lower
    local StringLen = string.len
    
    local instanceNew = Instance.new
    local TouchEnabled = UserInputService.TouchEnabled or false

    Library = {
    Theme = {},
    MenuKeybind = tostring(Enum.KeyCode.RightControl),
    DropdownSearch = false,
    Flags = {},
    Tween = {
        Time = 0.3,
        Style = Enum.EasingStyle.Quad,
        Direction = Enum.EasingDirection.Out
    },
    FadeSpeed = 0.2,
    Themes = nil,
    Folders = {
        Directory = "wings",
        Configs = "wings/Configs",
        Assets = "wings/Assets"
    },
    Pages = {},
    Sections = {},
    Connections = {},
    Threads = {},
    ThemeMap = {},
    ThemeItems = {},
    OpenFrames = {},
    SetFlags = {},
    UnnamedConnections = 0,
    UnnamedFlags = 0,
    Holder = nil,
    NotifHolder = nil,
    UnusedHolder = nil,
    IsASubWindowOpenLul = false,
    Font = nil,
    BoldFont = nil
}

Library.__index = Library
Library.Sections.__index = Library.Sections
Library.Pages.__index = Library.Pages

local Keys = {
    ["Unknown"] = "Unknown",
    ["Backspace"] = "Back",
    ["Tab"] = "Tab",
    ["Clear"] = "Clear",
    ["Return"] = "Return",
    ["Pause"] = "Pause",
    ["Escape"] = "Escape",
    ["Space"] = "Space",
    ["QuotedDouble"] = "\"",
    ["Hash"] = "#",
    ["Dollar"] = "$",
    ["Percent"] = "%",
    ["Ampersand"] = "&",
    ["Quote"] = "'",
    ["LeftParenthesis"] = "(",
    ["RightParenthesis"] = " )",
    ["Asterisk"] = "*",
    ["Plus"] = "+",
    ["Comma"] = ",",
    ["Minus"] = "-",
    ["Period"] = ".",
    ["Slash"] = "`",
    ["Three"] = "3",
    ["Seven"] = "7",
    ["Eight"] = "8",
    ["Colon"] = ":",
    ["Semicolon"] = ";",
    ["LessThan"] = "<",
    ["GreaterThan"] = ">",
    ["Question"] = "?",
    ["Equals"] = "=",
    ["At"] = "@",
    ["LeftBracket"] = "LeftBracket",
    ["RightBracket"] = "RightBracked",
    ["BackSlash"] = "BackSlash",
    ["Caret"] = "^",
    ["Underscore"] = "_",
    ["Backquote"] = "`",
    ["LeftCurly"] = "{",
    ["Pipe"] = "|",
    ["RightCurly"] = "}",
    ["Tilde"] = "~",
    ["Delete"] = "Delete",
    ["End"] = "End",
    ["KeypadZero"] = "Keypad0",
    ["KeypadOne"] = "Keypad1",
    ["KeypadTwo"] = "Keypad2",
    ["KeypadThree"] = "Keypad3",
    ["KeypadFour"]= "Keypad4",
    ["KeypadFive"] = "Keypad5",
    ["KeypadSix"] = "Keypad6",
    ["KeypadSeven"] = "Keypad7",
    ["KeypadEight"] = "Keypad8",
    ["KeypadNine"] = "Keypad9",
    ["KeypadPeriod"] = "KeypadP",
    ["KeypadDivide"] = "KeypadD",
    ["KeypadMultiply"] = "KeypadM",
    ["KeypadMinus"] = "KeypadM",
    ["KeypadPlus"] = "KeypadP",
    ["KeypadEnter"] = "KeypadE",
    ["KeypadEquals"] = "KeypadE",
    ["Insert"] = "Insert",
    ["Home"] = "Home",
    ["PageUp"] = "PageUp",
    ["PageDown"] = "PageDown",
    ["RightShift"] = "RightShift",
    ["LeftShift"] = "LeftShift",
    ["RightControl"] = "RightControl",
    ["LeftControl"] = "LeftControl",
    ["LeftAlt"] = "LeftAlt",
    ["RightAlt"] = "RightAlt"
}
local themes = {
    ["Preset"] = {
        ["Outline"] = FromRGB(20, 22, 24),
        ["Outline 2"] = FromRGB(29, 29, 33),
        ["Background"] = FromRGB(15, 16, 21),
        ["Logo Background"] = FromRGB(7, 17, 31),
        ["Background 2"] = FromRGB(12, 13, 17),
        ["Section Background"] = FromRGB(21, 20, 29),
        ["Page Background"] = FromRGB(42, 44, 51),
        ["Toggle"] = FromRGB(5, 9, 14),
        ["Element"] = FromRGB(28, 27, 38),
        ["Text"] = FromRGB(200, 200, 207),
        ["Text 2"] = FromRGB(151, 150, 162),
        ["Liner"] = FromRGB(27, 26, 35),
        ["Hover Element"] = FromRGB(41, 41, 48),
        ["Accent"] = FromRGB(81, 124, 253)
    }
}

Library.Theme = TableClone(themes.Preset)
Library.Themes = themes

for _, v in Library.Folders, nil, nil do
    if not isfolder(v) then
        makefolder(v)
    end
end

local Tween = {}

Tween.__index = Tween
Tween.Create = function(self, Item, Info, Goal, IsRawItem)
    if not Library then
        return {
            Tween = {
                Play = function() end,
                Pause = function() end,
                Completed = {
                    Connect = function()
                        return {
                            Disconnect = function() end
                        }
                    end
                }
            }
        }
    end

    local Instance_ = (IsRawItem or typeof(Item) == "Instance") and Item or type(Item) == "table" and Item.Instance or Item
    local tweenInfo = Info or TweenInfo.new(Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction)
    local NewTween = {
        Tween = TweenService:Create(Instance_, tweenInfo, Goal),
        Info = tweenInfo,
        Goal = Goal,
        Item = Instance_
    }

    NewTween.Tween:Play()
    setmetatable(NewTween, Tween)

    return NewTween
end

Tween.GetProperty = function(self, Item)
    Item = Item or self.Item 

    if Item:IsA("Frame") then
        return { "BackgroundTransparency" }
    elseif Item:IsA("TextLabel") or Item:IsA("TextButton") then
        return { "TextTransparency", "BackgroundTransparency" }
    elseif Item:IsA("ImageLabel") or Item:IsA("ImageButton") then
        return { "BackgroundTransparency", "ImageTransparency" }
    elseif Item:IsA("ScrollingFrame") then
        return { "BackgroundTransparency", "ScrollBarImageTransparency" }
    elseif Item:IsA("TextBox") then
        return { "TextTransparency", "BackgroundTransparency" }
    elseif Item:IsA("UIStroke") then 
        return { "Transparency" }
    end
end

Tween.FadeItem = function(self, Item, Property, Visibility, Speed)
    local Item = Item or self.Item 

    local OldTransparency = Item[Property]
    Item[Property] = Visibility and 1 or OldTransparency

    local NewTween = Tween:Create(Item, TweenInfo.new(Speed or Library.Tween.Time, Library.Tween.Style, Library.Tween.Direction), {
        [Property] = Visibility and OldTransparency or 1
    }, true)

    Library:Connect(NewTween.Tween.Completed, function()
        if not Visibility then 
            task.wait()
            Item[Property] = OldTransparency
        end
    end)

    return NewTween
end

Tween.Get = function(self)
    if not self.Tween then 
        return
    end

    return self.Tween, self.Info, self.Goal
end

Tween.Pause = function(self)
    if not self.Tween then 
        return
    end

    self.Tween:Pause()
end

Tween.Play = function(self)
    if not self.Tween then 
        return
    end

    self.Tween:Play()
end

Tween.Clean = function(self)
    if not self.Tween then 
        return
    end

    Tween:Pause()
    self = nil
end

local Instances = { } do
    Instances.__index = Instances

    Instances.Create = function(self, Class, Properties)
        local NewItem = {
            Instance = Instance.new(Class),
            Properties = Properties,
            Class = Class
        }

        setmetatable(NewItem, Instances)

        for Property, Value in NewItem.Properties do
            NewItem.Instance[Property] = Value
        end

        return NewItem
    end

    Instances.AddToTheme = function(self, Properties)
        if not self.Instance then 
            return
        end

        Library:AddToTheme(self, Properties)
        return self
    end

    Instances.ChangeItemTheme = function(self, Properties)
        if not self.Instance then 
            return
        end

        Library:ChangeItemTheme(self, Properties)
    end

    Instances.Connect = function(self, Event, Callback, Name)
        if not self.Instance then 
            return
        end

        if not self.Instance[Event] then 
            return
        end

        return Library:Connect(self.Instance[Event], Callback, Name)
    end

    Instances.Tween = function(self, Info, Goal)
        if not self.Instance then 
            return
        end

        return Tween:Create(self, Info, Goal)
    end

    Instances.Disconnect = function(self, Name)
        if not self.Instance then 
            return
        end

        return Library:Disconnect(Name)
    end

    Instances.Clean = function(self)
        if not self.Instance then 
            return
        end

        self.Instance:Destroy()
        self = nil
    end

    Instances.MakeDraggable = function(self)
        if not self.Instance then 
            return
        end
    
        local Gui = self.Instance
        local Dragging = false 
        local DragStart
        local StartPosition 
    
        local Set = function(Input)
            local DragDelta = Input.Position - DragStart
            local NewX = StartPosition.X.Offset + DragDelta.X
            local NewY = StartPosition.Y.Offset + DragDelta.Y

            local ScreenSize = Gui.Parent.AbsoluteSize
            local GuiSize = Gui.AbsoluteSize
    
            NewX = MathClamp(NewX, 0, ScreenSize.X - GuiSize.X)
            NewY = MathClamp(NewY, 0, ScreenSize.Y - GuiSize.Y)
    
            self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2New(0, NewX, 0, NewY)})
        end
    
        local InputChanged
    
        self:Connect("InputBegan", function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = Input.Position
                StartPosition = Gui.Position
    
                if InputChanged then 
                    return
                end
    
                InputChanged = Input.Changed:Connect(function()
                    if Input.UserInputState == Enum.UserInputState.End then
                        Dragging = false
                        InputChanged:Disconnect()
                        InputChanged = nil
                    end
                end)
            end
        end)
    
        Library:Connect(UserInputService.InputChanged, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                if Dragging then
                    Set(Input)
                end
            end
        end)
    
        return Dragging
    end

    Instances.MakeResizeable = function(self, Minimum, Maximum)
        if not self.Instance then 
            return
        end

        local Gui = self.Instance

        local Resizing = false 
        local CurrentSide = nil

        local StartMouse = nil 
        local StartPosition = nil 
        local StartSize = nil

local EdgeThickness = 1

        local MakeEdge = function(Name, Position, Size)
            local Button = Instances:Create("TextButton", {
                Name = "\0",
                Size = Size,
                Position = Position,
                BackgroundColor3 = FromRGB(166, 147, 243),
                BackgroundTransparency = 1,
                Text = "",
                BorderSizePixel = 0,
                AutoButtonColor = false,
                Parent = Gui,
                ZIndex = 99999,
            })  Button:AddToTheme({BackgroundColor3 = "Accent"})

            return Button
        end

                    local Edges = {
                {Button = MakeEdge("Left", UDim2New(0, 0, 0, 0), UDim2New(0, 2, 1, 0)),
                    Side = "L"
                },

                {Button = MakeEdge("Right", UDim2New(1, -2, 0, 0), UDim2New(0, 2, 1, 0)),
                    Side = "R"
                },

                {Button = MakeEdge("Top", UDim2New(0, 0, 0, 0), UDim2New(1, 0, 0, 2)),
                    Side = "T"
                },

                {Button = MakeEdge("Bottom", UDim2New(0, 0, 1, -2), UDim2New(1, 0, 0, 2)),
                    Side = "B"
                },
            }

        local BeginResizing = function(Side)
            Resizing = true 
            CurrentSide = Side 

            StartMouse = UserInputService:GetMouseLocation()

            StartPosition = Vector2New(Gui.Position.X.Offset, Gui.Position.Y.Offset)
            StartSize = Vector2New(Gui.Size.X.Offset, Gui.Size.Y.Offset)
            
            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = (Value.Side == Side) and 0 or 1
            end
        end

        local EndResizing = function()
            Resizing = false 
            CurrentSide = nil

            for Index, Value in Edges do 
                Value.Button.Instance.BackgroundTransparency = 1
            end
        end

        for Index, Value in Edges do 
            Value.Button:Connect("InputBegan", function(Input)
                if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                    BeginResizing(Value.Side)
                end
            end)
        end

        Library:Connect(UserInputService.InputEnded, function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
                if Resizing then
                    EndResizing()
                end
            end
        end)

        Library:Connect(RunService.RenderStepped, function()
            if not Resizing or not CurrentSide then 
                return 
            end

            local MouseLocation = UserInputService:GetMouseLocation()
            local dx = MouseLocation.X - StartMouse.X
            local dy = MouseLocation.Y - StartMouse.Y
        
            local x, y = StartPosition.X, StartPosition.Y
            local w, h = StartSize.X, StartSize.Y

            if CurrentSide == "L" then
                x = StartPosition.X + dx
                w = StartSize.X - dx
            elseif CurrentSide == "R" then
                w = StartSize.X + dx
            elseif CurrentSide == "T" then
                y = StartPosition.Y + dy
                h = StartSize.Y - dy
            elseif CurrentSide == "B" then
                h = StartSize.Y + dy
            end
        
            if w < Minimum.X then
                if CurrentSide == "L" then
                    x = x - (Minimum.X - w)
                end
                w = Minimum.X
            end
            if h < Minimum.Y then
                if CurrentSide == "T" then
                    y = y - (Minimum.Y - h)
                end
                h = Minimum.Y
            end
        
            self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Position = UDim2FromOffset(x, y)})
            self:Tween(TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {Size = UDim2FromOffset(w, h)})
        end)
    end

    Instances.OnHover = function(self, Function)
        if not self.Instance then 
            return
        end
        
        return Library:Connect(self.Instance.MouseEnter, Function)
    end

    Instances.OnHoverLeave = function(self, Function)
        if not self.Instance then 
            return
        end
        
        return Library:Connect(self.Instance.MouseLeave, Function)
    end
end

local ConfigFolder = Library.Folders.Configs

Library.GetFolder = function()
    return ConfigFolder
end

local CustomFont = { } do
    function CustomFont:New(Name, Weight, Style, Data)
        if not isfile(Data.Id) then 
            writefile(Data.Id, game:HttpGet(Data.Url))
        end

        local Data = {
            name = Name,
            faces = {
                {
                    name = Name,
                    weight = Weight,
                    style = Style,
                    assetId = getcustomasset(Data.Id)
                }
            }
        }

        writefile(`{Library.Folders.Assets}/{Name}.font`, HttpService:JSONEncode(Data))
        return Font.new(getcustomasset(`{Library.Folders.Assets}/{Name}.font`))
    end

    Library.Font = CustomFont:New("PromptRegular", 400, "Regular", {
        Id = "PromptRegular",
        Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/Prompt-Regular.ttf"
    })
    
    Library.BoldFont = CustomFont:New("PromptMedium", 400, "Regular", {
        Id = "PromptMedium",
        Url = "https://github.com/sametexe001/luas/raw/refs/heads/main/fonts/Prompt-Medium.ttf"
    })
end
Library.Holder = Instances:Create("ScreenGui", {
    Parent = gethui(),
    Name = "wings_UI_Holder",
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 2,
    ResetOnSpawn = false
})
Instances:Create("UIScale", {
    Parent = Library.Holder.Instance,
    Name = "UIScale",
    Scale = TouchEnabled and 0.65 or 1
})
Library.OtherHolder = Instances:Create("ScreenGui", {
    Parent = gethui(),
    Name = "wings_UI_Other",
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    DisplayOrder = 2,
    ResetOnSpawn = false
})
Library.NotifHolder = Instances:Create("Frame", {
    Parent = Library.Holder.Instance,
    Name = "\0",
    BackgroundTransparency = 1,
    Size = UDim2New(0, 0, 1, 0),
    BorderColor3 = FromRGB(0, 0, 0),
    BorderSizePixel = 0,
    AutomaticSize = Enum.AutomaticSize.X
})
Instances:Create("UIListLayout", {
    Parent = Library.NotifHolder.Instance,
    Name = "\0",
    Padding = UDimNew(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
})
Instances:Create("UIPadding", {
    Parent = Library.NotifHolder.Instance,
    Name = "\0",
    PaddingTop = UDimNew(0, 12),
    PaddingBottom = UDimNew(0, 12),
    PaddingRight = UDimNew(0, 12),
    PaddingLeft = UDimNew(0, 12)
})
Library.UnusedHolder = Instances:Create("ScreenGui", {
    Parent = gethui(),
    Name = "wings_UI_Unused",
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
    Enabled = false,
    ResetOnSpawn = false
})
Library.Unload = function(self)
    pcall(function()
        for _, v in self.Connections, nil, nil do
            if v.Connection then
                v.Connection:Disconnect()
            end
        end
    end)
    pcall(function()
        for _, v in self.Threads, nil, nil do
            coroutine.close(v)
        end
    end)
    pcall(function()
        if self.Holder then
            self.Holder:Clean()
        end
    end)
    pcall(function()
        if self.OtherHolder then
            self.OtherHolder:Clean()
        end
    end)
    pcall(function()
        if self.UnusedHolder then
            self.UnusedHolder:Clean()
        end
    end)
    Library = nil
    getgenv().Library = nil
end
Library.GetFolder = function()
    return ConfigFolder
end
Library.Round = function(self, Number, Float)
    local Multiplier = 1 / (Float or 1)

    return MathFloor(Number * Multiplier) / Multiplier
end
Library.Thread = function(self, Function)
    local thread = coroutine.create(Function)

    coroutine.wrap(function()
        coroutine.resume(thread)
    end)()
    TableInsert(self.Threads, thread)

    return thread
end
Library.SafeCall = function(self, Function, ...)
        local Success, Result = pcall(Function, TableUnpack({ ... }))

        if not Success then
            warn(Result)
            return false
        end

        return Success
    end
Library.Connect = function(self, Event, Callback, Name)
    local NewConnection = {
        Event = Event,
        Callback = Callback,
        Name = Name or StringFormat("connection_number_%s_%s", self.UnnamedConnections + 1, HttpService:GenerateGUID(false)),
        Connection = nil,
        Connection = Event:Connect(Callback)
    }

    NewConnection.Disconnect = function()
        if NewConnection.Connection then
            NewConnection.Connection:Disconnect()
            NewConnection.Connection = nil
        end
    end
    TableInsert(self.Connections, NewConnection)

    return NewConnection
end
Library.Disconnect = function(self, Name)
    for _, v in self.Connections, nil, nil do
        if v.Name == Name then
            v.Connection:Disconnect()

            break
        end
    end
end
Library.NextFlag = function(self)
    return StringFormat("flag_number_%s_%s", self.UnnamedFlags + 1, HttpService:GenerateGUID(false))
end
Library.AddToTheme = function(self, Item, Properties)
    local Instance_ = type(Item) == "table" and Item.Instance or Item
    local ThemeData = {
        Item = Instance_,
        Properties = Properties
    }

    for k, v in ThemeData.Properties, nil, nil do
        if type(v) == "string" then
            if not self.Theme[v] then
                Instance_[k] = v
            end

            Instance_[k] = self.Theme[v]
        else
            Instance_[k] = v()
        end
    end

    TableInsert(self.ThemeItems, ThemeData)
    self.ThemeMap[Instance_] = ThemeData
end
Library.ToRich = function(self, Text, Color)
		return `<font color="rgb({MathFloor(Color.R * 255)}, {MathFloor(Color.G * 255)}, {MathFloor(Color.B * 255)})">{Text}</font>`
	end
Library.GetConfig = function()
    local Config = {}
    local _ = Library:SafeCall(function()
        for k, v in Library.Flags, nil, nil do
            if type(v) == "table" then
                if v.Key then
                    Config[k] = {
                        Key = tostring(v.Key),
                        Mode = v.Mode
                    }

                    continue
                end
            end

            if type(v) == "table" and v.Color then
                Config[k] = {
                    Color = "#" .. v.HexValue,
                    Alpha = v.Alpha
                }
            else
                Config[k] = v
            end
        end
    end)

    return HttpService:JSONEncode(Config)
end
Library.GetConfig = function()
    local Config = {}
    local _ = Library:SafeCall(function()
        for k, v in Library.Flags, nil, nil do
            if type(v) == "table" and v.Key then
                Config[k] = {
                    Key = tostring(v.Key),
                    Mode = v.Mode
                }
            elseif type(v) == "table" and v.Color then
                Config[k] = {
                    Color = "#" .. v.HexValue,
                    Alpha = v.Alpha
                }
            else
                Config[k] = v
            end
        end
    end)

    return HttpService:JSONEncode(Config)
end
Library.LoadConfig = function(self, Config)
    local data = HttpService:JSONDecode(Config)
    local Success, Result = Library:SafeCall(function()
        for k, v in data, nil, nil do
            local SetFunction = Library.SetFlags[k]

            if SetFunction then
                if type(v) == "table" then
                    if v.Key then
                        SetFunction(v)

                        continue
                    end
                end

                if type(v) == "table" and v.Color then
                    SetFunction(v.Color, v.Alpha)
                else
                    SetFunction(v)
                end
            end
        end
    end)

    return Success, Result
end
Library.DeleteConfig = function(self, Config)
    if isfile(Library.Folders.Configs .. "/" .. Config) then
        delfile(Library.Folders.Configs .. "/" .. Config)
    end
end
Library.RefreshConfigsList = function()
    local CurrentList = {}
    local Files = listfiles(Library:GetFolder())

    for i = 1, #Files do
        local FilePath = Files[i]

        if FilePath:sub(-5) == ".json" then
            local pos = FilePath:find(".json", 1, true)
            local SeparatorPosition = pos
            local Character = FilePath:sub(pos, pos)

            while Character ~= "/" and Character ~= "\\" and Character ~= "" do
                pos -= 1
                Character = FilePath:sub(pos, pos)
            end

            if Character == "/" or Character == "\\" then
                TableInsert(CurrentList, FilePath:sub(pos + 1, SeparatorPosition - 1))
            end
        end
    end

    return CurrentList
end
Library.ChangeItemTheme = function(self, Item, Properties)
    local Instance_ = type(Item) == "table" and Item.Instance
    local Item = Instance_ or Item

    if not self.ThemeMap[Item] then
        return
    end

    self.ThemeMap[Item].Properties = Properties
    self.ThemeMap[Item] = self.ThemeMap[Item]
end
Library.ChangeTheme = function(self, Theme, Color)
    self.Theme[Theme] = Color

    for _, v in self.ThemeItems, nil, nil do
        for k, Property in v.Properties, nil, nil do
            if type(Property) == "string" and Property == Theme then
                v.Item[k] = Color
            elseif type(Property) == "function" then
                v.Item[k] = Property()
            end
        end
    end
end
    Library.IsMouseOverFrame = function(self, Frame)
        Frame = Frame.Instance

        local MousePosition = Vector2New(Mouse.X, Mouse.Y)

        return MousePosition.X >= Frame.AbsolutePosition.X and MousePosition.X <= Frame.AbsolutePosition.X + Frame.AbsoluteSize.X 
        and MousePosition.Y >= Frame.AbsolutePosition.Y and MousePosition.Y <= Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y
    end

    Library.Lerp = function(self, Start, Finish, Time)
        return Start + (Finish - Start) * Time
    end

    Library.CompareVectors = function(self, PointA, PointB)
        return (PointA.X < PointB.X) or (PointA.Y < PointB.Y)
    end

    Library.IsClipped = function(self, Object, Column)
        local Parent = Column
        
        local BoundryTop = Parent.AbsolutePosition
        local BoundryBottom = BoundryTop + Parent.AbsoluteSize

        local Top = Object.AbsolutePosition
        local Bottom = Top + Object.AbsoluteSize 

        return Library:CompareVectors(Top, BoundryTop) or Library:CompareVectors(BoundryBottom, Bottom)
    end
Library.MakeBlurred = function(self, Item, Window)
    Item = Item.Instance
    local BlurItem = Item

    local Part = Instances:Create("Part", {
        Material = Enum.Material.Glass,
        Transparency = 1,
        Reflectance = 1,
        CastShadow = false,
        Anchored = true,
        CanCollide = false,
        CanQuery = false,
        CollisionGroup = " ",
        Size = Vector3New(1, 1, 1) * 0.01,
        Color = FromRGB(0,0,0),
        Parent = Camera
    })
        
    local BlockMesh = Instances:Create("BlockMesh", {Parent = Part.Instance})

    local DepthOfField = Instances:Create("DepthOfFieldEffect", {
        Parent = Lighting,
        Enabled = true,
        FarIntensity = 0,
        FocusDistance = 0,
        InFocusRadius = 1000,
        NearIntensity = 1,
        Name = ""
    })

Library.GetCalculatedRayPosition = function(self, Origin, Normal, RayOrigin, RayDirection)
    local Difference = RayOrigin - Origin
    return RayOrigin + -(Normal.x * Difference.x + Normal.y * Difference.y + Normal.z * Difference.z) / (Normal.x * RayDirection.x + Normal.y * RayDirection.y + Normal.z * RayDirection.z) * RayDirection
end

    Library:Connect(RunService.RenderStepped, function()
        if Window.IsOpen then
            if Item.Visible then
                DepthOfField:Tween(nil, {NearIntensity = 1})

                Part:Tween(nil, {Transparency = 0.97})
                Part:Tween(nil, {Size = Vector3New(1, 1, 1) * 0.01})

                local Corner0 = BlurItem.AbsolutePosition;
                local Corner1 = Corner0 + BlurItem.AbsoluteSize;
                    
                local Ray0 = CurrentCamera:ScreenPointToRay(Corner0.X, Corner0.Y, 1);
                local Ray1 = CurrentCamera:ScreenPointToRay(Corner1.X, Corner1.Y, 1);

                local Origin = CurrentCamera.CFrame.Position + CurrentCamera.CFrame.LookVector * (0.05 - CurrentCamera.NearPlaneZ);

local Normal = CurrentCamera.CFrame.LookVector;

local Position0 = Library:GetCalculatedRayPosition(Origin, Normal, Ray0.Origin, Ray0.Direction)
local Position1 = Library:GetCalculatedRayPosition(Origin, Normal, Ray1.Origin, Ray1.Direction)

Position0 = CurrentCamera.CFrame:PointToObjectSpace(Position0)
Position1 = CurrentCamera.CFrame:PointToObjectSpace(Position1)

local Size = Position1 - Position0
local Center = (Position0 + Position1) / 2

BlockMesh.Instance.Offset = Center
BlockMesh.Instance.Scale  = Size / 0.0101

Part.Instance.CFrame = CurrentCamera.CFrame
            else
                DepthOfField:Tween(nil, {NearIntensity = 0})

                BlockMesh.Instance.Offset = Vector3New(0, 0, 0)
                BlockMesh.Instance.Scale  = Vector3New(0, 0, 0)
            end
        else
            DepthOfField:Tween(nil, {NearIntensity = 0})

            BlockMesh.Instance.Offset = Vector3New(0, 0, 0)
            BlockMesh.Instance.Scale  = Vector3New(0, 0, 0)
        end
    end)
end

Library.EscapePattern = function(self, String)
    local ShouldEscape = false 

    if string.match(String, "[%(%)%.%%%+%-%*%?%[%]%^%$]") then
        ShouldEscape = true
    end

    if ShouldEscape then
        return StringGSub(String, "[%(%)%.%%%+%-%*%?%[%]%^%$]", "%%%1")
    end

    return String
end

Library.CreateColorpicker = function(self, Data)
    local isASubWindowOpenLul = {
        Hue = 0,
        Value = 0,
        Saturation = 0,
        Alpha = 0,
        Color = Color3.fromRGB(0, 0, 0),
        HexValue = "#000000",
        Flag = Data.Flag,
        IsOpen = false,
        SelectedFormat = "HEX",
        Items = {},
        IsSettings = true
    }
    local InstancesClass = Instances
    local Create = Instances.Create
    local s3 = "TextButton"
    local ColorpickerButtonProperties = {
        Parent = type(Data.Parent) == "table" and Data.Parent.Instance or Data.Parent,
        Name = "\0",
        ZIndex = 3,
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = ""
    }

    ColorpickerButtonProperties.AutoButtonColor = false
    ColorpickerButtonProperties.Size = UDim2New(0, 18, 0, 18)
    ColorpickerButtonProperties.BorderSizePixel = 0
    ColorpickerButtonProperties.TextSize = 14
    ColorpickerButtonProperties.BackgroundColor3 = FromRGB(255, 151, 153)

    local Items = { } do
        Items["ColorpickerButton"] = Create(InstancesClass, s3, ColorpickerButtonProperties)
    end

    Instances:Create("UICorner", {
        Parent = Items["ColorpickerButton"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })

    local colorSequenceKeypointNew = ColorSequenceKeypoint.new

    Instances:Create("UIGradient", {
        Parent = Items["ColorpickerButton"].Instance,
        Name = "\0",
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, FromRGB(170, 170, 170)),
            colorSequenceKeypointNew(1, FromRGB(144, 144, 144))
        })
    })
    Items["ColorpickerWindow"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        Position = UDim2New(0, 654, 0, 152),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 259, 0, 400),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Outline
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 10)
    })
    Items["Hex"] = Instances:Create("Frame", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 1),
        Position = UDim2New(1, -90, 1, -80),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 100, 0, 25),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["Hex"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["HexColor"] = Instances:Create("Frame", {
        Parent = Items["Hex"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 0.5),
        Position = UDim2New(0, 4, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 14, 0, 14),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UICorner", {
        Parent = Items["HexColor"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["HexInput"] = Instances:Create("TextBox", {
        Parent = Items["Hex"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "<font color=\"rgb(185, 185, 185)\">#</font>ff9799",
        Size = UDim2New(1, -30, 0, 15),
        Position = UDim2New(0, 25, 0.5, 0),
        AnchorPoint = Vector2New(0, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        PlaceholderColor3 = FromRGB(125, 125, 125),
        TextXAlignment = Enum.TextXAlignment.Left,
        RichText = true,
        TextSize = 16
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["AlphaBackground"] = Instances:Create("Frame", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 1),
        Position = UDim2New(1, -40, 1, -80),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 45, 0, 25),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["AlphaBackground"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["AlphaValue"] = Instances:Create("TextLabel", {
        Parent = Items["AlphaBackground"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        RichText = true,
        Text = "100%",
        Size = UDim2New(0, 0, 0, 15),
        Selectable = true,
        AnchorPoint = Vector2New(0.5, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0.5, 0, 0.5, 0),
        Active = true,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["Alpha"] = Instances:Create("TextButton", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(0, 1),
        Position = UDim2New(0, 12, 1, -115),
        Size = UDim2New(1, -24, 0, 10),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UICorner", {
        Parent = Items["Alpha"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["Checkers"] = Instances:Create("ImageLabel", {
        Parent = Items["Alpha"].Instance,
        Name = "\0",
        ScaleType = Enum.ScaleType.Tile,
        BorderColor3 = FromRGB(0, 0, 0),
        TileSize = UDim2New(0, 6, 0, 6),
        Image = "http://www.roblox.com/asset/?id=18274452449",
        BackgroundTransparency = 1,
        Size = UDim2New(1, 0, 1, 0),
        ZIndex = 2,
        BorderSizePixel = 0
    })
    Instances:Create("UIGradient", {
        Parent = Items["Checkers"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.37, 0.5),
            NumberSequenceKeypoint.new(1, 0)
        })
    })
    Instances:Create("UICorner", {
        Parent = Items["Checkers"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["AlphaDragger"] = Instances:Create("Frame", {
        Parent = Items["Alpha"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 0.5),
        Position = UDim2New(0, 0, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 8, 0, 8),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UIStroke", {
        Parent = Items["AlphaDragger"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Library.Theme.Text,
        Thickness = 3.2000000476837158
    }):AddToTheme({
        Color = "Text"
    })
    Instances:Create("UICorner", {
        Parent = Items["AlphaDragger"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Hue"] = Instances:Create("TextButton", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(0, 1),
        Position = UDim2New(0, 12, 1, -140),
        Size = UDim2New(1, -24, 0, 10),
        BorderSizePixel = 0,
        TextSize = 14
    })
    Instances:Create("UICorner", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Items["HueInline"] = Instances:Create("TextButton", {
        Parent = Items["Hue"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        Size = UDim2New(1, 0, 1, 0),
        BorderSizePixel = 0,
        TextSize = 14
    })
    Instances:Create("UICorner", {
        Parent = Items["HueInline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })

    local colorSequenceKeypointNew2 = ColorSequenceKeypoint.new

    Instances:Create("UIGradient", {
        Parent = Items["HueInline"].Instance,
        Name = "\0",
        Rotation = 0,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, FromRGB(255, 0, 0)),
            ColorSequenceKeypoint.new(0.17, FromRGB(255, 255, 0)),
            ColorSequenceKeypoint.new(0.33, FromRGB(0, 255, 0)),
            ColorSequenceKeypoint.new(0.5, FromRGB(0, 255, 255)),
            ColorSequenceKeypoint.new(0.67, FromRGB(0, 0, 255)),
            ColorSequenceKeypoint.new(0.83, FromRGB(255, 0, 255)),
            colorSequenceKeypointNew2(1, FromRGB(255, 0, 0))
        })
    })
    Items["HueDragger"] = Instances:Create("Frame", {
        Parent = Items["HueInline"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 0.5),
        Position = UDim2New(0, 6, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 4, 1, 5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UICorner", {
        Parent = Items["HueDragger"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Instances:Create("UIStroke", {
        Parent = Items["HueDragger"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Library.Theme.Text,
        Thickness = 3.2000000476837158
    }):AddToTheme({
        Color = "Text"
    })
    Items["Palette"] = Instances:Create("TextButton", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        Position = UDim2New(0, 12, 0, 12),
        Size = UDim2New(1, -24, 1, -175),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UICorner", {
        Parent = Items["Palette"].Instance,
        Name = "\0"
    })
    Items["Saturation"] = Instances:Create("Frame", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 1, 1, 0),
        BorderSizePixel = 0
    })
    Instances:Create("UIGradient", {
        Parent = Items["Saturation"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
    })
    Instances:Create("UICorner", {
        Parent = Items["Saturation"].Instance,
        Name = "\0"
    })
    Items["Value"] = Instances:Create("Frame", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 1, 1, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(0, 0, 0)
    })
    Instances:Create("UIGradient", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        Rotation = 90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(1, 0)
        })
    })
    Instances:Create("UICorner", {
        Parent = Items["Value"].Instance,
        Name = "\0"
    })
    Items["PaletteDragger"] = Instances:Create("Frame", {
        Parent = Items["Palette"].Instance,
        Name = "\0",
        Size = UDim2New(0, 8, 0, 8),
        Position = UDim2New(0, 12, 0, 12),
        BorderColor3 = FromRGB(0, 0, 0),
        ZIndex = 3,
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(255, 151, 153)
    })
    Instances:Create("UICorner", {
        Parent = Items["PaletteDragger"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Instances:Create("UIStroke", {
        Parent = Items["PaletteDragger"].Instance,
        Name = "\0",
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Color = Library.Theme.Text,
        Thickness = 3.2000000476837158
    }):AddToTheme({
        Color = "Text"
    })
    Items["OpenSettings"] = Instances:Create("ImageButton", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme["Text 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 18, 0, 18),
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 1),
        Image = "rbxassetid://71009909482717",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -12, 1, -83),
        Rotation = 1,
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["ColorFormatDorpdown"] = Instances:Create("TextButton", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 12, 1, -82),
        Size = UDim2New(0, 60, 0, 20),
        BorderSizePixel = 0,
        TextSize = 14
    })
    Items["ArrowIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["ColorFormatDorpdown"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme["Text 2"],
        ScaleType = Enum.ScaleType.Fit,
        BorderColor3 = FromRGB(0, 0, 0),
        Image = "rbxassetid://111436698580046",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, -2),
        Size = UDim2New(0, 9, 0, 5),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["Value"] = Instances:Create("TextLabel", {
        Parent = Items["ColorFormatDorpdown"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "HEX",
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 20, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["Content"] = Instances:Create("Frame", {
        Parent = Items["ColorpickerWindow"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 1, 0),
        Size = UDim2New(1, 0, 0, 80),
        BorderSizePixel = 0
    })
    Items["Holder"] = Instances:Create("ScrollingFrame", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0),
        ScrollBarImageColor3 = Library.Theme["Text 2"],
        MidImage = "rbxassetid://81680855285439",
        BorderColor3 = FromRGB(0, 0, 0),
        ScrollBarThickness = 1,
        BackgroundTransparency = 1,
        Size = UDim2New(1, 0, 1, 0),
        BottomImage = "rbxassetid://81680855285439",
        TopImage = "rbxassetid://81680855285439"
    }):AddToTheme({
        ScrollBarImageColor3 = "Text 2"
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["Content"] = Items["Holder"]
    Items["OptionHolder"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        BackgroundTransparency = 0,
        Position = UDim2New(0, 20, 0, 91),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 122, 0, 80),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Background
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 12)
    })
    Instances:Create("UIStroke", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["OptionHolderHolder"] = Instances:Create("ScrollingFrame", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0),
        MidImage = "rbxassetid://81680855285439",
        BorderColor3 = FromRGB(0, 0, 0),
        ScrollBarThickness = 2,
        Size = UDim2New(1, -16, 1, -16),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 8, 0, 8),
        BottomImage = "rbxassetid://81680855285439",
        TopImage = "rbxassetid://81680855285439"
    }):AddToTheme({
        ScrollBarImageColor3 = "Text 2"
    })
    Instances:Create("UIListLayout", {
        Parent = Items["OptionHolderHolder"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Instances:Create("UIPadding", {
        Parent = Items["OptionHolderHolder"].Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 5),
        PaddingBottom = UDimNew(0, 10),
        PaddingRight = UDimNew(0, 8),
        PaddingLeft = UDimNew(0, 0)
    })
    Instances:Create("UIPadding", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 10),
        PaddingBottom = UDimNew(0, 10),
        PaddingRight = UDimNew(0, 10),
        PaddingLeft = UDimNew(0, 10)
    })
    isASubWindowOpenLul.Items = Items

    local ColorFormatDropdown = {
        Multi = false,
        Value = "",
        MaxSize = 80,
        Data = {},
        IsOpen = false,
        Flag = isASubWindowOpenLul.Flag .. "_Dropdown",
        Callback = function(Value)
            isASubWindowOpenLul.SelectedFormat = Value
            isASubWindowOpenLul:Update()
        end
    }
    local Debounce = false
    local RenderStepped

    ColorFormatDropdown.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        ColorFormatDropdown.IsOpen = IsOpen
        Debounce = true

        if ColorFormatDropdown.IsOpen then
            Items["OptionHolder"].Instance.Visible = true
            Items["OptionHolder"].Instance.Parent = Library.OtherHolder.Instance
            Items["OptionHolder"].Instance.Size = UDim2New(0, 120, 0, 0)
            Items["OptionHolder"].Instance.Position = UDim2New(0, Items["ColorFormatDorpdown"].Instance.AbsolutePosition.X, 0, Items["ColorFormatDorpdown"].Instance.AbsolutePosition.Y - 25)
            Items["OptionHolder"]:Tween(nil, {
                Size = UDim2New(0, 120, 0, ColorFormatDropdown.MaxSize)
            })

            if not Data.Section.IsSettings then
                for _, v in Library.OpenFrames, nil, nil do
                    if v ~= ColorFormatDropdown and v ~= isASubWindowOpenLul then
                        v:SetOpen(false)
                    end
                end

                Library.OpenFrames[ColorFormatDropdown] = ColorFormatDropdown
            end
        else
            if not Data.Section.IsSettings and Library.OpenFrames[ColorFormatDropdown] then
                Library.OpenFrames[ColorFormatDropdown] = nil
            end

            if connection then
                connection:Disconnect()
                connection = nil
            end

            if Library.IsASubWindowOpenLul == ColorFormatDropdown then
                Library.IsASubWindowOpenLul = nil
            end

            Items["OptionHolder"]:Tween(nil, {
                Size = UDim2New(0, 120, 0, 0)
            })
        end

        local descendants = Items["OptionHolder"].Instance:GetDescendants()

        TableInsert(descendants, Items["OptionHolder"].Instance)

        local FadeTween

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if not v.ClassName:find("UI") then
                    v.ZIndex = ColorFormatDropdown.IsOpen and 3 or 1
                end

                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        FadeTween = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    FadeTween = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        FadeTween.Tween.Completed:Connect(function()
            Debounce = false
            Items["OptionHolder"].Instance.Visible = ColorFormatDropdown.IsOpen
            task.wait(0.2)
            Items["OptionHolder"].Instance.Parent = not ColorFormatDropdown.IsOpen and Library.UnusedHolder.Instance or Library.OtherHolder.Instance
            task.wait(0.1)

            if ColorFormatDropdown.IsOpen then
                connection = Library:Connect(RunService.RenderStepped, function()
                    Items["OptionHolder"].Instance.Position = UDim2New(0, Items["ColorFormatDorpdown"].Instance.AbsolutePosition.X, 0, Items["ColorFormatDorpdown"].Instance.AbsolutePosition.Y - 25)
                    Items["OptionHolder"].Instance.Size = UDim2New(0, 120, 0, ColorFormatDropdown.MaxSize)
                end)
            else
                if connection then
                    connection:Disconnect()
                    connection = nil
                end

                Items["OptionHolder"]:Tween(nil, {
                    Size = UDim2New(0, 120, 0, 0)
                })
            end
        end)
    end
    ColorFormatDropdown.Add = function(self, Option)
        local OptionButton = Instances:Create("TextButton", {
            Parent = Items["OptionHolderHolder"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = FromRGB(0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 25),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        local OptionIcon = Instances:Create("ImageLabel", {
            Parent = OptionButton.Instance,
            Name = "\0",
            ImageTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(0, 0.5),
            Image = "rbxassetid://107907951570295",
            BackgroundTransparency = 1,
            Position = UDim2New(0, 5, 0.5, 0),
            Size = UDim2New(0, 16, 0, 16),
            BorderSizePixel = 0
        }):AddToTheme({
            ImageColor3 = "Text"
        })
        local OptionLabel = Instances:Create("TextLabel", {
            Parent = OptionButton.Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme["Text 2"],
            BorderColor3 = FromRGB(0, 0, 0),
            Text = Option,
            AnchorPoint = Vector2New(0, 0.5),
            Size = UDim2New(0, 0, 0, 15),
            BackgroundTransparency = 1,
            Position = UDim2New(0, 28, 0.5, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 18
        }):AddToTheme({
            TextColor3 = "Text 2"
        })

        Instances:Create("UICorner", {
            Parent = OptionButton.Instance,
            Name = "\0"
        })
        OptionButton:OnHover(function()
            OptionButton:Tween(nil, {
                BackgroundTransparency = 0
            })
        end)
        OptionButton:OnHoverLeave(function()
            OptionButton:Tween(nil, {
                BackgroundTransparency = 1
            })
        end)

        local SelectedOption

        SelectedOption = {
            Button = OptionButton,
            Name = Option,
            Check = OptionIcon,
            Text = OptionLabel,
            Selected = false,
            Toggle = function(self, Value)
                if Value == "Active" then
                    SelectedOption.Check:Tween(nil, {
                        ImageTransparency = 0
                    })
                    SelectedOption.Text:ChangeItemTheme({
                        TextColor3 = "Text"
                    })
                    SelectedOption.Text:Tween(nil, {
                        TextColor3 = Library.Theme.Text
                    })
                else
                    SelectedOption.Check:Tween(nil, {
                        ImageTransparency = 1
                    })
                    SelectedOption.Text:ChangeItemTheme({
                        TextColor3 = "Text 2"
                    })
                    SelectedOption.Text:Tween(nil, {
                        TextColor3 = Library.Theme["Text 2"]
                    })
                end
            end,
            Set = function()
                SelectedOption.Selected = not SelectedOption.Selected

                if ColorFormatDropdown.Multi then
                    local OptionIndex = TableFind(ColorFormatDropdown.Value, SelectedOption.Name)

                    if OptionIndex then
                        TableRemove(ColorFormatDropdown.Value, OptionIndex)
                    else
                        TableInsert(ColorFormatDropdown.Value, SelectedOption.Name)
                    end

                    SelectedOption:Toggle(OptionIndex and "Inactive" or "Active")
                    Library.Flags[ColorFormatDropdown.Flag] = ColorFormatDropdown.Value
                    Items["Value"].Instance.Text = #ColorFormatDropdown.Value > 0 and TableConcat(ColorFormatDropdown.Value, ", ") or "..."
                elseif SelectedOption.Selected then
                    ColorFormatDropdown.Value = SelectedOption.Name
                    Library.Flags[ColorFormatDropdown.Flag] = SelectedOption.Name
                    SelectedOption.Selected = true
                    SelectedOption:Toggle("Active")

                    for _, v in ColorFormatDropdown.Data, nil, nil do
                        if v ~= SelectedOption then
                            v.Selected = false
                            v:Toggle("Inactive")
                        end
                    end

                    Items["Value"].Instance.Text = SelectedOption.Name
                else
                    ColorFormatDropdown.Value = nil
                    Library.Flags[ColorFormatDropdown.Flag] = nil
                    SelectedOption.Selected = false
                    SelectedOption:Toggle("Inactive")
                    Items["Value"].Instance.Text = "..."
                end

                if ColorFormatDropdown.Callback then
                    Library:SafeCall(ColorFormatDropdown.Callback, ColorFormatDropdown.Value)
                end
            end
        }
        SelectedOption.Button:Connect("MouseButton1Down", function()
            SelectedOption:Set()
        end)
        ColorFormatDropdown.Data[SelectedOption.Name] = SelectedOption

        return SelectedOption
    end
    ColorFormatDropdown.Remove = function(self, Option)
        if ColorFormatDropdown.Data[Option] then
            ColorFormatDropdown.Data[Option].Button:Clean()
            ColorFormatDropdown.Data[Option] = nil
        end
    end
    ColorFormatDropdown.Refresh = function(self, Data)
        for _, v in ColorFormatDropdown.Data, nil, nil do
            ColorFormatDropdown:Remove(v.Name)
        end

        for _, v in Data, nil, nil do
            ColorFormatDropdown:Add(v)
        end
    end
    Items["ColorFormatDorpdown"]:Connect("MouseButton1Down", function()
        ColorFormatDropdown:SetOpen(not ColorFormatDropdown.IsOpen)
    end)
    Library:Connect(UserInputService.InputBegan, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and ColorFormatDropdown.IsOpen then
            if Library:IsMouseOverFrame(Items["OptionHolder"]) then
                return
            end

            ColorFormatDropdown:SetOpen(false)
        end
    end)

    local Debounce = false
    local RenderStepped

    isASubWindowOpenLul.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        isASubWindowOpenLul.IsOpen = IsOpen
        Debounce = true

        if isASubWindowOpenLul.IsOpen then
            Items["ColorpickerWindow"].Instance.Visible = true
            Items["ColorpickerWindow"].Instance.Parent = Library.Holder.Instance
            RenderStepped = Library:Connect(RunService.RenderStepped, function()
                Items["ColorpickerWindow"].Instance.Position = UDim2New(0, Items["ColorpickerButton"].Instance.AbsolutePosition.X, 0, Items["ColorpickerButton"].Instance.AbsolutePosition.Y + Items["ColorpickerButton"].Instance.AbsoluteSize.Y + 5)
            end)

            if not Data.Section.IsSettings then
                for _, v in Library.OpenFrames, nil, nil do
                    if v ~= isASubWindowOpenLul then
                        v:SetOpen(false)
                    end
                end

                Library.OpenFrames[isASubWindowOpenLul] = isASubWindowOpenLul
            end

            Library.IsASubWindowOpenLul = isASubWindowOpenLul
        else
            if not Data.Section.IsSettings and Library.OpenFrames[isASubWindowOpenLul] then
                Library.OpenFrames[isASubWindowOpenLul] = nil
            end

            if RenderStepped then
                RenderStepped:Disconnect()
                RenderStepped = nil
            end

            if Library.IsASubWindowOpenLul == isASubWindowOpenLul then
                Library.IsASubWindowOpenLul = nil
            end
        end

        local descendants = Items["ColorpickerWindow"].Instance:GetDescendants()

        TableInsert(descendants, Items["ColorpickerWindow"].Instance)

        local FadeTween

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if not v.ClassName:find("UI") then
                    v.ZIndex = isASubWindowOpenLul.IsOpen and 125 or 1
                end

                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        FadeTween = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    FadeTween = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        FadeTween.Tween.Completed:Connect(function()
            Debounce = false
            Items["ColorpickerWindow"].Instance.Visible = isASubWindowOpenLul.IsOpen
            task.wait(0.2)
            Items["ColorpickerWindow"].Instance.Parent = not isASubWindowOpenLul.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
        end)
    end
    isASubWindowOpenLul.Get = function()
        return isASubWindowOpenLul.Color, isASubWindowOpenLul.Alpha
    end
    isASubWindowOpenLul.Update = function(self, Value)
        local Hue = isASubWindowOpenLul.Hue

        isASubWindowOpenLul.Color = FromHSV(Hue, isASubWindowOpenLul.Saturation, isASubWindowOpenLul.Value)
        isASubWindowOpenLul.HexValue = isASubWindowOpenLul.Color:ToHex()
        Library.Flags[isASubWindowOpenLul.Flag] = {
            Alpha = isASubWindowOpenLul.Alpha,
            Color = isASubWindowOpenLul.Color,
            HexValue = isASubWindowOpenLul.HexValue,
            Transparency = 1 - isASubWindowOpenLul.Alpha
        }
        Items["ColorpickerButton"]:Tween(nil, {
            BackgroundColor3 = isASubWindowOpenLul.Color
        })
        Items["PaletteDragger"]:Tween(nil, {
            BackgroundColor3 = isASubWindowOpenLul.Color
        })
        Items["Palette"]:Tween(nil, {
            BackgroundColor3 = FromHSV(Hue, 1, 1)
        })
        Items["AlphaDragger"]:Tween(nil, {
            BackgroundColor3 = isASubWindowOpenLul.Color
        })
        Items["HexColor"]:Tween(nil, {
            BackgroundColor3 = isASubWindowOpenLul.Color
        })

        if isASubWindowOpenLul.SelectedFormat == "HEX" then
            Items["HexInput"].Instance.Text = Library:ToRich("#", Library.Theme["Text 2"]) .. isASubWindowOpenLul.HexValue
        else
            local Red = MathFloor(isASubWindowOpenLul.Color.R * 255)
            local Green = MathFloor(isASubWindowOpenLul.Color.G * 255)
            local Blue = MathFloor(isASubWindowOpenLul.Color.B * 255)

            Items["HexInput"].Instance.Text = tostring(Red) .. ", " .. tostring(Green) .. ", " .. tostring(Blue)
        end

        Items["AlphaValue"].Instance.Text = MathFloor(isASubWindowOpenLul.Alpha * 100) .. Library:ToRich("%", Library.Theme["Text 2"])

        if not Value then
            Items["Alpha"]:Tween(nil, {
                BackgroundColor3 = isASubWindowOpenLul.Color
            })
        end

        if Data.Callback then
            Library:SafeCall(Data.Callback, isASubWindowOpenLul.Color, isASubWindowOpenLul.Alpha)
        end
    end
    ColorFormatDropdown:Add("HEX"):Set()
    ColorFormatDropdown:Add("RGB")

    local Debounce = false
    local RenderStepped
    local Debounce = false
    local RenderStepped
    local Debounce = false
    local RenderStepped

    isASubWindowOpenLul.SlidePalette = function(self, Input)
        if Input then
            if Debounce then
                local saturation = MathClamp(1 - (Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 1)
                local value = MathClamp(1 - (Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 1)

                isASubWindowOpenLul.Saturation = saturation
                isASubWindowOpenLul.Value = value

                local PaletteX = MathClamp((Input.Position.X - Items["Palette"].Instance.AbsolutePosition.X) / Items["Palette"].Instance.AbsoluteSize.X, 0, 0.975)
                local PaletteY = MathClamp((Input.Position.Y - Items["Palette"].Instance.AbsolutePosition.Y) / Items["Palette"].Instance.AbsoluteSize.Y, 0, 0.975)

                Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2New(PaletteX, 0, PaletteY, 0)
                })
                isASubWindowOpenLul:Update()

                return
            end
        end
    end
    isASubWindowOpenLul.SlideHue = function(self, Input)
        if Input then
            if Debounce then
                isASubWindowOpenLul.Hue = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 1)

                local HuePosition = MathClamp((Input.Position.X - Items["Hue"].Instance.AbsolutePosition.X) / Items["Hue"].Instance.AbsoluteSize.X, 0, 0.975)

                Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2New(HuePosition, 0, 0.5, 0)
                })
                isASubWindowOpenLul:Update()

                return
            end
        end
    end
    isASubWindowOpenLul.SlideAlpha = function(self, Input)
        if Input then
            if Debounce then
                isASubWindowOpenLul.Alpha = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 1)

                local AlphaPosition = MathClamp((Input.Position.X - Items["Alpha"].Instance.AbsolutePosition.X) / Items["Alpha"].Instance.AbsoluteSize.X, 0, 0.975)

                Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = UDim2New(AlphaPosition, 0, 0.5, 0)
                })
                isASubWindowOpenLul:Update(true)

                return
            end
        end
    end
    isASubWindowOpenLul.Set = function(self, Color, Alpha)
        if type(Color) == "table" then
            Color = FromRGB(Color[1], Color[2], Color[3])
        elseif type(Color) == "string" then
            Color = FromHex(Color)
        end

        local Hue, Saturation, Value = Color:ToHSV()

        isASubWindowOpenLul.Hue = Hue
        isASubWindowOpenLul.Saturation = Saturation
        isASubWindowOpenLul.Value = Value
        isASubWindowOpenLul.Alpha = Alpha or 0

        local SaturationPosition = MathClamp(1 - isASubWindowOpenLul.Saturation, 0, 0.975)
        local ValuePosition = MathClamp(1 - isASubWindowOpenLul.Value, 0, 0.975)
        local ClampedAlpha = MathClamp(isASubWindowOpenLul.Alpha, 0, 0.975)
        local ClampedHue = MathClamp(isASubWindowOpenLul.Hue, 0, 0.975)

        Items["PaletteDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2New(SaturationPosition, 0, ValuePosition, 0)
        })
        Items["HueDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2New(ClampedHue, 0, 0.5, 0)
        })
        Items["AlphaDragger"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2New(ClampedAlpha, 0, 0.5, 0)
        })
        isASubWindowOpenLul:Update()
    end
    Items["ColorpickerButton"]:Connect("MouseButton1Down", function()
        isASubWindowOpenLul:SetOpen(not isASubWindowOpenLul.IsOpen)
    end)
    Items["Palette"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Debounce = true
            isASubWindowOpenLul:SlidePalette(Input)

            if RenderStepped then
                return
            end

            RenderStepped = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Debounce = false
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end
            end)
        end
    end)
    Items["HueInline"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Debounce = true
            isASubWindowOpenLul:SlideHue(Input)

            if RenderStepped then
                return
            end

            RenderStepped = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Debounce = false
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end
            end)
        end
    end)
    Items["Alpha"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Debounce = true
            isASubWindowOpenLul:SlideAlpha(Input)

            if RenderStepped then
                return
            end

            RenderStepped = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Debounce = false
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end
            end)
        end
    end)
    Library:Connect(UserInputService.InputBegan, function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
        if not isASubWindowOpenLul.IsOpen or ColorFormatDropdown.IsOpen then
            return
        end
        
        if Library:IsMouseOverFrame(Items["ColorpickerButton"]) then
            return
        end
        
        if Library:IsMouseOverFrame(Items["ColorpickerWindow"]) then
            return
        end
        
        if Items["PaletteIcon"] and not Data.Section.IsSettings then
            if Library:IsMouseOverFrame(Items["PaletteIcon"]) then
                return
            end
        end

        isASubWindowOpenLul:SetOpen(false)
    end
end)
    Library:Connect(UserInputService.InputChanged, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if Debounce then
                isASubWindowOpenLul:SlidePalette(Input)
            end

            if Debounce then
                isASubWindowOpenLul:SlideHue(Input)
            end

            if Debounce then
                isASubWindowOpenLul:SlideAlpha(Input)
            end
        end
    end)
    Items["HexInput"]:Connect("FocusLost", function()
        if isASubWindowOpenLul.SelectedFormat == "RGB" then
            local match, GreenText, BlueText = Items["HexInput"].Instance.Text:match("(%d+),%s*(%d+),%s*(%d+)")
            local RedValue = tonumber(match)
            local GreenValue = tonumber(GreenText)
            local BlueValue = tonumber(BlueText)

            isASubWindowOpenLul:Set({
                RedValue,
                GreenValue,
                BlueValue
            }, isASubWindowOpenLul.Alpha)
        elseif isASubWindowOpenLul.SelectedFormat == "HEX" then
            isASubWindowOpenLul:Set(tostring(Items["HexInput"].Instance.Text), isASubWindowOpenLul.Alpha)
        end
    end)
    setmetatable(isASubWindowOpenLul, Library.Sections)

    if Data.Default then
        isASubWindowOpenLul:Set(Data.Default, Data.Alpha)
    end

    Library.SetFlags[isASubWindowOpenLul.Flag] = function(Color, Alpha)
        isASubWindowOpenLul:Set(Color, Alpha)
    end

    return isASubWindowOpenLul, Items
end
Library.Watermark = function()
    local Watermark = {
        IsOpen = true,
        Widgets = {}
    }
    local Items = { } do
        Items["Watermark"] = Instances:Create("Frame", {
            Parent = Library.Holder.Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(0, 0),
            BackgroundTransparency = 0.20000000298023224,
            Position = UDim2FromOffset(CurrentCamera.ViewportSize.X - 225, 10),
            Size = UDim2New(0, 0, 0, 35),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = Library.Theme["Background 2"]
        }):AddToTheme({
            BackgroundColor3 = "Background 2"
        })
    end

    Library:MakeBlurred(Items["Watermark"], Watermark)
    Items["Watermark"]:MakeDraggable()
    Items["Watermark"].Instance:GetPropertyChangedSignal("Position"):Connect(function()
        Library.Flags.WatermarkPosition = {
            X = Items["Watermark"].Instance.Position.X.Offset,
            Y = Items["Watermark"].Instance.Position.Y.Offset
        }
    end)
    Library.SetFlags.WatermarkPosition = function(Position)
        if Position then
            if Position.X then
                if Position.Y then
                    Items["Watermark"].Instance.Position = UDim2New(0, Position.X, 0, Position.Y)
                end
            end
        end
    end
    Instances:Create("UICorner", {
        Parent = Items["Watermark"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Watermark"].Instance,
        Name = "\0",
        VerticalAlignment = Enum.VerticalAlignment.Center,
        FillDirection = Enum.FillDirection.Horizontal,
        Padding = UDimNew(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Instances:Create("UIPadding", {
        Parent = Items["Watermark"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 1),
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 12)
    })
    Watermark.SetVisibility = function(self, Visible)
        Items["Watermark"].Instance.Visible = Visible
        Watermark.IsOpen = Visible
    end

    Watermark.AddWidget = function(self, Widget)
        local tween

        if Widget.Type == "Image" then
            tween = Instances:Create("ImageLabel", {
                Parent = Items["Watermark"].Instance,
                Name = "\0",
                ImageColor3 = Widget.ImageColor,
                BorderColor3 = FromRGB(0, 0, 0),
                Image = Widget.Image,
                BackgroundTransparency = 1,
                Size = UDim2New(0, 18, 0, 18),
                BorderSizePixel = 0
            })
        elseif Widget.Type == "Text" then
            tween = Instances:Create("TextLabel", {
                Parent = Items["Watermark"].Instance,
                Name = "\0",
                FontFace = Library.BoldFont,
                TextColor3 = Widget.TextColor,
                BorderColor3 = FromRGB(0, 0, 0),
                Text = Widget.Text,
                BackgroundTransparency = 1,
                Size = UDim2New(0, 0, 0, 15),
                BorderSizePixel = 0,
                AutomaticSize = Enum.AutomaticSize.X,
                TextSize = 18
            })
        end

        tween.Set = function(self, Text, Status)
            tween.Instance[Text] = Status
        end
        tween.Remove = function()
            tween:Clean()
            TableRemove(Watermark.Widgets, TableFind(Watermark.Widgets, tween))
        end
        TableInsert(Watermark.Widgets, tween)

        return tween
    end

    return Watermark
end
Library.KeybindList = function(self, Data)
    local keyList = {}

    Library.KeyList = keyList

    local KeybindList = {
        KeybindList = Instances:Create("Frame", {
            Parent = Library.Holder.Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(0, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2New(0, 20, 0.5, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            Visible = false
        })
    }

    KeybindList.Top = Instances:Create("Frame", {
        Parent = KeybindList.KeybindList.Instance,
        Name = "\0",
        BackgroundTransparency = 0.2,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 100, 0, 30),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme["Background 2"]
    }):AddToTheme({ BackgroundColor3 = "Background 2" })
    
    Instances:Create("UICorner", { Parent = KeybindList.Top.Instance, Name = "\0", CornerRadius = UDimNew(0, 10) })
    Instances:Create("UIStroke", { Parent = KeybindList.Top.Instance, Name = "\0", Color = Library.Theme["Outline 2"], ApplyStrokeMode = Enum.ApplyStrokeMode.Border }):AddToTheme({ Color = "Outline 2" })
    
    KeybindList.Text = Instances:Create("TextLabel", {
        Parent = KeybindList.Top.Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme["Text 2"],
        Text = "Hotkeys",
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 12, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16
    }):AddToTheme({ TextColor3 = "Text 2" })

    KeybindList.Content = Instances:Create("Frame", {
        Parent = KeybindList.KeybindList.Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0, 35),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.XY
    })
    
    Instances:Create("UIPadding", { Parent = KeybindList.Content.Instance, Name = "\0", PaddingTop = UDimNew(0, 5), PaddingBottom = UDimNew(0, 10) })
    Instances:Create("UIListLayout", { Parent = KeybindList.Content.Instance, Name = "\0", Padding = UDimNew(0, 0), SortOrder = Enum.SortOrder.LayoutOrder })
    
    keyList.SetText = function(self, Text) 
        KeybindList.Text.Instance.Text = tostring(Text) 
        if Text and Text ~= "" then
            KeybindList.KeybindList.Instance.Visible = true
        end
    end

    keyList.SetVisibility = function(self, Visible) KeybindList.KeybindList.Instance.Visible = Visible end
    keyList.SetCenter = function()
        local AbsolutePosition = KeybindList.KeybindList.Instance.AbsolutePosition
        task.wait()
        KeybindList.KeybindList.Instance.AnchorPoint = Vector2New(0, 0)
        KeybindList.KeybindList.Instance.Position = UDim2New(0, AbsolutePosition.X, 0, AbsolutePosition.Y)
    end

    local TweenInfoOut = TweenInfo.new(0.4, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
    local RowHeight = 16
    local RowGap = 6
    local RowSlot = RowHeight + RowGap
    local SlideOffset = 14

    keyList.Keys = {}

    keyList.Add = function(self, Name)
        local KeybindWidget = {
            Active = false,
            Name = Name or "Keybind",
            Key = Instances:Create("Frame", {
                Parent = KeybindList.Content.Instance,
                Name = "\0",
                BackgroundTransparency = 1,
                ClipsDescendants = true,
                Size = UDim2New(1, 0, 0, 0),
                Visible = false,
                BorderSizePixel = 0
            })
        }

        KeybindWidget.Text = Instances:Create("TextLabel", {
            Parent = KeybindWidget.Key.Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme["Text"],
            Text = KeybindWidget.Name,
            TextTransparency = 1,
            AnchorPoint = Vector2New(0, 0.5),
            Position = UDim2New(0, -SlideOffset, 0, RowHeight / 2),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16
        }):AddToTheme({ TextColor3 = "Text" })

        KeybindWidget.Value = Instances:Create("TextLabel", {
            Parent = KeybindWidget.Key.Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme["Text 2"],
            Text = "None",
            TextTransparency = 1,
            AnchorPoint = Vector2New(1, 0.5),
            Position = UDim2New(1, SlideOffset, 0, RowHeight / 2),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Right,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.XY,
            TextSize = 16
        }):AddToTheme({ TextColor3 = "Text 2" })

        KeybindWidget.Set = function(self, NewName, NewKey)
            if NewName ~= nil then KeybindWidget.Text.Instance.Text = tostring(NewName) end
            if NewKey ~= nil then KeybindWidget.Value.Instance.Text = string.upper(tostring(NewKey)) end
        end

        KeybindWidget.SetStatus = function(self, Status)
            if not KeybindWidget.Value.Instance.Text or KeybindWidget.Value.Instance.Text == "" or KeybindWidget.Value.Instance.Text == "NONE" or KeybindWidget.Value.Instance.Text == "NIL" then
                Status = false
            end

            if KeybindWidget.Active == Status then return end
            KeybindWidget.Active = Status

            if Status then
                KeybindWidget.Key.Instance.Visible = true
                KeybindWidget.Key:Tween({Size = UDim2New(1, 0, 0, RowSlot)}, TweenInfoOut)
                KeybindWidget.Text:Tween({TextTransparency = 0, Position = UDim2New(0, 0, 0, RowHeight / 2)}, TweenInfoOut)
                KeybindWidget.Value:Tween({TextTransparency = 0, Position = UDim2New(1, 0, 0, RowHeight / 2)}, TweenInfoOut)
            else
                KeybindWidget.Key:Tween({Size = UDim2New(1, 0, 0, 0)}, TweenInfoOut)
                KeybindWidget.Text:Tween({TextTransparency = 1, Position = UDim2New(0, -SlideOffset, 0, RowHeight / 2)}, TweenInfoOut)
                KeybindWidget.Value:Tween({TextTransparency = 1, Position = UDim2New(1, SlideOffset, 0, RowHeight / 2)}, TweenInfoOut)

                task.delay(0.4, function()
                    if not KeybindWidget.Active then
                        KeybindWidget.Key.Instance.Visible = false
                    end
                end)
            end
        end

        table.insert(keyList.Keys, KeybindWidget)
        return KeybindWidget
    end
    
    keyList:SetText(Data or "")
    keyList:SetCenter()

    return keyList
end
Library.Notification = function(self, Title, Description, Duration, Icon)
    local Notification = {
        Notification = Instances:Create("Frame", {
            Parent = Library.NotifHolder.Instance,
            Name = "\0",
            ClipsDescendants = true,
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 0.20000000298023224,
            Size = UDim2New(0, 0, 0, 30),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = Library.Theme["Background 2"]
        }):AddToTheme({
            BackgroundColor3 = "Background 2"
        })
    }

    Instances:Create("UICorner", {
        Parent = Notification.Notification.Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 12)
    })
    Instances:Create("UIPadding", {
        Parent = Notification.Notification.Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 12),
        PaddingLeft = UDimNew(0, 8)
    })
    Notification.Icon = Instances:Create("ImageLabel", {
        Parent = Notification.Notification.Instance,
        Name = "\0",
        ImageColor3 = Duration,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://" .. Description,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 6, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    })
    Notification.Liner = Instances:Create("Frame", {
        Parent = Notification.Notification.Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 0.5),
        Position = UDim2New(0, -10, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 4, 1, -11),
        BorderSizePixel = 0,
        BackgroundColor3 = Duration
    })
    Instances:Create("UICorner", {
        Parent = Notification.Liner.Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Notification.Text = Instances:Create("TextLabel", {
        Parent = Notification.Notification.Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme["Text 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Title,
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 34, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text 2"
    })

    local vector2 = Vector2New(Notification.Text.Instance.TextBounds.X + 55, 30)

    Notification.Notification.Instance.Size = UDim2New(0, 0, 0, 30)

    for _, v in Notification, nil, nil do
        if v.Instance:IsA("Frame") then
            v.Instance.BackgroundTransparency = 1
        elseif v.Instance:IsA("TextLabel") then
            v.Instance.TextTransparency = 1
        elseif v.Instance:IsA("UIStroke") then
            v.Instance.Transparency = 1
        elseif v.Instance:IsA("ImageLabel") then
            v.Instance.ImageTransparency = 1
        end
    end

    Notification.Notification.Instance.AutomaticSize = Enum.AutomaticSize.None

    local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out, 0, false, 0)

    Library:Thread(function()
        for _, v in Notification, nil, nil do
            if v.Instance:IsA("Frame") then
                v:Tween(tweenInfo, {
                    BackgroundTransparency = 0
                })
            elseif v.Instance:IsA("TextLabel") then
                v:Tween(tweenInfo, {
                    TextTransparency = 0
                })
            elseif v.Instance:IsA("UIStroke") then
                v:Tween(tweenInfo, {
                    Transparency = 0
                })
            elseif v.Instance:IsA("ImageLabel") then
                v:Tween(tweenInfo, {
                    ImageTransparency = 0
                })
            end
        end

        Notification.Notification:Tween(tweenInfo, {
            Size = UDim2New(0, vector2.X, 0, 30)
        })
        task.delay(Icon + 0.1, function()
            for _, v in Notification, nil, nil do
                if v.Instance:IsA("Frame") then
                    v:Tween(nil, {
                        BackgroundTransparency = 1
                    })
                elseif v.Instance:IsA("TextLabel") then
                    v:Tween(nil, {
                        TextTransparency = 1
                    })
                elseif v.Instance:IsA("UIStroke") then
                    v:Tween(nil, {
                        Transparency = 1
                    })
                elseif v.Instance:IsA("ImageLabel") then
                    v:Tween(nil, {
                        ImageTransparency = 1
                    })
                end
            end

            Notification.Notification:Tween(tweenInfo, {
                Size = UDim2New(0, 0, 0, 30)
            })
            task.wait(0.5)
            Notification.Notification:Clean()
        end)
    end)
end
Library.Tooltip = {
    Instance = nil,
    TextLabel = nil,
    HoverStart = 0,
    CurrentText = nil,
    TargetItem = nil,
    IsShown = false
}

local function CreateTooltip()
    if Library.Tooltip.Instance then
        return
    end

    local TooltipFrame = Instances:Create("Frame", {
        Parent = Library.OtherHolder.Instance,
        Name = "Tooltip",
        Size = UDim2New(0, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = Library.Theme["Background 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        ZIndex = 10000,
        Visible = false,
        Active = false,
        Selectable = false,
        BackgroundTransparency = 0.1,
        AnchorPoint = Vector2New(0.5, 0)
    }):AddToTheme({
        BackgroundColor3 = "Background 2"
    })

    Instances:Create("UICorner", {
        Parent = TooltipFrame.Instance,
        CornerRadius = UDimNew(0, 4)
    })
    Instances:Create("UIStroke", {
        Parent = TooltipFrame.Instance,
        Color = Library.Theme["Outline 2"],
        Thickness = 1
    }):AddToTheme({
        Color = "Outline 2"
    })

    local TooltipText = Instances:Create("TextLabel", {
        Parent = TooltipFrame.Instance,
        Text = "",
        TextColor3 = Library.Theme.Text,
        TextSize = 14,
        FontFace = Library.Font,
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        ZIndex = 10001,
        Size = UDim2New(0, 0, 0, 0)
    }):AddToTheme({
        TextColor3 = "Text"
    })

    Instances:Create("UIPadding", {
        Parent = TooltipFrame.Instance,
        PaddingTop = UDimNew(0, 4),
        PaddingBottom = UDimNew(0, 4),
        PaddingLeft = UDimNew(0, 6),
        PaddingRight = UDimNew(0, 6)
    })
    Library.Tooltip.Instance = TooltipFrame
    Library.Tooltip.TextLabel = TooltipText
    Library:MakeBlurred(TooltipFrame.Instance, {
        IsOpen = true
    })
end

Library:Connect(RunService.RenderStepped, function()
    if not Library.Tooltip.CurrentText or not Library.Tooltip.TargetItem then
        if Library.Tooltip.Instance and Library.Tooltip.Instance.Instance.Visible then
            Library.Tooltip.Instance.Instance.Visible = false
            Library.Tooltip.IsShown = false
        end

        return
    end

    if tick() - Library.Tooltip.HoverStart < 1 then
        return
    end

    if not Library.Tooltip.Instance then
        CreateTooltip()
    end

    if not Library.Tooltip.IsShown then
        Library.Tooltip.Instance.Instance.Visible = true
        Library.Tooltip.IsShown = true
    end

    Library.Tooltip.TextLabel.Instance.Text = Library.Tooltip.CurrentText

    local mouseLocation = UserInputService:GetMouseLocation()

    Library.Tooltip.Instance.Instance.Position = UDim2New(0, mouseLocation.X + 20, 0, mouseLocation.Y + 20)
end)
Library.ShowTooltip = function(self, Text, TargetItem)
    Library.Tooltip.CurrentText = Text
    Library.Tooltip.TargetItem = TargetItem
    Library.Tooltip.HoverStart = tick()
end
Library.HideTooltip = function()
    Library.Tooltip.CurrentText = nil
    Library.Tooltip.TargetItem = nil
    Library.Tooltip.IsShown = false

    if Library.Tooltip.Instance then
        Library.Tooltip.Instance.Instance.Visible = false
    end
end
Library.Window = function(self, Data)
    local Data = Data or {}

    local Window = {
        Name = Data.Name or Data.name or "Window",
        SubName = Data.SubName or Data.subname or "SubName",
        TimeLeft = Data.TimeLeft or Data.timeleft or "59 days left",
        Logo = Data.Logo or Data.logo or "119425601173954",
        ConfigHeader = nil,
        Pages = {},
        Sections = {},
        Items = {},
        IsOpen = false
    }
    local Items = { } do
        Items["MainFrame"] = Instances:Create("CanvasGroup", {
            Parent = Library.Holder.Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Position = UDim2New(0, 180, 0, -5),
            Size = UDim2New(0, 865, 0, 480),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(13, 17, 18)
})
    end

    Items["MainFrame"]:MakeDraggable()
    Items["MainFrame"]:MakeResizeable(Vector2New(879, 500), Vector2New(9999, 9999))
    Library:MakeBlurred(Items["MainFrame"], Window)
    Instances:Create("UICorner", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Instances:Create("UIGradient", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        Rotation = -90,
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.446, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.759, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.843, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.879, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.9, 0.15000000596046448),
            NumberSequenceKeypoint.new(0.953, 0.15000000596046448),
            NumberSequenceKeypoint.new(1, 0.20000000298023224)
        })
    })
    Items["SideOutline"] = Instances:Create("Frame", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 250, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Outline
    }):AddToTheme({
        BackgroundColor3 = "Outline"
    })
    Items["SideInline"] = Instances:Create("Frame", {
        Parent = Items["SideOutline"].Instance,
        Name = "\0",
        Position = UDim2New(0, 1, 0, 1),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -2, 1, -2),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme["Background 2"]
    }):AddToTheme({
        BackgroundColor3 = "Background 2"
    })
    Items["LogoBackground"] = Instances:Create("Frame", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        BackgroundTransparency = 0.60000002384185791,
        Position = UDim2New(0, 15, 0, 15),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 40, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme["Logo Background"]
    }):AddToTheme({
        BackgroundColor3 = "Logo Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["LogoBackground"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 12)
    })
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["LogoBackground"].Instance,
        Name = "\0",
        ScaleType = Enum.ScaleType.Fit,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0.5, 0.5),
        Image = "rbxassetid://" .. Window.Logo,
        BackgroundTransparency = 1,
        Position = UDim2New(0.5, 0, 0.5, 0),
        Size = UDim2New(1, -10, 1, -10),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })

    local colorSequenceKeypointNew = ColorSequenceKeypoint.new

    Instances:Create("UIGradient", {
        Parent = Items["Icon"].Instance,
        Name = "\0",
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, FromRGB(255, 255, 255)),
            colorSequenceKeypointNew(1, FromRGB(167, 167, 167))
        })
    })
    Items["Pages"] = Instances:Create("ScrollingFrame", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0, 70),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, -135),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text,
        ScrollBarThickness = 0,
        CanvasSize = UDim2New(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Active = true
    })
    Instances:Create("UIPadding", {
        Parent = Items["Pages"].Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 8),
        PaddingBottom = UDimNew(0, 15),
        PaddingRight = UDimNew(0, 39),
        PaddingLeft = UDimNew(0, 15)
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Pages"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["SubTitle"] = Instances:Create("TextLabel", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        TextTransparency = 0.5,
        Text = Window.SubName,
        Size = UDim2New(0, 0, 0, 15),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 65, 0, 38),
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Instances:Create("UICorner", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Items["Title"] = Instances:Create("TextLabel", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        FontFace = Library.BoldFont,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Window.Name,
        Size = UDim2New(0, 0, 0, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 65, 0, 18),
        TextWrapped = true,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 22,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Instances:Create("UICorner", {
        Parent = Items["SideOutline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Instances:Create("Frame", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        Position = UDim2New(0, 18, 0, 65),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -62, 0, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Liner
    }):AddToTheme({
        BackgroundColor3 = "Liner"
    })
    Items["UserInfo"] = Instances:Create("Frame", {
        Parent = Items["SideInline"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 1),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 6, 1, -15),
        Size = UDim2New(1, -40, 0, 50),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Instances:Create("Frame", {
        Parent = Items["UserInfo"].Instance,
        Name = "\0",
        Position = UDim2New(0, 12, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -24, 0, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Liner
    }):AddToTheme({
        BackgroundColor3 = "Liner"
    })

    local userThumbnailAsync = Players:GetUserThumbnailAsync(Players.LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)

    Items["AvatarIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["UserInfo"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 1),
        Image = userThumbnailAsync,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 12, 1, 3),
        Size = UDim2New(0, 40, 0, 40),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Instances:Create("UICorner", {
        Parent = Items["AvatarIcon"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["UIStroke"] = Instances:Create("UIStroke", {
        Parent = Items["AvatarIcon"].Instance,
        Name = "\0",
        Color = FromRGB(77, 126, 254),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Accent"
    })

    local colorSequenceKeypointNew2 = ColorSequenceKeypoint.new

    Instances:Create("UIGradient", {
        Parent = Items["UIStroke"].Instance,
        Name = "\0",
        Rotation = 90,
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, FromRGB(255, 255, 255)),
            colorSequenceKeypointNew2(1, FromRGB(102, 102, 102))
        })
    })
    Items["Username"] = Instances:Create("TextLabel", {
        Parent = Items["UserInfo"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = LocalPlayer.Name,
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 60, 0, 15),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Items["TimeLeft"] = Instances:Create("TextLabel", {
        Parent = Items["UserInfo"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        TextTransparency = 0.5,
        Text = Window.TimeLeft,
        Size = UDim2New(0, 0, 0, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 60, 0, 34),
        BorderColor3 = FromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Items["InlineOutline"] = Instances:Create("Frame", {
        Parent = Items["MainFrame"].Instance,
        Name = "\0",
        Position = UDim2New(0, 225, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -225, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Outline
    }):AddToTheme({
        BackgroundColor3 = "Outline"
    })
    Instances:Create("UICorner", {
        Parent = Items["InlineOutline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Items["Inline"] = Instances:Create("Frame", {
        Parent = Items["InlineOutline"].Instance,
        Name = "\0",
        Position = UDim2New(0, 1, 0, 1),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -2, 1, -2),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Background
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Items["Content"] = Instances:Create("Frame", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Items["ConfigHeader"] = Instances:Create("TextButton", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 10, 0, 12),
        Size = UDim2New(0, 264, 0, 28),
        BorderSizePixel = 0,
        TextSize = 14
    })
    Instances:Create("UICorner", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("Frame", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        Position = UDim2New(0, 10, 0, 55),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -20, 0, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(27, 26, 35)
    }):AddToTheme({
        BackgroundColor3 = "Liner"
    })
    Instances:Create("UIStroke", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        Color = Library.Theme.Outline,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline"
    })
    Items["ConfigHeaderIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://115980460667207",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 6, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text"
    })
    Instances:Create("Frame", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        Position = UDim2New(0, 28, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 1, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Outline
    }):AddToTheme({
        BackgroundColor3 = "Outline"
    })
    Items["ConfigText"] = Instances:Create("TextLabel", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "None",
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(1, -60, 0, 15),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2New(0, 40, 0.5, 0),
        BorderSizePixel = 0,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Instances:Create("UIGradient", {
        Parent = Items["ConfigText"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.676, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    })
    Items["ArrowIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["ConfigHeader"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme["Text 2"],
        ScaleType = Enum.ScaleType.Fit,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(1, 0.5),
        Image = "rbxassetid://111436698580046",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -10, 0.5, 0),
        Size = UDim2New(0, 9, 0, 5),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["ConfigHeaderWindow"] = Instances:Create("TextButton", {
        Parent = Library.UnusedHolder.Instance,
        Text = "",
        AutoButtonColor = false,
        Name = "\0",
        Visible = false,
        BorderColor3 = FromRGB(0, 0, 0),
        BackgroundTransparency = 0.1,
        Position = UDim2New(0, 489, 0, 214),
        Size = UDim2New(0, 300, 0, 100),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = FromRGB(15, 16, 21)
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Instances:Create("UIStroke", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["Top"] = Instances:Create("Frame", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 0, 50),
        BorderSizePixel = 0
    })
    Instances:Create("Frame", {
        Parent = Items["Top"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 1),
        Position = UDim2New(0, 12, 1, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -24, 0, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(27, 26, 35)
    }):AddToTheme({
        BackgroundColor3 = "Liner"
    })
    Items["Presets"] = Instances:Create("Frame", {
        Parent = Items["Top"].Instance,
        Name = "\0",
        Position = UDim2New(0, 10, 0, 10),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 95, 0, 28),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(28, 27, 38)
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["Presets"].Instance,
        Name = "\0"
    })
    Items["CloudIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["Presets"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(81, 124, 253),
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://99531003828686",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 8, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Accent"
    })
    Items["PresetsText"] = Instances:Create("TextLabel", {
        Parent = Items["Presets"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(81, 124, 253),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "Presets",
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 9, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 34, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Accent"
    })
    Instances:Create("UIStroke", {
        Parent = Items["Presets"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["PlusIcon"] = Instances:Create("ImageButton", {
        Parent = Items["Top"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Image = "rbxassetid://116054682931186",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -10, 0.5, -2),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["DeleteIcon"] = Instances:Create("ImageButton", {
        Parent = Items["Top"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Image = "rbxassetid://106573800301941",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -32, 0.5, -2),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["ConfigContent"] = Instances:Create("Frame", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 12, 0, 105),
        Size = UDim2New(1, -24, 0, 1),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y
    })
    Instances:Create("UIPadding", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 12)
    })
    Instances:Create("UIListLayout", {
        Parent = Items["ConfigContent"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["Search"] = Instances:Create("Frame", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        Position = UDim2New(0, 12, 0, 60),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -55, 0, 30),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(28, 27, 38)
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("UIStroke", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Instances:Create("Frame", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0, 1),
        Position = UDim2New(0, 0, 1, 8),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 0, 1),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(27, 26, 35)
    }):AddToTheme({
        BackgroundColor3 = "Liner"
    })
    Items["SearchIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://93412599989519",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 10, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text"
    })
    Items["SearchInput"] = Instances:Create("TextBox", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        AnchorPoint = Vector2New(0, 0.5),
        PlaceholderColor3 = FromRGB(151, 150, 162),
        PlaceholderText = "Search..",
        TextSize = 18,
        Size = UDim2New(1, -60, 0, 15),
        TextColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        CursorPosition = -1,
        Position = UDim2New(0, 36, 0.5, 0),
        BorderSizePixel = 0
    }):AddToTheme({
        TextColor3 = "Text",
        PlaceholderColor3 = "Text 2"
    })
    Items["SortIcon"] = Instances:Create("ImageButton", {
        Parent = Items["ConfigHeaderWindow"].Instance,
        Name = "\0",
        ImageColor3 = FromRGB(200, 200, 207),
        BorderColor3 = FromRGB(0, 0, 0),
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0),
        Image = "rbxassetid://76151043492079",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -13, 0, 63),
        Size = UDim2New(0, 20, 0, 20),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text"
    })
    Items["RefreshIcon"] = Instances:Create("ImageButton", {
        Parent = Items["Top"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Image = "rbxassetid://93349220165339",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -55, 0.5, -2),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    })
    Items["PlusIcon"]:OnHover(function()
        Items["PlusIcon"]:ChangeItemTheme({
            ImageColor3 = "Text"
        })
        Items["PlusIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Text
        })
    end)
    Items["PlusIcon"]:OnHoverLeave(function()
        Items["PlusIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["PlusIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)
    Items["DeleteIcon"]:OnHover(function()
        Items["DeleteIcon"]:ChangeItemTheme({
            ImageColor3 = "Text"
        })
        Items["DeleteIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Text
        })
    end)
    Items["DeleteIcon"]:OnHoverLeave(function()
        Items["DeleteIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["DeleteIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)
    Items["RefreshIcon"]:OnHover(function()
        Items["RefreshIcon"]:ChangeItemTheme({
            ImageColor3 = "Text"
        })
        Items["RefreshIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Text
        })
    end)
    Items["RefreshIcon"]:OnHoverLeave(function()
        Items["RefreshIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["RefreshIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)

    local configHeader = {
        IsOpen = false,
        Selected = nil,
        Configs = {}
    }
    local Debounce = false
    local RenderStepped

    configHeader.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        configHeader.IsOpen = IsOpen
        Debounce = true

        if configHeader.IsOpen then
            Items["ConfigHeaderWindow"].Instance.Visible = true
            Items["ConfigHeaderWindow"].Instance.Parent = Library.OtherHolder.Instance
            Items["ConfigHeaderWindow"].Instance.Position = UDim2New(0, Items["ConfigHeader"].Instance.AbsolutePosition.X, 0, Items["ConfigHeader"].Instance.AbsolutePosition.Y + Items["ConfigHeader"].Instance.AbsoluteSize.Y + 5)

            for _, v in Library.OpenFrames, nil, nil do
                if v ~= configHeader then
                    v:SetOpen(false)
                end
            end

            Library.OpenFrames[configHeader] = configHeader
        else
            if Library.OpenFrames[configHeader] then
                Library.OpenFrames[configHeader] = nil
            end

            if connection then
                connection:Disconnect()
                connection = nil
            end
        end

        local descendants = Items["ConfigHeaderWindow"].Instance:GetDescendants()

        TableInsert(descendants, Items["ConfigHeaderWindow"].Instance)

        local DragConnection

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if not v.ClassName:find("UI") then
                    v.ZIndex = configHeader.IsOpen and 1124 or 1
                end

                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        DragConnection = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    DragConnection = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        DragConnection.Tween.Completed:Connect(function()
            Debounce = false
            Items["ConfigHeaderWindow"].Instance.Visible = configHeader.IsOpen
            task.wait(0.2)
            Items["ConfigHeaderWindow"].Instance.Parent = not configHeader.IsOpen and Library.UnusedHolder.Instance or Library.OtherHolder.Instance
            task.wait(0.1)

            if configHeader.IsOpen then
                connection = Library:Connect(RunService.RenderStepped, function()
                    Items["ConfigHeaderWindow"].Instance.Position = UDim2New(0, Items["ConfigHeader"].Instance.AbsolutePosition.X, 0, Items["ConfigHeader"].Instance.AbsolutePosition.Y + Items["ConfigHeader"].Instance.AbsoluteSize.Y + 5)
                end)
            elseif connection then
                connection:Disconnect()
                connection = nil
            end
        end)
    end

    local Debounce
    local RenderStepped

    Items["ConfigHeader"]:Connect("MouseButton1Down", function(X, Y)
        Debounce = X
        RenderStepped = Y
    end)
    Items["ConfigHeader"]:Connect("MouseButton1Up", function(X, Y)
        if Debounce then
            local DeltaX = X - Debounce
            local DeltaY = Y - RenderStepped

            if DeltaX * DeltaX + DeltaY * DeltaY < 25 then
                configHeader:SetOpen(not configHeader.IsOpen)
            end

            Debounce = nil
            RenderStepped = nil
        end
    end)
    Library:Connect(UserInputService.InputBegan, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and configHeader.IsOpen then
            if Library:IsMouseOverFrame(Items["ConfigHeaderWindow"]) then
                return
            end

            configHeader:SetOpen(false)
        end
    end)

    local Debounce = false

    configHeader.Sort = function(self, Value)
        if Value then
            table.sort(configHeader.Configs, function(A, B)
                if Debounce then
                    return StringLen(A.Text) > StringLen(B.Text)
                end

                return StringLen(A.Text) < StringLen(B.Text)
            end)

            for k, config in pairs(configHeader.Configs) do
                config.Object.Instance.LayoutOrder = k
            end
        end
    end
    Items["SortIcon"]:Connect("MouseButton1Down", function()
        Debounce = not Debounce
        configHeader:Sort(Debounce)
    end)
    configHeader.AddConfig = function(self, Text)
        for _, config in pairs(configHeader.Configs) do
            if config.Text ~= Text then
                continue
            end

            return
        end

        local selected = {
            File = nil,
            Text = nil,
            Object = nil,
            Selected = false,
            AutoLoadButton = nil,
        }
        local ConfigOption = {
            NewConfig = Instances:Create("TextButton", {
                Parent = Items["ConfigContent"].Instance,
                Name = "\0",
                FontFace = Library.Font,
                ZIndex = 11245,
                TextColor3 = FromRGB(0, 0, 0),
                BorderColor3 = FromRGB(0, 0, 0),
                Text = "",
                AutoButtonColor = false,
                Size = UDim2New(1, 0, 0, 30),
                BorderSizePixel = 0,
                TextSize = 14,
                BackgroundColor3 = FromRGB(28, 27, 38)
            }):AddToTheme({
                BackgroundColor3 = "Element"
            })
        }

        Instances:Create("UICorner", {
            Parent = ConfigOption.NewConfig.Instance,
            Name = "\0"
        })
        ConfigOption.Stroke = Instances:Create("UIStroke", {
            Parent = ConfigOption.NewConfig.Instance,
            Name = "\0",
            Color = Library.Theme["Outline 2"],
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        }):AddToTheme({
            Color = "Outline 2"
        })
        ConfigOption.LoadButton = Instances:Create("ImageButton", {
            Parent = ConfigOption.NewConfig.Instance,
            ZIndex = 11245,
            Name = "\0",
            ImageColor3 = FromRGB(200, 200, 207),
            BorderColor3 = FromRGB(0, 0, 0),
            AutoButtonColor = false,
            AnchorPoint = Vector2New(1, 0.5),
            Image = "rbxassetid://126165013650337",
            BackgroundTransparency = 1,
            Position = UDim2New(1, -8, 0.5, -1),
            Size = UDim2New(0, 20, 0, 20),
            BorderSizePixel = 0
        }):AddToTheme({
            ImageColor3 = "Text"
        })
        ConfigOption.ConfigName = Instances:Create("TextBox", {
            Parent = ConfigOption.NewConfig.Instance,
            Name = "\0",
            FontFace = Library.Font,
            CursorPosition = -1,
            Active = false,
            Interactable = false,
            AnchorPoint = Vector2New(0, 0.5),
            TextSize = 18,
            ZIndex = 11245,
            Size = UDim2New(0, 0, 0, 15),
            TextColor3 = FromRGB(200, 200, 207),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = Text or "Unnamed" .. tostring(#configHeader.Configs),
            Selectable = false,
            BackgroundTransparency = 1,
            Position = UDim2New(0, 10, 0.5, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            ClearTextOnFocus = false,
            BorderSizePixel = 0
        }):AddToTheme({
            TextColor3 = "Text"
        })
        ConfigOption.OverwriteButton = Instances:Create("ImageButton", {
            Parent = ConfigOption.NewConfig.Instance,
            Name = "\0",
            ImageColor3 = FromRGB(200, 200, 207),
            BorderColor3 = FromRGB(0, 0, 0),
            AutoButtonColor = false,
            AnchorPoint = Vector2New(1, 0.5),
            Image = "rbxassetid://124600563612369",
            BackgroundTransparency = 1,
            ZIndex = 11246,
            Position = UDim2New(1, -34, 0.5, -1),
            Size = UDim2New(0, 20, 0, 20),
            BorderSizePixel = 0
        }):AddToTheme({
            ImageColor3 = "Text"
        })
        ConfigOption.AutoLoadButton = Instances:Create("ImageButton", {
            Parent = ConfigOption.NewConfig.Instance,
            Name = "\0",
            ImageColor3 = FromRGB(200, 200, 207),
            BorderColor3 = FromRGB(0, 0, 0),
            AutoButtonColor = false,
            AnchorPoint = Vector2New(1, 0.5),
            Image = "rbxassetid://93209682414397",
            BackgroundTransparency = 1,
            ZIndex = 11246,
            Position = UDim2New(1, -60, 0.5, -1),
            Size = UDim2New(0, 20, 0, 20),
            BorderSizePixel = 0
        }):AddToTheme({
            ImageColor3 = "Text 2"
        })
        ConfigOption.NewConfig:OnHover(function()
            if selected.Selected then
                return
            end

            ConfigOption.NewConfig:ChangeItemTheme({
                BackgroundColor3 = "Hover Element"
            })
            ConfigOption.NewConfig:Tween(nil, {
                BackgroundColor3 = Library.Theme["Hover Element"]
            })
        end)
        ConfigOption.NewConfig:OnHoverLeave(function()
            if selected.Selected then
                return
            end

            ConfigOption.NewConfig:ChangeItemTheme({
                BackgroundColor3 = "Element"
            })
            ConfigOption.NewConfig:Tween(nil, {
                BackgroundColor3 = Library.Theme.Element
            })
        end)
        ConfigOption.AutoLoadButton:OnHover(function()
            local AutoLoadPath = Library:GetFolder() .. "/autoload.txt"
            local AutoLoadEnabled = false

            if isfile(AutoLoadPath) and readfile(AutoLoadPath) == selected.Text then
                AutoLoadEnabled = true
            end

            if not AutoLoadEnabled then
                ConfigOption.AutoLoadButton:ChangeItemTheme({
                    ImageColor3 = "Text"
                })
                ConfigOption.AutoLoadButton:Tween(nil, {
                    ImageColor3 = Library.Theme.Text
                })
            end
        end)
        ConfigOption.AutoLoadButton:OnHoverLeave(function()
            local AutoLoadPath = Library:GetFolder() .. "/autoload.txt"
            local AutoLoadEnabled = false

            if isfile(AutoLoadPath) and readfile(AutoLoadPath) == selected.Text then
                AutoLoadEnabled = true
            end

            if not AutoLoadEnabled then
                ConfigOption.AutoLoadButton:ChangeItemTheme({
                    ImageColor3 = "Text 2"
                })
                ConfigOption.AutoLoadButton:Tween(nil, {
                    ImageColor3 = Library.Theme["Text 2"]
                })
            end
        end)

        local n1 = 0

        ConfigOption.NewConfig:Connect("MouseButton1Down", function()
            selected:Select(not selected.Selected)

            local now = tick()

            if now - n1 <= 0.25 then
                ConfigOption.ConfigName.Instance.Interactable = true
                ConfigOption.ConfigName.Instance:CaptureFocus()
            end

            n1 = now
        end)
        ConfigOption.OverwriteButton:Connect("MouseButton1Down", function()
            selected:Overwrite()
        end)
        ConfigOption.AutoLoadButton:Connect("MouseButton1Down", function()
            selected:ToggleAutoLoad()
        end)
ConfigOption.ConfigName:Connect("Focused", function()
    local RenderStepped
    local Text = selected.Text

    RenderStepped = ConfigOption.ConfigName.Instance.FocusLost:Connect(function()
        local Text2 = ConfigOption.ConfigName.Instance.Text

        if Text2 == Text then
            RenderStepped:Disconnect()
            ConfigOption.ConfigName.Instance.Interactable = false

            return
        end

        selected.Text = Text2

        local ConfigFileName = "/" .. Text .. ".json"
        local ConfigPath = Library:GetFolder() .. ConfigFileName

        selected.File = Library:GetFolder() .. "/" .. Text2 .. ".json"

        if isfile(ConfigPath) then
            local ConfigData = readfile(ConfigPath)

            writefile(selected.File, ConfigData)
            delfile(ConfigPath)
        end

        RenderStepped:Disconnect()
        ConfigOption.ConfigName.Instance.Interactable = false
        Items["ConfigText"].Instance.Text = selected.Text
    end)
end)
selected.Overwrite = function()
    if isfile(Library:GetFolder() .. "/" .. selected.Text .. ".json") then
        writefile(Library:GetFolder() .. "/" .. selected.Text .. ".json", Library:GetConfig())
        Library:Notification("Overwrote config " .. selected.Text, "107463660077553", FromRGB(0, 255, 0), 5)
    end
end
        selected.ToggleAutoLoad = function()
            local AutoLoadPath = Library:GetFolder() .. "/autoload.txt"
            local AutoLoadEnabled = false

            if isfile(AutoLoadPath) and readfile(AutoLoadPath) == selected.Text then
                AutoLoadEnabled = true
            end

            if AutoLoadEnabled then
                writefile(AutoLoadPath, "")
                ConfigOption.AutoLoadButton:ChangeItemTheme({
                    ImageColor3 = "Text 2"
                })
                ConfigOption.AutoLoadButton:Tween(nil, {
                    ImageColor3 = Library.Theme["Text 2"]
                })
                Library:Notification("Disabled autoload for " .. selected.Text, "93209682414397", FromRGB(255, 0, 0), 5)
            else
                writefile(AutoLoadPath, selected.Text)
                ConfigOption.AutoLoadButton:ChangeItemTheme({
                    ImageColor3 = "Accent"
                })
                ConfigOption.AutoLoadButton:Tween(nil, {
                    ImageColor3 = Library.Theme.Accent
                })
                Library:Notification("Enabled autoload for " .. selected.Text, "93209682414397", FromRGB(0, 255, 0), 5)

                for _, config in pairs(configHeader.Configs) do
                    if config ~= selected then
                        if config.AutoLoadButton then
                            config.AutoLoadButton:ChangeItemTheme({
                                ImageColor3 = "Text 2"
                            })
                            config.AutoLoadButton:Tween(nil, {
                                ImageColor3 = Library.Theme["Text 2"]
                            })
                        end
                    end
                end
            end
        end
        selected.Select = function(self, Value)
            if Value then
                selected.Selected = true

                for _, config in pairs(configHeader.Configs) do
                    config:Select(false)
                end

                ConfigOption.NewConfig:ChangeItemTheme({
                    BackgroundColor3 = "Hover Element"
                })
                ConfigOption.NewConfig:Tween(nil, {
                    BackgroundColor3 = Library.Theme["Hover Element"]
                })
                ConfigOption.Stroke:ChangeItemTheme({
                    Color = "Accent"
                })
                ConfigOption.Stroke:Tween(nil, {
                    Color = Library.Theme.Accent
                })
                configHeader.Selected = selected
                Items["ConfigText"].Instance.Text = selected.Text
            else
                selected.Selected = false
                ConfigOption.NewConfig:ChangeItemTheme({
                    BackgroundColor3 = "Element"
                })
                ConfigOption.NewConfig:Tween(nil, {
                    BackgroundColor3 = Library.Theme.Element
                })
                ConfigOption.Stroke:ChangeItemTheme({
                    Color = "Outline 2"
                })
                ConfigOption.Stroke:Tween(nil, {
                    Color = Library.Theme["Outline 2"]
                })
            end
        end
        selected.Load = function()
    if not selected.File then
        selected.File = Library:GetFolder() .. "/" .. selected.Text .. ".json"
    end

    local ConfigData = readfile(selected.File)

    if not ConfigData then
        return
    end

    local Success, Result = Library:LoadConfig(ConfigData)

    if not Success then
        return Library:Notification("Failed to load config, report this to the devs:\n" .. Result, "83016346682572", FromRGB(255, 0, 0), 5)
    end

    selected:Select(true)
    Library:Notification("Successfully loaded config", "107463660077553", FromRGB(0, 255, 0), 5)
end
    selected.Remove = function()
        ConfigOption.NewConfig:Clean()
        TableRemove(configHeader.Configs, TableFind(configHeader.Configs, selected))
    end
    selected.Text = ConfigOption.ConfigName.Instance.Text
    selected.Object = ConfigOption.NewConfig
    selected.AutoLoadButton = ConfigOption.AutoLoadButton

    if isfile(Library:GetFolder() .. "/autoload.txt") and readfile(Library:GetFolder() .. "/autoload.txt") == selected.Text then
        ConfigOption.AutoLoadButton:ChangeItemTheme({
            ImageColor3 = "Accent"
        })
        ConfigOption.AutoLoadButton:Tween(nil, {
            ImageColor3 = Library.Theme.Accent
        })
    end

    if not isfile(Library:GetFolder() .. "/" .. selected.Text .. ".json") then
        writefile(Library:GetFolder() .. "/" .. selected.Text .. ".json", Library:GetConfig())
        selected.File = Library:GetFolder() .. "/" .. selected.Text .. ".json"
    end

    TableInsert(configHeader.Configs, selected)

    return selected
end
    Items["PlusIcon"]:Connect("MouseButton1Down", function()
        Items["PlusIcon"]:ChangeItemTheme({
            ImageColor3 = "Accent"
        })
        Items["PlusIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Accent
        })
        configHeader:AddConfig()
        task.wait(0.1)
        Items["PlusIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["PlusIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)
    Items["DeleteIcon"]:Connect("MouseButton1Down", function()
        Items["DeleteIcon"]:ChangeItemTheme({
            ImageColor3 = "Accent"
        })
        Items["DeleteIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Accent
        })

if configHeader.Selected then
    if isfile(Library:GetFolder() .. "/" .. configHeader.Selected.Text .. ".json") then
        delfile(Library:GetFolder() .. "/" .. configHeader.Selected.Text .. ".json")
        configHeader.Selected:Remove()
        configHeader.Selected = nil
        Items["ConfigText"].Instance.Text = "None"
    end
end

        task.wait(0.1)
        Items["DeleteIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["DeleteIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)
    Items["RefreshIcon"]:Connect("MouseButton1Down", function()
        Items["RefreshIcon"]:ChangeItemTheme({
            ImageColor3 = "Accent"
        })
        Items["RefreshIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme.Accent
        })

        for _, config in pairs(configHeader.Configs) do
            if config.Object and config.Object.Instance then
                config.Object.Instance:Destroy()
            end
        end

        configHeader.Configs = {}
        configHeader.Selected = nil

        local Configs = Library:RefreshConfigsList()

        for _, v in ipairs(Configs) do
            if type(v) == "table" then
                configHeader:AddConfig(v.name, v.id)
            else
                configHeader:AddConfig(v)
            end
        end

        task.wait(0.1)
        Items["RefreshIcon"]:ChangeItemTheme({
            ImageColor3 = "Text 2"
        })
        Items["RefreshIcon"]:Tween(nil, {
            ImageColor3 = Library.Theme["Text 2"]
        })
    end)

    local Configs = Library:RefreshConfigsList()

    for _, v in ipairs(Configs) do
        if type(v) == "table" then
            configHeader:AddConfig(v.name, v.id)
        else
            configHeader:AddConfig(v)
        end
    end

    Library:Connect(Items["SearchInput"].Instance:GetPropertyChangedSignal("Text"), function()
        for _, config in pairs(configHeader.Configs) do
            if StringFind(StringLower(config.Text), StringLower(Items["SearchInput"].Instance.Text)) then
                config.Object.Instance.Visible = true
            else
                config.Object.Instance.Visible = false
            end
        end
    end)
    Window.ConfigHeader = configHeader
    Window.Items = Items

    local Debounce = false

    Window.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        Window.IsOpen = IsOpen
        Debounce = true

        if Window.IsOpen then
            Items["MainFrame"].Instance.Visible = true
        end

        local descendants = Items["MainFrame"].Instance:GetDescendants()

        TableInsert(descendants, Items["MainFrame"].Instance)

        local FadeTween

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        FadeTween = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    FadeTween = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        if FadeTween then
            FadeTween.Tween.Completed:Connect(function()
                Debounce = false
                Items["MainFrame"].Instance.Visible = Window.IsOpen
            end)
        else
            Debounce = false
            Items["MainFrame"].Instance.Visible = Window.IsOpen
        end
    end
    Library:Connect(UserInputService.InputBegan, function(Input)
        if tostring(Input.KeyCode) == Library.MenuKeybind or tostring(Input.UserInputType) == Library.MenuKeybind then
            Window:SetOpen(not Window.IsOpen)

            for _, v in Library.OpenFrames, nil, nil do
                v:SetOpen(false)
            end

            Window.ConfigHeader:SetOpen(false)
        end
    end)

    task.wait()
    Window:SetOpen(true)

    return setmetatable(Window, Library)
end
Library.Group = function(self, Data)
    local Group = {
        Group = Instances:Create("TextLabel", {
            Parent = self.Items["Pages"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme.Text,
            TextTransparency = 0.7,
            Text = Data:upper(),
            Size = UDim2New(0, 0, 0, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BorderColor3 = FromRGB(0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 15
        }):AddToTheme({
            TextColor3 = "Text"
        })
    }
end
Library.Page = function(self, Data)
    local Data = Data or {}
    local Page = {
        Window = self,
        Name = Data.Name or Data.name or "Page",
        Icon = Data.Icon or Data.icon or "104155143774171",
        Items = {},
        SubPages = {},
        Sections = {},
        ColumnsData = {},
        Columns = Data.Columns or Data.columns or 2,
        Active = false
    }
    local Items = { } do
        Items["Inactive"] = Instances:Create("Frame", {
            Parent = Page.Window.Items["Pages"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 25),
            BorderColor3 = FromRGB(0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = Library.Theme.Text,
            ClipsDescendants = false
        })
    end

    Items["InactiveButton"] = Instances:Create("TextButton", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Size = UDim2New(1, 0, 0, 35),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = FromRGB(32, 38, 46)
    }):AddToTheme({
        BackgroundColor3 = "Page Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["InactiveButton"].Instance,
        Name = "\0"
    })
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["InactiveButton"].Instance,
        Name = "\0",
        ImageTransparency = 0.55000001192092896,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://" .. Page.Icon,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 10, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["InactiveButton"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        TextTransparency = 0.55000001192092896,
        Text = Page.Name,
        Size = UDim2New(0, 0, 0, 15),
        AnchorPoint = Vector2New(0, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 40, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Items["SubTabs"] = Instances:Create("Frame", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        Visible = false,
        BorderColor3 = FromRGB(0, 0, 0),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0, 35),
        Size = UDim2New(1, 0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Library.Theme.Text
    }):AddToTheme({
        BackgroundColor3 = "Text"
    })
    Instances:Create("UIListLayout", {
        Parent = Items["SubTabs"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Instances:Create("UIPadding", {
        Parent = Items["SubTabs"].Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 5),
        PaddingLeft = UDimNew(0, 25)
    })
    Items["Page"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        Position = UDim2New(0, 0, 0, 50),
        Size = UDim2New(1, 0, 1, -50),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    })
    Items["Columns"] = Instances:Create("Frame", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, 0),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    })
    Items["Stroke"] = Instances:Create("UIStroke", {
        Parent = Items["InactiveButton"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        Transparency = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Items["Stroke"]:AddToTheme({
        Color = "Outline 2"
    })
    Page.Items = Items

    function Page:InitializeColumns()
        if self.ColumnsData[1] then
            return
        end

        Instances:Create("UIListLayout", {
            Parent = self.Items["Columns"].Instance,
            Name = "\0",
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDimNew(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder
        })

        for Index = 1, self.Columns do
            local NewColumn = Instances:Create("ScrollingFrame", {
                Parent = self.Items["Columns"].Instance,
                Name = "\0",
                ScrollBarImageColor3 = FromRGB(0, 0, 0),
                Active = true,
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                ScrollBarThickness = 0,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Selectable = true,
                BackgroundTransparency = 1,
                Size = UDim2New(1, 0, 1, 0),
                BackgroundColor3 = Library.Theme.Text,
                BorderColor3 = FromRGB(0, 0, 0),
                BorderSizePixel = 0,
                CanvasSize = UDim2New(0, 0, 0, 0)
            })

            Instances:Create("UIPadding", {
                Parent = NewColumn.Instance,
                Name = "\0",
                PaddingBottom = UDimNew(0, 60),
                PaddingTop = UDimNew(0, 15),
                PaddingLeft = UDimNew(0, Index == 1 and 10 or 0),
                PaddingRight = UDimNew(0, Index == self.Columns and 10 or 0)
            })

            Instances:Create("UIListLayout", {
                Parent = NewColumn.Instance,
                Name = "\0",
                Padding = UDimNew(0, 16),
                SortOrder = Enum.SortOrder.LayoutOrder
            })

            self.ColumnsData[Index] = NewColumn
        end
    end

    local Debounce = false

    Page.Turn = function(self, IsOpen, Direction)
        if Debounce then
            return
        end

        Page.Active = IsOpen
        Debounce = true

        if not Direction then
            Items["SubTabs"].Instance.Visible = IsOpen
            Items["Page"].Instance.Visible = IsOpen
            Items["Page"].Instance.Parent = IsOpen and Page.Window.Items["Content"].Instance or Library.UnusedHolder.Instance
        end

        if Page.Active then
            Items["InactiveButton"]:Tween(nil, {
                BackgroundTransparency = 0
            })
            Items["Stroke"]:Tween(nil, {
                Transparency = 0
            })
            Items["Icon"]:ChangeItemTheme({
                ImageColor3 = "Accent"
            })
            Items["Icon"]:Tween(nil, {
                ImageColor3 = Library.Theme.Accent,
                ImageTransparency = 0
            })
            Items["Text"]:Tween(nil, {
                TextTransparency = 0
            })
        else
            Items["InactiveButton"]:Tween(nil, {
                BackgroundTransparency = 1
            })
            Items["Stroke"]:Tween(nil, {
                Transparency = 1
            })
            Items["Icon"]:ChangeItemTheme({
                ImageColor3 = "Text"
            })
            Items["Icon"]:Tween(nil, {
                ImageColor3 = Library.Theme.Text,
                ImageTransparency = 0.55
            })
            Items["Text"]:Tween(nil, {
                TextTransparency = 0.55
            })
        end

        local descendants = Items["Page"].Instance:GetDescendants()

        TableInsert(descendants, Items["Page"].Instance)

        local PageConnection

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        PageConnection = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    PageConnection = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        if PageConnection then
            Library:Connect(PageConnection.Tween.Completed, function()
                Debounce = false
            end)
        else
            Debounce = false
        end
    end
    Items["InactiveButton"]:Connect("MouseButton1Down", function()
        for _, v in Page.Window.Pages, nil, nil do
            if v == Page and Page.Active then
                return
            end

            v:Turn(v == Page)
        end
    end)

    if #Page.Window.Pages == 0 then
        Page:Turn(true)
    end

    TableInsert(Page.Window.Pages, Page)

    return setmetatable(Page, Library.Pages)
end
Library.Pages.SubPage = function(self, Data)
    local Data = Data or {}
    local Subpage = {
        Window = self.Window,
        Page = self,
        Name = Data.Name or Data.name or "SubPage",
        Icon = Data.Icon or Data.icon or "104155143774171",
        Active = false,
        Items = {},
        Sections = {},
        ColumnsData = {}
    }
    local Items = { } do
        Items["Inactive"] = Instances:Create("TextButton", {
            Parent = Subpage.Page.Items["SubTabs"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = FromRGB(0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Position = UDim2New(0, 0, 0, 25),
            Size = UDim2New(1, 0, 0, 35),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = FromRGB(32, 38, 46)
        })
    end

    Items["Inactive"]:AddToTheme({
        BackgroundColor3 = "Page Background"
    })
    Items["Stroke"] = Instances:Create("UIStroke", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        Transparency = 1,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Items["Stroke"]:AddToTheme({
        Color = "Outline 2"
    })
    Instances:Create("UICorner", {
        Parent = Items["Inactive"].Instance,
        Name = "\0"
    })
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        ImageTransparency = 0.55000001192092896,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://" .. Subpage.Icon,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 10, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    })
    Items["Icon"]:AddToTheme({
        ImageColor3 = "Text"
    })
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Inactive"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        TextTransparency = 0.55000001192092896,
        Text = Subpage.Name,
        Size = UDim2New(0, 0, 0, 15),
        AnchorPoint = Vector2New(0, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 40, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["Page"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Visible = false,
        ClipsDescendants = true,
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, 0),
        Position = UDim2New(0, 0, 0, 60),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Text
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalFlex = Enum.UIFlexAlignment.Fill,
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["LeftColumn"] = Instances:Create("ScrollingFrame", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        ScrollBarImageColor3 = FromRGB(0, 0, 0),
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = true,
        BackgroundTransparency = 1,
        Size = UDim2New(1, 0, 1, 0),
        BackgroundColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0)
    })
    Instances:Create("UIPadding", {
        Parent = Items["LeftColumn"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 60),
        PaddingTop = UDimNew(0, 15),
        PaddingLeft = UDimNew(0, 10)
    })
    Instances:Create("UIListLayout", {
        Parent = Items["LeftColumn"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 16),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["RightColumn"] = Instances:Create("ScrollingFrame", {
        Parent = Items["Page"].Instance,
        Name = "\0",
        ScrollBarImageColor3 = FromRGB(0, 0, 0),
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        ScrollBarThickness = 0,
        ScrollingDirection = Enum.ScrollingDirection.Y,
        Selectable = true,
        BackgroundTransparency = 1,
        Size = UDim2New(1, 0, 1, 0),
        BackgroundColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0)
    })
    Instances:Create("UIPadding", {
        Parent = Items["RightColumn"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 60),
        PaddingTop = UDimNew(0, 15),
        PaddingRight = UDimNew(0, 10)
    })
    Instances:Create("UIListLayout", {
        Parent = Items["RightColumn"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 16),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Subpage.ColumnsData[1] = Items["LeftColumn"]
    Subpage.ColumnsData[2] = Items["RightColumn"]

    local u452 = false

    Subpage.Turn = function(self, IsOpen)
        if u452 then
            return
        end

        Subpage.Active = IsOpen
        u452 = true
        Items["Page"].Instance.Visible = IsOpen
        Items["Page"].Instance.Parent = IsOpen and Subpage.Page.Items["Columns"].Instance or Library.UnusedHolder.Instance

        if Subpage.Active then
            Items["Inactive"]:Tween(nil, {
                BackgroundTransparency = 0
            })
            Items["Stroke"]:Tween(nil, {
                Transparency = 0
            })
            Items["Icon"]:ChangeItemTheme({
                ImageColor3 = "Accent"
            })
            Items["Icon"]:Tween(nil, {
                ImageColor3 = Library.Theme.Accent,
                ImageTransparency = 0
            })
            Items["Text"]:Tween(nil, {
                TextTransparency = 0
            })
            Items["Page"]:Tween(TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2New(0, 0, 0, 0)
            })
        else
            Items["Inactive"]:Tween(nil, {
                BackgroundTransparency = 1
            })
            Items["Stroke"]:Tween(nil, {
                Transparency = 1
            })
            Items["Icon"]:ChangeItemTheme({
                ImageColor3 = "Text"
            })
            Items["Icon"]:Tween(nil, {
                ImageColor3 = Library.Theme.Text,
                ImageTransparency = 0.55
            })
            Items["Text"]:Tween(nil, {
                TextTransparency = 0.55
            })
            Items["Page"]:Tween(TweenInfo.new(0.75, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
                Position = UDim2New(0, 0, 0, 60)
            })
        end

        local descendants = Items["Page"].Instance:GetDescendants()

        TableInsert(descendants, Items["Page"].Instance)

        local SubpageConnection

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        SubpageConnection = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    SubpageConnection = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        if SubpageConnection then
            Library:Connect(SubpageConnection.Tween.Completed, function()
                u452 = false
            end)
        else
            u452 = false
        end
    end
    Items["Inactive"]:Connect("MouseButton1Down", function()
        for _, v in Subpage.Page.SubPages, nil, nil do
            if v == Subpage and Subpage.Active then
                return
            end

            v:Turn(v == Subpage)
        end
    end)

    if #Subpage.Page.SubPages == 0 then
        Subpage:Turn(true)
    end

    TableInsert(Subpage.Page.SubPages, Subpage)

    return setmetatable(Subpage, Library.Pages)
end
Library.Pages.Section = function(self, Data)
    local Data = Data or {}

    if not self.ColumnsData or not self.ColumnsData[1] then
        self:InitializeColumns()
    end

    local Section = {
        Window = self.Window,
        Page = self,
        Name = Data.Name or Data.name or "Section",
        Side = Data.Side or Data.side or 1,
        IsFirstElement = false,
        IsLastElement = false,
        Items = {}
    }
    local Items = { } do
        Items["Section"] = Instances:Create("Frame", {
            Parent = Section.Page.ColumnsData[Section.Side].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 45),
            BorderColor3 = FromRGB(0, 0, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.Y
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        TextTransparency = 0.5,
        Text = Section.Name:upper(),
        TextStrokeTransparency = 1,
        Size = UDim2New(0, 0, 0, 15),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 8, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 14
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["InlineOutline"] = Instances:Create("Frame", {
        Parent = Items["Section"].Instance,
        Name = "\0",
        Size = UDim2New(1, 0, 0, 20),
        Position = UDim2New(0, 0, 0, 22),
        BorderColor3 = FromRGB(0, 0, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = Library.Theme["Outline 2"]
    }):AddToTheme({
        BackgroundColor3 = "Outline 2"
    })
    Instances:Create("UIPadding", {
        Parent = Items["InlineOutline"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 10)
    })
    Instances:Create("UICorner", {
        Parent = Items["InlineOutline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Items["Inline"] = Instances:Create("Frame", {
        Parent = Items["InlineOutline"].Instance,
        Name = "\0",
        Position = UDim2New(0, 1, 0, 1),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -2, 1, 8),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme["Section Background"]
    }):AddToTheme({
        BackgroundColor3 = "Section Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })
    Items["Content"] = Instances:Create("Frame", {
        Parent = Items["Inline"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 15, 0, 10),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -30, 0, 0),
        BorderSizePixel = 0
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Content"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Section.Items = Items
    TableInsert(Section.Page.Sections, Section)

    return setmetatable(Section, Library.Sections)
end
Library.Sections.Toggle = function(self, Data)
    local Data = Data or {}
    local Toggle = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "Toggle"
    }

    Toggle.Flag = Data.Flag or Data.flag or Library:NextFlag()
    Toggle.Default = Data.Default or Data.default or false
    Toggle.Callback = Data.Callback or Data.callback or function()
    end
    Toggle.Value = false

    local Items = { } do
        Items["Toggle"] = Instances:Create("TextButton", {
            Parent = Toggle.Section.Items["Content"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = FromRGB(0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0,
            TextSize = 14
        })
    end

    if Toggle.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Toggle"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Toggle.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Toggle"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Toggle"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Toggle"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Toggle"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Toggle.Name,
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["Indicator"] = Instances:Create("Frame", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, 0, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        ZIndex = 2,
        Size = UDim2New(0, 32, 0, 20),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Toggle
    }):AddToTheme({
        BackgroundColor3 = "Toggle"
    })
    Instances:Create("UICorner", {
        Parent = Items["Indicator"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Circle"] = Instances:Create("Frame", {
        Parent = Items["Indicator"].Instance,
        Name = "\0",
        Position = UDim2New(0, 2, 0, 2),
        ZIndex = 2,
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 16, 0, 16),
        BorderSizePixel = 0,
        BackgroundColor3 = FromRGB(125, 135, 145)
    })
    Instances:Create("UICorner", {
        Parent = Items["Circle"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["SubElements"] = Instances:Create("Frame", {
        Parent = Items["Toggle"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(1, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2New(1, -40, 0.5, 0),
        Size = UDim2New(0, 0, 0, 20),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X
    })
    Instances:Create("UIListLayout", {
        Parent = Items["SubElements"].Instance,
        Name = "\0",
        VerticalAlignment = Enum.VerticalAlignment.Center,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDimNew(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Items["Toggle"]:OnHover(function()
        if Toggle.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Toggle"].Instance)
        end
    end)
    Items["Toggle"]:OnHoverLeave(function()
        if Toggle.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    Toggle.Get = function()
        return Toggle.Value
    end
    Toggle.Set = function(self, Value)
        Toggle.Value = Value
        Library.Flags[Toggle.Flag] = Value

        if Toggle.Value then
            Items["Indicator"]:ChangeItemTheme({
                BackgroundColor3 = "Accent"
            })
            Items["Indicator"]:Tween(nil, {
                BackgroundColor3 = Library.Theme.Accent
            })
            Items["Circle"]:Tween(nil, {
                BackgroundColor3 = FromRGB(255, 255, 255),
                Position = UDim2New(1, -2, 0, 2),
                AnchorPoint = Vector2New(1, 0)
            })
        else
            Items["Indicator"]:ChangeItemTheme({
                BackgroundColor3 = "Toggle"
            })
            Items["Indicator"]:Tween(nil, {
                BackgroundColor3 = Library.Theme.Toggle
            })
            Items["Circle"]:Tween(nil, {
                BackgroundColor3 = FromRGB(125, 135, 145),
                Position = UDim2New(0, 2, 0, 2),
                AnchorPoint = Vector2New(0, 0)
            })
        end

        if Toggle.Callback then
            Library:SafeCall(Toggle.Callback, Toggle.Value)
        end
    end
    Toggle.SetVisibility = function(self, Visible)
        Items["Toggle"].Instance.Visible = Visible
    end
    Toggle.Colorpicker = function(self, Data)
        local Data = Data or {}
        local Colorpicker = {
            Window = Toggle.Window,
            Page = Toggle.Page,
            Section = Toggle.Section,
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
            Callback = Data.Callback or Data.callback or function()
            end,
            Alpha = Data.Alpha or Data.alpha or false
        }
        local Colorpicker = Library:CreateColorpicker({
            Parent = Items["SubElements"],
            Page = Colorpicker.Page,
            Section = Colorpicker.Section,
            Flag = Colorpicker.Flag,
            Default = Colorpicker.Default,
            Callback = Colorpicker.Callback,
            Alpha = Colorpicker.Alpha
        })

        return Colorpicker
    end
    Toggle.Keybind = function(self, Data)
        local Data = Data or {}
        local Keybind = {
            Window = Toggle.Window,
            Page = Toggle.Page,
            Section = Toggle.Section,
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Enum.KeyCode.E,
            Callback = Data.Callback or Data.callback or function()
            end,
            Mode = Data.Mode or Data.mode or "Toggle"
        }
        local Keybind = Library:CreateKeybind({
            Parent = Items["SubElements"],
            Page = Keybind.Page,
            Section = Keybind.Section,
            Flag = Keybind.Flag,
            Default = Keybind.Default,
            Mode = Keybind.Mode,
            Callback = Keybind.Callback
        })

        return Keybind
    end
Toggle.Settings = function(self, Options)
    local ToggleSettings = {
        IsOpen = false,
        IsSettings = {},
        Items = {}
    }

    Items["SettingsButton"] = Instances:Create("ImageButton", {
        Parent = Items["SubElements"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AutoButtonColor = false,
        Image = "rbxassetid://116690698569160",
        BackgroundTransparency = 1,
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })

    Items["SettingsWindow"] = Instances:Create("TextButton", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        Active = false,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        Size = UDim2New(0, 295, 0, 213),
        Position = UDim2New(0, 314, 0, 183),
        Selectable = false,
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = FromRGB(15, 16, 21)
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })

    Instances:Create("UICorner", {
        Parent = Items["SettingsWindow"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 15)
    })

    Items["Holder"] = Instances:Create("ScrollingFrame", {
        Parent = Items["SettingsWindow"].Instance,
        Name = "\0",
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0),
        ScrollBarImageColor3 = FromRGB(151, 150, 162),
        MidImage = "rbxassetid://81680855285439",
        BorderColor3 = FromRGB(0, 0, 0),
        ScrollBarThickness = 2,
        Size = UDim2New(1, -24, 1, -24),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 12, 0, 12),
        BottomImage = "rbxassetid://81680855285439",
        TopImage = "rbxassetid://81680855285439"
    }):AddToTheme({
        ScrollBarImageColor3 = "Text 2"
    })

    Instances:Create("UIPadding", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        PaddingBottom = UDimNew(0, 10),
        PaddingRight = UDimNew(0, 10)
    })

    Instances:Create("UIListLayout", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 10),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    Items["Content"] = Items["Holder"]
    ToggleSettings.Items = Items

    local Debounce = false
    local RenderStepped

    ToggleSettings.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        ToggleSettings.IsOpen = IsOpen
        Debounce = true

        if ToggleSettings.IsOpen then
            Items["SettingsWindow"].Instance.Visible = true
            Items["SettingsWindow"].Instance.Parent = Library.Holder.Instance
            Items["SettingsWindow"].Instance.Size = UDim2New(0, 295, 0, 0)
            Items["SettingsWindow"].Instance.Position = UDim2New(0, Items["SettingsButton"].Instance.AbsolutePosition.X, 0, Items["SettingsButton"].Instance.AbsolutePosition.Y + Items["SettingsButton"].Instance.AbsoluteSize.Y + 10)
            Items["SettingsWindow"]:Tween(nil, {
                Size = UDim2New(0, 295, 0, Options or 213)
            })

            for _, v in pairs(Library.OpenFrames) do
                if v ~= ToggleSettings then
                    v:SetOpen(false)
                end
            end

            Library.OpenFrames[ToggleSettings] = ToggleSettings
        else
            if Library.OpenFrames[ToggleSettings] then
                Library.OpenFrames[ToggleSettings] = nil
            end

            if RenderStepped then
                RenderStepped:Disconnect()
                RenderStepped = nil
            end

            Items["SettingsWindow"]:Tween(nil, {
                Size = UDim2New(0, 295, 0, 0)
            })
        end

        local descendants = Items["SettingsWindow"].Instance:GetDescendants()

        TableInsert(descendants, Items["SettingsWindow"].Instance)

        local FadeTween

        for _, v in pairs(descendants) do
            local property = Tween:GetProperty(v)

            if property then
                if not v.ClassName:find("UI") then
                    v.ZIndex = ToggleSettings.IsOpen and 4 or 1
                end

                if type(property) == "table" then
                    for _, Property in pairs(property) do
                        FadeTween = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    FadeTween = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        FadeTween.Tween.Completed:Connect(function()
            Debounce = false
            Items["SettingsWindow"].Instance.Visible = ToggleSettings.IsOpen
            task.wait(0.2)
            Items["SettingsWindow"].Instance.Parent = not ToggleSettings.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
            task.wait(0.1)

            if ToggleSettings.IsOpen then
                RenderStepped = Library:Connect(RunService.RenderStepped, function()
                    Items["SettingsWindow"].Instance.Position = UDim2New(0, Items["SettingsButton"].Instance.AbsolutePosition.X, 0, Items["SettingsButton"].Instance.AbsolutePosition.Y + Items["SettingsButton"].Instance.AbsoluteSize.Y + 10)
                    Items["SettingsWindow"].Instance.Size = UDim2New(0, 295, 0, Options or 213)
                end)
            else
                if RenderStepped then
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end

                Items["SettingsWindow"]:Tween(nil, {
                    Size = UDim2New(0, 295, 0, 0)
                })
            end
        end)
    end

    Items["SettingsButton"]:Connect("MouseButton1Down", function()
        ToggleSettings:SetOpen(not ToggleSettings.IsOpen)
    end)

    Library:Connect(UserInputService.InputBegan, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and ToggleSettings.IsOpen and not Library:IsMouseOverFrame(Items["SettingsWindow"]) then
            if Library.IsASubWindowOpenLul then
                return
            end

            ToggleSettings:SetOpen(false)
        end
    end)

    return setmetatable(ToggleSettings, Library.Sections)
end
    Items["Toggle"]:Connect("MouseButton1Down", function()
        Toggle:Set(not Toggle.Value)
    end)
    Toggle:Set(Toggle.Default)
    Library.SetFlags[Toggle.Flag] = function(Value)
        Toggle:Set(Value)
    end

    return Toggle
end
Library.Sections.Button = function(self, Data)
    local Data = Data or {}
    local Button = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "Button",
        Callback = Data.Callback or Data.callback or function()
        end
    }
    local Items = { } do
        Items["Button"] = Instances:Create("Frame", {
            Parent = Button.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 40),
            BorderSizePixel = 0
        })
    end

    Items["RealButton"] = Instances:Create("TextButton", {
        Parent = Items["Button"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(0, 0.5),
        Position = UDim2New(0, 0, 0.5, 0),
        Size = UDim2New(1, 0, 0, 30),
        BorderSizePixel = 0,
        ZIndex = 2,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UIStroke", {
        Parent = Items["RealButton"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Instances:Create("UICorner", {
        Parent = Items["RealButton"].Instance,
        Name = "\0"
    })
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["RealButton"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Button.Name,
        ZIndex = 2,
        AnchorPoint = Vector2New(0.5, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0.5, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })

    if Button.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Button"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Button.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Button"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Button"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Button"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Button"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["RealButton"]:OnHover(function()
        if Button.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["RealButton"].Instance)
        end
    end)
    Items["RealButton"]:OnHoverLeave(function()
        if Button.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    Button.SetVisibility = function(self, Visible)
        Items["Button"].Instance.Visible = Visible
    end
    Button.Press = function()
        Items["RealButton"]:ChangeItemTheme({
            BackgroundColor3 = "Accent"
        })
        Items["RealButton"]:Tween(nil, {
            BackgroundColor3 = Library.Theme.Accent
        })
        task.wait(0.1)
        Library:SafeCall(Button.Callback)
        Items["RealButton"]:ChangeItemTheme({
            BackgroundColor3 = "Element"
        })
        Items["RealButton"]:Tween(nil, {
            BackgroundColor3 = Library.Theme.Element
        })
    end
    Items["RealButton"]:Connect("MouseButton1Down", function()
        Button:Press()
    end)

    return Button
end
Library.Sections.Slider = function(self, Data)
    local Data = Data or {}
    local Slider = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "Slider"
    }

    Slider.Flag = Data.Flag or Data.flag or Library:NextFlag()
    Slider.Min = Data.Min or Data.min or 0
    Slider.Default = Data.Default or Data.default or 0
    Slider.Max = Data.Max or Data.max or 100
    Slider.Suffix = Data.Suffix or Data.suffix or ""
    Slider.Decimals = Data.Decimals or Data.decimals or 1

    local Callback = Data.Callback or Data.callback

    Slider.Callback = Callback or function()
    end
    Slider.Value = 0
    Slider.Sliding = false

    local Items = { } do
        Items["Slider"] = Instances:Create("Frame", {
            Parent = Slider.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Slider.Name,
        AnchorPoint = Vector2New(0, 0.5),
        ZIndex = 2,
        Size = UDim2New(0, 120, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Instances:Create("UIGradient", {
        Parent = Items["Text"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.676, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    })
    Items["Value"] = Instances:Create("TextBox", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme["Text 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "180*",
        Position = UDim2New(1, 0, 0.5, 0),
        AnchorPoint = Vector2New(1, 0.5),
        Size = UDim2New(0, 0, 0, 20),
        PlaceholderColor3 = FromRGB(125, 125, 125),
        BorderSizePixel = 0,
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16,
        BackgroundColor3 = FromRGB(25, 25, 37)
    }):AddToTheme({
        TextColor3 = "Text 2"
    })
    Instances:Create("UICorner", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 5)
    })
    Instances:Create("UIStroke", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Instances:Create("UIPadding", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 5),
        PaddingLeft = UDimNew(0, 5)
    })
    Items["RealSlider"] = Instances:Create("TextButton", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(0, -20, 0.5, 0),
        Size = UDim2New(0, 95, 0, 5),
        BorderSizePixel = 0,
        ZIndex = 2,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Accent"] = Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Accent
    }):AddToTheme({
        BackgroundColor3 = "Accent"
    })
    Instances:Create("UICorner", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Dragger"] = Instances:Create("Frame", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, 5, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 12, 0, 12),
        ZIndex = 2,
        BorderSizePixel = 0
    })
    Instances:Create("UICorner", {
        Parent = Items["Dragger"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })

    if Slider.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Slider.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Slider"]:OnHover(function()
        if Slider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Slider"].Instance)
        end
    end)
    Items["Slider"]:OnHoverLeave(function()
        if Slider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    Slider.Get = function()
        return Slider.Value
    end
    Slider.SetVisibility = function(self, Visible)
        Items["Slider"].Instance.Visible = Visible
    end
    Slider.Set = function(self, Value)
        Slider.Value = Library:Round(MathClamp(Value, Slider.Min, Slider.Max), Slider.Decimals)
        Library.Flags[Slider.Flag] = Slider.Value

        if Slider.Sliding then
            Items["Accent"].Instance.Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
        else
            Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2New((Slider.Value - Slider.Min) / (Slider.Max - Slider.Min), 0, 1, 0)
            })
        end

        Items["Value"].Instance.Text = StringFormat("%s%s", Slider.Value, Slider.Suffix)

        if Slider.Callback then
            Library:SafeCall(Slider.Callback, Slider.Value)
        end
    end

    local RenderStepped

    Items["RealSlider"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Slider.Sliding = true
            Slider:Set((Slider.Max - Slider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + Slider.Min)

            if connection then
                return
            end

            connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Slider.Sliding = false
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end
    end)
    Library:Connect(UserInputService.InputChanged, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and Slider.Sliding then
            Slider:Set((Slider.Max - Slider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + Slider.Min)
        end
    end)
    Items["Value"]:Connect("Focused", function()
        Items["Value"]:ChangeItemTheme({
            TextColor3 = "Text"
        })
        Items["Value"]:Tween(nil, {
            TextColor3 = Library.Theme.Text
        })
        Items["Value"].Instance.Text = StringFormat("%s", tostring(Slider.Value))
    end)
    Items["Value"]:Connect("FocusLost", function()
        Items["Value"]:ChangeItemTheme({
            TextColor3 = "Text 2"
        })
        Items["Value"]:Tween(nil, {
            TextColor3 = Library.Theme["Text 2"]
        })
        Slider:Set(tonumber(Items["Value"].Instance.Text))
    end)

    if Slider.Default then
        Slider:Set(Slider.Default)
    end

    Library.SetFlags[Slider.Flag] = function(Value)
        Slider:Set(Value)
    end

    return Slider
end
Library.Sections.TextSlider = function(self, Data)
    local Data = Data or {}
    local TextSlider = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "TextSlider"
    }

    TextSlider.Flag = Data.Flag or Data.flag or Library:NextFlag()
    TextSlider.Min = Data.Min or Data.min or 0
    TextSlider.Default = Data.Default or Data.default or 0
    TextSlider.Max = Data.Max or Data.max or 100
    TextSlider.Suffix = Data.Suffix or Data.suffix or ""
    TextSlider.Decimals = Data.Decimals or Data.decimals or 1
    TextSlider.TextProps = Data.TextProps or Data.textprops or nil
    TextSlider.Callback = Data.Callback or Data.callback or function()
    end
    TextSlider.Value = 0
    TextSlider.Sliding = false

    local Items = { } do
        Items["Slider"] = Instances:Create("Frame", {
            Parent = TextSlider.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = TextSlider.Name,
        AnchorPoint = Vector2New(0, 0.5),
        ZIndex = 2,
        Size = UDim2New(0, 120, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Instances:Create("UIGradient", {
        Parent = Items["Text"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.676, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    })
    Items["ValueHolder"] = Instances:Create("Frame", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, -5, 0.5, 0),
        Size = UDim2New(1, -125, 1, 0),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = false
    })
    Instances:Create("UIListLayout", {
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimNew(0, 10)
    })
    Items["Value"] = Instances:Create("TextBox", {
        LayoutOrder = 2,
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme["Text 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "180*",
        Position = UDim2New(1, 0, 0.5, 0),
        AnchorPoint = Vector2New(1, 0.5),
        Size = UDim2New(0, 0, 0, 20),
        PlaceholderColor3 = FromRGB(125, 125, 125),
        BorderSizePixel = 0,
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 16,
        BackgroundColor3 = FromRGB(25, 25, 37)
    }):AddToTheme({
        TextColor3 = "Text 2"
    })
    Instances:Create("UICorner", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 5)
    })
    Instances:Create("UIStroke", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Instances:Create("UIPadding", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 5),
        PaddingLeft = UDimNew(0, 5)
    })
    Items["RealSlider"] = Instances:Create("TextButton", {
        LayoutOrder = 1,
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(0, -10, 0.5, 0),
        Size = UDim2New(0, 110, 0, 5),
        BorderSizePixel = 0,
        ZIndex = 2,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Accent"] = Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, 0, 1, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Accent
    }):AddToTheme({
        BackgroundColor3 = "Accent"
    })
    Instances:Create("UICorner", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Dragger"] = Instances:Create("Frame", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, 5, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 12, 0, 12),
        ZIndex = 2,
        BorderSizePixel = 0
    })
    Instances:Create("UICorner", {
        Parent = Items["Dragger"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })

    if TextSlider.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif TextSlider.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Slider"]:OnHover(function()
        if TextSlider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Slider"].Instance)
        end
    end)
    Items["Slider"]:OnHoverLeave(function()
        if TextSlider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    TextSlider.Get = function()
        return TextSlider.Value
    end
    TextSlider.SetVisibility = function(self, Visible)
        Items["Slider"].Instance.Visible = Visible
    end
    TextSlider.Set = function(self, Value)
        TextSlider.Value = Library:Round(MathClamp(Value, TextSlider.Min, TextSlider.Max), TextSlider.Decimals)
        Library.Flags[TextSlider.Flag] = TextSlider.Value

        if TextSlider.Sliding then
            Items["Accent"].Instance.Size = UDim2New((TextSlider.Value - TextSlider.Min) / (TextSlider.Max - TextSlider.Min), 0, 1, 0)
        else
            Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2New((TextSlider.Value - TextSlider.Min) / (TextSlider.Max - TextSlider.Min), 0, 1, 0)
            })
        end

        local text = StringFormat("%s%s", TextSlider.Value, TextSlider.Suffix)

        if TextSlider.TextProps and TextSlider.TextProps[TextSlider.Value] then
            text = TextSlider.TextProps[TextSlider.Value]
        end

        Items["Value"].Instance.Text = text

        if TextSlider.Callback then
            Library:SafeCall(TextSlider.Callback, TextSlider.Value)
        end
    end

    local RenderStepped

    Items["RealSlider"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            TextSlider.Sliding = true
            TextSlider:Set((TextSlider.Max - TextSlider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + TextSlider.Min)

            if connection then
                return
            end

            connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    TextSlider.Sliding = false
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end
    end)
    Library:Connect(UserInputService.InputChanged, function(Input)
        if (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) and TextSlider.Sliding then
            TextSlider:Set((TextSlider.Max - TextSlider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + TextSlider.Min)
        end
    end)
    Items["Value"]:Connect("Focused", function()
        Items["Value"]:ChangeItemTheme({
            TextColor3 = "Text"
        })
        Items["Value"]:Tween(nil, {
            TextColor3 = Library.Theme.Text
        })
        Items["Value"].Instance.Text = StringFormat("%s", tostring(TextSlider.Value))
    end)
    Items["Value"]:Connect("FocusLost", function()
        Items["Value"]:ChangeItemTheme({
            TextColor3 = "Text 2"
        })
        Items["Value"]:Tween(nil, {
            TextColor3 = Library.Theme["Text 2"]
        })
        TextSlider:Set(tonumber(Items["Value"].Instance.Text))
    end)

    if TextSlider.Default then
        TextSlider:Set(TextSlider.Default)
    end

    Library.SetFlags[TextSlider.Flag] = function(Value)
        TextSlider:Set(Value)
    end

    return TextSlider
end
Library.Sections.RangedSlider = function(self, Data)
    local Data = Data or {}
    local RangedSlider = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "Ranged Slider"
    }

    RangedSlider.Flag = Data.Flag or Data.flag or Library:NextFlag()
    RangedSlider.Min = Data.Min or Data.min or 0
    RangedSlider.Default = Data.Default or Data.default or {
        Min = 10,
        Max = 20
    }
    RangedSlider.Max = Data.Max or Data.max or 100
    RangedSlider.Suffix = Data.Suffix or Data.suffix or ""
    RangedSlider.Decimals = Data.Decimals or Data.decimals or 1
    RangedSlider.Callback = Data.Callback or Data.callback or function()
    end
    RangedSlider.Value = {
        Min = 0,
        Max = 0
    }
    RangedSlider.SlidingMin = false
    RangedSlider.SlidingMax = false

    local Items = { } do
        Items["Slider"] = Instances:Create("Frame", {
            Parent = RangedSlider.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = RangedSlider.Name,
        AnchorPoint = Vector2New(0, 0.5),
        ZIndex = 2,
        Size = UDim2New(0, 120, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Instances:Create("UIGradient", {
        Parent = Items["Text"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.676, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    })
    Items["ValueHolder"] = Instances:Create("Frame", {
        Parent = Items["Slider"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, -5, 0.5, 0),
        Size = UDim2New(0, 0, 1, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Active = false
    })
    Instances:Create("UIListLayout", {
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDimNew(0, 10)
    })
    Items["Value"] = Instances:Create("TextLabel", {
        LayoutOrder = 2,
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme["Text 2"],
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "10 - 20",
        Position = UDim2New(1, 0, 0.5, 0),
        AnchorPoint = Vector2New(1, 0.5),
        Size = UDim2New(0, 0, 0, 20),
        BorderSizePixel = 0,
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        TextXAlignment = Enum.TextXAlignment.Right,
        TextSize = 16,
        BackgroundColor3 = FromRGB(25, 25, 37)
    }):AddToTheme({
        TextColor3 = "Text 2"
    })
    Instances:Create("UICorner", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 5)
    })
    Instances:Create("UIStroke", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Instances:Create("UIPadding", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 5),
        PaddingLeft = UDimNew(0, 5)
    })
    Items["RealSlider"] = Instances:Create("TextButton", {
        LayoutOrder = 1,
        Parent = Items["ValueHolder"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(0, -10, 0.5, 0),
        Size = UDim2New(0, 75, 0, 5),
        BorderSizePixel = 0,
        ZIndex = 2,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["Accent"] = Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0.5, 0, 1, 0),
        Position = UDim2New(0.25, 0, 0, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Accent
    }):AddToTheme({
        BackgroundColor3 = "Accent"
    })
    Instances:Create("UICorner", {
        Parent = Items["Accent"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["DraggerMin"] = Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0.5, 0.5),
        Position = UDim2New(0.25, 0, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 12, 0, 12),
        ZIndex = 3,
        BorderSizePixel = 0
    })
    Instances:Create("UICorner", {
        Parent = Items["DraggerMin"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })
    Items["DraggerMax"] = Instances:Create("Frame", {
        Parent = Items["RealSlider"].Instance,
        Name = "\0",
        AnchorPoint = Vector2New(0.5, 0.5),
        Position = UDim2New(0.75, 0, 0.5, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 12, 0, 12),
        ZIndex = 3,
        BorderSizePixel = 0
    })
    Instances:Create("UICorner", {
        Parent = Items["DraggerMax"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(1, 0)
    })

    if RangedSlider.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif RangedSlider.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Slider"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            ZIndex = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Slider"]:OnHover(function()
        if RangedSlider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Slider"].Instance)
        end
    end)
    Items["Slider"]:OnHoverLeave(function()
        if RangedSlider.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    RangedSlider.Get = function()
        return RangedSlider.Value
    end
    RangedSlider.SetVisibility = function(self, Visible)
        Items["Slider"].Instance.Visible = Visible
    end
    RangedSlider.Set = function(self, Value)
        if type(Value) == "table" then
            RangedSlider.Value.Min = Library:Round(MathClamp(Value.Min, RangedSlider.Min, RangedSlider.Max), RangedSlider.Decimals)
            RangedSlider.Value.Max = Library:Round(MathClamp(Value.Max, RangedSlider.Min, RangedSlider.Max), RangedSlider.Decimals)

            if RangedSlider.Value.Max < RangedSlider.Value.Min then
                if RangedSlider.SlidingMin then
                    RangedSlider.Value.Min = RangedSlider.Value.Max
                elseif RangedSlider.SlidingMax then
                    RangedSlider.Value.Max = RangedSlider.Value.Min
                end
            end
        end

        Library.Flags[RangedSlider.Flag] = RangedSlider.Value

        local Range = RangedSlider.Max - RangedSlider.Min
        local MinPercent = (RangedSlider.Value.Min - RangedSlider.Min) / Range
        local MaxPercent = (RangedSlider.Value.Max - RangedSlider.Min) / Range
        local FillPercent = MaxPercent - MinPercent

        if RangedSlider.SlidingMin or RangedSlider.SlidingMax then
            Items["Accent"].Instance.Position = UDim2New(MinPercent, 0, 0, 0)
            Items["Accent"].Instance.Size = UDim2New(FillPercent, 0, 1, 0)
            Items["DraggerMin"].Instance.Position = UDim2New(MinPercent, 0, 0.5, 0)
            Items["DraggerMax"].Instance.Position = UDim2New(MaxPercent, 0, 0.5, 0)
        else
            Items["Accent"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2New(MinPercent, 0, 0, 0),
                Size = UDim2New(FillPercent, 0, 1, 0)
            })
            Items["DraggerMin"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2New(MinPercent, 0, 0.5, 0)
            })
            Items["DraggerMax"]:Tween(TweenInfo.new(Library.Tween.Time, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Position = UDim2New(MaxPercent, 0, 0.5, 0)
            })
        end

        Items["Value"].Instance.Text = StringFormat("%s - %s %s", RangedSlider.Value.Min, RangedSlider.Value.Max, RangedSlider.Suffix)

        if RangedSlider.Callback then
            Library:SafeCall(RangedSlider.Callback, RangedSlider.Value)
        end
    end

    local RenderStepped

    Items["RealSlider"]:Connect("InputBegan", function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            local NewValue = (RangedSlider.Max - RangedSlider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + RangedSlider.Min

            if MathAbs(NewValue - RangedSlider.Value.Min) < MathAbs(NewValue - RangedSlider.Value.Max) then
                RangedSlider.SlidingMin = true
                RangedSlider:Set({
                    Min = NewValue,
                    Max = RangedSlider.Value.Max
                })
            else
                RangedSlider.SlidingMax = true
                RangedSlider:Set({
                    Min = RangedSlider.Value.Min,
                    Max = NewValue
                })
            end

            if connection then
                return
            end

            connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    RangedSlider.SlidingMin = false
                    RangedSlider.SlidingMax = false
                    connection:Disconnect()
                    connection = nil
                end
            end)
        end
    end)
    Library:Connect(UserInputService.InputChanged, function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            if RangedSlider.SlidingMin then
                RangedSlider:Set({
                    Min = (RangedSlider.Max - RangedSlider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + RangedSlider.Min,
                    Max = RangedSlider.Value.Max
                })
            elseif RangedSlider.SlidingMax then
                RangedSlider:Set({
                    Min = RangedSlider.Value.Min,
                    Max = (RangedSlider.Max - RangedSlider.Min) * ((Input.Position.X - Items["RealSlider"].Instance.AbsolutePosition.X) / Items["RealSlider"].Instance.AbsoluteSize.X) + RangedSlider.Min
                })
            end
        end
    end)

    if RangedSlider.Default then
        RangedSlider:Set(RangedSlider.Default)
    end

    Library.SetFlags[RangedSlider.Flag] = function(Value)
        RangedSlider:Set(Value)
    end

    return RangedSlider
end
Library.Sections.Dropdown = function(self, Options)
    local Options = Options or {}
    local Dropdown = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Options.Name or Options.name or "Dropdown"
    }

    Dropdown.Flag = Options.Flag or Options.flag or Library:NextFlag()
    Dropdown.Items = Options.Items or Options.Items or {
        "One",
        "Two",
        "Three"
    }
    Dropdown.Default = Options.Default or Options.default or nil
    Dropdown.Callback = Options.Callback or Options.callback or function()
    end
    Dropdown.Multi = Options.Multi or Options.multi or false
    Dropdown.MaxSize = Options.MaxSize or Options.maxsize or 85

    local Size = Options.Size or Options.size

    Dropdown.Size = Size or 105
    Dropdown.Value = {}
    Dropdown.Options = {}
    Dropdown.IsOpen = false

    local Items = { } do
        Items["Dropdown"] = Instances:Create("Frame", {
            Parent = Dropdown.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
    end

    Items["RealDropdown"] = Instances:Create("TextButton", {
        Parent = Items["Dropdown"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = FromRGB(0, 0, 0),
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        AnchorPoint = Vector2New(1, 0.5),
        Position = UDim2New(1, 0, 0.5, 0),
        ZIndex = 2,
        Size = UDim2New(0, Dropdown.Size, 0, 24),
        BorderSizePixel = 0,
        TextSize = 14,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("UIStroke", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["Value"] = Instances:Create("TextLabel", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "...",
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(1, -28, 0, 15),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        Position = UDim2New(0, 8, 0.5, 0),
        ZIndex = 2,
        BorderSizePixel = 0,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Instances:Create("UIGradient", {
        Parent = Items["Value"].Instance,
        Name = "\0",
        Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 0),
            NumberSequenceKeypoint.new(0.676, 0),
            NumberSequenceKeypoint.new(1, 1)
        })
    })
    Items["ArrowIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["RealDropdown"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme["Text 2"],
        ScaleType = Enum.ScaleType.Fit,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(1, 0.5),
        ZIndex = 2,
        Image = "rbxassetid://111436698580046",
        BackgroundTransparency = 1,
        Position = UDim2New(1, -8, 0.5, 0),
        Size = UDim2New(0, 9, 0, 5),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text 2"
    })
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Dropdown"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Dropdown.Name,
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        ZIndex = 2,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })

    if Dropdown.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Dropdown"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Dropdown.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Dropdown"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Dropdown"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Dropdown"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Dropdown"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["OptionHolder"] = Instances:Create("Frame", {
        Parent = Library.UnusedHolder.Instance,
        Name = "\0",
        BackgroundTransparency = 0,
        Position = UDim2New(0, 20, 0, 91),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(0, 122, 0, 80),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Background
    }):AddToTheme({
        BackgroundColor3 = "Background"
    })
    Instances:Create("UICorner", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 12)
    })
    Instances:Create("UIStroke", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["Search"] = Instances:Create("Frame", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Position = UDim2New(0, 8, 0, 8),
        BorderColor3 = FromRGB(0, 0, 0),
        Size = UDim2New(1, -16, 0, 25),
        BorderSizePixel = 0,
        BackgroundColor3 = Library.Theme.Element,
        Visible = false
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("UIStroke", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        Color = Library.Theme["Outline 2"],
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Items["SearchIcon"] = Instances:Create("ImageLabel", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://93412599989519",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 8, 0.5, 0),
        Size = UDim2New(0, 14, 0, 14),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Text"
    })
    Items["SearchInput"] = Instances:Create("TextBox", {
        Parent = Items["Search"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        AnchorPoint = Vector2New(0, 0.5),
        PlaceholderColor3 = Library.Theme["Text 2"],
        PlaceholderText = "Search..",
        TextSize = 14,
        Size = UDim2New(1, -30, 0, 15),
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left,
        CursorPosition = -1,
        Position = UDim2New(0, 26, 0.5, 0),
        BorderSizePixel = 0
    }):AddToTheme({
        TextColor3 = "Text",
        PlaceholderColor3 = "Text 2"
    })
    Items["Holder"] = Instances:Create("ScrollingFrame", {
        Parent = Items["OptionHolder"].Instance,
        Name = "\0",
        Active = true,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        BorderSizePixel = 0,
        CanvasSize = UDim2New(0, 0, 0, 0),
        MidImage = "rbxassetid://81680855285439",
        BorderColor3 = FromRGB(0, 0, 0),
        ScrollBarThickness = 2,
        Size = UDim2New(1, -16, 1, -16),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 8, 0, 8),
        BottomImage = "rbxassetid://81680855285439",
        TopImage = "rbxassetid://81680855285439"
    }):AddToTheme({
        ScrollBarImageColor3 = "Text 2"
    })
    Instances:Create("UIListLayout", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        Padding = UDimNew(0, 6),
        SortOrder = Enum.SortOrder.LayoutOrder
    })
    Instances:Create("UIPadding", {
        Parent = Items["Holder"].Instance,
        Name = "\0",
        PaddingTop = UDimNew(0, 5),
        PaddingBottom = UDimNew(0, 10),
        PaddingRight = UDimNew(0, 8),
        PaddingLeft = UDimNew(0, 0)
    })
    Library:Connect(Items["SearchInput"].Instance:GetPropertyChangedSignal("Text"), function()
        for _, v in Dropdown.Options, nil, nil do
            if StringFind(StringLower(v.Name), StringLower(Items["SearchInput"].Instance.Text)) then
                v.Button.Instance.Visible = true
            else
                v.Button.Instance.Visible = false
            end
        end
    end)
    Items["Dropdown"]:OnHover(function()
        if Dropdown.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Options.Tooltip then
            Library:ShowTooltip(Options.Tooltip, Items["Dropdown"].Instance)
        end
    end)
    Items["Dropdown"]:OnHoverLeave(function()
        if Dropdown.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Options.Tooltip then
            Library:HideTooltip()
        end
    end)
    Dropdown.Get = function()
        return Dropdown.Value
    end
    Dropdown.SetVisibility = function(self, Visible)
        Items["Dropdown"].Instance.Visible = Visible
    end

    local Debounce = false
    local connection

    Dropdown.SetOpen = function(self, IsOpen)
        if Debounce then
            return
        end

        Dropdown.IsOpen = IsOpen
        Debounce = true

        local UIScale = Library.Holder.Instance:FindFirstChild("UIScale")
        local Scale = UIScale and UIScale.Scale or 1

        if Dropdown.IsOpen then
            Items["OptionHolder"].Instance.Visible = true
            Items["OptionHolder"].Instance.Parent = Library.Holder.Instance
            Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X / Scale, 0, 0)
            Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X / Scale, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y / Scale - 25)
            Items["OptionHolder"]:Tween(nil, {
                Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X / Scale, 0, Dropdown.MaxSize)
            })
            Items["Search"].Instance.Visible = Library.DropdownSearch

            if Library.DropdownSearch then
                Items["Holder"].Instance.Position = UDim2New(0, 8, 0, 38)
                Items["Holder"].Instance.Size = UDim2New(1, -16, 1, -46)
            else
                Items["Holder"].Instance.Position = UDim2New(0, 8, 0, 8)
                Items["Holder"].Instance.Size = UDim2New(1, -16, 1, -16)
            end

            for _, v in Library.OpenFrames, nil, nil do
                if v ~= Dropdown and not Dropdown.Section.IsSettings then
                    v:SetOpen(false)
                end
            end

            Library.OpenFrames[Dropdown] = Dropdown
        else
            if Library.OpenFrames[Dropdown] then
                Library.OpenFrames[Dropdown] = nil
            end

            if RenderStepped then
                RenderStepped:Disconnect()
                RenderStepped = nil
            end

            Items["OptionHolder"]:Tween(nil, {
                Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X / Scale, 0, 0)
            })
        end

        local descendants = Items["OptionHolder"].Instance:GetDescendants()

        TableInsert(descendants, Items["OptionHolder"].Instance)

        local FadeTween

        for _, v in descendants, nil, nil do
            local property = Tween:GetProperty(v)

            if property then
                if not v.ClassName:find("UI") then
                    v.ZIndex = Dropdown.IsOpen and Dropdown.Section.IsSettings and 111 or 1
                end

                if type(property) == "table" then
                    for _, Property in property, nil, nil do
                        FadeTween = Tween:FadeItem(v, Property, IsOpen, Library.FadeSpeed)
                    end
                else
                    FadeTween = Tween:FadeItem(v, property, IsOpen, Library.FadeSpeed)
                end
            end
        end

        FadeTween.Tween.Completed:Connect(function()
            Debounce = false
            Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
            task.wait(0.2)
            Items["OptionHolder"].Instance.Parent = not Dropdown.IsOpen and Library.UnusedHolder.Instance or Library.Holder.Instance
            task.wait(0.1)

            if Dropdown.IsOpen then
                RenderStepped = Library:Connect(RunService.RenderStepped, function()
                    local UIScale2 = Library.Holder.Instance:FindFirstChild("UIScale")
                    local Scale2 = UIScale2 and UIScale2.Scale or 1

                    Items["OptionHolder"].Instance.Position = UDim2New(0, Items["RealDropdown"].Instance.AbsolutePosition.X / Scale2, 0, Items["RealDropdown"].Instance.AbsolutePosition.Y / Scale2 - 25)
                    Items["OptionHolder"].Instance.Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X / Scale2, 0, Dropdown.MaxSize)
                end)
            else
                if RenderStepped then
                    RenderStepped:Disconnect()
                    RenderStepped = nil
                end

                Items["OptionHolder"]:Tween(nil, {
                    Size = UDim2New(0, Items["RealDropdown"].Instance.AbsoluteSize.X / Scale, 0, 0)
                })
            end
        end)
    end
    Dropdown.Set = function(self, Value)
        if Dropdown.Multi then
            if type(Value) ~= "table" then
                return
            end

            Dropdown.Value = Value
            Library.Flags[Dropdown.Flag] = Value

            for _, v in Value, nil, nil do
                local OptionData = Dropdown.Options[v]

                if OptionData then
                    OptionData.Selected = true
                    OptionData:Toggle("Active")
                end
            end

            Items["Value"].Instance.Text = TableConcat(Value, ", ")
        else
            if not Dropdown.Options[Value] then
                return
            end

            local SelectedOptionData = Dropdown.Options[Value]

            Dropdown.Value = Value
            Library.Flags[Dropdown.Flag] = Value

            for _, v in Dropdown.Options, nil, nil do
                if v == SelectedOptionData then
                    v.Selected = true
                    v:Toggle("Active")
                else
                    v.Selected = false
                    v:Toggle("Inactive")
                end
            end

            Items["Value"].Instance.Text = Value
        end

        if Dropdown.Callback then
            Library:SafeCall(Dropdown.Callback, Dropdown.Value)
        end
    end
    Dropdown.Add = function(self, Option)
        local OptionButton = Instances:Create("TextButton", {
            Parent = Items["Holder"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = FromRGB(0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            AutoButtonColor = false,
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 25),
            BorderSizePixel = 0,
            TextSize = 14,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        local OptionIcon = Instances:Create("ImageLabel", {
            Parent = OptionButton.Instance,
            Name = "\0",
            ImageTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(0, 0.5),
            Image = "rbxassetid://107907951570295",
            BackgroundTransparency = 1,
            Position = UDim2New(0, 5, 0.5, 0),
            Size = UDim2New(0, 16, 0, 16),
            BorderSizePixel = 0
        }):AddToTheme({
            ImageColor3 = "Text"
        })
        local OptionLabel = Instances:Create("TextLabel", {
            Parent = OptionButton.Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme["Text 2"],
            BorderColor3 = FromRGB(0, 0, 0),
            Text = Option,
            AnchorPoint = Vector2New(0, 0.5),
            Size = UDim2New(0, 0, 0, 15),
            BackgroundTransparency = 1,
            Position = UDim2New(0, 28, 0.5, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 18
        }):AddToTheme({
            TextColor3 = "Text 2"
        })

        Instances:Create("UICorner", {
            Parent = OptionButton.Instance,
            Name = "\0"
        })
        OptionButton:OnHover(function()
            OptionButton:Tween(nil, {
                BackgroundTransparency = 0
            })
        end)
        OptionButton:OnHoverLeave(function()
            OptionButton:Tween(nil, {
                BackgroundTransparency = 1
            })
        end)

        local SelectedOption

        SelectedOption = {
            Button = OptionButton,
            Name = Option,
            Check = OptionIcon,
            Text = OptionLabel,
            Selected = false,
            Toggle = function(self, Value)
                if Value == "Active" then
                    SelectedOption.Check:Tween(nil, {
                        ImageTransparency = 0
                    })
                    SelectedOption.Text:ChangeItemTheme({
                        TextColor3 = "Text"
                    })
                    SelectedOption.Text:Tween(nil, {
                        TextColor3 = Library.Theme.Text
                    })
                else
                    SelectedOption.Check:Tween(nil, {
                        ImageTransparency = 1
                    })
                    SelectedOption.Text:ChangeItemTheme({
                        TextColor3 = "Text 2"
                    })
                    SelectedOption.Text:Tween(nil, {
                        TextColor3 = Library.Theme["Text 2"]
                    })
                end
            end,
            Set = function()
                SelectedOption.Selected = not SelectedOption.Selected

                if Dropdown.Multi then
                    local OptionIndex = TableFind(Dropdown.Value, SelectedOption.Name)

                    if OptionIndex then
                        TableRemove(Dropdown.Value, OptionIndex)
                    else
                        TableInsert(Dropdown.Value, SelectedOption.Name)
                    end

                    SelectedOption:Toggle(OptionIndex and "Inactive" or "Active")
                    Library.Flags[Dropdown.Flag] = Dropdown.Value
                    Items["Value"].Instance.Text = #Dropdown.Value > 0 and TableConcat(Dropdown.Value, ", ") or "..."
                elseif SelectedOption.Selected then
                    Dropdown.Value = SelectedOption.Name
                    Library.Flags[Dropdown.Flag] = SelectedOption.Name
                    SelectedOption.Selected = true
                    SelectedOption:Toggle("Active")

                    for _, v in Dropdown.Options, nil, nil do
                        if v ~= SelectedOption then
                            v.Selected = false
                            v:Toggle("Inactive")
                        end
                    end

                    Items["Value"].Instance.Text = SelectedOption.Name
                else
                    Dropdown.Value = nil
                    Library.Flags[Dropdown.Flag] = nil
                    SelectedOption.Selected = false
                    SelectedOption:Toggle("Inactive")
                    Items["Value"].Instance.Text = "..."
                end

                if Dropdown.Callback then
                    Library:SafeCall(Dropdown.Callback, Dropdown.Value)
                end
            end
        }
        SelectedOption.Button:Connect("MouseButton1Down", function()
            SelectedOption:Set()
        end)
        Dropdown.Options[SelectedOption.Name] = SelectedOption

        return SelectedOption
    end
    Dropdown.Remove = function(self, Option)
        if Dropdown.Options[Option] then
            Dropdown.Options[Option].Button:Clean()
            Dropdown.Options[Option] = nil
        end
    end
    Dropdown.Refresh = function(self, Options)
        for _, v in Dropdown.Options, nil, nil do
            Dropdown:Remove(v.Name)
        end

        for _, v in Options, nil, nil do
            Dropdown:Add(v)
        end
    end
    Items["RealDropdown"]:Connect("MouseButton1Down", function()
        Dropdown:SetOpen(not Dropdown.IsOpen)
    end)
    
Library:Connect(UserInputService.InputBegan, function(Input)
    if (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) and Dropdown.IsOpen then
        if Library:IsMouseOverFrame(Items["RealDropdown"]) then
            return
        end

        if Library:IsMouseOverFrame(Items["OptionHolder"]) then
            return
        end

        Dropdown:SetOpen(false)
    end
end)
    
    Items["RealDropdown"]:Connect("Changed", function(Value)
        if Value == "AbsolutePosition" and Dropdown.IsOpen then
            Dropdown.IsOpen = not Library:IsClipped(Items["OptionHolder"].Instance, Dropdown.Section.Items["Section"].Instance.Parent)
            Items["OptionHolder"].Instance.Visible = Dropdown.IsOpen
        end
    end)

    for _, v in Dropdown.Items, nil, nil do
        Dropdown:Add(v)
    end

    if Dropdown.Default then
        Dropdown:Set(Dropdown.Default)
    end

    Library.SetFlags[Dropdown.Flag] = function(Value)
        Dropdown:Set(Value)
    end

    return Dropdown
end
Library.Sections.Label = function(self, Data)
    local Name = type(Data) == "table" and (Data.Name or Data.name) or Data
    local Label = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Name or "Label"
    }
    local Items = { } do
        Items["Label"] = Instances:Create("Frame", {
            Parent = Label.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
    end

    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["Label"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Label.Name,
        ZIndex = 2,
        AnchorPoint = Vector2New(0, 0.5),
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["SubElements"] = Instances:Create("Frame", {
        Parent = Items["Label"].Instance,
        Name = "\0",
        ZIndex = 3,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(1, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2New(1, 0, 0.5, 0),
        Size = UDim2New(0, 0, 0, 20),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X
    })
    Instances:Create("UIListLayout", {
        Parent = Items["SubElements"].Instance,
        Name = "\0",
        VerticalAlignment = Enum.VerticalAlignment.Center,
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDimNew(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder
    })

    if Label.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Label"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Label.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Label"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Label"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Label"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Label"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Label"]:OnHover(function()
        if Label.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if type(Data) == "table" and Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Label"].Instance)
        end
    end)
    Items["Label"]:OnHoverLeave(function()
        if Label.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if type(Data) == "table" and Data.Tooltip then
            Library:HideTooltip()
        end
    end)
    function Label:SetText(Text)
        Items["Text"].Instance.Text = tostring(Text)
    end
    function Label:SetVisibility(Bool)
        Items["Label"].Instance.Visible = Bool
    end
    Label.Colorpicker = function(self, Data)
        local Data = Data or {}
        local Colorpicker = {
            Window = Label.Window,
            Page = Label.Page,
            Section = Label.Section,
            Flag = Data.Flag or Data.flag or Library:NextFlag(),
            Default = Data.Default or Data.default or Color3.fromRGB(255, 255, 255),
            Callback = Data.Callback or Data.callback or function()
            end,
            Alpha = Data.Alpha or Data.alpha or false
        }
        local Colorpicker = Library:CreateColorpicker({
            Parent = Items["SubElements"],
            Page = Colorpicker.Page,
            Section = Colorpicker.Section,
            Flag = Colorpicker.Flag,
            Default = Colorpicker.Default,
            Callback = Colorpicker.Callback,
            Alpha = Colorpicker.Alpha
        })

        return Colorpicker
    end
    Label.Keybind = function(self, Data)
        local Data = Data or {}
        local Keybind = {
            Window = Label.Window,
            Page = Label.Page,
            Section = Label.Section,
            Flag = Data.Flag or Data.flag or Library:NextFlag()
        }
        local Default = Data.Default or Data.default

        Keybind.Default = Default or Enum.KeyCode.E
        Keybind.Callback = Data.Callback or Data.callback or function()
        end
        Keybind.Mode = Data.Mode or Data.mode or "Toggle"

        local Keybind = Library:CreateKeybind({
            Parent = Items["SubElements"],
            Page = Keybind.Page,
            Section = Keybind.Section,
            Flag = Keybind.Flag,
            Default = Keybind.Default,
            Mode = Keybind.Mode,
            Callback = Keybind.Callback
        })

        return Keybind
    end

    return Label
end
Library.Sections.Textbox = function(self, Data)
    Data = Data or { }

    local Textbox = {
        Window = self.Window,
        Page = self.Page,
        Section = self,

        Name = Data.Name or Data.name or "Textbox",
        Flag = Data.Flag or Data.flag or Library:NextFlag(),
        Default = Data.Default or Data.default or "",
        Callback = Data.Callback or Data.callback or function() end,
        Placeholder = Data.Placeholder or Data.placeholder or "Placeholder",
        Numeric = Data.Numeric or Data.numeric or false,
        Finished = Data.Finished or Data.finished or false,

        Value = ""
    }

    local Items = { } do 
        Items["Textbox"] = Instances:Create("Frame", {
            Parent = Textbox.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 30),
            BorderSizePixel = 0
        })
        
        Items["Text"] = Instances:Create("TextLabel", {
            Parent = Items["Textbox"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            TextColor3 = Library.Theme["Text"],
            BorderColor3 = FromRGB(0, 0, 0),
            Text = Textbox.Name,
            AnchorPoint = Vector2New(0, 0.5),
            Size = UDim2New(0, 0, 0, 15),
            BackgroundTransparency = 1,
            Position = UDim2New(0, 0, 0.5, 0),
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            TextSize = 16
        }):AddToTheme({TextColor3 = 'Text'})
        
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Textbox"].Instance,
            Name = "\0",
            Active = false,
            BorderColor3 = FromRGB(0, 0, 0),
            AnchorPoint = Vector2New(1, 1),
            Size = UDim2New(0, 0, 0, 30),
            Position = UDim2New(1, 0, 1, 0),
            Selectable = false,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X,
            BackgroundColor3 = Library.Theme["Element"]
        }):AddToTheme({BackgroundColor3 = 'Element'})
        
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 6)
        })
        
        Instances:Create("UIStroke", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            Color = Library.Theme["Outline"],
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        }):AddToTheme({Color = 'Outline'})
        
        Instances:Create("UIPadding", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            PaddingRight = UDimNew(0, 8),
            PaddingLeft = UDimNew(0, 8)
        })
        
        Items["Input"] = Instances:Create("TextBox", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            FontFace = Library.Font,
            Active = true,
            TextTransparency = 0,
            AnchorPoint = Vector2New(0, 0.5),
            PlaceholderColor3 = FromRGB(133, 139, 143),
            PlaceholderText = Textbox.Placeholder,
            TextSize = 16,
            Size = UDim2New(0, 0, 0, 15),
            TextColor3 = Library.Theme["Text"],
            BorderColor3 = FromRGB(0, 0, 0),
            Text = "",
            Selectable = true,
            BackgroundTransparency = 1,
            Position = UDim2New(0, 0, 0.5, 0),
            CursorPosition = -1,
            BorderSizePixel = 0,
            AutomaticSize = Enum.AutomaticSize.X
        }):AddToTheme({TextColor3 = 'Text'})                
    end
    
    function Textbox:Get()
        return Textbox.Value
    end

    function Textbox:SetVisibility(Bool)
        Items["Textbox"].Instance.Visible = Bool
    end

    function Textbox:Set(Value)
        if Textbox.Numeric then
            if (not tonumber(Value)) and StringLen(tostring(Value)) > 0 then
                Value = Textbox.Value
            end
        end

        Textbox.Value = Value
        Items["Input"].Instance.Text = Value
        Library.Flags[Textbox.Flag] = Value

        if Textbox.Callback then
            Library:SafeCall(Textbox.Callback, Value)
        end
    end

    if Textbox.Finished then 
        Items["Input"]:Connect("FocusLost", function(PressedEnterQuestionMark)
            if PressedEnterQuestionMark then
                Textbox:Set(Items["Input"].Instance.Text)
            end
        end)
    else
        Library:Connect(Items["Input"].Instance:GetPropertyChangedSignal("Text"), function()
            Textbox:Set(Items["Input"].Instance.Text)
        end)
    end

    if Textbox.Default then
        Textbox:Set(Textbox.Default)
    end

    Library.SetFlags[Textbox.Flag] = function(Value)
        Textbox:Set(Value)
    end

    return Textbox
end
Library.Sections.Keybind = function(self, Data)
    local Data = Data or {}
    local Keybind = {
        Window = self.Window,
        Page = self.Page,
        Section = self,
        Name = Data.Name or Data.name or "Keybind"
    }

    Keybind.Flag = Data.Flag or Data.flag or Library:NextFlag()
    Keybind.Default = Data.Default or Data.default or Enum.KeyCode.RightShift
    Keybind.Callback = Data.Callback or Data.callback or function()
    end
    Keybind.RealMode = Data.Mode or Data.mode or "Toggle"
    Keybind.Key = ""
    Keybind.Value = ""
    Keybind.Mode = ""
    Keybind.Picking = false
    Keybind.IsOpen = false
    Keybind.Toggled = false

    local Items = { } do
        Items["Keybind"] = Instances:Create("Frame", {
            Parent = Keybind.Section.Items["Content"].Instance,
            Name = "\0",
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 65),
            BorderSizePixel = 0
        })
    end

    Items["RealKey"] = Instances:Create("Frame", {
        Parent = Items["Keybind"].Instance,
        Name = "\0",
        BackgroundTransparency = 1,
        BorderColor3 = FromRGB(0, 0, 0),
        ZIndex = 2,
        Size = UDim2New(1, 0, 0, 30),
        BorderSizePixel = 0
    })
    Items["KeyButton"] = Instances:Create("TextButton", {
        Parent = Items["RealKey"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "Shift",
        AutoButtonColor = false,
        ZIndex = 2,
        AnchorPoint = Vector2New(1, 0),
        Size = UDim2New(0, 0, 0, 24),
        Position = UDim2New(1, 0, 0, 5),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element",
        TextColor3 = "Text"
    })
    Instances:Create("UICorner", {
        Parent = Items["KeyButton"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("UIStroke", {
        Parent = Items["KeyButton"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    }):AddToTheme({
        Color = "Outline 2"
    })
    Instances:Create("UIPadding", {
        Parent = Items["KeyButton"].Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 8),
        PaddingLeft = UDimNew(0, 8)
    })
    Items["Text"] = Instances:Create("TextLabel", {
        Parent = Items["RealKey"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = Keybind.Name,
        ZIndex = 2,
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0, 8),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })
    Items["RealMode"] = Instances:Create("Frame", {
        Parent = Items["Keybind"].Instance,
        Name = "\0",
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 1),
        ZIndex = 2,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 1, 0),
        Size = UDim2New(1, 0, 0, 30),
        BorderSizePixel = 0
    })
    Items["ModeButton"] = Instances:Create("TextButton", {
        Parent = Items["RealMode"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "",
        AutoButtonColor = false,
        ZIndex = 2,
        AnchorPoint = Vector2New(1, 0),
        Size = UDim2New(0, 0, 0, 24),
        Position = UDim2New(1, 0, 0, 5),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18,
        BackgroundColor3 = Library.Theme.Element
    }):AddToTheme({
        BackgroundColor3 = "Element"
    })
    Instances:Create("UICorner", {
        Parent = Items["ModeButton"].Instance,
        Name = "\0",
        CornerRadius = UDimNew(0, 6)
    })
    Instances:Create("UIStroke", {
        Parent = Items["ModeButton"].Instance,
        Name = "\0",
        Color = FromRGB(29, 28, 32),
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    })
    Instances:Create("UIPadding", {
        Parent = Items["ModeButton"].Instance,
        Name = "\0",
        PaddingRight = UDimNew(0, 8),
        PaddingLeft = UDimNew(0, 8)
    })
    Items["Icon"] = Instances:Create("ImageLabel", {
        Parent = Items["ModeButton"].Instance,
        Name = "\0",
        ImageColor3 = Library.Theme.Accent,
        ZIndex = 2,
        BorderColor3 = FromRGB(0, 0, 0),
        AnchorPoint = Vector2New(0, 0.5),
        Image = "rbxassetid://124351435313553",
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0.5, 0),
        Size = UDim2New(0, 18, 0, 18),
        BorderSizePixel = 0
    }):AddToTheme({
        ImageColor3 = "Accent"
    })
    Items["ModeValue"] = Instances:Create("TextLabel", {
        Parent = Items["ModeButton"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        TextWrapped = true,
        TextColor3 = Library.Theme.Accent,
        BorderColor3 = FromRGB(0, 0, 0),
        ZIndex = 2,
        Text = "Hold",
        Size = UDim2New(0, 0, 0, 15),
        AnchorPoint = Vector2New(0, 0.5),
        BorderSizePixel = 0,
        BackgroundTransparency = 1,
        Position = UDim2New(0, 24, 0.5, 0),
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Accent"
    })
    Items["ModeText"] = Instances:Create("TextLabel", {
        Parent = Items["RealMode"].Instance,
        Name = "\0",
        FontFace = Library.Font,
        ZIndex = 2,
        TextColor3 = Library.Theme.Text,
        BorderColor3 = FromRGB(0, 0, 0),
        Text = "Mode",
        Size = UDim2New(0, 0, 0, 15),
        BackgroundTransparency = 1,
        Position = UDim2New(0, 0, 0, 8),
        BorderSizePixel = 0,
        AutomaticSize = Enum.AutomaticSize.X,
        TextSize = 18
    }):AddToTheme({
        TextColor3 = "Text"
    })

    if Keybind.Section.IsFirstElement then
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Keybind"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -10),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 15),
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 1),
            Position = UDim2New(0, 0, 1, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    elseif Keybind.Section.IsLastElement then
        Instances:Create("Frame", {
            Parent = Items["Keybind"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Keybind"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BackgroundTransparency = 1,
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 13),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
        Instances:Create("UICorner", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            CornerRadius = UDimNew(0, 15)
        })
        Items["BackgroundLiner"] = Instances:Create("Frame", {
            Parent = Items["Background"].Instance,
            Name = "\0",
            AnchorPoint = Vector2New(0, 0),
            Position = UDim2New(0, 0, 0, 0),
            BorderColor3 = FromRGB(0, 0, 0),
            BackgroundTransparency = 1,
            Size = UDim2New(1, 0, 0, 15),
            BorderSizePixel = 0,
            BackgroundColor3 = FromRGB(29, 31, 42)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    else
        Instances:Create("Frame", {
            Parent = Items["Keybind"].Instance,
            Name = "\0",
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 0, 0, 1),
            Position = UDim2New(0, 0, 0, -5),
            BorderSizePixel = 0,
            BackgroundColor3 = Library.Theme.Liner
        }):AddToTheme({
            BackgroundColor3 = "Liner"
        })
        Items["Background"] = Instances:Create("Frame", {
            Parent = Items["Keybind"].Instance,
            Name = "\0",
            Position = UDim2New(0, -15, 0, -4),
            BorderColor3 = FromRGB(0, 0, 0),
            Size = UDim2New(1, 30, 1, 9),
            BorderSizePixel = 0,
            BackgroundTransparency = 1,
            BackgroundColor3 = FromRGB(26, 28, 38)
        }):AddToTheme({
            BackgroundColor3 = "Hover Element"
        })
    end

    Items["Keybind"]:OnHover(function()
        if Keybind.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 0
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 0
            })
        end

        if Data.Tooltip then
            Library:ShowTooltip(Data.Tooltip, Items["Keybind"].Instance)
        end
    end)
    Items["Keybind"]:OnHoverLeave(function()
        if Keybind.Section.IsSettings then
            return
        end

        Items["Background"]:Tween(nil, {
            BackgroundTransparency = 1
        })

        if Items["BackgroundLiner"] then
            Items["BackgroundLiner"]:Tween(nil, {
                BackgroundTransparency = 1
            })
        end

        if Data.Tooltip then
            Library:HideTooltip()
        end
    end)

    local function UpdateKeybindWidget()
    if KeybindWidget then
        KeybindWidget:Set(Keybind.Name)
        KeybindWidget:SetStatus(Keybind.Toggled)
        
        if Keybind.Value and Keybind.Value ~= "None" and Keybind.Value ~= "" and Keybind.Value ~= "nil" then
            KeybindWidget.Key.Instance.Visible = true
        else
            KeybindWidget.Key.Instance.Visible = false
        end
    end
end

    Keybind.SetMode = function(self, Mode)
        Keybind.Mode = Mode
        Items["ModeValue"].Instance.Text = Mode
        Library.Flags[Keybind.Flag] = {
            Mode = Keybind.Mode,
            Key = Keybind.Key,
            Toggled = Keybind.Toggled
        }

        if Keybind.Callback then
            Library:SafeCall(Keybind.Callback, Keybind.Toggled)
        end
    end
    Keybind.Press = function(self, Pressed)
        if Keybind.Mode == "Toggle" then
            Keybind.Toggled = not Keybind.Toggled
        elseif Keybind.Mode == "Hold" then
            Keybind.Toggled = Pressed
        elseif Keybind.Mode == "Always" then
            Keybind.Toggled = true
        end

        Library.Flags[Keybind.Flag] = {
            Mode = Keybind.Mode,
            Key = Keybind.Key,
            Toggled = Keybind.Toggled
        }

        if Keybind.Callback then
            Library:SafeCall(Keybind.Callback, Keybind.Toggled)
        end

        UpdateKeybindWidget()
    end
    Keybind.Get = function()
        return Keybind.Key, Keybind.Mode, Keybind.Toggled
    end
    Keybind.GetNextMode = function()
        if Keybind.Mode == "Toggle" then
            return "Hold"
        end

        if Keybind.Mode == "Hold" then
            return "Always"
        end

        if Keybind.Mode == "Always" then
            return "Toggle"
        end
    end
    Keybind.Set = function(self, Key)
        if StringFind(tostring(Key), "Enum") then
            Keybind.Key = tostring(Key)

            local value = StringGSub(StringGSub(Keys[Keybind.Key] or StringGSub(Key.Name == "Backspace" and "None" or Key.Name, "Enum.", "") or "None", "KeyCode.", ""), "UserInputType.", "") or "None"

            Keybind.Value = value
            Items["KeyButton"].Instance.Text = value
            Library.Flags[Keybind.Flag] = {
                Mode = Keybind.Mode,
                Key = Keybind.Key,
                Toggled = Keybind.Toggled
            }

            if Keybind.Callback then
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
        elseif type(Key) == "table" then
            local Key = Key.Key == "Backspace" and "None" or Key.Key

            Keybind.Key = tostring(Key.Key)

            if Key.Mode then
                Keybind:SetMode(Key.Mode)
            else
                Keybind:SetMode("Toggle")
            end

            local KeyName = Keys[Keybind.Key] or StringGSub(tostring(Key), "Enum.", "") or Key

            if not (KeyName and StringGSub(StringGSub(KeyName, "KeyCode.", ""), "UserInputType.", "")) then
            end

            local ShortKeyName = StringGSub(StringGSub(KeyName, "KeyCode.", ""), "UserInputType.", "")

            Keybind.Value = ShortKeyName
            Items["KeyButton"].Instance.Text = ShortKeyName

            if Keybind.Callback then
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
        elseif TableFind({
                    "Toggle",
                    "Hold",
                    "Always"
                }, Key) then
            Keybind:SetMode(Key)

            if Keybind.Callback then
                Library:SafeCall(Keybind.Callback, Keybind.Toggled)
            end
        end

        UpdateKeybindWidget()
        Keybind.Picking = false
    end
    Items["KeyButton"]:Connect("MouseButton1Click", function()
        Keybind.Picking = true
        Items["KeyButton"].Instance.Text = "."
        Library:Thread(function()
            local n2 = 1

            while Keybind.Picking do
                if n2 == 4 then
                    n2 = 1
                end

                Items["KeyButton"].Instance.Text = n2 == 1 and "." or n2 == 2 and ".." or n2 == 3 and "..."
                n2 += 1
                task.wait(0.35)
            end
        end)

        local RenderStepped

        connection = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.Keyboard then
                Keybind:Set(input.KeyCode)
            else
                Keybind:Set(input.UserInputType)
            end

            connection:Disconnect()
            connection = nil
        end)
    end)
    Library:Connect(UserInputService.InputBegan, function(Input)
        if Keybind.Value == "None" then
            return
        end

        if tostring(Input.KeyCode) ~= Keybind.Key then
            if tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.Mode == "Toggle" then
                    Keybind:Press()
                elseif Keybind.Mode == "Hold" then
                    Keybind:Press(true)
                elseif Keybind.Mode == "Always" then
                    Keybind:Press(true)
                end
            end
        elseif Keybind.Mode == "Toggle" then
            Keybind:Press()
        elseif Keybind.Mode == "Hold" then
            Keybind:Press(true)
        elseif Keybind.Mode == "Always" then
            Keybind:Press(true)
        end

        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            if not Keybind.IsOpen then
                return
            end

            if Library:IsMouseOverFrame(Items["KeybindWindow"]) then
                return
            end

            Keybind:SetOpen(false)
        end
    end)
    Library:Connect(UserInputService.InputEnded, function(Input)
        if Keybind.Value == "None" then
            return
        end

        if tostring(Input.KeyCode) ~= Keybind.Key then
            if tostring(Input.UserInputType) == Keybind.Key then
                if Keybind.Mode == "Hold" then
                    Keybind:Press(false)
                elseif Keybind.Mode == "Always" then
                    Keybind:Press(true)
                end
            end
        elseif Keybind.Mode == "Hold" then
            Keybind:Press(false)
        elseif Keybind.Mode == "Always" then
            Keybind:Press(true)
        end
    end)
    Items["ModeButton"]:Connect("MouseButton1Down", function()
        Keybind:Set(Keybind:GetNextMode())
    end)

    if Keybind.Default then
        Keybind:Set({
            Mode = Keybind.RealMode or "Toggle",
            Key = Keybind.Default
        })
    end

    Library.SetFlags[Keybind.Flag] = function(Value)
        Keybind:Set(Value)
    end

    return Keybind
end
Library.CheckAutoLoad = function(self, Value)
    local AutoLoadPath = Library:GetFolder() .. "/autoload.txt"

    if isfile(AutoLoadPath) then
        local AutoLoadConfig = readfile(AutoLoadPath)

        if AutoLoadConfig and AutoLoadConfig ~= "" then
            local ConfigPath = Library:GetFolder() .. "/" .. AutoLoadConfig .. ".json"

            if isfile(ConfigPath) then
                local ConfigData = readfile(ConfigPath)
                local Success, Result = Library:LoadConfig(ConfigData)

                if Success then
                    Library:Notification("Auto-loaded config: " .. AutoLoadConfig, "93209682414397", FromRGB(0, 255, 0), 5)

                    if Value and Value.ConfigHeader and Value.ConfigHeader.Configs then
                        for _, config in pairs(Value.ConfigHeader.Configs) do
                            if config.Text == AutoLoadConfig then
                                config:Select(true)

                                break
                            end
                        end
                    end
                else
                    Library:Notification("Failed to auto-load config: " .. Result, "83016346682572", FromRGB(255, 0, 0), 5)
                end
            end
        end
    end
end
Library.CreateSettingsPage = function(self, Window, SettingsPage, ConfigPage)
    local SettingsPage = Window:Page({
        Name = "Settings",
        Icon = "89030482276146"
    }):SubPage({
        Name = "General",
        Icon = "98488959537895"
    })
    local SettingsSection = SettingsPage:Section({
        Name = "General",
        Side = 1
    })

    for _, v in {
        "Outline",
        "Outline 2",
        "Background",
        "Logo Background",
        "Background 2",
        "Section Background",
        "Page Background",
        "Toggle",
        "Element",
        "Text",
        "Text 2",
        "Liner",
        "Hover Element",
        "Accent"
    }, nil, nil do
        if v == "Outline" then
            SettingsSection.IsFirstElement = true
        else
            SettingsSection.IsFirstElement = false
        end

        if v == "Accent" then
            SettingsSection.IsLastElement = true
        else
            SettingsSection.IsLastElement = false
        end

        SettingsSection:Label(v):Colorpicker({
            Flag = "Theme" .. v,
            Default = Library.Theme[v],
            Callback = function(Value)
                Library.Theme[v] = Value
                Library:ChangeTheme(v, Value)
            end
        })
    end

    local ConfigSection = SettingsPage:Section({
        Name = "Settings",
        Side = 2
    })

    ConfigSection.IsFirstElement = true
    ConfigSection:Button({
        Name = "Unload",
        Callback = function()
            Library:Unload()
        end
    })
    ConfigSection.IsFirstElement = false
    ConfigSection:Keybind({
        Name = "Menu keybind",
        Flag = "MenuKeybind",
        Default = Library.MenuKeybind,
        Mode = "Toggle",
        Callback = function()
            Library.MenuKeybind = Library.Flags.MenuKeybind.Key
        end
    })
    ConfigSection:Dropdown({
        Name = "DPI Scale",
        Flag = "DPIScale",
        Default = TouchEnabled and "65%" or "100%",
        Size = 150,
        MaxSize = 150,
        Items = {
            "25%",
            "50%",
            "65%",
            "75%",
            "100%",
            "125%",
            "150%",
            "175%",
            "200%"
        },
        Callback = function(Value)
            local scale = tonumber(Value:match("%d+")) / 100
            local UIScale = Library.Holder.Instance:FindFirstChild("UIScale")

            if UIScale then
                UIScale.Scale = scale
            end
        end
    })
    ConfigSection:Slider({
        Name = "Fade time",
        Flag = "FadeTime",
        Default = Library.FadeSpeed,
        Min = 0,
        Max = 5,
        Decimals = 0.01,
        Callback = function(Value)
            Library.FadeSpeed = Value
        end
    })
    ConfigSection:Slider({
        Name = "Tween speed",
        Flag = "TweenSpeed",
        Default = Library.Tween.Time,
        Min = 0,
        Max = 1,
        Decimals = 0.01,
        Callback = function(Value)
            Library.Tween.Time = Value
        end
    })
    ConfigSection:Dropdown({
        Name = "UI Tween style",
        Flag = "TweenStyle",
        Default = "Quad",
        Items = {
            "Linear",
            "Sine",
            "Quad",
            "Cubic",
            "Quart",
            "Quint",
            "Exponential",
            "Circular",
            "Back",
            "Elastic",
            "Bounce"
        },
        Callback = function(Value)
            Library.Tween.Style = Enum.EasingStyle[Value]
        end
    })
    ConfigSection:Toggle({
        Name = "Dropdown Search",
        Flag = "DropdownSearch",
        Default = true,
        Callback = function(Value)
            Library.DropdownSearch = Value
        end
    })
    ConfigSection:Toggle({
        Name = "Watermark",
        Flag = "Watermark",
        Default = false,
        Callback = function(Value)
            SettingsPage:SetVisibility(Value)
        end
    })
    ConfigSection:Toggle({
        Name = "Keybind List",
        Flag = "Keybind List",
        Default = false,
        Callback = function(Value)
            ConfigPage:SetVisibility(Value)
        end
    })
    ConfigSection.IsLastElement = true
    ConfigSection:Dropdown({
        Name = "Tween direction",
        Flag = "TweenDirection",
        Default = "Out",
        Items = {
            "In",
            "Out",
            "InOut"
        },
        Callback = function(Value)
            Library.Tween.Direction = Enum.EasingDirection[Value]
        end
    })
        ConfigSection.IsLastElement = false
        Library:CheckAutoLoad(Window)
    end
end

getgenv().Library = Library
return Library
