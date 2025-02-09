; huge thanks to:
; raynnpjl for contributing the card selector
; yuh for heavily inspiring  the macro + some functions
; taxi for the base macro
; keirahela for the updated base macro (1.1.6-9)
; invaliddatastore for the webhook logic
; durrenth for the placement logic

#Requires AutoHotkey v2.0
#Include %A_ScriptDir%\Lib\gui.ahk
#Include %A_ScriptDir%\Lib\config.ahk
#Include %A_ScriptDir%\Lib\FindText.ahk
#Include %A_ScriptDir%\Lib\imageForCS.ahk
#Include %A_ScriptDir%\Lib\OCR-main\Lib\OCR.ahk
#Include %A_ScriptDir%\Lib\WebhookOptions.ahk
#Include %A_ScriptDir%\Lib\keybinds.ahk
#Include %A_ScriptDir%\Lib\IsProcessElevated.ahk
#SingleInstance Force

global MacroStartTime := A_TickCount
global StageStartTime := A_TickCount

SendMode "Event"
RobloxWindow := "ahk_exe RobloxPlayerBeta.exe"

UnitExistence := "|<UnitExistenceUpgrade>*86$64.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzznzztszzzzzyDzz7XzzzzzszzwSDzzzzzXrztsUQ230kA7zbW1U8820UDyS9UMb61UMztta1WQM607zX60U9s20bzz0s60bU821zy7Uw2T0kA7zzyTqTzzzzzzzty1zzzzzzzzbwDzzzzzzzzzzzzzzzzzzzzzzzzzzy"


MaxUpgrade :=
    "|<TopMax>*91$30.zzzzzzDzzzy9yD7wMwD7wsMC3ws8C3ws0AHst2AFsta81wty80wty1wwtyNwwzzzzyDzzzzDzzzU"

MaxUpgrade2 :=
    "|<MaxButton>*80$47.TU7k0000X0Mk000331VU00063630000A3M6TwsSM3kBzjNak70S0AS5U40s0EMD001U0k0q41331k1gA6673k6MQQAS7UMkwsMQC0NVTEk0M0P20Vk0kES413k1VkoM37kX6nDk3szzswU"


VoteStart := "|<>*95$38.ryzzzzlz7zlzwDVzwTzXszz7zsSC30Q7770E40klU410C8sklVXUACAM0w7X360T1s1kEbsz0Q40zDsTVUM"

LobbyText :=
    "|<>*134$56.0000000000k00U10000T00y1w000Cs0RkvU003606AAM000lU1X36000AMzMwlswS36zyDwTzjslw7WD4ST6AS0M1k33lX7060A0MMPlkkVX366DwQS8sFkk3z772C4QC1zlkkV327UTw40M0k1wDz1UC0Q0z3zsQ7WD4TkzzzzzzzzwTzzzzzzzy7zzzzzzzzXzzzzzzzzszs"

AreasText := "|<>*108$36.zs007zyzztzzwTzzzzwTzTzzsA4613tA421/k4M0F3k4M4FXXUQ603bmy713zzzzzzU"

MatchmakeUI :=
    "|<>*129$83.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzUzzzzzzzzzzzzz0zzzzzzzw7zzzw1zzzzzzzkDzzzs3zzzzzzzUTzzzs7zzzzzzz0zzzzkTzzzzzzy1zzzzzzzzzzzzw3zzzzzzzzzzzzs7zzzzzzzzzzzzkDy0Tw7UsDzzzzUTk0Ds7007zzzz0z00DUA007zzzy1w00D0M007zzzw3k00S0k00Dzzzs7U00Q1U00DzzzkC0S0s3060TzzzUQ1y0k60y0zzzz0s7w1UA1y1zzzy1kDs30M3w3zzzw3UTk60k7s7zy7k70TUA1UDkDzs70C0Q0s30TUTzk00S001k60z0zzU01w007UA1y1zz007w00D0M3w3zz00Dw00y0k7s7zz01zw03y1kDkDzzU7zy0Tw7UzkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"

CaptchaExistence :=
    "|<>*100$131.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwDzzzzzzzs3zzzzzzzzzzzkDzzzzzzz01zzzzzzy7zzzUTzzzzzzs00zzzzzzs7zzz0zzzzzzzU01zzzzzzkDzzy1zzzzzzy003zzzzzzUTzzw3zzzzzzs007zzzzzz0zzzs7zzzzzzk7wTzzzzzy1zyTkDzzzzzz0Tzz0UsEDk0DU7UEDz0Uzy1zzw01U0DU0S0300Dw01zw3zzk0300C00s0600Dk03zsDzz00600C01U0A00T007zkTzw00A00A0200M00Q00DzUzzs30M3US1w1lk70s30Tz0zzkD0kDUw3s7zUT1kD0zy1zzUz1UT1s7kTz0y3Uz1zw1zz1w30y3kDUzy1w31w3zw1zC1s61s7UT0zw3s61s7zs0sA00A00D0y0Es7kA00Dzs00A00M00y0C00kDUQ00Tzs00M00k01y0A01UT0s00zzs00s01U07w0Q030y3s01zzs03s0300zw1w0C1w7s03zzw0TwCC1rzy3y1y7wDwCDzzzzzzzw3zzzzzzzzzzzzzzzzzzzzs7zzzzzzzzzzzzzzzzzzzzkDzzzzzzzzzzzzzzzzzzzzUTzzzzzzzzzzzzzzzzzzzz0zzzzzzzzzzzzzzzzzzzzy3zzzzzzzzzzzzzzzzzzzzy7zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzU"

P := "|<>*88$35.3zzzy0Tzzzy0zzzzy3zzzzw7zzzzsTzzzzszzzzzlzzzzzXzw1zz7zs1zyDzk1zwTzV3zszz73zlzyC7zXzwQTz7zs0zyDzk3zwTzVzzszz7zzlzyDzzXzwTzz7zzzzyDzzzzwTzzzzszzzzzkzzzzzVzzzzy1zzzzw3zzzzk3zzzz00zzzs0000000000004"

Matchmaking :=
    "|<>*93$73.zzzzzzzzzzzzzzlzzzsszzzzk08zzzwATzzzs04Tzzy6Dzzzw03zzzz3zzzzy7zzzzzVzzzzz3zX4DwElW7w8U7lU3s0Mk1w0E1sk0w0AM0Q080wM0A06A06040SAC6736737W7z6D37VX3VXl3zX7VVklXkkkVzlXkk0MlsM0EzslsQ0AMwC08zwMwC06AS7U4TyATDlb6DbxXzzzzzzzzzzzlzzzzzzzzzzs0zzzzzzzzzzw0zzzzzzzzzzy0zzzzzzzzzzzty"

AbilityOFF := "|<>*83$21.zzzzzzzwD4S0kXl28wS03Xk0QSH7nWMy0n7sCQzzzzU"
AbilityOFF2 := "|<>**50$21.7tznXsWM7AKQnbnk0SqE3rmRqQngM6RXVvgDvzY"

ClaimText :=
    "|<>*127$71.00000000000000A7s01y000007zTs07w00000Tzlk0AQ00003k7VU0MM0000D03300kk0000Q0667zXzsw01k0AAzzzzzy031ysTrjTSyS0C7zky0AA0EQ0QCTVs0MM00Q0ss73U0kk00M1lkC711VVUUk3VnwC73333VU73zsQS666737y3tksQAAAC7zy01Uk0MMMQDzy030k0kkksTzy061U1VVVkzzz0y3kX77XXzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz"

