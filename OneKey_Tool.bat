@echo off
mode con cols=100 lines=30
color 0b
title PotPlayer Portable OneKey Tool

echo PotPlayer 绿色便携版一键制作工具 v1.0.0
echo ===============================================================================
echo 本工具用于下载制作绿色便携版 PotPlayer，包含32位和64位，绿色版PotPlayer不写注册表。
echo ===============================================================================
echo 请选择想要附加的额外编解码器种类：
echo 1.附加完整的 OpenCodec (占用硬盘空间较大)
echo 2.只附加 FFmpegMininum (占用硬盘空间较小)
echo ===============================================================================
:choice0
set /p choice=请键入对应选项前的数字，并按回车：
if /i %choice%==2 goto FFmpegMininum
if /i %choice%==1 goto OpenCodec
echo 输入无效，请重新输入！
goto choice0

:OpenCodec
:: 从官网下载安装包
cd /d %~dp0
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: 可选下载地址
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Codec/OpenCodecSetup64.exe
title PotPlayer Portable OneKey Tool
:: 获取 PotPlayer 版本号并创建文件夹
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%
:: 解压32位版 Potplayer
7z.exe x PotPlayerSetup.exe -o.\PotPlayer -y
:: 精简文件
cd PotPlayer
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
del /f D_Exec.exe
del /f DesktopHook.exe
del /f FileList.txt
del /f KillPot.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify.exe
del /f PotPlayer.exe
del /f PotPlayerXP.exe
del /f PotScreenSaver.scr
del /f uninstall.exe.nsis
md For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
move DesktopHook.dll For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
:: 拷贝皮肤文件 ini设置文件等
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
rename .\PotPlayerMini64.ini PotPlayerMini.ini
copy ..\Data\readme.txt .\For_WinXP_User
:: 提取 OpenCodec 并拷贝到对应位置
cd ..
7z.exe x OpenCodecSetup.exe -o.\OpenCodecSetup -y
xcopy /s /i /y .\OpenCodecSetup\Module .\PotPlayer\Module
:: 创建绿色版的压缩包等
7z a PotPlayer.7z PotPlayer\
rename PotPlayer.7z PotPlayer_%version%_Public.7z
move PotPlayer_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup.exe PotPlayerSetup_%version%_Public.exe
move PotPlayerSetup_%version%_Public.exe PotPlayer_%version%
move OpenCodecSetup.exe PotPlayer_%version%
rd /s /q PotPlayer
rd /s /q OpenCodecSetup
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
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
cd ..
7z.exe x OpenCodecSetup64.exe -o.\OpenCodecSetup64 -y
xcopy /s /i /y .\OpenCodecSetup64\Module .\PotPlayer64\Module
7z a PotPlayer64.7z PotPlayer64\
rename PotPlayer64.7z PotPlayer64_%version%_Public.7z
move PotPlayer64_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup64.exe PotPlayerSetup64_%version%_Public.exe
move PotPlayerSetup64_%version%_Public.exe PotPlayer_%version%
move OpenCodecSetup64.exe PotPlayer_%version%
rd /s /q PotPlayer64
rd /s /q OpenCodecSetup64
goto end1

:FFmpegMininum
:: 从官网下载所需安装包
cd /d %~dp0
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
wget.exe -N --no-check-certificate https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup64.exe
:: 可选下载地址
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer/v4/Module/FFmpeg/FFmpegMininum.dll
wget.exe -N --no-check-certificate https://get.daum.net/PotPlayer64/v4/Module/FFmpeg/FFmpegMininum64.dll
title PotPlayer Portable OneKey Tool
:: 获取 PotPlayer 版本号并创建文件夹
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%
:: 解压制作32位版 Potplayer
7z.exe x PotPlayerSetup.exe -o.\PotPlayer -y
cd PotPlayer
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
del /f D_Exec.exe
del /f DesktopHook.exe
del /f FileList.txt
del /f KillPot.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify.exe
del /f PotPlayer.exe
del /f PotPlayerXP.exe
del /f PotScreenSaver.scr
del /f uninstall.exe.nsis
md For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
move DesktopHook.dll For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
rename .\PotPlayerMini64.ini PotPlayerMini.ini
copy ..\Data\readme.txt .\For_WinXP_User
cd ..
move FFmpegMininum.dll .\PotPlayer\Module\FFmpeg
7z a PotPlayer.7z PotPlayer\
rename PotPlayer.7z PotPlayer_%version%_Public.7z
move PotPlayer_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup.exe PotPlayerSetup_%version%_Public.exe
move PotPlayerSetup_%version%_Public.exe PotPlayer_%version%
rd /s /q PotPlayer
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
xcopy /s /i /y ..\Data\Skins .\Skins
copy ..\Data\PotPlayerMini64.ini .\
cd ..
move FFmpegMininum64.dll .\PotPlayer64\Module\FFmpeg
7z a PotPlayer64.7z PotPlayer64\
rename PotPlayer64.7z PotPlayer64_%version%_Public.7z
move PotPlayer64_%version%_Public.7z PotPlayer_%version%
rename PotPlayerSetup64.exe PotPlayerSetup64_%version%_Public.exe
move PotPlayerSetup64_%version%_Public.exe PotPlayer_%version%
rd /s /q PotPlayer64
goto end2

:end1
cls
echo ===============================================================================
echo PotPlayer 制作完成，生成的文件位于 PotPlayer_%version% 文件夹下。说明如下：
echo ===============================================================================
echo 32位绿色版(附加完整的OpenCodec)               PotPlayer_%version%_Public.7z
echo 64位绿色版(附加完整的OpenCodec)               PotPlayer64_%version%_Public.7z
echo 32位官方安装包                                PotPlayerSetup_%version%_Public.exe
echo 64位官方安装包                                PotPlayerSetup64_%version%_Public.exe
echo 32位 OpenCodec                                OpenCodecSetup.exe
echo 64位 OpenCodec                                OpenCodecSetup64.exe
echo ===============================================================================
goto end

:end2
cls
echo ===============================================================================
echo PotPlayer 制作完成，生成的文件位于 PotPlayer_%version% 文件夹下。说明如下：
echo ===============================================================================
echo 32位绿色版(附加FFmpegMininum.dll)           PotPlayer_%version%_Public.7z
echo 64位绿色版(附加FFmpegMininum64.dll)         PotPlayer64_%version%_Public.7z
echo 32位官方安装包                              PotPlayerSetup_%version%_Public.exe
echo 64位官方安装包                              PotPlayerSetup64_%version%_Public.exe
echo ===============================================================================
goto end

:end
pause