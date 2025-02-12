#Requires AutoHotkey v2
#Include %A_ScriptDir%\Lib\guidegui.ahk
#Include %A_ScriptDir%\Lib\webhooksgui.ahk
#Include %A_ScriptDir%\Lib\config.ahk
#Include %A_ScriptDir%\Lib\mainsettingsui.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk
#Include %A_ScriptDir%\Lib\PriorityPicker.ahk
#Include %A_ScriptDir%\Lib\UnitUpgradePriority.ahk

MinimizeImage := "Lib\Images\minimize.png"
CloseImage := "Lib/Images/close.png"
TaxiImage := "Lib\Images\faxi pfp.png"
PantheonImage := "Lib\Images\pantheon_logo.png"
lastlog := ""
MainGUI := Gui("-Caption +Border +AlwaysOnTop", "Taxi Winter Event Farm")

MainGUI.BackColor := "0c000a"
MainGUI.SetFont("s9 bold", "Segoe UI")

CloseAppButton := MainGUI.Add("Picture", "x920 y0 w50 h50 +BackgroundTrans cffffff", PantheonImage)
CloseAppButton.OnEvent("Click", (*) => OpenPantheonDiscord())

MinimizeButton := MainGUI.Add("Picture", "x1000 y22 w37 h9 +BackgroundTrans cffffff", MinimizeImage)
MinimizeButton.OnEvent("Click", (*) => MinimizeGUI())

CloseAppButton := MainGUI.Add("Picture", "x1052 y10 w30 h32 +BackgroundTrans cffffff", CloseImage)
CloseAppButton.OnEvent("Click", (*) => ExitAndSaveApp())
ExitAndSaveApp() {
    SaveConfig()
    ExitApp()
}

GuideBttn := MainGui.Add("Button", "x840 y270 w105 cffffff +BackgroundTrans +Center", "How to use?")
GuideBttn.OnEvent("Click", (*) => OpenGuide())

#Requires AutoHotkey v2.0
#MaxThreadsPerHotkey 2

; Create the initial GUI
MainSettings := Gui("+AlwaysOnTop")
MainSettings.SetFont("s8 bold", "Segoe UI")

; Set GUI properties
MainSettings.BackColor := "0c000a"
MainSettings.MarginX := 20
MainSettings.MarginY := 20
MainSettings.OnEvent("Close", (*) => MainSettings.Hide())
MainSettings.Title := "Main Settings UI"

MainSettings.Add("Text", "x30 y20 w340 h190 +Center cffffff", "Settings")

; Add Launch Button
Webhookbttn := MainSettings.Add("Button", "x30 y45 w150", "Webhook Settings")
Webhookbttn.OnEvent("Click", (*) => OpenWebhooks())

SendChatBttn := MainSettings.Add("Button", "x220 y45 w150", "Private Server")
SendChatBttn.OnEvent("Click", (*) => OpenPSGUI())

SendChatBttn := MainSettings.Add("Button", "x30 y110 w150", "Keybinds")
SendChatBttn.OnEvent("Click", (*) => OpenKeybinds())

SendChatBttn := MainSettings.Add("Button", "x30 y170 w150", "Unit upgrade priority order")
SendChatBttn.OnEvent("Click", (*) => OpenUnitUpgrade())

SendChatBttn := MainSettings.Add("Button", "x220 y110 w150", "Card priority order")
SendChatBttn.OnEvent("Click", (*) => OpenPriorityPicker())

SendChatBttn := MainSettings.Add("Button", "x220 y170 w150", "Placement Logic")
SendChatBttn.OnEvent("Click", (*) => OpenPlacementLogic())

global PlacementLogicUI := Gui("+AlwaysOnTop")
PlacementLogicUI.SetFont("s10 bold", "Segoe UI")
PlacementLogicUI.BackColor := "0c000a"
PlacementLogicUI.MarginX := 20
PlacementLogicUI.MarginY := 20

PlacementLogicUI.Add("Text", "x10 y8 w250 cWhite",
    "If you feel like the placement is not working as intended, change this option")