LoadingScreen :=
    "|<>*98$87.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzwTzzzzzzzzzzzzX3zszzzzzszXzzsMTz7zzzzz7wDzz3XzszzzzzszVzzsTzz7zzzzz7wDkz3bwMz3szbszXs1sQS07U73sT7wS07XXU0w0QT7s03UkQQMA7b3Vkz00QD3XX3kzwCCDs03XwQQMz7s1llz7wQTXXX7sw0C4TszXXwQQMz73VsXz7wQD3XX3kswD0TszXk0wQQ0731w7z7wT0DXXU0s0DUzszXw3wQT17UFyDzzzzzzzzzzzzzlzzzzzzzzzzzzzgTw"

SoloTeleporter := "|<SoloTeleporter>**50$60.zz00000000U100000000U100000000U1z7kzsyDsXzzyxzzrzyXy0kD060k7U60U7040k3U65V3kAQE1U6DXXsQQFlXy9XWkw0lFW29XXVwTlFW28U304AlFW28k7060lFa2MMD070nFy3sDtzzzzTU"
InsideTPIndicator := "|<InsideTPIndicator>**70$66.0000000000w0zU0000001w3nk00000016C0M00000016A0800000016M09zzy1y7t6EzTzzzbzTT6lny0MVy1s76lUA0M0w0k36l0M0M0M1VV6lUMsMQMzXl6lVswMwMzU16EzssMoMzU36MSMEMoMNXz7M0A0MoM0U31C0Q0MoQ1k317Uz4sYT3w3V1znzzbnzDyzU"


IngameSettingsIcon := "|<ingameSettingsIcon>**50$22.0Dk01nU0660DMPlz0zi837k00D0A0y3w7QDkslnX37CAQDkv0z0w0k3k00BX0Fbw3yDMPk1VU06600Dk2"

Priority :="|<FirstButton>**90$36.03k000Tzk01sk2M03sk2M03Ak7zzzCnyNC63kCMA43kCMgy3kCNw7CnyNa3An6NhX6n6Ng32m6NA7WS3z7wyU"

DeathText := 
	"|<>*100$22.zzzzUzUw3w3l7l6ASAMtstXbXaASAQFgFkAEDUlUzzzzU"

ChatOpenCheck := "|<chatOpen>*135$37.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz0001zz0000zzU000Tzk000Dzs0007zw0003zy1zy1zz0zz0zzU000Tzk000Dzs0z07zw0Tk3zy0001zz0000zzU000Tzk000Dzs0007zzs01zzzzU7zzzzs7zzzzy7zzzzzbzzzzzzzzzzzzzzzzzzzzzzzzzzzk"

SettingONCheck := "|<SettingON>**50$61.00000000000000003zz00000003k3k07zzzzzU0S0700003003UC00003000k600003000A6000010007600001U001X00000U000l00000E0008U000080004E00004000280000200014000010000W00000U000F00000E0008k000080004M00004000660000300031U0000U003Us0000M001U700006001U1zzzzzU01k000000w03k0000007U7U0000001zzU00000000002"

ShowUpgradeUILeftCheck := "|<>*91$181.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyDzy7zzzzzzzzzzzzzzzzzzz6Dzzzzz7zz1DzzzzzzzzU7zzzzzzzzV7zzzzzXzz13zzzzzzzy00TzzzzzzzkXzzzzzlzzVVzzzzzzzy007zzzzzzzsFzsyNzsz7U0Dzzzzzzy001zzzzzzzw8zk70DwS0U07zzzzzzy000TzzzzzzyATk1U3yC0003zzzzzzy0007zzzzzzz6Ds0k1z72401zzzzzzz0003zzzzzzzX7sQMszX3373zzzzzzzU001zzzzzzzlXwCAQTlU1XVzzzzzzzU000Tzzzzzzklz66CDskzlkzzzzzzzk000DzzzzzzkszU377w40sw7zzzzzzs0007zzzzzzsQTs3XXy20QS3zzzzzzw0003zzzzzzwyDy3llzXkCDVzzzzzzy0001zzzzzzzzzzzzzzzzzzzzzzzzzz0000zzzzzzzzzzzzzzzzzzzzzzzzzzU000Tzzzzzzzzzzzzzzzzzzzzzzzzzk000Dzzzzzzzzzzzzzzzzzzzzzzzzzw000Dzzzzzzzzzzzzzzzzzzzzzzzzzy0007zzzzzzzzzzzzzzzzzzzzzzzzzz0003zzzzzzzzTXzbzzzzzzzzzzzzzzk003zzzzzzzngUwXuSr9onjzzzzzzzw003zzzzzzzUo+Q/o378Y03zzzzzzzz003zzzzzzzluRSptMbkqNhzzzzzzzzk03zzzzzzzuSarayn7t/aKTzzzzzzzz0Dzzzzzzzzzzzzyzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"

DisableAutoOpenUpgradeUICheck := "|<>*109$172.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzztwTzzzzzzXzzblbzzzzzzzzzzzzzzXlzzzzzzyDzyD6Dzzzzzzzzzs0TzyD7zzzzzzszzswMzzzzzzzzzy00TzswTzzTjxzXtzXlXzzzzk0000000TzXlUS0UM3UC1yD6Dzzzw00000000zyD60k210A0k3swMzzzzU00000003zswMV48wEk36DXlXzzzw000000007zXlX0sXXWC80yD6DzzzU00000000TyC6A12S6AMU7ssMzzzy000000000zs0s309w0k37TU3bzzzk000000003zk3UC0bk30A1z0CTzzz000000000DzUy3wWTkD0s7y3tzzzw000000000zzztziDzzzzzzzzzzzzk000000003zzzbw1zzzzzzzzzzzzz000000000DzzyTsDzzzzzzzzzzzzw000000000zzztzvzzzzzzzzzzzzzk000000003zzzzzzzzzzzzzzzzzzzU00000000Dzzzzzzzzzzzzzzzzzzy000000000zzzzzzzzzzzzzzzzzzzw000000007zzzjzzyzzTzzzzjzzzzs00000000TRjwbzzvzzzzzzzjzzzzk00000003xqzmRzzjxzzzzzyTzzzzk0000000DrPV0dD6kXEVkvEdzzzzzzzzzy001zRipqZxfOxOrPhOjzzzzzzzzzy00TxiuLPrph/peRCZezzzzzzzzzzy07ztzpTnzSuryxuxSxzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy"

TPtoSpawnCheck := "|<TPtoSpawnCheck>*113$68.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy1zzzzzzzzzz0Dzzzzzzzzzk3zzzzzzzzzwRxzzrjyvzzz3y0w0XX40zzk7U608EV0Dzy0s0U348k1zzs6C8kk0AQTzzlXUCC0377zwQMEX3U1llzz060M0w8QQTzk3U70D6D77zz1sbsXtnllzzzyDzzzzzzzzzzXzzzzzzzzzzszzzzzzzzzzyTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"

ClickToMoveCheck := "|<ClickToMove>*123$91.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzkvTyzyzztyTzzzznBzzTyTzwTDzzzznyr3iS33yD73DMTvzPAqTbAz7fAr9bxzhjuTnjDVpj/hvyzqrwTtrbmmrYq0zTvPybwvntPPnHTzbxhzPyRtwZhtfjztaqNgziNyMqNlnDy7PVrDlVzAvVwwDzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzy"

DefaultKeyboardCheck := "|<DefaultKeyboard>*122$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzyTzzzzzzzzzzzzsDzvzzyvz9nzzvzzzn7zrzzxbynDzzrzzzbi633jO3tYwAxcwD3D9bQrSqTr/nBnAnAqSLizaxgzi7jPawjDgwUBsBvNzQD0HRtSMNtTviPqnytCzqvmwinqzrQrhbxnRzdrZtRaAnilaPjvaNb7aNan1wDQ3Wr7rCMTD1sQ7zzzzzzzzbzzyTzzzzzzzzzzzzjzzxzzzzzzzzzzzzzDzzbzzzzzzzzzzzzzzzzzzzzz"

