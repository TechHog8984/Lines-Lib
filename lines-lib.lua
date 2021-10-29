local Drawing = assert(Drawing or drawing, 'This ui is based solely on the Drawing API. I am unable to find the Drawing API, so this script will not function at all. Use an exploit like Synapse X, Sentinel, or Protosmasher.')

local events = loadstring(game:HttpGet('https://pastebin.com/raw/3YaYx4gi'))()

local player = game:GetService'Players'.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera
local UIS = game:GetService'UserInputService'

local middle = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
local topleft = Vector2.new(camera.ViewportSize.X / 6 - 100, camera.ViewportSize.Y / 6 + 65)

local leftclicking = false
local rightclicking = false
local oldmousepos = nil

local lib = {}

local function upper(str)
    local list = {
        ['`'] = '~',
        ['1'] = '!',
        ['2'] = '@',
        ['3'] = '#',
        ['4'] = '$',
        ['5'] = '%',
        ['6'] = '^',
        ['7'] = '&',
        ['8'] = '*',
        ['9'] = '(',
        ['0'] = ')',
        ['-'] = '_',
        ['='] = '+',

        ['['] = '{',
        [']'] = '}',
        ['\\'] = '|',

        [';'] = ':',
        ['\''] = '"',

        [','] = '<',
        ['.'] = '>',
        ['/'] = '?',
    }

    return list[str] or str:upper()
end

