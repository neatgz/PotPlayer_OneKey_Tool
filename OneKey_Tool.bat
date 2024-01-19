@echo off
:: author neatgz @ GitHub
:: download from https://github.com/neatgz/PotPlayer_OneKey_Tool/releases
mode con cols=100 lines=30
color 0b
title PotPlayer Portable OneKey Tool
echo PotPlayer 绿色便携版一键制作工具 v3.5.1
echo ===============================================================================
echo 主要功能：
echo * 下载、精简、制作、更新 PotPlayer 绿色版（可选 x86 x64）
echo * 可选 在线下载 Public版、Dev 版（Dev 版仅限 x64）
echo * 可选 本地已有安装包的绿化处理（仅限 x64）
echo * 可选附加滤镜解码器种类，可选 LAVFilters + madVR + XySubFilter
echo * 下载过程中可选使用本地 http 网络代理
echo * 可选是否保留 WinXP 支持（仅限 x86）
echo * 可选是否附加精选皮肤、美化文件关联图标
echo * 可选是否附加电视源，可用于观看电视直播
echo * 可选是否配置便携化，附加推荐的 PotPlayer 设置
echo 使用说明：
echo * 所有选择页面，选项 1 均为默认选项
echo * 除本页外，其它所有选择页面在倒计时 2 分钟后将自动选择默认选项，本页倒计时等待 5 分钟
echo * 若附加 LAVFilters + madVR + XySubFilter，后续请自行在 PotPlayer 里手动启用和配置
echo ===============================================================================
echo 请选择要制作的 PotPlayer 版本：
echo 1.PotPlayer 64bit Public 绿色版【默认】
echo 2.PotPlayer 32bit Public 绿色版
echo 3.PotPlayer 64bit Dev 绿色版
echo 4.PotPlayer 64bit Local 本地已有安装包的绿化打包 【请提前下载好官方安装包和解码包】
echo  【仅限64位，请把 PotPlayerSetup64.exe 和 OpenCodecSetup64.exe 拷贝至本文件夹里】
echo ===============================================================================
choice  /c 1234 /n /m "请输入目标选项前的数字：" /d 1 /t 300
if %errorlevel%==4 (goto tag_AA_4)
if %errorlevel%==3 (goto tag_AA_3)
if %errorlevel%==2 (goto tag_AA_2)
if %errorlevel%==1 (goto tag_AA_1)
:tag_AA_1
set platform=64
set platformA=x64
set ver=Public
set EXEurl=https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup%platform%.exe
:: 可选 Public PotPlayer64 下载地址 https://get.daum.net/PotPlayer64/Version/Latest/PotPlayerSetup64.exe
goto tag_AA_over
:tag_AA_2
set platform=
set platformA=x86
set ver=Public
set EXEurl=https://t1.daumcdn.net/potplayer/PotPlayer/Version/Latest/PotPlayerSetup.exe
:: 可选 Public PotPlayer   下载地址 https://get.daum.net/PotPlayer/Version/Latest/PotPlayerSetup.exe
goto tag_AA_over
:tag_AA_3
set platform=64
set platformA=x64
set ver=Dev
set EXEurl=https://t1.daumcdn.net/potplayer/beta/PotPlayerSetup%platform%.exe
:: 可选 Dev PotPlayer   下载地址 https://t1.daumcdn.net/potplayer/beta/PotPlayerSetup.exe
goto tag_AA_over
:tag_AA_4
set platform=64
set platformA=x64
set ver=Local
set keepXP=0
set Module=all
set ModuleName=OpenCodec
goto tag_BB
:tag_AA_over
cls
echo ===============================================================================
echo 请选择下载过程中使用的下载工具：
echo ===============================================================================
echo 1.aria2(多线程)【默认】
echo 2.wget(单线程)
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set downloadtool=wget)
if %errorlevel%==1 (set downloadtool=aria2)
cls
echo ===============================================================================
echo 下载过程中是否需要本地 http 网络代理：
echo ===============================================================================
echo 1.不使用代理【默认】
echo 2.使用 127.0.0.1:7890
echo 3.手动输入 http 代理地址
echo ===============================================================================
choice  /c 123 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==3 (goto tag_B1)
if %errorlevel%==2 (set proxy_parameter_wget_http=-e "http_proxy=http://127.0.0.1:7890" & set proxy_parameter_wget_https=-e "https_proxy=https://127.0.0.1:7890" & set proxy_parameter_aria2=--all-proxy="http://127.0.0.1:7890" )
if %errorlevel%==1 (set proxy_parameter_wget_http=& set proxy_parameter_wget_https=& set proxy_parameter_aria2=)
goto tag_B2
:tag_B1
set /P proxy=请输入代理地址，然后按回车，格式为【127.0.0.1:1080】不含方括号：
set proxy_parameter_wget_http=-e "http_proxy=http://%proxy%" 
set proxy_parameter_wget_https=-e "https_proxy=https://%proxy%" 
set proxy_parameter_aria2=--all-proxy="http://%proxy%" 
:tag_B2
cls
if %platformA%==x64 (goto tagA_1)
echo ===============================================================================
echo 是否保留 WinXP 支持(仅限x86)：
echo ===============================================================================
echo 1.是【默认】
echo 2.否
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set keepXP=0)
if %errorlevel%==1 (set keepXP=1)
goto tagA_1_1
:tagA_1
set keepXP=0
:tagA_1_1
cls
echo ===============================================================================
echo 请选择附加滤镜解码器的种类：
echo ===============================================================================
echo 1.官方完整版的 OpenCodec【默认】
echo 2.官方精简版的 FFmpegMininum
echo 3.LAVFilters + madVR + XySubFilter + FFmpegMininum
echo ===============================================================================
choice  /c 123 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==3 (set Module=madVR& set ModuleName=LAVFilters_madVR_XySubFilter)
if %errorlevel%==2 (set Module=mini& set ModuleName=FFmpegMininum& set ffmpegminiURL=https://t1.daumcdn.net/potplayer/PotPlayer/Codec/v2/FFmpegMininum%platform%.dll)
if %errorlevel%==1 (set Module=all& set ModuleName=OpenCodec& set codecEXEurl=https://t1.daumcdn.net/potplayer/PotPlayer/Codec/v2/OpenCodecSetup%platform%.exe)
:: :: 可选 OpenCodec 下载地址 https://get.daum.net/PotPlayer/Codec/OpenCodecSetup%platform%.exe
:: :: 230327(1.7.21892)开始OpenCodecSetup新链接的子目录由FFmpeg4改为FFmpeg60
:: :: 旧版 OpenCodec 下载地址 https://t1.daumcdn.net/potplayer/PotPlayer/Codec/v1/OpenCodecSetup%platform%.exe
:tag_BB
cls
echo ===============================================================================
echo 是否保留 PotPlayer 官方 EXE 安装包以作备用：
echo ===============================================================================
echo 1.是【默认】
echo 2.否
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set keepEXE=0)
if %errorlevel%==1 (set keepEXE=1)
cls
if %Module%==all (goto tagA_2)
goto tagA_3
:tagA_2
echo ===============================================================================
echo 是否保留 OpenCodec 官方 EXE 安装包以作备用：
echo ===============================================================================
echo 1.是【默认】
echo 2.否
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set keepEXEcodec=0)
if %errorlevel%==1 (set keepEXEcodec=1)
:tagA_3
cls
if %Module%==madVR (goto tagA_4)
goto tagA_5
:tagA_4
echo ===============================================================================
echo 请选择要附加的 LAVFilters + madVR + XySubFilter 的版本：
echo ===============================================================================
echo 1.默认版本【默认】
echo 2.手动输入版本号
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set /P LAVversion=请输入 LAVFilters 的版本号，然后按回车，格式为【0.77.1】不含方括号：& set /P XySubversion=请输入 XySubFilter 的版本号，然后按回车，格式为【3.1.0.752】不含方括号：)
if %errorlevel%==1 (set LAVversion=0.78& set XySubversion=3.1.0.752)
set ffmpegminiURL=https://t1.daumcdn.net/potplayer/PotPlayer/Codec/v2/FFmpegMininum%platform%.dll
set LAVFiltersURL=https://github.com/Nevcairiel/LAVFilters/releases/download/%LAVversion%/LAVFilters-%LAVversion%-%platformA%.zip
set madVRurl=http://madshi.net/madVR.zip
set XySubFilterURL=https://github.com/Cyberbeing/xy-VSFilter/releases/download/%XySubversion%/XySubFilter_%XySubversion%_%platformA%.zip
:tagA_5
cls
echo ===============================================================================
echo 是否附加精选皮肤：
echo ===============================================================================
echo 1.是【默认】
echo 2.否
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set addSkins=0)
if %errorlevel%==1 (set addSkins=1)
cls
echo ===============================================================================
echo 是否美化文件关联图标：
echo ===============================================================================
echo 1.否【默认】
echo 2.是
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set replaceFileICON=1)
if %errorlevel%==1 (set replaceFileICON=0)
cls
echo ===============================================================================
echo 是否 解决【菜单 打开 打开链接】时卡顿转圈的问题：
echo ===============================================================================
echo 1.是【默认】
echo 2.否
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set UrlList=0)
if %errorlevel%==1 (set UrlList=1)
cls
echo ===============================================================================
echo 是否附加电视源(可用于观看电视直播)：
echo ===============================================================================
echo 1.否【默认】
echo 2.是
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set addTVlist=1)
if %errorlevel%==1 (set addTVlist=0)
cls
if %platformA%==x86 (goto tagA_6)
echo ===============================================================================
echo 是否附加 Update_Tool ：
echo ===============================================================================
echo 1.否【默认】
echo 2.是
echo ===============================================================================
choice  /c 12 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==2 (set addUpdateTool=1)
if %errorlevel%==1 (set addUpdateTool=0)
goto tagA_6_1
:tagA_6
set addUpdateTool=0
:tagA_6_1
cls
echo ===============================================================================
echo 请选择 PotPlayer 的配置及保存方式：
echo ===============================================================================
echo 1.推荐的个性化配置，保存到 ini 文件（便携）【默认】
echo 2.官方默认配置，关闭检查更新，保存到 ini 文件（便携）
echo 3.官方默认配置，保存到注册表
echo ===============================================================================
choice  /c 123 /n /m "请输入目标选项前的数字：" /d 1 /t 120
if %errorlevel%==3 (set settingsSaveInINI=0)
if %errorlevel%==2 (set settingsSaveInINI=1& set INIsettings=0)
if %errorlevel%==1 (set settingsSaveInINI=1& set INIsettings=1)
echo 参数选择完成，即将开始制作
PAUSE
cls
:: 参数设定完成，操作开始
cd /d %~dp0
if %ver%==Local (goto tag_down_pot_exe_over)
:: 下载 PotPlayer 官方 exe 安装包
if %downloadtool%==aria2 (goto tag_down_pot_exe_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%EXEurl%
goto tag_down_pot_exe_over
:tag_down_pot_exe_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%EXEurl%
:tag_down_pot_exe_over
:: 获取 PotPlayer 版本号并创建文件夹
set batPath =%~dp0
for /f "skip=1 tokens=2 delims==" %%i in (
  'wmic datafile where "name='%batPath :\=\\%PotPlayerSetup%platform%.exe'" get Version /format:list'
) do for /f "delims=" %%v in ("%%i") do set "version=%%v"
mkdir PotPlayer_%version%_%ver%
:: 解压 Potplayer 安装包
7z.exe x PotPlayerSetup%platform%.exe -o.\PotPlayer%platform% -y
:: 精简文件
cd PotPlayer%platform%
rd /s /q $0
rd /s /q $PLUGINSDIR
rd /s /q Html
if exist Logos\PotPlayer_1.png (del /f /q Logos\PotPlayer.png & rename Logos\PotPlayer_1.png PotPlayer.png)
:: del /f /q Logos
:: del /f /q Skins
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
:: md Module\FFmpeg
del /f Alarm.wav
del /f D_Exec%platform%.exe
del /f DesktopHook%platform%.exe
del /f FileList.txt
del /f KillPot%platform%.exe
del /f LGPL.TXT
del /f LogManager.exe
del /f PotNotify%platform%.exe
del /f PotPlayer%platform%.exe
del /f PotPlayerXP%platform%.exe
del /f PotScreenSaver%platform%.scr
del /f uninstall.exe.nsis
:: 是否保留 WinXP 支持(仅限x86)
if %keepXP%==1 (goto tag_xp)
del /f DesktopHook%platform%.dll
del /f PotPlayerMiniXP%platform%.exe
goto tag_xp_over
:tag_xp
md For_WinXP_User
move DesktopHook.dll For_WinXP_User
move PotPlayerMiniXP.exe For_WinXP_User
rename For_WinXP_User\PotPlayerMiniXP.exe PotPlayerMini.exe
copy ..\Data\WinXP\readme.txt .\For_WinXP_User
:tag_xp_over
cd ..
:: 附加编解码器的种类判断
if %ver%==Local (goto tag_down_OpenCodecSetup_over)
if %Module%==mini (goto tag_FFmpegMininum)
if %Module%==all (goto tag_all)
:: LAVFilters + madVR + XySubFilter
:: 附加 FFmpegMininum 备用
if %downloadtool%==aria2 (goto tag_down_ffmpegmini-madvr_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%ffmpegminiURL%
goto tag_down_ffmpegmini-madvr_over
:tag_down_ffmpegmini-madvr_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%ffmpegminiURL%
:tag_down_ffmpegmini-madvr_over
move FFmpegMininum%platform%.dll .\PotPlayer%platform%\Module\FFmpeg4
:: LAVFilters
if %downloadtool%==aria2 (goto tag_down_LAVFilters_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%LAVFiltersURL%
goto tag_down_LAVFilters_over
:tag_down_LAVFilters_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%LAVFiltersURL%
:tag_down_LAVFilters_over
7z.exe x LAVFilters-%LAVversion%-%platformA%.zip -o.\LAVFilters -y
xcopy /s /i /y .\LAVFilters .\PotPlayer%platform%\Module\LAVFilters
rd /s /q LAVFilters
:: del /f LAVFilters-%LAVversion%-%platformA%.zip
move LAVFilters-%LAVversion%-%platformA%.zip PotPlayer_%version%_%ver%
:: madVR
if %downloadtool%==aria2 (goto tag_down_madVR_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_http%%madVRurl%
goto tag_down_madVR_over
:tag_down_madVR_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%madVRurl%
:tag_down_madVR_over
7z.exe x madVR.zip -o.\madVR -y
xcopy /s /i /y .\madVR .\PotPlayer%platform%\Module
rd /s /q madVR
:: del /f madVR.zip
move madVR.zip PotPlayer_%version%_%ver%
:: XySubFilter
if %downloadtool%==aria2 (goto tag_down_XySubFilter_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%XySubFilterURL%
goto tag_down_XySubFilter_over
:tag_down_XySubFilter_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%XySubFilterURL%
:tag_down_XySubFilter_over
7z.exe x XySubFilter_%XySubversion%_%platformA%.zip -o.\XySubFilter -y
xcopy /s /i /y .\XySubFilter .\PotPlayer%platform%\Module\XySubFilter
rd /s /q XySubFilter
:: del /f XySubFilter_%XySubversion%_%platformA%.zip
move XySubFilter_%XySubversion%_%platformA%.zip PotPlayer_%version%_%ver%
goto tag_Module_over
:: 附加完整的 OpenCodec，占用空间较大
:tag_all
if %downloadtool%==aria2 (goto tag_down_OpenCodecSetup_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%codecEXEurl%
goto tag_down_OpenCodecSetup_over
:tag_down_OpenCodecSetup_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%codecEXEurl%
:tag_down_OpenCodecSetup_over
7z.exe x OpenCodecSetup%platform%.exe -o.\OpenCodecSetup%platform% -y
xcopy /s /i /y .\OpenCodecSetup%platform%\Module .\PotPlayer%platform%\Module
rd /s /q OpenCodecSetup%platform%
:: 是否保留 OpenCodec exe 安装包
if %keepEXEcodec%==1 (goto tag_keep_exe_codec)
del /f OpenCodecSetup%platform%.exe
goto tag_keep_exe_codec_over
:tag_keep_exe_codec
move OpenCodecSetup%platform%.exe PotPlayer_%version%_%ver%
:tag_keep_exe_codec_over
goto tag_Module_over
:: 附加 FFmpegMininum，占用空间较小
:tag_FFmpegMininum
if %downloadtool%==aria2 (goto tag_down_ffmpegmini_aria2)
wget.exe -N --no-check-certificate %proxy_parameter_wget_https%%ffmpegminiURL%
goto tag_down_ffmpegmini_over
:tag_down_ffmpegmini_aria2
aria2c.exe --split=15 --max-connection-per-server=15 %proxy_parameter_aria2%%ffmpegminiURL%
:tag_down_ffmpegmini_over
move FFmpegMininum%platform%.dll .\PotPlayer%platform%\Module\FFmpeg4
:tag_Module_over
:: 是否附加皮肤文件
if %addSkins%==0 (goto tag_UrlList)
xcopy /s /i /y .\Data\Skins .\PotPlayer%platform%\Skins
:tag_UrlList
:: 是否解决打开链接卡顿转圈
if %UrlList%==0 (goto tag_addSkins)
xcopy /s /i /y .\Data\Extension .\PotPlayer%platform%\Extension
:tag_addSkins
:: 是否附加电视源
if %addTVlist%==0 (goto tag_addTVlist)
xcopy /s /i /y .\Data\Playlist .\PotPlayer%platform%\Playlist
:tag_addTVlist
:: 是否附加 update tool
if %addUpdateTool%==0 (goto tag_addUpdateTool)
cd PotPlayer%platform%
mkdir Update_Tool
xcopy /s /i /y ..\Data\Update_Tool\Update_Tool_%platformA%_OpenCodec.bat .\Update_Tool\
rename .\Update_Tool\Update_Tool_%platformA%_OpenCodec.bat Update_Tool.bat
xcopy /s /i /y ..\Data\%platformA%\* .\Update_Tool\
cd ..
:tag_addUpdateTool
:: 绿色版的配置，是否存储在INI文件里
if %settingsSaveInINI%==0 (goto tag_settingsSaveInINI_over)
:: INI配置
if %INIsettings%==0 (goto tag_INIsettings_checkupdate)
:: 自定义配置
copy .\Data\Config\Config_2.ini .\PotPlayer%platform%\
rename .\PotPlayer%platform%\Config_2.ini PotPlayerMini%platform%.ini
goto tag_INIsettings_over
:: 官方配置（关闭自动下载更新）
:tag_INIsettings_checkupdate
copy .\Data\Config\Config_1.ini .\PotPlayer%platform%\
rename .\PotPlayer%platform%\Config_1.ini PotPlayerMini%platform%.ini
:tag_INIsettings_over
:tag_settingsSaveInINI_over
:: 是否替换文件关联图标
if %replaceFileICON%==0 (goto tag_replaceFileICON)
del /f .\PotPlayer%platform%\PotIcons%platform%.dll
copy .\Data\PotIcons\PotIcons_1.dll .\PotPlayer%platform%\
rename .\PotPlayer%platform%\PotIcons_1.dll PotIcons%platform%.dll
:tag_replaceFileICON
:: 打包绿色版 PotPlayer
7z a PotPlayer%platform%.7z PotPlayer%platform%\
rename PotPlayer%platform%.7z PotPlayer%platform%_%version%_%ver%_with_%ModuleName%.7z
move PotPlayer%platform%_%version%_%ver%_with_%ModuleName%.7z PotPlayer_%version%_%ver%
rd /s /q PotPlayer%platform%
:: 是否保留 PotPlayer 官方 exe 安装包
if %keepEXE%==1 (goto tag_keep_exe)
del /f PotPlayerSetup%platform%.exe
goto tag_keep_exe_over
:tag_keep_exe
rename PotPlayerSetup%platform%.exe PotPlayerSetup%platform%_%version%_%ver%.exe
move PotPlayerSetup%platform%_%version%_%ver%.exe PotPlayer_%version%_%ver%
:tag_keep_exe_over


:end1
cls
title PotPlayer Portable OneKey Tool
echo ===============================================================================
echo PotPlayer 绿色版 制作完成
echo ===============================================================================
echo 得到的所有文件位于此文件夹里：
echo 【PotPlayer_%version%_%ver%】
echo ===============================================================================
echo 生成的绿色版压缩包文件名为：
echo 【PotPlayer%platform%_%version%_%ver%_with_%ModuleName%.7z】
echo ===============================================================================
goto end

:end
pause