GraphicsModeCheck := "|<GraphicsMode>*102$101.zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzbzzzzzzzzzy7zzztzTzzwT7zzDzs7zzznzzzzswDzyTzbwAC3UQkwTlsQD0sTTsGAH4t0mTVolAFaSznyNmQmzjz3dj/nSxkbUnYtZz3yKHSLa0vtCNb9n/zXwYawjBznmRnCHaLzrt/BtSPzk4t69bAWNDn6Ma0lDktkA7CNVkzaAsS9kzzzztzzzzzzzzzzzzzzzznzzzzzzzzzzzzzzzzbzzzzzzzzzzzzzzzzzzzzzzzzzzzzzk"

GraphicsManualCheck := "|<GraphicsManual>*124$56.zzzzzzzzzzzzzzzzzzzzzzzzzzzzyTbzzzzzrzXtzzzzzxzswQCXri7TyDKPXRvBrzVpyPrSzBztNQ6wri3TyKqtjBvQrzYhiPnSrBztXP6wnBXTyNq1jC/0rzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"

CameraModeCheck := "|<CameraMode>**80$105.00000000000000000000000000000000000000000000000000000001s0000000000000Tk0N007Q3rvU001k723U2s00gUPVo000+0gLhzrzQxr6vqjntxryWSsMASZc8azr7lsvVqGKNrRohr5q2rRqvNamGLijyZgUeULzjrvTmGG1pUohY5I2sASDO2GGryfqZgUekKxwyPEGHqzJSrho5LyrjrvPyGxnefaNisjSqtirPAmET3JashF5gCtiD7QCnyDnjxzvsozTzzTizo000000006k0000005U00000000O0000000g000000003k0000007000000000000000000U"

VoteStartStar := "|<votesstartStar>*115$61.zzzzzzzznzzzzzzzzztxzzzzzzzzwyTzzzzzzzyT7zzzzzzzzDVzzzzzzzzbkzzzzzzzzntTzzzzzzztwzzzzzbzzySTzzzzVzzz0TzzzzUTzzsTzzzzkDzzzzzzzzk3zzzzzzzzs1zzzzzzzzs0Tzzzzzzzw0Dzzzzzzzy07zzzzzzzy01zzzzzzzz00zzzzzzzz00Dzzzzzzz003zzzzzzzU01zzzzzzw0003zzzzk000000DzzU0000001zzk0000000zzs0000000Tzy0000000TzzU000000Tzzs000000Tzzy000000TzzzU00000Tzzzs00000Tzzzy00000TzzzzU0000Tzzzzs0000Tzzzzy0000Tzzzzz0000DzzzzzU0007zzzzzk0003zzzzzs0001zzzzzs0000Tzzzzw0000Dzzzzyk0DU7zzzzzy0Dznzzzzzz0CDxzzzz7lk776zzzzXszzXXzzzzlwTzzlzzzzsyCzzkD7zzwT60QE20zzyDX0C810Tzz7lU361XzzzXsllXXkDzzlwMsllw3zzsQAQMsz1zzy0CCAQ68zzzU776C30TzzsDXX7lkTzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzs"

IngameSettingsIcon := "|<ingameSettingsIcon>**50$22.07U00z007C00MM0xVj7w3ysUAT000w0k3sDkRkz3X7CAAQslkz3g3w3k30D000qA16TkDsxVj06600MM00z08"

SettingsMenuOFF := "|<>**50$22.00zwTnCLXvrPrjRTg8Ravro9fHEahBWuoLvfFjSh7Xuo7xvm"

NewMainSettingUI := "|<>**50$51.wT0w00006nM5U0000qPyjjzyTWqwxhPAzCPrNhfAPrPTrhhPrRvBirhfSfUNhqxhPpRzBSxhvSfjknPBqPpSu6Pbi/SfskyDrzzxvyU"

GraphQualityMinus := "|<>*95$28.zw0zzz00zzkzkzyDzlznzznyTzzbnzzzCTzzyNzzztjzzzozzzz3zzzwTzzzty00Tbs01yTU07ty00TbzzzyDzzzkzzzz/zzzxbzzzaTzzyQzzzntzzyTnzznzXzwTz3z3zz00zzz0DzU"

NextButtonCheck := "|<nextButtonCheck>**70$56.0000000000000000000000000000000000000000000000000000000000000000000000000000000000001wDU000S00na8000Dk0ARW0002A033MVsM1X00kS9zjDsw0A3WkSTA1U30ss3XX0M0l6A0MEk60AEX770SD0360llsBXU0lkA0S38k0AS37z0OD035Uk3V3Uk0lgC0MswA0AFakCTNX01wDbywSDU000000000000000000000000000000000000000000000000000000008"

ReplayButtonCheck := "|<ReplayButtonCheck>**50$79.0000000000000000000000000000000007000000Tw00007s00000TzU0007A00000M1s0003600000A0C0001X000006031U00lU010033UryTyMkzzsy1XsTjzzgNzzyTUlaC0w0SAkFXMMMz60C076k0kwAAD22303Xs0MSA6033VVklsQC66301VkkwMwS7361U0k0sSASB3k30ksMTwC6D3Vw30My4Du073U0q1UAP30703UM0NVk6Alk3U3sC0Akk3aNw3lzCDnCMM0z7rzsz3yzyMM0C1kzgM0S7CAA000006A00006A0000036000066000001n00001a000000TU0000z0000007000007000000000000001"
;435, 144, 605, 187
ReturnToLobbyCheck := "|<ReturnToLobbyCheck>**50$55.0000000007k0DUT0007w0DsTk003606AAM001X0366A000lVtXX71kkMnzlxXtwyAPVsblDana/0Q0s1lsn5060A0MstXXX366CAMllsXn7b6AMswFtXnkAAQQMMkls6660A0M0q631UC0Q0nX0twDAyNtX0DryztzklU1Us4E8UlU0000000Mk0000000AM00000003s00000000s0000000000U"
;331, 142, 425, 180

AddToLog("You can pause/unpause with F4.")
F4::Pause -1

global hasReconnect := 0									
global matchModeEnabled := MatchMode.Value
global backToLobbyEnabled := LobbyMode.Value
global autoAbilityEnabled := AutoAbility.Value
global settingsCheckerEnabled := SettingsChecker.Value		
global sleepTimer := PlacementSpeedDDL.Value			   

SetupMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    if WinExist(RobloxWindow) {
        WinActivate(RobloxWindow)
        Sleep 50
        WinMove(27, 15, 800, 600, RobloxWindow)
        Sleep 50
    }
    if WinExist("Taxi Winter Event Farm") {
        Sleep 50
        WinActivate("Taxi Winter Event Farm")
        Sleep 100
    }
}

InitializeMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    global MacroStartTime := A_TickCount
    global loss := 0
    global wins := 0

    if WinExist("Taxi Auto-Challenge") {
        WinActivate("Taxi Auto-Challenge")
    }

    if WinExist(RobloxWindow) {
        WinMove(27, 15, 800, 600, RobloxWindow)
        WinActivate(RobloxWindow)
        Sleep 100
    }
    else {
        MsgBox("You must have ROBLOX open in order to start the macro (microsoft roblox doesnt work)", "Error T4",
            "+0x1000",)
        return
    }
    AutoSettingsChecker()

    if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText)) {
        GoToRaids()
    }
    else {
        MsgBox("You must be in the lobby with default camera angle to start the macro.", "Error T3", "+0x1000",)
        return
    }
}

SetDefaultKeyboard(localeID) {
    static SPI_SETDEFAULTINPUTLANG := 0x005A, SPIF_SENDWININICHANGE := 2
    Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
    binaryLocaleID := Buffer(4, 0)
    NumPut("UInt", LocaleID, binaryLocaleID)
    DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "Ptr", binaryLocaleID, "UInt",
        SPIF_SENDWININICHANGE)
    for hwnd in WinGetList()
        PostMessage 0x50, 0, Lan, , hwnd
}

