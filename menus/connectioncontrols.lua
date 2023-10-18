function buildConnectionControlsMenu()
    if connetionControlMenuOpen[0] then
        imgui.Begin("Connection Control", showLowerThirdCon, imgui.love.WindowFlags("NoSavedSettings"))
            imgui.SetWindowSize_Vec2(imgui.ImVec2_Float(200,120))
            local connectionstatus = "Connected to Viz!"
            if connected == false then
                connectionstatus = "Disconnected from Viz."
            end
            imgui.Text(connectionstatus)
            if imgui.Button("Connect") then
                client:connect()
            end
            imgui.SameLine()
            if imgui.Button("Disconnect") then
                client:disconnect()
            end

            imgui.Separator()

            if imgui.Button("Force disconnect") then
                client:disconnect()
                connected = false
            end
        imgui.End()
    end
end