function lib:CreateGui(guiname)
    local guiname = guiname or 'GUI'
    local gui = {
        parent = nil,
        classname = 'gui',

        children = {},
        descendants = {},

        exists = true,
        lookingat = false,
        draggable = false,

    }
    local mt = {}

    local connections = {}
    local threads = {}
    local objects = {}
    local sections = {}

    local lookingat = nil
    local dragging = nil
    local selectedtextbox = nil

    local cursor = {
        object = Drawing.new'Circle',
        parent = nil,
        classname = 'cursor',

        children = {},
        descendants = {},

        exists = true,
        lookingat = false,
        draggable = false,

    }

    local cursor_object = cursor.object
    cursor_object.ZIndex = 100
    cursor_object.Color = Color3.new(1, 1, 1)
    cursor_object.Thickness = 3
    cursor_object.Radius = 3
    cursor_object.Filled = true

    table.insert(objects, cursor)

    function gui:CreateSection(sectionname)
        local addedobjects = {}
        local name = sectionname or 'section'

        local topbar = {
            object = Drawing.new'Square',

            name = sectionname or 'section',
            parent = gui,
            classname = 'textlabel',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = true,

        }

        local topbarText = {
            object = Drawing.new'Text',

            name = sectionname or 'section',
            parent = topbar,
            classname = 'text',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,

        }
        topbar.text = topbarText

        local closebutton = {
            object = Drawing.new'Square',

            name = 'close',
            parent = topbar,
            classname = 'textbutton',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,

            events = {
                hoverenter = events:CreateEvent('close-hover_enter'),
                hoverleave = events:CreateEvent('close-hover_leave'),
                click = events:CreateEvent('close-click'),

            },
        }

        local closebuttonText = {
            object = Drawing.new'Text',

            name = 'close',
            parent = closebutton,
            classname = 'text',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,

        }
        closebutton.text = closebuttonText


        local minimizebutton = {
            object = Drawing.new'Square',

            name = 'minimize',
            parent = topbar,
            classname = 'textbutton',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,

            events = {
                hoverenter = events:CreateEvent('minimize-hover_enter'),
                hoverleave = events:CreateEvent('minimize-hover_leave'),
                click = events:CreateEvent('minimize-click'),

            },
        }

        local minimizebuttonText = {
            object = Drawing.new'Text',

            name = 'minimize',
            parent = minimizebutton,
            classname = 'text',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,

        }
        minimizebutton.text = minimizebuttonText

        local frame = {
            object = Drawing.new'Square',

            name = sectionname or 'section',
            parent = topbar,
            classname = 'frame',

            children = {},
            descendants = {},

            exists = true,
            lookingat = false,
            dragging = false,
            draggable = false,
            open = true,

            xvelocity = 0,
            yvelocity = 0,

        }

        function frame:GetChildren()
            return frame.children
        end
        function frame:GetDescendants()
            return frame.descendants
        end

        local function objectGetProperty(object, index, value)
            if index then
                if index:sub(1, 4) == 'Text' then
                    if index == 'Text' then
                        return object.text.object.Text
                    end
                    index = index:sub(5, #index)
                    local success, objectTextValue, objectTextObjectValue = pcall(function()return object.text[index], object.text.object[index] end)
                    if success then
                        if objectTextValue ~= nil then
                            return object.text[index]
                        elseif objectTextObjectValue ~= nil then
                            return object.text.object[index]
                        end
                    end
                elseif index:sub(1, 10) == 'Background' then
                    index = index:sub(11, #index)
                    local success, objectObjectValue = pcall(function()return object.object[index] end)
                    if success then
                        return object.object[index]
                    end
                else
                    local success, objectValue, objectObjectValue = pcall(function()return object[index], object.object[index] end)
                    if success then
                        if objectValue ~= nil then
                            return object[index]
                        elseif objectObjectValue ~= nil then
                            return object.object[index]
                        end
                    end
                end
            end
            return nil
        end
        local function objectSetProperty(object, index, value)
            if index then
                if index:sub(1, 4) == 'Text' then
                    if index == 'Text' then
                        object.text.object.Text = value
                        return
                    end
                    index = index:sub(5, #index)
                    local success, objectTextValue, objectTextObjectValue = pcall(function()return object.text[index], object.text.object[index] end)
                    if success then
                        if objectTextValue ~= nil then
                            object.text[index] = value
                            return
                        elseif objectTextObjectValue ~= nil then
                            object.text.object[index] = value
                            return
                        end
                    end
                elseif index:sub(1, 10) == 'Background' then
                    index = index:sub(11, #index)
                    local success, objectObjectValue = pcall(function()return object.object[index] end)
                    if success then
                        object.object[index] = value
                        return
                    end
                else
                    local success, objectValue, objectObjectValue = pcall(function()return object[index], object.object[index] end)
                    if success then
                        if objectValue ~= nil then
                            object[index] = value
                            return
                        elseif objectObjectValue ~= nil then
                            object.object[index] = value
                            return
                        end
                    end
                end
            end
            return nil
        end

        function frame:TextButton(objectName, clickcallback)
            local button = {
                object = Drawing.new'Square',

                name = objectName or 'button',
                parent = frame,
                classname = 'textbutton',

                children = {},
                descendants = {},

                exists = true,
                lookinagat = false,
                dragging = false,
                draggable = false,

                events = {
                    hoverenter = events:CreateEvent((objectName or 'button') .. '-hover_enter'),
                    hoverleave = events:CreateEvent((objectName or 'button') .. '-hover_leave'),
                    click = events:CreateEvent((objectName or 'button') .. '-click'),
                    changed = events:CreateEvent((objectName or 'button') .. '-changed'),

                },

            }
            local text = {
                object = Drawing.new'Text',

                name = objectName or 'button',
                parent = button,
                classname = 'text',

                children = {},
                descendants = {},

                exists = true,
                lookingat = false,
                dragging = false,
                draggable = false,

                events = button.events,

            }
            button.text = text

            local button_object = button.object
            button_object.Visible = true
            button_object.Filled = true
            button_object.Color = Color3.fromRGB(20, 20, 20)
            button_object.ZIndex = 2
            button_object.Thickness = 0
            button_object.Size = Vector2.new(250, 50)

            local posY = 0
            for i, child in pairs(frame:GetChildren()) do
                posY = posY - button_object.Size.Y
            end
            button_object.Position = Vector2.new(frame.object.Position.X, frame.object.Position.Y - posY)

            local text_object = text.object
            text_object.Visible = true
            text_object.Color = Color3.new(1, 1, 1)
            text_object.Text = text.name
            text_object.ZIndex = 3
            text_object.Size = 18
            text_object.Center = true
            text_object.Position = Vector2.new(button_object.Position.X + (button_object.Size.X / 2), button_object.Position.Y + text_object.Size)
            text_object.Font = 3

            button.events.hoverenter:Connect(function()
                text_object.Color = Color3.new(.8, .8, .8)
            end)
            button.events.hoverleave:Connect(function()
                text_object.Color = Color3.new(1, 1, 1)
            end)
            if clickcallback then
                button.events.click:Connect(clickcallback)
            end

            function button:GetEvent(index)
                if index then
                    local result, event = pcall(function()return button.events[index] end)
                    if result and event then
                        return event
                    end
                    return nil
                end
            end

            function button:GetProperty(index, value)
                return objectGetProperty(button, index, value)
            end
            function button:SetProperty(index, value)
                return objectSetProperty(button, index, value)
            end

            table.insert(addedobjects, button)
            table.insert(frame.children, button)
            table.insert(frame.descendants, button)
            table.insert(topbar.descendants, button)
            table.insert(gui.descendants, button)
            table.insert(objects, button)

            table.insert(addedobjects, text)
            table.insert(button.children, text)
            table.insert(button.descendants, text)
            table.insert(frame.descendants, text)
            table.insert(topbar.descendants, text)
            table.insert(gui.descendants, text)
            table.insert(objects, text)

            
            -- this is for indexing properties without the GetProperty method 
            local fake = {}
            setmetatable(fake, {
                __index = function(self, index)
                    if index then
                        if index:sub(1, 4) == 'Text' then
                            local success, selfTextValue, selfTextObjectValue = pcall(function()return button.text[index], button.text.object[index] end)
                            if success and (selfTextValue or selfTextObjectValue) then
                                if selfTextValue then
                                    return button.text[index]
                                elseif selfTextObjectValue then
                                    return button.text.object[index]
                                end
                            end
                        else
                            local success, selfValue, selfObjectValue = pcall(function()return button[index] or button.object[index] end)
                            if success and (selfValue or selfObjectValue) then
                                if selfValue then
                                    return button[index]
                                elseif selfObjectValue then
                                    return button.object[index]
                                end
                            end
                        end
                    end
                end
            })

            return fake
        end

        function frame:TextLabel(objectName, objectText)
            local label = {
                object = Drawing.new'Square',

                name = objectName or 'label',
                parent = frame,
                classname = 'textlabel',

                children = {},
                descendants = {},

                exists = true,
                lookinagat = false,
                dragging = false,
                draggable = false,

                events = {
                    hoverenter = events:CreateEvent((objectName or 'label') .. '-hover_enter'),
                    hoverleave = events:CreateEvent((objectName or 'label') .. '-hover_leave'),
                    changed = events:CreateEvent((objectName or 'label') .. '-changed'),

                },

            }
            local text = {
                object = Drawing.new'Text',

                name = objectName or 'label',
                parent = label,
                classname = 'text',

                children = {},
                descendants = {},

                exists = true,
                lookingat = false,
                dragging = false,
                draggable = false,

                events = label.events,

            }
            label.text = text

            local label_object = label.object
            label_object.Visible = true
            label_object.Filled = true
            label_object.Color = Color3.fromRGB(20, 20, 20)
            label_object.ZIndex = 2
            label_object.Thickness = 0
            label_object.Size = Vector2.new(250, 50)

            local posY = 0
            for i, child in pairs(frame:GetChildren()) do
                posY = posY - label_object.Size.Y
            end
            label_object.Position = Vector2.new(frame.object.Position.X, frame.object.Position.Y - posY)

            local text_object = text.object
            text_object.Visible = true
            text_object.Color = Color3.new(1, 1, 1)
            text_object.Text = objectText or text.name
            text_object.ZIndex = 3
            text_object.Size = 18
            text_object.Center = true
            text_object.Position = Vector2.new(label_object.Position.X + (label_object.Size.X / 2), label_object.Position.Y + text_object.Size)
            text_object.Font = 3

            function label:GetEvent(index)
                if index then
                    local result, event = pcall(function()return label.events[index] end)
                    if result and event then
                        return event
                    end
                    return nil
                end
            end
            function label:GetProperty(index, value)
                return objectGetProperty(label, index, value)
            end
            function label:SetProperty(index, value)
                return objectSetProperty(label, index, value)
            end

            table.insert(addedobjects, label)
            table.insert(frame.children, label)
            table.insert(frame.descendants, label)
            table.insert(topbar.descendants, label)
            table.insert(gui.descendants, label)
            table.insert(objects, label)

            table.insert(addedobjects, text)
            table.insert(label.children, text)
            table.insert(label.descendants, text)
            table.insert(frame.descendants, text)
            table.insert(topbar.descendants, text)
            table.insert(gui.descendants, text)
            table.insert(objects, text)

            return label
        end

        function frame:TextBox(objectName, placeholdertext)
            local textbox = {
                object = Drawing.new'Square',

                name = objectName or 'textbox',
                parent = frame,
                classname = 'textbox',

                children = {},
                descendants = {},

                exists = true,
                lookinagat = false,
                dragging = false,
                draggable = false,
                selected = false,

                events = {
                    hoverenter = events:CreateEvent((objectName or 'textbox') .. '-hover_enter'),
                    hoverleave = events:CreateEvent((objectName or 'textbox') .. '-hover_leave'),
                    selected = events:CreateEvent((objectName or 'textbox') .. '-selected'),
                    unselected = events:CreateEvent((objectName or 'textbox') .. '-unselected'),
                    changed = events:CreateEvent((objectName or 'textbox') .. '-changed'),

                },

                placeholdertext = placeholdertext or nil,
                isplaceholdertext = true,

            }
            local text = {
                object = Drawing.new'Text',

                name = objectName or 'textbox',
                parent = textbox,
                classname = 'text',

                children = {},
                descendants = {},

                exists = true,
                lookingat = false,
                dragging = false,
                draggable = false,

                events = textbox.events,

            }
            textbox.text = text

            local textbox_object = textbox.object
            textbox_object.Visible = true
            textbox_object.Filled = true
            textbox_object.Color = Color3.fromRGB(20, 20, 20)
            textbox_object.ZIndex = 2
            textbox_object.Thickness = 0
            textbox_object.Size = Vector2.new(250, 50)

            local posY = 0
            for i, child in pairs(frame:GetChildren()) do
                posY = posY - textbox_object.Size.Y
            end
            textbox_object.Position = Vector2.new(frame.object.Position.X, frame.object.Position.Y - posY)

            local text_object = text.object
            text_object.Visible = true
            text_object.Color = Color3.new(1, 1, 1)
            text_object.Text = placeholdertext or text.name
            text_object.ZIndex = 3
            text_object.Size = 18
            text_object.Center = true
            text_object.Position = Vector2.new(textbox_object.Position.X + (textbox_object.Size.X / 2), textbox_object.Position.Y + text_object.Size)
            text_object.Font = 3

            textbox.events.selected:Connect(function()
                text_object.Color = Color3.new(.8, .8, .8)
            end)
            textbox.events.unselected:Connect(function()
                text_object.Color = Color3.new(1, 1, 1)
            end)

            function textbox:GetEvent(index)
                if index then
                    local result, event = pcall(function()return textbox.events[index] end)
                    if result and event then
                        return event
                    end
                    return nil
                end
            end
            function textbox:GetProperty(index, value)
                return objectGetProperty(textbox, index, value)
            end
            function textbox:SetProperty(index, value)
                return objectSetProperty(textbox, index, value)
            end

            table.insert(addedobjects, textbox)
            table.insert(frame.children, textbox)
            table.insert(frame.descendants, textbox)
            table.insert(topbar.descendants, textbox)
            table.insert(gui.descendants, textbox)
            table.insert(objects, textbox)

            table.insert(addedobjects, text)
            table.insert(textbox.children, text)
            table.insert(textbox.descendants, text)
            table.insert(frame.descendants, text)
            table.insert(topbar.descendants, text)
            table.insert(gui.descendants, text)
            table.insert(objects, text)

            return textbox
        end

        local topbar_object = topbar.object
        topbar_object.Visible = true
        topbar_object.Filled = true
        topbar_object.Color = Color3.fromRGB(30, 30, 30)
        topbar_object.ZIndex = 1
        topbar_object.Size = Vector2.new(250, 35)

        local topbarText_object = topbarText.object
        topbarText_object.Visible = true
        topbarText_object.Color = Color3.new(1, 1, 1)
        topbarText_object.Text = sectionname or 'section'
        topbarText_object.ZIndex = 2
        topbarText_object.Size = 24
        topbarText_object.Center = true

        local closebutton_object = closebutton.object
        closebutton_object.Visible = true
        closebutton_object.Filled = true
        closebutton_object.Color = Color3.fromRGB(30, 30, 30)
        closebutton_object.ZIndex = 2
        closebutton_object.Thickness = 0
        closebutton_object.Size = Vector2.new(35, 35)

        local closebuttonText_object = closebuttonText.object
        closebuttonText_object.Visible = true
        closebuttonText_object.Color = Color3.new(1, 1, 1)
        closebuttonText_object.Text = 'X'
        closebuttonText_object.ZIndex = 3
        closebuttonText_object.Size = 18
        closebuttonText_object.Center = true
        closebuttonText_object.Font = 3

        local minimizebutton_object = minimizebutton.object
        minimizebutton_object.Visible = true
        minimizebutton_object.Filled = true
        minimizebutton_object.Color = Color3.fromRGB(30, 30, 30)
        minimizebutton_object.ZIndex = 2
        minimizebutton_object.Thickness = 0
        minimizebutton_object.Size = Vector2.new(35, 35)

        local minimizebuttonText_object = minimizebuttonText.object
        minimizebuttonText_object.Visible = true
        minimizebuttonText_object.Color = Color3.new(1, 1, 1)
        minimizebuttonText_object.Text = '-'
        minimizebuttonText_object.ZIndex = 3
        minimizebuttonText_object.Size = 18
        minimizebuttonText_object.Center = true
        minimizebuttonText_object.Font = 3

        local frame_object = frame.object
        frame_object.Visible = true
        frame_object.Filled = true
        frame_object.Color = Color3.fromRGB(30, 30, 30)
        frame_object.ZIndex = 1
        frame_object.Thickness = 0
        frame_object.Size = Vector2.new(250, 350)

        local posX = 0
        for i, section in pairs(sections) do
            posX = posX - frame_object.Size.X - 30
        end
        frame_object.Position = Vector2.new(topleft.X - frame_object.Size.X / 2 - posX, topleft.Y - frame_object.Size.Y / 2)

        topbar_object.Position = Vector2.new(frame_object.Position.X, frame_object.Position.Y - topbar_object.Size.Y)
        
        topbarText_object.Position = Vector2.new(topbar_object.Position.X + (topbar_object.Size.X / 2), topbar_object.Position.Y + topbarText_object.Size / 4)
        
        closebutton_object.Position = Vector2.new(topbar_object.Position.X + (topbar_object.Size.X - closebutton_object.Size.X), topbar_object.Position.Y)
        
        closebuttonText_object.Position = Vector2.new(closebutton_object.Position.X + (closebutton_object.Size.X / 2), topbarText_object.Position.Y)
        
        minimizebutton_object.Position = Vector2.new(closebutton_object.Position.X - minimizebutton_object.Size.X, closebutton_object.Position.Y)
        
        minimizebuttonText_object.Position = Vector2.new(minimizebutton_object.Position.X + (minimizebutton_object.Size.X / 2), topbarText_object.Position.Y)

        closebutton.events.click:Connect(function()
            for i, object in pairs(addedobjects) do 
                if object and object.exists == true and object.object then
                    table.remove(objects, table.find(objects, object))

                    if object == lookingat then
                        lookingat = nil
                    end
                    if object.events then
                        for i, event in pairs(object.events) do
                            event:DisconnectAll()
                        end
                    end
                    object.exists = false
                    object.object:Remove()
                    object = nil
                end
            end
            addedobjects = {}
            table.remove(sections, table.find(sections, frame))
            if #sections < 1 then
                if cursor then
                    if cursor.object then
                        cursor.object:Remove()
                    end
                    cursor.exists = false
                    cursor = nil
                end
                objects = {}
                sections = {}
                for i, connection in pairs(connections) do
                    connection:Disconnect()
                end
                for thread, event in pairs(threads) do
                    if thread and event then
                        event:Fire()
                        threads[thread] = nil
                        thread = nil
                        event:DisconnectAll()
                        event = nil
                    end
                end
            end
        end)
        minimizebutton.events.click:Connect(function()
            frame.open = not frame.open
            for i, descendant in pairs(frame.descendants) do
                if descendant and descendant.object and descendant.exists == true then
                    descendant.object.Visible = frame.open
                end
            end
            if frame.object then
                frame.object.Visible = frame.open
            end
            if minimizebutton and minimizebutton.exists == true and minimizebuttonText and minimizebuttonText.exists == true and minimizebuttonText.object then
                if frame.open then
                    minimizebuttonText.object.Text = '-'
                else
                    minimizebuttonText.object.Text = '+'
                end
            end
        end)

        local velocityEvent = events:CreateEvent()

        local velocityThread = coroutine.create(function()
            local active = true
            velocityEvent.Event:Connect(function()
                active = false
                coroutine.yield()
            end)
            while active do
                wait()
                if frame and frame.exists == true and frame.object and frame.xvelocity and frame.yvelocity then
                    frame.xvelocity = frame.xvelocity / 1.3
                    frame.yvelocity = frame.yvelocity / 1.3

                    frame.object.Position = frame.object.Position + Vector2.new(frame.xvelocity, frame.yvelocity)
                    print(frame.xvelocity, frame.yvelocity)
                end
            end
        end)

        threads[velocityThread] = velocityEvent

        table.insert(addedobjects, topbar)
        table.insert(gui.descendants, topbar)
        table.insert(gui.children, topbar)
        table.insert(objects, topbar)

        table.insert(addedobjects, topbarText)
        table.insert(gui.descendants, topbarText)
        table.insert(topbar.descendants, topbarText)
        table.insert(topbar.children, topbarText)
        table.insert(objects, topbarText)

        table.insert(addedobjects, closebutton)
        table.insert(gui.descendants, closebutton)
        table.insert(topbar.descendants, closebutton)
        table.insert(topbar.children, closebutton)
        table.insert(objects, closebutton)

        table.insert(addedobjects, closebuttonText)
        table.insert(gui.descendants, closebuttonText)
        table.insert(topbar.descendants, closebuttonText)
        table.insert(closebutton.children, closebuttonText)
        table.insert(objects, closebuttonText)

        table.insert(addedobjects, minimizebutton)
        table.insert(gui.descendants, minimizebutton)
        table.insert(topbar.descendants, minimizebutton)
        table.insert(topbar.children, minimizebutton)
        table.insert(objects, minimizebutton)

        table.insert(addedobjects, minimizebuttonText)
        table.insert(gui.descendants, minimizebuttonText)
        table.insert(topbar.descendants, minimizebuttonText)
        table.insert(minimizebutton.children, minimizebuttonText)
        table.insert(objects, minimizebuttonText)

        table.insert(addedobjects, frame)
        table.insert(gui.descendants, frame)
        table.insert(topbar.children, frame)
        table.insert(topbar.descendants, frame)
        table.insert(objects, frame)
        table.insert(sections, frame)

        return frame
    end

    function gui:GetChildren()
        return gui.children
    end
    function gui:GetDescendants()
        return gui.descendants
    end

    local function mousemove()
        local mousepos = Vector2.new(mouse.X, mouse.Y)

        for i, object in pairs(objects) do 
            local success, exists, drawing, drawingvisible, drawingsize, drawingsizetype = pcall(function() return object.exists, object.object, object.object.Visible, object.object.Size, typeof(object.object.Size) end)
            if object and exists == true and drawing and drawingvisible == true and drawingsizetype and drawingsizetype == 'Vector2' then
                local objectPos = drawing.Position
                local oldLookingat = object.lookingat
                local newLookingat = mousepos.X >= objectPos.X and mousepos.X <= objectPos.X + drawing.Size.X and mousepos.Y >= objectPos.Y - 35 and mousepos.Y <= objectPos.Y + drawing.Size.Y - 35
                object.lookingat = newLookingat
                if newLookingat then
                    if lookingat then
                        if drawing.ZIndex > lookingat.object.ZIndex then
                            lookingat = object
                        end
                    else
                        lookingat = object
                    end
                elseif lookingat == object then
                    lookingat = nil
                end
                if object.events then
                    if newLookingat ~= oldLookingat then
                        if object.events.hoverenter and newLookingat and not oldLookingat then
                            object.events.hoverenter:Fire()
                        elseif object.events.hoverleave and not newLookingat and oldLookingat then
                            object.events.hoverleave:Fire()
                        end
                    end
                end
            end
        end

        if lookingat and lookingat.exists == true then
            if cursor and cursor.exists == true and cursor.object then 
                cursor.object.Position = Vector2.new(mousepos.X, mousepos.Y + 35)
                cursor.object.Visible = true
            end
        elseif cursor and cursor.exists == true and cursor.object then 
            cursor.object.Visible = false
        end
        if dragging and dragging.object and oldmousepos then
            dragging.object.Position = Vector2.new(dragging.object.Position.X + (mousepos.X - oldmousepos.X), dragging.object.Position.Y + (mousepos.Y - oldmousepos.Y))
            
            local x = dragging.object.Position.X
            local xDestination = x + (mousepos.X - oldmousepos.X)

            local y = dragging.object.Position.Y
            local yDestination = y + (mousepos.Y - oldmousepos.Y)

            if dragging.xvelocity and dragging.yvelocity then
                if x > xDestination then
                    dragging.xvelocity = dragging.xvelocity - i
                elseif x < xDestination then
                    dragging.xvelocity = dragging.xvelocity + i
                end

                if y > yDestination then
                    dragging.yvelocity = dragging.yvelocity - i
                elseif y < yDestination then
                    dragging.yvelocity = dragging.yvelocity + i
                end
            end
            
            for i, descendant in pairs(dragging.descendants) do
                if descendant and descendant.exists == true and descendant.object then
                    descendant.object.Position = Vector2.new(descendant.object.Position.X + (mousepos.X - oldmousepos.X), descendant.object.Position.Y + (mousepos.Y - oldmousepos.Y))
                end
            end
        end
        oldmousepos = mousepos
    end
    local function button1down()
        leftclicking = true
        if lookingat and lookingat.exists == true then
            if lookingat.classname == 'textbox' then
                if selectedtextbox ~= lookingat then
                    if selectedtextbox then
                        selectedtextbox.selected = false
                        local success, unselectedevent = pcall(function()return selectedtextbox.events.unselected end)
                        if success and unselectedevent then
                            unselectedevent:Fire()
                        end
                    end

                    local success, selected, selectedevent = pcall(function()return lookingat.selected, lookingat.events.selected end)
                    if success then
                        if selected == false then
                            lookingat.selected = true
                        end
                        if selectedevent then
                            selectedevent:Fire()
                        end
                    end
                    selectedtextbox = lookingat 
                end
            end
            if selectedtextbox and lookingat ~= selectedtextbox then
                selectedtextbox.selected = false
                local success, unselectedevent = pcall(function()return selectedtextbox.events.unselected end)
                if success and unselectedevent then
                    unselectedevent:Fire()
                end
                selectedtextbox = nil
            end
            if lookingat.draggable == true then
                lookingat.dragging = true
                dragging = lookingat
            end
            local success, clickevent = pcall(function()return lookingat.events.click end)
            if success and clickevent then
                clickevent:Fire()
            end
        elseif selectedtextbox then
            selectedtextbox.selected = false
            local success, unselectedevent = pcall(function()return selectedtextbox.events.unselected end)
            if success and unselectedevent then
                unselectedevent:Fire()
            end
            selectedtextbox = nil
        end
    end
    local function button1up()
        leftclicking = false
        if dragging and dragging.exists == true and dragging.dragging == true then
            dragging.dragging = false
        end
        dragging = nil
    end
    local function button2down()
        rightclicking = true
    end
    local function button2up()
        rightclicking = false
    end

    table.insert(connections, UIS.InputBegan:connect(function(Input)
        if selectedtextbox and selectedtextbox.exists == true then
            local success, text = pcall(function()return selectedtextbox.text end)
            if success and text and text.exists == true and text.object then
                local textchanged = false

                local comb = tostring(Input.KeyCode):gsub('Enum.KeyCode.', '')
                local key = UIS:GetStringForKeyCode(Input.KeyCode):lower()

                if key and #key > 0 then
                    if UIS:IsKeyDown(Enum.KeyCode.LeftShift) then
                        key = upper(key)
                    end

                    text.object.Text = text.object.Text .. key

                    textchanged = true
                elseif comb == 'Backspace' and selectedtextbox.isplaceholdertext == false then
                    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then
                        text.object.Text = ''
                    else
                        text.object.Text = text.object.Text:sub(1, #text.object.Text - 1)
                    end

                    textchanged = true
                end

                if textchanged then
                    if selectedtextbox.isplaceholdertext == true then
                        selectedtextbox.isplaceholdertext = false
                        text.object.Text = text.object.Text:sub((#selectedtextbox.placeholdertext + 1 or ''), #text.object.Text)
                    elseif text.object.Text == '' then
                        selectedtextbox.isplaceholdertext = true
                        text.object.Text = selectedtextbox.placeholdertext or ''
                    end
                    local success, changedevent = pcall(function()return selectedtextbox.events.changed end)
                    if success and changedevent then
                        changedevent:Fire('Text', text.object.Text)
                    end
                end
            end
        end
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            button1down()
        elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
            button2down()
        end
    end))

    table.insert(connections, UIS.InputEnded:connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            button1up()
        elseif Input.UserInputType == Enum.UserInputType.MouseButton2 then
            button2up()
        end
    end))

    table.insert(connections, UIS.InputChanged:connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement then
            mousemove()
        end
    end))

    return gui
end

if not shared.__lineslib__ then
    print'Thanks for using Lines Lib - TechHog'
end
shared.__lineslib__ = lib

return lib