BetterClick(x, y, LR := "Left") { ; credits to yuh for this, lowk a life saver
    MouseMove(x, y)
    Sleep(50)
    MouseMove(1, 0, , "R")
    Sleep(50)
    MouseClick(LR, -1, 0, , , , "R")
    Sleep(50)
}

GoToRaids() {
    SendInput ("{Tab}")

    moveOnce := 0
    loop {
        if (ok := FindText(&X, &Y, 10, 70, 350, 205, 0, 0, LoadingScreen)) {
            AddToLog("Found LoadingScreen, stopping loop")
            break
        }
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
            AddToLog("Found VoteStart, stopping loop")
            break
        }
        if (ok := FindText(&X, &Y, 338, 505, 536, 572, 0, 0, ClaimText)) ; daily reward
        {
            BetterClick(406, 497)
            Sleep 3000
        }
        
        if (ok:=FindText(&X, &Y, 146, 50, 196, 103, 0, 0, ChatOpenCheck)) {
            AddToLog("Turned Chat off.")
            BetterClick(137, 32)
        }

        ; go to xmas map
        if (moveOnce == 0) {
            BetterClick(89, 302)
            Sleep 2000
            SendInput ("{a up}")
            ; go to teleporter
            Sleep 100
            SendInput ("{a down}")
            Sleep 6000
            SendInput ("{a up}")
            KeyWait "a" ; Wait for "d" to be fully processed
        }

        moveOnce++

        ;sacred planet act 4
        Sleep 1200
        if (matchModeEnabled) {
            BetterClick(469, 340) ; play (matchmaking mode)
            Sleep 2000
            AntiCaptcha()
        } else {
            BetterClick(380, 340) ; play (non-matchmaking mode)
            Sleep 2000
        }		 
    }
    LoadedLoop()
    StartedLoop()
    TryPlacingUnits()
}

StopMacro() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    Reload()
}
; Define the rectangle coordinates
global startX := 200, startY := 500, endX := 700, endY := 350
global startY2 := 200, endY2 := 350
global step := 50 ; Step size for grid traversal
global successfulCoordinates := [] ; Array to store successful placements
global successThreshold := 3 ; Number of successful placements needed

PlaceUnit(x, y, slot := 1) {
    SendInput(slot)
    Sleep 50
    BetterClick(x, y)
    Sleep 100
    SendInput("q")
    Sleep 50
    SendInput("q")

    ; Check if placement is successful
    if IsPlacementSuccessful() {
        Sleep 50
        return true
    }
    return false
}

IsPlacementSuccessful() {
    
    switch sleepTimer {
        case 1: Sleep 1000
        case 2: Sleep 1500
        case 3: Sleep 2000
        case 4: Sleep 2500
        case 5: Sleep 3000
        case 6: Sleep 4000    
    }
    loop 2 {
        if (ok := FindText(&X, &Y, 48, 396, 127, 433, 0, 0, Priority) or ok := FindText(&X, &Y, 200, 239, 276, 270, 0, 0, UnitExistence) ) {
            AddToLog("Placed unit successfully!")
            Sleep 100
            if (autoAbilityEnabled and ok := FindText(&X, &Y, 367, 262, 445, 302, 0, 0, AbilityOFF)) {
                AddToLog("Ability found. Toggling ON")
                BetterClick(373, 237)
            }
            BetterClick(329, 184) ; close upg menu
            return true
        }
    }
    return false
}

GetWindowCenter(WinTitle) {
    x := 0 y := 0 Width := 0 Height := 0
    WinGetPos(&X, &Y, &Width, &Height, WinTitle)

    centerX := X + (Width / 2)
    centerY := Y + (Height / 2)

    return { x: centerX, y: centerY, width: Width, height: Height }
}

rect1 := { x: 37, y: 45, width: 254, height: 69 }
rect2 := { x: 591, y: 45, width: 243, height: 47 }
rect3 := { x: 36, y: 594, width: 105, height: 51 }

isInsideRect(rect, x, y) {
    return (x >= rect.x and x <= rect.x + rect.width and y >= rect.y and y <= rect.y + rect.height)
}

; ********* PLACEMENT ALGOS START HERE **********

;By @keirahela
;Modified by @Haie (smaller steps, centered start)
SpiralPlacement(gridPlacement := false) {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    centerX := GetWindowCenter(RobloxWindow).x - 30
    centerY := GetWindowCenter(RobloxWindow).y - 30
    radius := step
    direction := [[1, 0], [0, 1], [-1, 0], [0, -1]]
    dirIndex := 0
    directionCount := 0

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        currentX := centerX
        currentY := centerY
        steps := 30
        maxSteps := 5

        while (placementCount < placements) {
            for index, stepSize in [steps] {

                if PlaceUnit(currentX, currentY, slotNum) {
                    placementCount++
                    successfulCoordinates.Push({ x: currentX, y: currentY, slot: "slot_" slotNum }) ; Track successful placements
					
					try {
                        if savedPlacements.Get("slot_" slotNum) {
                            savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                        }
                    } catch {
                        savedPlacements.Set("slot_" slotNum, 1)
                    }

                    if placementCount >= placements {
                        break
                    }
		
                    if (gridPlacement) {
                        PlaceInGrid(currentX, currentY, slotNum, &placementCount, &successfulCoordinates, &
                            savedPlacements, &placements)
                    }

                }
		

                if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
                        cardSelector()
                }
                
				BetterClick(284, 400) ; next
				BetterClick(60, 450) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby  condition.")
                    return LobbyLoop()
                }
                Reconnect()

                currentX += direction[dirIndex + 1][1] * steps
                currentY += direction[dirIndex + 1][2] * steps

                currentX += Random(-15, 15)
                currentY += Random(-15, 15)

                if isInsideRect(rect1, currentX, currentY) or isInsideRect(rect2, currentX, currentY) or isInsideRect(
                    rect3, currentX, currentY) {
                    steps := 30
                    currentX := centerX
                    currentY := centerY
                }

                if currentX > 635 or currentY > 520 or currentX <= 190 or currentY < 150 {
                    steps := 30
                    currentX := centerX
                    currentY := centerY
                }
            }

            directionCount++

            if directionCount == 2 {
                steps += 30
                directionCount := 0
            }

            dirIndex := Mod(dirIndex + 1, 4)
            if ShouldStopUpgrading(1) {
                AddToLog("Stopping due to lobby condition.")
                return LobbyLoop()
            }
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
    }

    UpgradeUnits()

    AddToLog("All slot placements and upgrades completed.")
}

; The OG placement by @Original author of macro
LinePlacement() {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []

    x := startX ; Initialize x only once
    y := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        ; Continue placement for the current slot
        while (placementCount < placements && y >= endY && y2 <= endY2) { ; Rows
            while (placementCount < placements && x <= endX) { ; Columns
                if (alternatingPlacement == 0) {
                    if PlaceUnit(x, y2, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y2, slot: "slot_" slotNum }) ; Track successful placements
                    }
                }
                if (alternatingPlacement == 1) {
                    if PlaceUnit(x, y, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements
                    }
                }
				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
				BetterClick(284, 400) ; next
				BetterClick(60, 450) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby  condition.")
                    return LobbyLoop()
                }
                Reconnect()
                x += step - 20 ; Move to the next column
            }
            if x > endX {
                x := startX ; Reset x for the next row
                if (Mod(alternatingPlacement, 2) == 0) {
                    y2 += (step + 25) ; Move to the next row, upwards
                    alternatingPlacement += 1
                }
                else {
                    y -= (step + 25) ; Move to the next row, downwards
                    alternatingPlacement -= 1
                }
            }
            Reconnect()
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    }

    UpgradeUnits()

    AddToLog("All slot placements and upgrades completed.")
}

