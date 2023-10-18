function buildHome()
    imgui.SetNextWindowSize(imgui.ImVec2_Float(500,400))
    imgui.Begin("VizHelper", nil, imgui.love.WindowFlags("NoSavedSettings","NoResize", "NoTitleBar", "NoBorders", "NoMove", "NoBackground","NoBringToFrontOnFocus"))
        imgui.SetWindowPos_Vec2(imgui.ImVec2_Float(30, 15))

        imgui.Text("Welcome to VizHelper!")

        imgui.Separator()
        
        if imgui.Button("Connection Controls") then
            connetionControlMenuOpen[0] = true
        end

        imgui.Separator()

        if imgui.Button("Astons", imgui.ImVec2_Float(100, 100)) then
            astonControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Ticker", imgui.ImVec2_Float(100, 100)) then
            tickerControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Playout", imgui.ImVec2_Float(100, 100)) then
            playoutControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Branding", imgui.ImVec2_Float(100, 100)) then
            brandingControlMenuOpen[0] = true
        end
        

        if imgui.Button("Headlines", imgui.ImVec2_Float(100, 100)) then
            headlineControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Identity", imgui.ImVec2_Float(100, 100)) then
            identityControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Live Bug", imgui.ImVec2_Float(100, 100)) then
            liveBugControlMenuOpen[0] = true
        end
        imgui.SameLine()
        if imgui.Button("Automation", imgui.ImVec2_Float(100, 100)) then
            automationControlMenuOpen[0] = true
        end
    imgui.End()
end