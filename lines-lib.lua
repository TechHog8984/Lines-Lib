assert(Drawing, 'This ui is based solely on the Drawing library. You do not have this library, so this script will not function at all. Use an exploit like Synapse X.')

local events = loadstring(game:HttpGet('https://pastebin.com/raw/3YaYx4gi'))()

local player = game:GetService'Players'.LocalPlayer
local mouse = player:GetMouse()
local camera = workspace.CurrentCamera

local middle = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
local topleft = Vector2.new(camera.ViewportSize.X / 6 - 100, camera.ViewportSize.Y / 6 + 65)

local leftclicking = false
local rightclicking = false
local oldmousepos = nil

local lib = {}

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
    local objects = {}
    local sections = {}

    local lookingat = nil
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

        }

        function frame:GetChildren()
            return frame.children
        end
        function frame:GetDescendants()
            return frame.descendants
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

            return button
        end

        function frame:TextLabel(objectName)
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
            text_object.Text = text.name
            text_object.ZIndex = 3
            text_object.Size = 18
            text_object.Center = true
            text_object.Position = Vector2.new(label_object.Position.X + (label_object.Size.X / 2), label_object.Position.Y + text_object.Size)
            text_object.Font = 3

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

                },

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
            text_object.Text = text.name
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
                    table.remove(objects, table.find(objects, object))
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
        table.insert(sections, frame)
        table.insert(gui.descendants, frame)
        table.insert(topbar.children, frame)
        table.insert(topbar.descendants, frame)
        table.insert(objects, frame)

        return frame
    end

    function gui:GetChildren()
        return gui.children
    end
    function gui:GetDescendants()
        return gui.descendants
    end

    table.insert(connections, mouse.Move:connect(function()
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
            if lookingat.dragging == true and lookingat.object and oldmousepos then
                lookingat.object.Position = Vector2.new(lookingat.object.Position.X + (mousepos.X - oldmousepos.X), lookingat.object.Position.Y + (mousepos.Y - oldmousepos.Y))
                for i, descendant in pairs(lookingat.descendants) do
                    if descendant and descendant.exists == true and descendant.object then
                        descendant.object.Position = Vector2.new(descendant.object.Position.X + (mousepos.X - oldmousepos.X), descendant.object.Position.Y + (mousepos.Y - oldmousepos.Y))
                    end
                end
            end
        elseif cursor and cursor.exists == true and cursor.object then 
            cursor.object.Visible = false
        end
        oldmousepos = mousepos
    end))

    table.insert(connections, mouse.KeyDown:connect(function(keypressed)
        if selectedtextbox and selectedtextbox.exists == true then
            local success, text = pcall(function()return selectedtextbox.text end)
            if success and text and text.exists == true and text.object then
                text.object.Text = text.object.Text .. keypressed
            end
        end
    end))

    table.insert(connections, mouse.Button1Down:connect(function()
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
    end))
    table.insert(connections, mouse.Button1Up:connect(function()
        leftclicking = false
        for i, object in pairs(objects) do
            if object and object.exists == true then
                object.dragging = false
            end
        end
    end))

    table.insert(connections, mouse.Button2Down:connect(function()
        rightclicking = true
    end))

    table.insert(connections, mouse.Button2Up:connect(function()
        rightclicking = false
    end))

    return gui
end

print'Thanks for using Lines Lib! Lines Lib was developed by me, TechHog.\nYou can find my github at https://github.com/TechHog8984 and my discord at.\nIf you have any questions or suggestions or if you just want to contact me for any reason, my discord is TechHog#8984 (402264559509045258).'

return gui
