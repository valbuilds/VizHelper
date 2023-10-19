import imgui

import var

def build():
    imgui.set_next_window_size(500, 400)
    imgui.set_next_window_position(30, 50)
    imgui.begin("Home", False, imgui.WINDOW_NO_SAVED_SETTINGS | imgui.WINDOW_NO_RESIZE | imgui.WINDOW_NO_TITLE_BAR | imgui.WINDOW_NO_BACKGROUND | imgui.WINDOW_NO_MOVE | imgui.WINDOW_NO_BRING_TO_FRONT_ON_FOCUS)
    
    imgui.text("vizhelper :3")
    imgui.separator()
    if imgui.button("Aston", 100, 100):
        var.showAstonControls = True
    imgui.same_line()
    if imgui.button("Ticker", 100, 100):
        var.showTickerControls = True
    imgui.same_line()
    if imgui.button("Playout", 100, 100):
        var.showPlayoutControls = True

    if imgui.button("Branding", 100, 100):
        ...
    imgui.same_line()
    if imgui.button("Ticker", 100, 100):
        ...
    imgui.same_line()
    if imgui.button("Automation", 100, 100):
        ...
    

    imgui.end()