; Modified version of LinePlaceMent, placing in a 2x2 grid when a unit is placed,then goes back to line placing
; By @Durrenth
LinePlacementGrid() {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    x := startX ; Initialize x only once
    y := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        ; Continue placement for the current slot
        while (placementCount < placements && y >= endY && y2 <= endY2) { ; Rows
            while (placementCount < placements && x <= endX) { ; Columns
                if (alternatingPlacement == 0) {

                    if PlaceUnit(x, y2, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y2, slot: "slot_" slotNum }) ; Track successful placements

                        try {
                            if savedPlacements.Get("slot_" slotNum) {
                                savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                            }
                        } catch {
                            savedPlacements.Set("slot_" slotNum, 1)
                        }

                        if placementCount >= placements {
                            break
                        }

                        PlaceInGrid(x, y2, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &
                            placements)
                    }

                }

                if (alternatingPlacement == 1) {
                    if PlaceUnit(x, y, slotNum) {
                        placementCount++
                        successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements

                        try {
                            if savedPlacements.Get("slot_" slotNum) {
                                savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                            }
                        } catch {
                            savedPlacements.Set("slot_" slotNum, 1)
                        }

                        if placementCount >= placements {
                            break
                        }

                        PlaceInGrid(x, y2, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &
                            placements)

                    }
                }
				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
				BetterClick(284, 400) ; next
				BetterClick(60, 450) ; move mouse
                if ShouldStopUpgrading(1) {
                    AddToLog("Stopping due to finding lobby  condition.")
                    return LobbyLoop()
                }
                Reconnect()
                x += step - 20 ; Move to the next column
            }
            if x > endX {
                x := startX ; Reset x for the next row
                if (Mod(alternatingPlacement, 2) == 0) {
                    y2 += (step + 25) ; Move to the next row, upwards
                    alternatingPlacement += 1
                }
                else {
                    y -= (step + 25) ; Move to the next row, downwards
                    alternatingPlacement -= 1
                }
            }
            Reconnect()
        }

        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    }

    UpgradeUnits()

    AddToLog("All slot placements and upgrades completed.")
}

; Places units in a zig-zag pattern
; By @Durrenth
ZigZagPlacement(gridPlacement := false) {
    global startX, startY, endX, endY, step, successfulCoordinates, maxedCoordinates
    successfulCoordinates := [] ; Reset successfulCoordinates for each run
    maxedCoordinates := []
    savedPlacements := Map()

    startY2 := 200, endY2 := 500
    startY := 170, endY := 470

    rectZigZag := { x: startX, y: startY, width: 500, height: 500 }

    ; += Random(0, 15)

    x := startX + Random(0, 15) ; Incase 2 or more players are using the same placement, randomize starting location by 0-15 steps.
    y1 := startY ; Initialize y only once
    y2 := startY2 ; Initialize y2 only once
    y := y1 ; Start with the top Y coordinate

    ; Iterate through all slots (1 to 6)
    for slotNum in [1, 2, 3, 4, 5, 6] {
        enabled := "Enabled" slotNum
        enabled := %enabled%
        enabled := enabled.Value
        placements := "Placement" slotNum
        placements := %placements%
        placements := placements.Text

        ; Skip if the slot is not enabled
        if !(enabled = 1) {
            continue
        }

        AddToLog("Starting placements for Slot " slotNum " with " placements " placements.")

        placementCount := 0
        alternatingPlacement := 0

        while (placementCount < placements) {

            if PlaceUnit(x, y, slotNum) {
                placementCount++
                successfulCoordinates.Push({ x: x, y: y, slot: "slot_" slotNum }) ; Track successful placements
                ;AddToLog("Unit placed at x: " x ", y: " y)
                try {
                    if savedPlacements.Get("slot_" slotNum) {
                        savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                    }
                } catch {
                    savedPlacements.Set("slot_" slotNum, 1)
                }

                if placementCount >= placements {
                    break
                }

                if (gridPlacement) {
                    PlaceInGrid(x, y, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements)
                }

            }

 				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
            BetterClick(284, 400) ; next
            BetterClick(60, 450) ; move mouse
            if ShouldStopUpgrading(1) {
                AddToLog("Stopping due to finding lobby  condition.")
                return LobbyLoop()
            }
            Reconnect()

            ; Move to the next X-coordinate
            x += step
            AddToLog("x: " x ", y: " y)

            ; If X exceeds the end range, reset it and move down
            if (isInsideRect(rectZigZag, x, y)) {
                ; Alternate y between y1 and y2 for zig-zag effect
                y := (y = y1) ? y2 : y1
            } else {

                ; Incase y value goes out of bounds, re-initialize starting locations, and add a huge offset to x
                if (y >= endY) {
                    AddToLog("Reached end of Y-range or coordinates are outside rectangles. Moving to the next row.")
                    x := startX + Random(20, 40) ; Reset x to the starting position, add random offset to it incase 2 players are using same placement style
                    startY := 170
                    startY2 := 200
                    y1 := startY
                    y2 := startY2
                    y := y1
                } else { ; If y isin't OOB
                    AddToLog("Reached end of X-range or coordinates are outside rectangles. Moving to the next row.")
                    x := startX + Random(0, 15) ; Reset x to the starting position, add random offset to it incase 2 players are using same placement style
                    y1 := startY + step ; Move top Y-coordinate down
                    y2 := startY2 + step ; Move bottom Y-coordinate down
                    startY := y1 ; This is needed incase you loop again. Otherwise you will keep starting at the default startY/startY2 locations
                    startY2 := y2
                    y := y1 ; Start the new row with the top Y-coordinate
                }

            }

        } ; End While
        AddToLog("Completed " placementCount " placements for Slot " slotNum ".")
        Reconnect()
    } ; End For
    UpgradeUnits()
    AddToLog("All slot placements and upgrades completed.")
}

; Algorithm that's used in LinePlacement. Is a helper function. Attempts to place units in a 2x2 grid once an initial unit has been placed.
; Can be combined with other placement algos.
; by @Durrenth
; modified to place units in a 3x3 grid around the successful unit instead of 2x2
PlaceInGrid(startX, startY, slotNum, &placementCount, &successfulCoordinates, &savedPlacements, &placements) {
    ; Places untis in a 2x2 grid, starting from the top left where the initial unit is placed (as dictated by startX and startY)
    ; U x
    ; x x
    ;"Y"     ;"X"
    ;[number1,number2]

    gridOffsets := [
    [30, 0],  ; Row 1, Column 0
    [0, 30],  ; Row 0, Column 1
    [30, 30],   ; Row 1, Column 1
	[-30, -30],
	[-30, 30],
	[-30, 0],
	[0, -30],
	[30, -30]
    ]
    for index, offset in gridOffsets {

        ; Adds the value that's stored in the array at the current index to either x or y's starting location
        gridX := startX + offset[2] ; Move horizontally by 'step' from the initial start location
        gridY := startY + offset[1] ; Move vertically by 'step' from the initial start location
		
        ; Handle card picker and related logic during grid placement
		if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
			cardSelector()
		}
        BetterClick(284, 400) ; next
        BetterClick(60, 450) ; move mouse
        if ShouldStopUpgrading(1) {
            AddToLog("Stopping due to finding lobby condition.")
            return LobbyLoop()
        }
        Reconnect()

        if PlaceUnit(gridX, gridY, slotNum) {
            placementCount++ ; Increment the placement count
            successfulCoordinates.Push({ x: gridX, y: gridY, slot: "slot_" slotNum }) ; Track the placement
            AddToLog("Placed unit at (" gridX ", " gridY ") in 3x3 grid.")

            ; Update or initialize saved placements for the current slot
            try {
                if savedPlacements.Get("slot_" slotNum) {
                    savedPlacements.Set("slot_" slotNum, savedPlacements.Get("slot_" slotNum) + 1)
                }
            } catch {
                savedPlacements.Set("slot_" slotNum, 1)
            }



            ; Check if placement limit is reached
            if placementCount >= placements {
                break
            }

        }

    } ; End for

}

