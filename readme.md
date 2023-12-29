# 本人已换用 [mpv](https://mpv.io/)  [MPV_lazy](https://github.com/hooke007/MPV_lazy) , 停止维护，其实本工具就是简单的批处理，没什么技术含量，自行去网上学习一下批处理，自行修改即可。
# PotPlayer 绿色版一键下载、制作、更新工具
# 请在 [Release](https://github.com/neatgz/PotPlayer_OneKey_Tool/releases) 页面下载最新版
## 主要功能
* 下载最新 PotPlayer （可选x86 x64）
* 下载过程中可选是否使用代理
* 可选 Public 或 Dev 版（仅限x86，因官方只提供x86的Dev）
* 下载最新附加的编解码器 （可选x86 x64）
* 生成绿色版 PotPlayer 压缩包（可选x86 x64，包含附加的编解码器）
* 可选是否附加 WinXP 支持 （仅限x86）
* 可选附加的编解码器的种类 （FFmpegMininum ；完整的 OpenCodec；LAVFilters+madVR+XySubFilter）
* 可选是否附加精选的皮肤文件
* 可选是否美化文件关联图标
* 可选是否附加电视直播源
* 可选是否附加 update tool （仅限x64，用于后续一键更新当前正在使用的PotPlayer至最新稳定版）
* 可选是否自动检查更新
* 可选是否保留官方exe安装包以作备用

## 支持自定义
* 拷贝喜欢的皮肤文件到 Data\Skins 文件夹下，可以在制作绿色版时自动集成
* 拷贝喜欢的电视直播源到 Data\Playlist 文件夹下，可以在制作绿色版时自动集成
* 拷贝喜欢的关联图标dll文件替换 Data\PotIcons\PotIcons_1.dll ，可以在制作绿色版时自动集成
* 如需自定义设置，可参考 Data\Config 文件夹下的 sample.ini 文件，修改另外两个 ini 文件，可以在制作绿色版时自动集成

## 使用方法
* GitHub [release](https://github.com/neatgz/PotPlayer_OneKey_Tool/releases) 页面下载
* 解压，双击 OneKey_Tool.bat 即可

## to do list
+ 关于附加 LAVFilters madVR XySubFilter
    - ~~madVR 的下载地址，速度极慢，需要代理，可以手动填写代理或设置全局代理，待完善~~ 可以设定本地代理了
    - ~~因批处理的局限，貌似无法自动检查并获取最新的 LAVFilters 和 XySubFilter 的下载地址，有知道的朋友请告知~~ 批处理的局限，无法自动解析GitHub的api获取最新版本号，改为内置版本号，如果有新版本，可以通过手动输入版本号的方式下载最新版
    - 即使附加了 LAVFilters madVR XySubFilter，启用和配置仍需打开PotPlayer手动配置，有知道的朋友请告知

+ 关于集成 update tool，目前只支持 x64 with all OpenCodec，其他版本待添加
    - 集成的 update tool 以后会加入检测功能，没有新版本，不执行解压和覆盖操作

## 其他说明
* 批处理写的很简陋，纯自用。没啥技术含量，随便拿去改拿去用。
* 所有涉及的工具和软件(Potplayer、wget、7zip)的版权归原作者所有。
* v3.0.0 版本，未经全面测试，如有问题请反馈。
* 如有问题，随时欢迎提交 issue
