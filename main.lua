-- set identity
love.filesystem.setIdentity("VizHelper fork")

-- setup server
local sock = require ("lib.sock")
client = sock.newClient("*", 10655)
client:connect()
connected = false

-- setup imgui
ffi = require "ffi"
local libPath = love.filesystem.getSaveDirectory() .. "/libraries"
local extension = jit.os == "Windows" and "dll" or jit.os == "Linux" and "so" or jit.os == "OSX" and "dylib"
package.cpath = string.format("%s;%s/?.%s", package.cpath, lib_path, extension)

imgui = require "lib.cimgui"
local imio = imgui.GetIO()

-- debug
debug = true

-- ui setup
require "ui"

-- server functions
client:on("connect", function(data)
    connected = true
end)

client:on("disconnect", function(data)
    connected = false
end)

-- love functions
love.load = function()
    uiLoad()
end

love.draw = function()
    if debug then
        imgui.ShowDemoWindow()
    end
    
    uiDraw()
end

love.update = function(dt)
    uiUpdate(dt)
end




love.mousemoved = function(x, y, ...)
    imgui.love.MouseMoved(x, y)
    if not imgui.love.GetWantCaptureMouse() then
        -- your code here
    end
end

love.mousepressed = function(x, y, button, ...)
    imgui.love.MousePressed(button)
    if not imgui.love.GetWantCaptureMouse() then
        -- your code here 
    end
end

love.mousereleased = function(x, y, button, ...)
    imgui.love.MouseReleased(button)
    if not imgui.love.GetWantCaptureMouse() then
        -- your code here 
    end
end

love.wheelmoved = function(x, y)
    imgui.love.WheelMoved(x, y)
    if not imgui.love.GetWantCaptureMouse() then
        -- your code here 
    end
end

love.keypressed = function(key, ...)
    imgui.love.KeyPressed(key)
    if not imgui.love.GetWantCaptureKeyboard() then
        -- your code here 
    end
end

love.keyreleased = function(key, ...)
    imgui.love.KeyReleased(key)
    if not imgui.love.GetWantCaptureKeyboard() then
        -- your code here 
    end
end

love.textinput = function(t)
    imgui.love.TextInput(t)
    if imgui.love.GetWantCaptureKeyboard() then
        -- your code here 
    end
end

love.quit = function()
    return imgui.love.Shutdown()
end