; Add placement options here
TryPlacingUnits() {
    switch PlacementDropdown.Text {
        case "Spiral":
            SpiralPlacement()
        case "Lines":
            LinePlacement()
        case "Lines + 3x3 Grid Finder":
            LinePlacementGrid()
        case "Zig Zag":
            ZigZagPlacement()
        case "Zig Zag + 3x3 Grid Finder":
            ZigZagPlacement(true)
        case "Spiral + 3x3 Grid Finder":
            SpiralPlacement(true)
        default:
            AddToLog("Invalid placement logic selection")
    }
}



IsMaxed(coord) {
    global maxedCoordinates
    for _, maxedCoord in maxedCoordinates {
        if (maxedCoord.x = coord.x && maxedCoord.y = coord.y) {
            return true
        }
    }
    return false
}

UpgradeUnits() {
    if UUPCheckbox.Value == 1 {
        global successfulCoordinates, maxedCoordinates, unitUpgradePrioritydropDowns
        AddToLog("Beginning prioritized unit upgrades.")

        priorityMapping := []
        for index, dropDown in unitUpgradePrioritydropDowns {
            priorityText := dropDown.Text
            if priorityText && priorityText != "" {
                priorityMapping.Push(priorityText)
            }
        }

        SortByPriority(&successfulCoordinates, priorityMapping)

        for coord in successfulCoordinates {
            if IsMaxed(coord) {
                AddToLog("Unit already maxed at: X" coord.x " Y" coord.y ". Skipping upgrade.")
                continue
            }
            while !IsMaxUpgrade() {
                UpgradeUnit(coord.x, coord.y)
				
                if (IsMaxUpgrade()) {
                    break
                }
                
                Sleep 200

                if (autoAbilityEnabled and ok := FindText(&X, &Y, 367, 262, 445, 302, 0, 0, AbilityOFF)) {
                    BetterClick(373, 237)
                }
				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
                BetterClick(284, 400) ; next

                if ShouldStopUpgrading() {
                    AddToLog("Found return to lobby, going back.")
                    successfulCoordinates := []
                    maxedCoordinates := []
                    return LobbyLoop()
                }

				Sleep 100
                Reconnect()
            }

            if (autoAbilityEnabled and ok := FindText(&X, &Y, 367, 262, 445, 302, 0, 0, AbilityOFF)) ; USE ABILITY IF OFF
            {
                BetterClick(373, 237)
            }

            if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
                cardSelector()
            }
			
            BetterClick(565, 563) ; move mouse
            AddToLog("Max upgrade reached for: X" coord.x " Y" coord.y ". Moving onto next unit")
            maxedCoordinates.Push(coord)
        }

        AddToLog("All units upgraded or maxed.")
        while !ShouldStopUpgrading() {
            BetterClick(284, 400) ; next
            Sleep(2000)
			if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
				cardSelector()
			}
        }

        return LobbyLoop()
    }
    else {
        global successfulCoordinates
        global maxedCoordinates

        AddToLog("Beginning unit upgrades.")

        while true { ; Infinite loop to ensure continuous checking
            for index, coord in successfulCoordinates {

                UpgradeUnit(coord.x, coord.y)

                if ShouldStopUpgrading() {
                    AddToLog("Found return to lobby, going back.")
                    successfulCoordinates := []
                    maxedCoordinates := []
                    return LobbyLoop()
                }

                if IsMaxUpgrade() {
                    AddToLog("Max upgrade reached for: X" coord.x " Y" coord.y)
                    maxedCoordinates.Push(successfulCoordinates.Get(index))
                    successfulCoordinates.RemoveAt(index) ; Remove the coordinate
                    continue ; Skip to the next coordinate
                }

                Sleep(200)
                if (autoAbilityEnabled and ok := FindText(&X, &Y, 367, 262, 445, 302, 0, 0, AbilityOFF)) ; USE ABILITY IF OFF
                {
                    BetterClick(373, 237)
                }
				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
                BetterClick(284, 400) ; next
                BetterClick(565, 563) ; move mouse
                Reconnect()
            }

            ; If all units are maxed, still check for stopping condition
            if successfulCoordinates.Length = 0 and maxedCoordinates.Length > 0 {
                Reconnect()
				if (ok := FindText(&cardX, &cardY, 196, 204, 568, 278, 0, 0, pick_card)) {
					cardSelector()
				}
                BetterClick(284, 400) ; next
                if ShouldStopUpgrading() {
                    AddToLog("Stopping due to finding return to lobby button.")
                    return LobbyLoop()
                }
                Sleep(2000) ; Prevent excessive looping

            }

            Reconnect()
        }
    }
}

SortByPriority(&array, priorityMapping) {
    AddToLog("Starting unit sorting by priority mapping")
    sortedArray := []

    for index, slot in priorityMapping {
        foundSlot := false

        for i, item in array {
            if (item.slot = slot) {
                sortedArray.Push(item)
                foundSlot := true
            }
        }

        if !foundSlot {
            AddToLog("No units found for: " slot ". Moving onto next slot")
        }
    }

    array := sortedArray
    AddToLog("Finished sorting units, starting upgrading")
}



UpgradeUnit(x, y) {
    counter := 1
    loop 4 {
		BetterClick(x, y - 3)
        if (counter == 4) {
            AddToLog("Unit is actually maxed? Last attempt")
            break
        }
        if (IsMaxUpgrade()) {
            AddToLog("Clicked on wrong unit by accident? Retry " counter "/3")
            BetterClick(329, 184) ; close upg menu
            counter += 1
            continue
        }
	    break
    }
    
    BetterClick(210, 363) ; upgrade
    BetterClick(210, 363) ; upgrade
    BetterClick(210, 363) ; upgrade
    Sleep 1000
}

IsMaxUpgrade() {
    Sleep 500
    if (ok := FindText(&X, &Y, 245, 233, 362, 274, 0, 0, MaxUpgrade) or (ok := FindText(&X, &Y, 212, 385, 361, 440, 0,
        0, MaxUpgrade2))) {
        return true
    }
}

ShouldStopUpgrading(sleepamount := 300) {
    global loss
    global wins
    Sleep sleepamount
    if CheckForLobbyButton() {
        if (WebhookCheckbox.Value = 1) {
            if Checkforloss() {
                loss++
                SendInput ("{Tab}")
                Sleep 100
                LossWebhook()
            } else if !Checkforloss() {
                wins++
                SendInput ("{Tab}")
                Sleep 100
                sendWebhook()
            }
        }

        ; Check the state of the Back To Lobby checkbox
        if (backToLobbyEnabled) {
            BetterClick(376, 117) ; Back to Lobby
        } else {
            BetterClick(540, 117) ; Replay
            sleep 2000

            LoadedLoop()
            StartedLoop()
            TryPlacingUnits()

        }

        return true
    }
}

FindAndClickColor(targetColor := 0x006783, searchArea := [0, 0, GetWindowCenter(RobloxWindow).Width, GetWindowCenter(RobloxWindow).Height]) {
    ; Extract the search area boundaries
    x1 := searchArea[1], y1 := searchArea[2], x2 := searchArea[3], y2 := searchArea[4]
	
    ; Perform the pixel search
    if (PixelSearch(&foundX, &foundY, x1, y1, x2, y2, targetColor, 0)) {
        ; Color found, click on the detected coordinates
		AddToLog("Beam found at X" foundX " Y" foundY " . Waiting 5s before clicking")
        Sleep 5000
        BetterClick(foundX, foundY, "Right")
        AddToLog("YES IT JUST CLICKED ON THE BEAM")
        AddToLog("Waiting 14 seconds.")
		Sleep 10000
        return true
    }
}

