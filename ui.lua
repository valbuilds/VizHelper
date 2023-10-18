uiLoad = function()
    imgui.love.Init()

    -- setup fonts
    local imio = imgui.GetIO()
    
    imio.ConfigWindowsMoveFromTitleBarOnly = true
    imio.ConfigDockingWithShift = true

    local config = imgui.ImFontConfig()
    config.FontDataOwnedByAtlas = false -- it's important to set this, or imgui.love.Shutdown() will crash trying to free already freed memory

    local font_size = 18
    local content, size = love.filesystem.read("fonts/reith/sans/regular.ttf")
    local contentBold, sizeBold = love.filesystem.read("fonts/reith/sans/bold.ttf")
    local newfont = imio.Fonts:AddFontFromMemoryTTF(ffi.cast("void*", content), size, font_size, config)
    ScriptEditorFont = imio.Fonts:AddFontFromMemoryTTF(ffi.cast("void*", content), size, 22, config)
    NCSEditorFont = imio.Fonts:AddFontFromMemoryTTF(ffi.cast("void*", content), size, 25, config)
    title = imio.Fonts:AddFontFromMemoryTTF(ffi.cast("void*", contentBold), sizeBold, 18, config)
    header = imio.Fonts:AddFontFromMemoryTTF(ffi.cast("void*", contentBold), sizeBold, 45, config)
    imio.FontDefault = newfont

    imgui.love.BuildFontAtlas()
end

require "home"
require "menus.connectioncontrols"
require "menus.astoncontrols"
require "menus.tickercontrols"

connetionControlMenuOpen = ffi.new("bool[1]", false)
astonControlMenuOpen = ffi.new("bool[1]", false)
tickerControlMenuOpen = ffi.new("bool[1]", false)
playoutControlMenuOpen = ffi.new("bool[1]", false)
brandingControlMenuOpen = ffi.new("bool[1]", false)
headlineControlMenuOpen = ffi.new("bool[1]", false)
identityControlMenuOpen = ffi.new("bool[1]", false)
liveBugControlMenuOpen = ffi.new("bool[1]", false)
automationControlMenuOpen = ffi.new("bool[1]", false)

uiDraw = function()
    love.graphics.setBackgroundColor(0, 0, 0, 1)

    buildHome()

    buildConnectionControlsMenu()
    buildAstonControlsMenu()
    buildTickerControlsMenu()

    imgui.Render()
    imgui.love.RenderDrawLists()
end

uiUpdate = function(dt)
    imgui.love.Update(dt)
    imgui.NewFrame()
end