PlacementLogicUI.SetFont("s8", "Segoe UI")
global PlacementDropdown := PlacementLogicUI.Add("DropDownList", "x10 y60  w250 c90ffac",
    ["Spiral", "Lines",
        "Lines + 3x3 Grid Finder", "Zig Zag",
        "Zig Zag + 3x3 Grid Finder", "Spiral + 3x3 Grid Finder"])

OpenPlacementLogic() {
    PlacementLogicUI.Show()
}

; Show the main settings GUI
; Show the initial GUI
OpenSettings() {
    MainSettings.Show("AutoSize Center")
}

WebhookBtn := MainGui.Add("Button", "x955 y270 w105 cffffff +BackgroundTrans +Center", "Settings")
WebhookBtn.OnEvent('Click', (*) => OpenSettings())



MatchmakeGroupbox := MainGUI.Add("GroupBox", "x285 y630 w120 h70 c4dce58", "Pre Game")
MatchMode := MainGUI.Add("Radio", "x295 y650 w100 h23 cffffff Checked", "Matchmaking")
SoloMode := MainGUI.Add("Radio", "x295 y670 w100 h23 cffffff", "Solo")
changeMatchMode() {
    global matchModeEnabled := MatchMode.Value
    if (matchModeEnabled == 1) {
        AddToLog("Matchmaking Mode on")
    }
    else {
        AddToLog("Solo Mode on")
    }
}
MatchMode.OnEvent('Click', (*) => changeMatchMode())
SoloMode.OnEvent('Click', (*) => changeMatchMode())


LobbyGroupbox := MainGUI.Add("GroupBox", "x420 y630 w120 h70 c4dce58", "Post Game")
LobbyMode := MainGUI.Add("Radio", "x430 y650 w100 h23 cffffff Checked", "Back to Lobby")
ReplayMode := MainGUI.Add("Radio", "x430 y670 w100 h23 cffffff", "Replay")
changeLobbyMode() {
    global backToLobbyEnabled := LobbyMode.Value
    if (backToLobbyEnabled == 1) {
        AddToLog("Back to Lobby enabled")
    }
    else {
        AddToLog("Replaying enabled")
    }
}
LobbyMode.OnEvent('Click', (*) => changeLobbyMode())
ReplayMode.OnEvent('Click', (*) => changeLobbyMode())


AbilityGroupbox := MainGUI.Add("GroupBox", "x555 y630 w120 h70 c4dce58", "Misc")
AutoAbility := MainGUI.Add("Checkbox", "x565 y650 w100 cffffff Checked", "Auto Ability")
changeAutoAbility() {
    global autoAbilityEnabled := AutoAbility.Value
}
AutoAbility.OnEvent('Click', (*) => changeAutoAbility())

SettingsChecker := MainGUI.Add("Checkbox", "x565 y670 w100 cffffff", "Auto Settings")
changeSettingsChecker() {
    global settingsCheckerEnabled := SettingsChecker.Value
    if (settingsCheckerEnabled == 1) {
        AddToLog("Auto Settings ON")
    }
    else {
        AddToLog("Auto Settings OFF")
    }
}
SettingsChecker.OnEvent('Click', (*) => changeSettingsChecker())

PlacementSpeedGroupbox := MainGUI.Add("GroupBox", "x690 y630 w120 h70 c4dce58", "Placement Speed")
PlacementSpeedDDL := MainGUI.Add("DDL", "x705 y660 w90", ["Super Fast (1s)", "Fast (1.5s)", "Default (2s)", "Slow (2.5s)", "Very Slow (3s)", "Toaster (4s)"])
PlacementSpeedDDL.OnEvent('Change', (*) => placementSpeedChange())
placementSpeedChange() {
    global sleepTimer := PlacementSpeedDDL.Value
    AddToLog("New sleeptimer set!")
}

MainGUI.Add("Picture", "x820 y-20 w90 h90 +BackgroundTrans cffffff", )
TaxiImage := MainGUI.Add("Picture", "x820 y-20 w90 h90 +BackgroundTrans cffffff", TaxiImage)
TaxiImage.OnEvent("Click", (*) => OpenFaxiDiscord())

MainGUI.AddProgress("c0x7e4141 x8 y27 h602 w800", 100) ; box behind roblox, credits to yuh for this idea
WinSetTransColor("0x7e4141 255", MainGUI)