OnSpawn() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    OnSpawnSetup()
}

LookDown() {
    MouseMove(400, 300)
    loop 20 {
        SendInput("{WheelUp}")
        Sleep 50
    }
    Sleep 200
    MouseGetPos(&x, &y)
    MouseMove(400, 300)
    SendInput(Format("{Click {} {} Left}", x, y + 150))

    loop 20 {
        SendInput("{WheelDown}")
        Sleep 50
    }
}

LoadedLoop() {
    global hasReconnect
    AddToLog("Waiting to load in")
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
            global StageStartTime := A_TickCount
            AddToLog("Loaded in")
            if (hasReconnect == 1 && DisconnectCheckbox.Value == 1) {
                sendRCWebhook()
                hasReconnect := 0
            }
            break
        }
        else if (ok := FindText(&X, &Y, 606, 47, 648, 85, 0, 0, P)) {
            Sleep 10000
            if (ok := FindText(&X, &Y, 606, 47, 648, 85, 0, 0, P) and !(ok :=
                FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart))) {
                global StageStartTime := A_TickCount
                AddToLog("Loaded in late")
                if (hasReconnect == 1 && DisconnectCheckbox.Value == 1) {
                    sendRCWebhook()
                    hasReconnect := 0
                }
                break
            }
        }

        Reconnect()
    }
    chat := ChatToSend.Value
    if (ChatStatusBox.Value = 1 && StrLen(chat) > 0) {
        AddToLog("Sending chat")
        SendChat()
    }
}

StartedLoop() {
    AddToLog("Spawn setup starting")
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
            Sleep 1000
			OnSpawnSetup()
            break
        }
        break
    }
    AddToLog("Spawn setup done, waiting for vote start")
    	BetterClick(350, 103) ; click yes
        BetterClick(350, 100) ; click yes
        BetterClick(350, 97) ; click yes
	Sleep 500
	loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart))
        {
            continue
        }
        break
    }
    AddToLog("Game started, waiting 6s for income")
	Sleep(6000)
}

LobbyLoop() {
    loop {
        Sleep 1000
        if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText)) {
            break
        }
        Reconnect()
    }
    AddToLog("Returned to lobby, going back to raids")
    return GoToRaids()
}


CheckForLobbyButton() {
    if (ok := FindText(&X, &Y, 31, 142, 425, 180, 0, 0, ReturnToLobbyCheck) or ok := FindText(&X, &Y, 435, 144, 605, 187, 0, 0, ReplayButtonCheck)) {
        return true
    }
}

Checkforloss(targetColor := 0x161616){
    if (PixelSearch(&foundX, &foundY, 157, 63, 1, 1, targetColor, 0)) {
        return true
    }
    else
        return false
}

SendChat() {
    SendInput("/")
    Sleep 250
    chat := ChatToSend.Value
    if (ChatStatusBox.Value = 1 && StrLen(chat) > 0) {
        for char in StrSplit(chat) {
            Send(char)
            Sleep(Random(100, 200))  ; Optional delay between each keypress
        }
    }
    Sleep 1200
    SendInput("{Enter}")
    Sleep 250
    BetterClick(130, 43)
}

AutoSettingsChecker() {
    if (settingsCheckerEnabled) {
        SendInput("{Esc}")
        Sleep 1000
        BetterClick(246, 91)
        Sleep 1000

        if ((ok:=FindText(&X, &Y, 43, 180, 196, 298, 0, 0, NewMainSettingUI))) {
            AddToLog("New UI detected")
            Sleep 500
            SendInput("{Down}")
            Sleep 500
        
    
            AddToLog("Checking Camera Mode")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, CameraModeCheck))) {
                SendInput("{Right}")
                Sleep 1000 
            }
            SendInput("{Down}")
            Sleep 500
            AddToLog("Checking Movement Mode")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, DefaultKeyboardCheck))) {
                SendInput("{Right}")
                Sleep 1000 
            }
            
            SendInput("{Down}")
            Sleep 500
            AddToLog("Checking Camera Inverted")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, SettingsMenuOFF))) {
                SendInput("{Right}")
                Sleep 1000 
            }
    
            SendInput("{Down}")
            Sleep 500
            AddToLog("Checking Graphics Quality")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, GraphicsManualCheck))) {
                SendInput("{Left}")
                Sleep 1000
            }
    
            SendInput("{Down}")
            AddToLog("Reducing Graphics Quality to 1")
            Sleep 500
    
            while (ok:=FindText(&X, &Y, 334, 168, 407, 477, 0, 0, GraphQualityMinus)) {
                SendInput("{Left}")
                Sleep 250
            }
            
            Sleep 500
            SendInput("{Esc}")
            Sleep 1000

        }
        else {
            AddToLog("Old UI detected")
            Sleep 500
            MouseMove(0, 50, , "R")
            Sleep 500
            SendInput("{Down}")
            Sleep 500
        
    
            AddToLog("Checking Camera Mode (Default Classic)")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, CameraModeCheck))) {
                SendInput("{Right}")
                Sleep 1000 
            }
            SendInput("{Down}")
            Sleep 500
            AddToLog("Selecting Default (Keyboard)")
            while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, DefaultKeyboardCheck))) {
                SendInput("{Right}")
                Sleep 1000 
            }
            
            Sleep 1000
            loop 4 {
                Sleep 250
                SendInput("{WheelDown 1}") ; scroll
            }
    
            Sleep 1000
    
            if (ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, GraphicsModeCheck))
            {
                
                BetterClick(X-15, Y-40)
                AddToLog("Graphics Quality set to manual.")
                while (!(ok:=FindText(&X, &Y, 43, 166, 829, 528, 0, 0, GraphicsManualCheck))) {
                    SendInput("{Left}")
                    Sleep 1000
                }
    
                SendInput("{Down}")
                AddToLog("Reducing Graphics Quality to 1")
    
                Sleep 1000
    
                loop 9 {
                    SendInput("{Left}")
                    Sleep 250
                }
            }
            Sleep 500
            SendInput("{Esc}")
            Sleep 1000
        }
    
    }
    
}


TPtoSpawn() {

    BetterClick(27, 574) ; settings
    Sleep 1000
    BetterClick(400, 287)
    Sleep 600 
    loop 4 {
        Sleep 250
        SendInput("{WheelDown 1}") ; scroll
    }
    Sleep 600
    if (settingsCheckerEnabled) {
        if (ok := FindText(&X, &Y, 263, 232, 602, 489, 0, 0, DisableAutoOpenUpgradeUICheck)) {
            AddToLog("Wrong setting detected. Turning Auto Open Upgrade OFF") 
            BetterClick(523, Y-45)
        }
    
        Sleep 600
        if (ok := FindText(&X, &Y, 263, 232, 602, 489, 0, 0, ShowUpgradeUILeftCheck)) {
            AddToLog("Wrong setting detected. Turning Upgrade UI on Left ON") ; 561 360
            BetterClick(523, Y-45)
        }

    }
	
    Sleep 600
    if (ok := FindText(&X, &Y, 263, 217, 601, 487, 0, 0, TPtoSpawnCheck)) {
        AddToLog("Teleport To Spawn found. Clicking")
        BetterClick(523, Y-45)
    }
    else {
        AddToLog("Teleport to Spawn not found. Manually clicking on X523 Y366")
        BetterClick(523, 366)
    }

    Sleep 600
    BetterClick(582, 150) ; exit settings

}

