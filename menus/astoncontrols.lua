require "convert"

local presetBadges = {
    {"ACROSS THE UK", bcolour = {.7,0,0,1}, tcolour = {1,1,1,1}}
}

local topLine = ffi.new("char[1024]", "")
local bottomLine1 = ffi.new("char[1024]", "")
local bottomLine2 = ffi.new("char[1024]", "")
local box = ffi.new("char[1024]", "")
local breakingTopLine = ffi.new("char[1024]", "")
local breakingBottomLine1 = ffi.new("char[1024]", "")
local breakingBottomLine2 = ffi.new("char[1024]", "")
local breakingBox = ffi.new("bool[1]", false)
local badgeProgrammeText = ffi.new("char[1024]", "")
local badgeProgrammeBadgeColour = ffi.new("float[3]",{0.68,0,0})
local badgeProgrammeTextColour = ffi.new("float[3]",{1,1,1})
local badgeSocialsText = ffi.new("char[1024]", "")
local badgeCreditsText = ffi.new("char[1024]", "")

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
            imgui.InputText("###topLine", topLine, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###bottomLine1", bottomLine1, 1024)
            imgui.Text("Bottom Line (2/2):") imgui.SameLine()
            imgui.InputText("###bottomLine2", bottomLine2, 1024)
            imgui.Text("Box Text:") imgui.SameLine()
            imgui.InputText("###box", box, 1024)

            if imgui.Button("Show/Update Strap") then
                if ffi.string(topLine) == "" then
                    showerror = true
                    errorTitle = "Missing field!"
                    errorMessage = "No value for 'topLine'. Please fill out that field."
                    return
                end
                client:send("headline", {Type = "ShowAstonsTextStrap", Text = ffi.string(topLine).."\n"..ffi.string(bottomLine1).."\n"..ffi.string(bottomLine2), BoxText = ffi.string(box)})
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
            imgui.InputText("###breakingTopLine", breakingTopLine, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###breakingBottomLine1", breakingBottomLine1, 1024)
            imgui.Text("Bottom Line (1/2):") imgui.SameLine()
            imgui.InputText("###breakingBottomLine2", breakingBottomLine2, 1024)

            imgui.Checkbox("'BREAKING' Box", breakingBox)

            if imgui.Button("Show/Update Strap") then
                if ffi.string(inputAstonsBreakingStoryName) == "" then
                    showError = true
                    errorTitle = "You missed a field!"
                    errorMessage = "No value for 'inputAstonsBreakingStoryName'. Please fill out that field."
                    return
                end

                client:send("headline", {Type = "ShowAstonsBreaking", Text = ffi.string(breakingTopLine).."\n"..ffi.string(breakingBottomLine1).."\n"..ffi.string(breakingBottomLine2), Box = ffi.bool(breakingBox)})
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
                    imgui.InputText("###badgeProgrammeText", badgeProgrammeText, 1024)
                    imgui.Text("Badge Colour") imgui.SameLine()
                    imgui.ColorEdit3("###badgeProgrammeBadgeColour", badgeProgrammeBadgeColour, imgui.love.ColorEditFlags("None"))
                    imgui.Text("Text Colour") imgui.SameLine()
                    imgui.ColorEdit3("###badgeProgrammeTextColour", badgeProgrammeTextColour, imgui.love.ColorEditFlags("None"))

                    if imgui.Button("Set Badge") then
                        client:send("headline", {Type = "SetAstonsProgrammeBadge", Text = ffi.string(inputAstonsBadgeProgrammeText), TextColour = convertTableToCondensedString({badgeProgrammeTextColour[0], badgeProgrammeTextColour[1], badgeProgrammeTextColour[2]}), BackgroundColour = convertTableToCondensedString({badgeProgrammeBadgeColour[0], badgeProgrammeBadgeColour[1], badgeProgrammeBadgeColour[2]})})
                    end
                    imgui.SameLine()
                    if imgui.Button("Remove Badge") then
                        client:send("headline", {Type = "RemoveAstonsProgrammeBadge"})
                    end

                    if imgui.Button("Show Badge") then
                        client:send("headline", {Type = "ShowAstonsProgrammeBadge", Text = ffi.string(inputAstonsBadgeProgrammeText), TextColour = convertTableToCondensedString({badgeProgrammeTextColour[0], badgeProgrammeTextColour[1], badgeProgrammeTextColour[2]}), BackgroundColour = convertTableToCondensedString({badgeProgrammeBadgeColour[0], badgeProgrammeBadgeColour[1], badgeProgrammeBadgeColour[2]})})
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
                                badgeProgrammeText = ffi.new("char[1024]", v[1])
                                badgeProgrammeTextColour[0] = v.tcolour[1]
                                badgeProgrammeTextColour[1] = v.tcolour[2]
                                badgeProgrammeTextColour[2] = v.tcolour[3]
                                badgeProgrammeBadgeColour[0] = v.bcolour[1]
                                badgeProgrammeBadgeColour[1] = v.bcolour[2]
                                badgeProgrammeBadgeColour[2] = v.bcolour[3]
                            end
                            imgui.SameLine()
                            imgui.PushStyleColor_Vec4(imgui.ImGuiCol_ChildBg, imgui.ImVec4_Float(v.bcolour[1], v.bcolour[2], v.bcolour[3], 1))
                                imgui.BeginChild_Str("###programBadgeColExample"..i, imgui.ImVec2_Float(30,18))
                                imgui.EndChild()
                            imgui.PopStyleColor()
                        end
                    imgui.EndListBox()

                    if imgui.Button("Save badge") then
                        table.insert(presetBadges, {ffi.string(badgeProgrammeText), tcolour = {inputAstonsBadgeProgrammeTextColour[0], inputAstonsBadgeProgrammeTextColour[1], inputAstonsBadgeProgrammeTextColour[2]}, bcolour = {inputAstonsBadgeProgrammeBadgeColour[0], inputAstonsBadgeProgrammeBadgeColour[1], inputAstonsBadgeProgrammeBadgeColour[2]}})
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
                    imgui.InputText("###badgeSocialsText", badgeSocialsText, 1024) imgui.SameLine()
                    if imgui.Button("Show") then
                        client:send("headline", {Type = "ShowAstonsSocialsBadge", Text = ffi.string(badgeSocialsText)})
                    end
                    imgui.SameLine()
                    if imgui.Button("Hide") then
                        client:send("headline", {Type = "HideAstonsSocialsBadge"})
                    end

                    imgui.Text("Credits badge:") imgui.SameLine()
                    imgui.InputText("###badgeCreditsText", badgeCreditsText, 1024) imgui.SameLine()
                    if imgui.Button("Show") then
                        client:send("headline", {Type = "ShowAstonsCreditsBadge", Text = ffi.string(badgeCreditsText)})
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