MainGUI.Add("GroupBox", "x830 y60 w238 h200 c4dce58 ", "Unit Setup")
enabled1 := MainGUI.Add("Checkbox", "x840 y80 cffffff", "Slot 1")
enabled2 := MainGUI.Add("Checkbox", "x840 y110 cffffff", "Slot 2")
enabled3 := MainGUI.Add("Checkbox", "x840 y140 cffffff", "Slot 3")
enabled4 := MainGUI.Add("Checkbox", "x840 y170 cffffff", "Slot 4")
enabled5 := MainGUI.Add("Checkbox", "x840 y200 cffffff", "Slot 5")
enabled6 := MainGUI.Add("Checkbox", "x840 y230 cffffff", "Slot 6")

placement1 := MainGUI.Add("DropDownList", "x1020 y80  w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement2 := MainGUI.Add("DropDownList", "x1020 y110 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement3 := MainGUI.Add("DropDownList", "x1020 y140 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement4 := MainGUI.Add("DropDownList", "x1020 y170 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement5 := MainGUI.Add("DropDownList", "x1020 y200 w40 cffffff Choose3", [1, 2, 3, 4, 5])
placement6 := MainGUI.Add("DropDownList", "x1020 y230 w40 cffffff Choose3", [1, 2, 3, 4, 5])

MainGUI.Add("Text", "x940 y80 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y110 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y140 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y170 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y200 h60 cffffff +BackgroundTrans", "Placements: ")
MainGUI.Add("Text", "x940 y230 h60 cffffff +BackgroundTrans", "Placements: ")

SaveConfigBttn := MainGUI.Add("Button", "x840 y305 w105 cffffff +Center", "Load config")
SaveConfigBttn.OnEvent('Click', (*) => LoadConfig())

SaveConfigBttn := MainGUI.Add("Button", "x955 y305 w105 cffffff +Center", "Save config")
SaveConfigBttn.OnEvent('Click', (*) => SaveConfig())

MainGUI.Add("GroupBox", "x830 y340 w238 h260 c4dce58 ", "Activity Log ")
ActivityLog := MainGUI.Add("Text", "x830 y360 w238 h415 r15 cffffff +BackgroundTrans +Center", "Macro Launched")

MainGUI.Add("GroupBox", "x830 y610 w238 h80 c4dce58 ", "Keybinds")
KeyBinds := MainGUI.Add("Text", "x830 y630 w238 h300 r7 cffffff +BackgroundTrans +Center",
    "F1 - Fix Roblox Position `n F2 - Start Macro `n F3/F4 - Reload/Pause Macro")

MainGUI.SetFont("s16 bold", "Segoe UI")

MainGUI.Add("Text", "x20 y635 w260 c4dce58 +BackgroundTrans", "Haie's Winter Macro v1.6-beta5")

MainGUI.Show("x27 y15 w1100 h705")

AddToLog(text) {
    global lastlog
    ActivityLog.Value := text "`n" ActivityLog.Value
}

MinimizeGUI() {
    WinMinimize("Taxi Winter Event Farm")
}

OpenPantheonDiscord() {
    Run("https://discord.gg/ANUFU8mVas")
}

OpenFaxiDiscord() {
    Run("https://discord.gg/UB9AaPzqdq")
}

PrivateServerGUI := Gui("+AlwaysOnTop")

PrivateServerGUI.SetFont("s8 bold", "Segoe UI")
PrivateServerGUI.Add("Text", "x10 y8 w280 cWhite",
    "Enter your PS Link:"
)

PrivateServerGUI.Add("Text", "x10 y56 cWhite", "PS Link")
ChatToSend := PrivateServerGUI.Add("Edit", "x10 y70 w280", "Just a placeholder for next update, not functional yet")

ChatStatusBox := PrivateServerGUI.Add("Checkbox", "x10 y109 cWhite", "Enabled")

PrivateServerGUI.BackColor := "0c000a"
PrivateServerGUI.MarginX := 20
PrivateServerGUI.MarginY := 20

PrivateServerGUI.OnEvent("Close", (*) => PrivateServerGUI.Hide())
PrivateServerGUI.Title := "Private Server"

OpenPSGUI() {
    PrivateServerGUI.Show("w300 h150")
}

LoadLocal()