DebugOCR() {
    if ControlGetVisible(keybindsGui) {
        return
    }
    ocrResult := OCR.FromRect(266, 309, 603 - 266, 352 - 309, , 2)

    if ocrResult {
        BetterClick(414, 342)
        AddToLog("Captcha Detected: " ocrResult.Text)

        ; Clean up the captcha string
        captcha := StrReplace(ocrResult.Text, " ")  ; Remove spaces
        if (StrLen(captcha) <= 1 || RegExMatch(captcha, "[A-Za-z]")) {
            AddToLog("invalid captcha retrying")
        }

        ; Remove special characters like /, -, and .
        captcha := RegExReplace(captcha, "[/.\-_,]")

        ; Send each character
        Send(captcha)
        ;for char in StrSplit(captcha) {
        ;    Send(char)
        ;    Sleep(Random(25, 75))  ; Optional delay between each keypress
        ;}
    } else {
        AddToLog("NO CAPTCHA FOUND.")
    }
}

AntiCaptcha() {

    ; Perform OCR on the defined region directly
    ocrResult := OCR.FromRect(266, 309, 603 - 266, 352 - 309, , 2)

    ; Display OCR results
    Reconnect()
    if ocrResult {
        BetterClick(414, 342)
        AddToLog("Captcha Detected: " ocrResult.Text)

        ; Clean up the captcha string
        captcha := StrReplace(ocrResult.Text, " ")  ; Remove spaces
        if (StrLen(captcha) <= 1 || RegExMatch(captcha, "[A-Za-z]")) {
            AddToLog("invalid captcha retrying")
            BetterClick(584, 192) ; close captcha
            return
        }

        ; Remove special characters like /, -, and .
        captcha := RegExReplace(captcha, "[/.\-_,]")

        ; Send each character
        Send(captcha)
        ;for char in StrSplit(captcha) {
        ;    Send(char)
        ;    Sleep(Random(25, 75))  ; Optional delay between each keypress
        ;}
    } else {
        AddToLog("NO CAPTCHA FOUND.")
    }

    BetterClick(309, 386) ; select
    Sleep 1500
    BetterClick(383, 221)
    Sleep 500

    sleep 10000
    if (ok := FindText(&X, &Y, 10, 70, 350, 205, 0, 0, LoadingScreen)) {
        return
    }
    if (ok := FindText(&X, &Y, 326, 60, 547, 173, 0, 0, VoteStart)) {
        return
    }
    AddToLog("Walking to ensure the UI pops up again if it didnt matchmake")

    loop 2 {
        HoldKey("D", 400)
        HoldKey("A", 800)
        HoldKey("Space", 2000)
    }

    Sleep 1500
    if (ok := FindText(&X, &Y, 221, 206, 403, 355, 0, 0, MatchmakeUI)) {
        AddToLog("Waiting for captcha cooldown then retrying")
        Sleep 6000
    }
    Reconnect()
    return
}

TapToMove(toggle) {

    SendInput("{Esc}")
    Sleep 1000
    BetterClick(246, 91)
    Sleep 500
    SendInput("{Down}")
    Sleep 500
    SendInput("{Down}")
    Sleep 500
    if (toggle) {
        SendInput("{Right}")
        Sleep 400
        SendInput("{Right}")
    }
    else {
        SendInput("{Left}")
        Sleep 400
        SendInput("{Left}")
    }
    Sleep 500
    SendInput("{Esc}")
    Sleep 1000
}

OnSpawnSetup() {
    SendInput ("{Tab}")
    LookDown()
    Sleep 200
    TPtoSpawn()
    Sleep 200
    TapToMove(true)
    Sleep 200

    AddToLog("Attempting to move to spot")
    loop 200 {
        Sleep 100

        if FindAndClickColor() {
            break
        }
    }
    Sleep 4000
    ;BetterClick(590, 15) ; click on P
    ;Sleep 1000
    TapToMove(false)
}

Reconnect() {
    ; Check for Disconnected Screen
    color_home := PixelGetColor(10, 10)
    color_reconnect := PixelGetColor(519,329)
    global hasReconnect
    if (color_home == 0x121215 or color_reconnect == 0x393B3D) {
        AddToLog("Disconnected! Attempting to reconnect...")
        if (DisconnectCheckbox.Value = 1) {
            sendDCWebhook()
        }

        ; Use Roblox deep linking to reconnect
        Run("roblox://placeID=" 8304191830)
        Sleep 2000
        if WinExist(RobloxWindow) {
            WinMove(27, 15, 800, 600, RobloxWindow)
            WinActivate(RobloxWindow)
            Sleep 1000
        }
        loop {
            AddToLog("Reconnecting to Roblox...")
            Sleep 15000
            if (ok := FindText(&X, &Y, 746, 476, 862, 569, 0, 0, AreasText)) {
                AddToLog("Reconnected Succesfully!")
                hasReconnect := 1
                return GoToRaids() ; Check for challenges in the lobby
            }
            else {
                Reconnect()
            }
        }
    }
}

HoldKey(key, duration) {
    SendInput ("{" key "up}")
    ; go to teleporter
    Sleep 100
    SendInput ("{" key " down}")
    Sleep duration
    SendInput ("{" key " up}")
    KeyWait key ; Wait for "d" to be fully processed
}

cardSelector() {
    AddToLog("Picking card in priority order")
    if (ok := FindText(&X, &Y, 200, 239, 276, 270, 0, 0, UnitExistence)) {
        BetterClick(329, 184) ; close upg menu
        sleep 100
    }

    BetterClick(59, 572) ; Untarget Mouse
    sleep 100

    for index, priority in priorityOrder {
        if (!textCards.Has(priority)) {
			AddToLog(Format("Card {} not available in textCards", priority))																
            continue
        }
        if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, textCards.Get(priority))) {
			
			if (priority == "shield") {
                if (RadioHighest.Value == 1) {
                    AddToLog("Picking highest shield debuff")
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, shield3)) {
                        AddToLog("Found shield 3")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, shield2)) {
                        AddToLog("Found shield 2")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, shield1)) {
                        AddToLog("Found shield 1")
                    }
                }

            }

            else if (priority == "speed") {
                if (RadioHighest.Value == 1) {
                    AddToLog("Picking highest speed debuff")
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, speed3)) {
                        AddToLog("Found speed 3")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, speed2)) {
                        AddToLog("Found speed 2")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, speed1)) {
                        AddToLog("Found speed 1")
                    }
                }
            }

            else if (priority == "health") {
                if (RadioHighest.Value == 1) {
                    AddToLog("Picking highest health debuff")
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, health3)) {
                        AddToLog("Found health 3")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, health2)) {
                        AddToLog("Found health 2")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, health1)) {
                        AddToLog("Found health 1")
                    }
                }
            }

            else if (priority == "regen") {
                if (RadioHighest.Value == 1) {
                    AddToLog("Picking highest regen debuff")
                    if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, regen3)) {
                        AddToLog("Found regen 3")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, regen2)) {
                        AddToLog("Found regen 2")
                    }
                    else if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, regen1)) {
                        AddToLog("Found regen 1")
                    }
                }
            }
            
            else if (priority == "yen") {
				if (ok := FindText(&cardX, &cardY, 209, 203, 652, 404, 0, 0, yen2)) {
					AddToLog("Found yen 2")
				}
				else {
					AddToLog("Found yen 1")
				}
			}

            FindText().Click(cardX, cardY, 0)
            MouseMove 0, 10, 2, "R"
            Click 2
            sleep 1000
            MouseMove 0, 120, 2, "R"
            Click 2
            AddToLog(Format("Picked card: {}", priority))
            sleep 5000
            return
        }
    }
    AddToLog("Failed to pick a card")
}