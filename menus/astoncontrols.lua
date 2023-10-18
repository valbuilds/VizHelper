local presetBadges = {}

inputAstonsTextTopLine = ffi.new("char[1024]", "")
inputAstonsTextBottomLine1 = ffi.new("char[1024]", "")
inputAstonsTextBottomLine2 = ffi.new("char[1024]", "")
inputAstonsTextBox = ffi.new("char[1024]", "")
inputAstonsBreakingTopLine = ffi.new("char[1024]", "")
inputAstonsBreakingBottomLine1 = ffi.new("char[1024]", "")
inputAstonsBreakingBottomLine2 = ffi.new("char[1024]", "")
inputAstonsBreakingBox = ffi.new("bool[1]", false)
inputAstonsBadgeProgrammeText = ffi.new("char[1024]", "")
inputAstonsBadgeProgrammeBadgeColour = ffi.new("float[3]",{0.68,0,0})
inputAstonsBadgeProgrammeTextColour = ffi.new("float[3]",{1,1,1})
inputAstonsBadgeSocialsText = ffi.new("char[1024]", "")
inputAstonsBadgeCreditsText = ffi.new("char[1024]", "")

function buildAstonControlsMenu()
    if astonControlMenuOpen[0] then
        imgui.Begin("Aston Control", astonControlMenuOpen, imgui.love.WindowFlags("NoSavedSettings"))
            imgui.SetWindowSize_Vec2(imgui.ImVec2_Float(800,400))
            imgui.Text("* indicates a required field")
            imgui.Separator()
            if imgui.Button("Show Astons") then
                client:send("headline", {Type = "ShowAstons"})
            end
            imgui.SameLine()
            if imgui.Button("Hide Astons") then
                client:send("headline", {Type = "HideAstons"})
            end

            imgui.Separator()

            -- text straps
            imgui.PushFont(header)
            imgui.Text("Text Straps")
            imgui.PopFont()

            imgui.Text("Top Line:*") imgui.SameLine()
            imgui.InputText("###inputAstonsTextTopLine", inputAstonsTextTopLine, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###inputAstonsTextBottomLine1", inputAstonsTextBottomLine1, 1024)
            imgui.Text("Bottom Line (2/2):") imgui.SameLine()
            imgui.InputText("###inputAstonsTextBottomLine2", inputAstonsTextBottomLine2, 1024)
            imgui.Text("Box Text:") imgui.SameLine()
            imgui.InputText("###inputAstonsTextBottomLine2", inputAstonsTextBox, 1024)

            if imgui.Button("Show/Update Strap") then
                if ffi.string(inputAstonsTextTopLine) == "" then
                    showerror = true
                    errorTitle = "Missing field!"
                    errorMessage = "No value for 'inputAstonsTextTopLine'. Please fill out that field."
                    return
                end
                client:send("headline", {Type = "ShowAstonsTextStrap", Text = ffi.string(inputAstonsTextTopLine).."\n"..ffi.string(inputAstonsTextBottomLine1).."\n"..ffi.string(inputAstonsTextBottomLine2), BoxText = ffi.string(inputAstonsTextBox)})
            end
            imgui.SameLine()
            if imgui.Button("Hide Strap") then
                client:send("headline", {Type = "HideAstonsTextStrap"})
            end

            imgui.Separator()

            -- breaking straps
            imgui.PushFont(header)
            imgui.Text("Breaking Straps")
            imgui.PopFont()

            imgui.Text("Top Line:*") imgui.SameLine()
            imgui.InputText("###inputAstonsBreakingTopLine", inputAstonsBreakingTopLine, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###inputAstonsBreakingBottomLine1", inputAstonsBreakingBottomLine1, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###inputAstonsBreakingBottomLine2", inputAstonsBreakingBottomLine2, 1024)

            imgui.Checkbox("'BREAKING' Box", inputAstonsBreakingBox)

            if imgui.Button("Show/Update Strap") then
                if ffi.string(inputAstonsBreakingStoryName) == "" then
                    showError = true
                    errorTitle = "You missed a field!"
                    errorMessage = "No value for 'inputAstonsBreakingStoryName'. Please fill out that field."
                    return
                end

                client:send("headline", {Type = "ShowAstonsBreaking", Text = ffi.string(inputAstonsBreakingStoryName).."\n"..ffi.string(inputAstonsBreakingBottomLine1).."\n"..ffi.string(inputAstonsBreakingBottomLine2), Box = ffi.bool(inputAstonsBreakingBox)})
            end
            imgui.SameLine()
            if imgui.Button("Hide Strap") then
                client:send("headline", {Type = "HideAstonsBreaking"})
            end

            imgui.Separator()

            -- badges
            imgui.PushFont(header)
            imgui.Text("Badges")
            imgui.PopFont()
            if imgui.BeginTabBar("Badges") then
                if imgui.BeginTabItem("Programme Badge") then
                    imgui.Text("Badge Text") imgui.SameLine()
                    imgui.InputText("###inputAstonsBadgeProgrammeText", inputAstonsBadgeProgrammeText, 1024)
                    imgui.Text("Badge Colour") imgui.SameLine()
                    imgui.ColorEdit3("###inputAstonsBadgeProgrammeBadgeColour", inputAstonsBadgeProgrammeBadgeColour, imgui.love.ColorEditFlags("None"))
                    imgui.Text("Text Colour") imgui.SameLine()
                    imgui.ColorEdit3("###inputAstonsBadgeProgrammeTextColour", inputAstonsBadgeProgrammeTextColour, imgui.love.ColorEditFlags("None"))

                    if imgui.Button("Set Badge") then
                        client:send("headline", {Type = "SetAstonsProgrammeBadge", Text = ffi.string(inputAstonsBadgeProgrammeText), TextColour = convertTableToCondensedString({inputAstonsBadgeProgrammeTextColour[0], inputAstonsBadgeProgrammeTextColour[1], inputAstonsBadgeProgrammeTextColour[2]}), BackgroundColour = convertTableToCondensedString({inputAstonsBadgeProgrammeBadgeColour[0], inputAstonsBadgeProgrammeBadgeColour[1], inputAstonsBadgeProgrammeBadgeColour[2]})})
                    end
                    imgui.SameLine()
                    if imgui.Button("Remove Badge") then
                        client:send("headline", {Type = "RemoveAstonsProgrammeBadge"})
                    end

                    if imgui.Button("Show Badge") then
                        client:send("headline", {Type = "ShowAstonsProgrammeBadge", Text = ffi.string(inputAstonsBadgeProgrammeText), TextColour = convertTableToCondensedString({inputAstonsBadgeProgrammeTextColour[0], inputAstonsBadgeProgrammeTextColour[1], inputAstonsBadgeProgrammeTextColour[2]}), BackgroundColour = convertTableToCondensedString({inputAstonsBadgeProgrammeBadgeColour[0], inputAstonsBadgeProgrammeBadgeColour[1], inputAstonsBadgeProgrammeBadgeColour[2]})})
                    end
                    imgui.SameLine()
                    if imgui.Button("Hide Badge") then
                        client:send("headline", {Type = "HideAstonsProgrammeBadge"})
                    end

                    imgui.PushFont(title)
                    imgui.Text("Saved badges")
                    imgui.PopFont()
                    imgui.BeginListBox("###inputAstonsSavedProgrammeBadges",imgui.ImVec2_Float(300, 80))
                        ---@diagnostic disable-next-line: param-type-mismatch
                        for i, v in ipairs(presetBadges) do
                            local selected = false
                            if presetBadgeSelected == i then
                                selected = true
                            end

                            if imgui.Selectable_Bool(v[1].."###"..i, selected) then
                                presetBadgeSelected = i
                                inputAstonsBadgeProgrammeText = ffi.new("char[1024]", v[1])
                                inputAstonsBadgeProgrammeTextColour[0] = v.tcolor[1]
                                inputAstonsBadgeProgrammeTextColour[1] = v.tcolor[2]
                                inputAstonsBadgeProgrammeTextColour[2] = v.tcolor[3]
                                inputAstonsBadgeProgrammeBadgeColour[0] = v.bcolor[1]
                                inputAstonsBadgeProgrammeBadgeColour[1] = v.bcolor[2]
                                inputAstonsBadgeProgrammeBadgeColour[2] = v.bcolor[3]
                            end
                            imgui.SameLine()
                            imgui.PushStyleColor_Vec4(imgui.ImGuiCol_ChildBg, imgui.ImVec4_Float(v.bcolor[1], v.bcolor[2], v.bcolor[3], 1))
                                imgui.BeginChild_Str("###programBadgeColExample"..i, imgui.ImVec2_Float(30,18))
                                imgui.EndChild()
                            imgui.PopStyleColor()
                        end
                    imgui.EndListBox()

                    if imgui.Button("Save badge") then
                        table.insert(presetBadges, {ffi.string(inputAstonsBadgeProgrammeText), tcolor = {inputAstonsBadgeProgrammeTextColour[0], inputAstonsBadgeProgrammeTextColour[1], inputAstonsBadgeProgrammeTextColour[2]}, bcolor = {inputAstonsBadgeProgrammeBadgeColour[0], inputAstonsBadgeProgrammeBadgeColour[1], inputAstonsBadgeProgrammeBadgeColour[2]}})
                    end
                    imgui.SameLine()
                    if imgui.Button("Remove selected badge") then
                        table.remove(presetBadges, presetBadgeSelected)
                        presetBadgeSelected = 0
                    end

                    imgui.EndTabItem()
                end
                if imgui.BeginTabItem("Other badges") then
                    imgui.Text("Socials badge:") imgui.SameLine()
                    imgui.InputText("###inputAstonsBadgeSocialsText", inputAstonsBadgeSocialsText, 1024) imgui.SameLine()
                    if imgui.Button("Show") then
                        client:send("headline", {Type = "ShowAstonsSocialsBadge", Text = ffi.string(inputAstonsBadgeSocialsText)})
                    end
                    imgui.SameLine()
                    if imgui.Button("Hide") then
                        client:send("headline", {Type = "HideAstonsSocialsBadge"})
                    end

                    imgui.Text("Credits badge:") imgui.SameLine()
                    imgui.InputText("###inputAstonsBadgeCreditsText", inputAstonsBadgeCreditsText, 1024) imgui.SameLine()
                    if imgui.Button("Show") then
                        client:send("headline", {Type = "ShowAstonsCreditsBadge", Text = ffi.string(inputAstonsBadgeCreditsText)})
                    end
                    imgui.SameLine()
                    if imgui.Button("Hide") then
                        client:send("headline", {Type = "HideAstonsCreditsBadge"})
                    end

                    imgui.EndTabItem()
                end
                imgui.EndTabBar()
            end
        imgui.End()
    end
end