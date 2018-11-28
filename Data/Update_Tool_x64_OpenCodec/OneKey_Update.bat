@echo off
mode con cols=100 lines=30
color 0b
title PotPlayer Portable OneKey Update

echo ===============================================================================
echo PotPlayer x64 with OpenCodec 一键更新工具 v1.0.0
echo ===============================================================================
echo 本工具会一键更新 PotPlayer 到最新版本，使用前请关闭 PotPlayer。
echo ===============================================================================
pause
:: 从官网下载安装包
cd /d %~dp0
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: 可选下载地址
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup64.exe
title PotPlayer Portable OneKey Update

:: 解压制作64位版 Potplayer
7z.exe x PotPlayerSetup64.exe -o.\PotPlayer64 -y
cd PotPlayer64
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
del /f /q UrlList
rename History\Chinese(Simplified).txt Chinese(Simplified).bak
rename History\English.txt English.bak
rename History\Korean.txt Korean.bak
rename Language\Chinese(Simplified).ini Chinese(Simplified).bak
rename Language\English.ini English.bak
rename Language\Korean.ini Korean.bak
del /f /q History\*.txt
del /f /q Language\*.ini
rename History\Chinese(Simplified).bak Chinese(Simplified).txt
rename History\English.bak English.txt
rename History\Korean.bak Korean.txt
rename Language\Chinese(Simplified).bak Chinese(Simplified).ini
rename Language\English.bak English.ini
rename Language\Korean.bak Korean.ini
md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec64.exe
del /f DesktopHook64.dll
del /f DesktopHook64.exe
del /f FileList.txt
del /f KillPot64.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify64.exe
del /f PotPlayer64.exe
del /f PotPlayerMiniXP64.exe
del /f PotPlayerXP64.exe
del /f PotScreenSaver64.scr
del /f uninstall.exe.nsis
cd ..
7z.exe x OpenCodecSetup64.exe -o.\OpenCodecSetup64 -y
xcopy /s /i /y .\OpenCodecSetup64\Module .\PotPlayer64\Module

xcopy /s /i /y .\PotPlayer64\* ..\*

del /f PotPlayerSetup64.exe
del /f OpenCodecSetup64.exe
rd /s /q PotPlayer64
rd /s /q OpenCodecSetup64

echo 更新完成，请按任意键退出！
pause>nul