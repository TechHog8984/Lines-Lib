--see this gui at URL

--local lib = loadstring(game:HttpGet('https://raw.githubusercontent.com/TechHog8984/Lines-Lib/main/lines-lib.lua'))()


local gui = lib:CreateGui('Awesome GUI')

local section1 = gui:CreateSection('Section1')

local button1 = nil
local label1 = nil
button1 = section1:TextButton('Button1', function()
    coroutine.wrap(function()
        local originalBackgroundColor = button1:GetProperty('BackgroundColor')
        print('making text invisible')
        button1:SetProperty('TextVisible', false)
        wait(1)
        print('making text visible')
        button1:SetProperty('TextVisible', true)
        wait(1)
        print('setting backgroundcolor to pink')
        button1:SetProperty('BackgroundColor', Color3.fromRGB(255, 0, 150))
        wait(1)
        print('setting backgroundtransparency to 0')
        button1:SetProperty('BackgroundTransparency', 0)
        wait(1)
        print('setting backgroundtransparency to 1')
        button1:SetProperty('BackgroundTransparency', 1)
        wait(1)
        print('setting backgroundcolor to original')
        button1:SetProperty('BackgroundColor', originalBackgroundColor)
    end)()
    coroutine.wrap(function()
        label1:SetProperty('Text', 'lol')
        wait(1)
        label1:SetProperty('Text', 'label1')
        wait(1)
        label1:SetProperty('TextTransparency', .5)
        wait(1)
        label1:SetProperty('TextColor', Color3.new(0, 0, 0))
        label1:SetProperty('BackgroundColor', Color3.new(1, 1, 1))
        wait(1)
        label1:SetProperty('TextColor', Color3.new(1, 1, 1))
        label1:SetProperty('BackgroundTransparency', 0)
    end)()
end)

label1 = section1:TextLabel('Label1')
