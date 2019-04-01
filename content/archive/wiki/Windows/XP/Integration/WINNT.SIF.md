+++
title = "[PukiWiki:wiki] Windows/XP/Integration/WINNT.SIF"
date = "2008-12-10T09:33:23Z"
+++

# WINNT.SIF  {#y98804b9}
プロダクトキーなどの入力を自動化する。


## View  {#k571b9bf}

```
[Data]
    AutoPartition=0
    MsDosInitiated="0"
    UnattendedInstall="Yes"

[Unattended]
    UnattendMode=FullUnattended
    OemSkipEula=Yes
    OemPreinstall=Yes
    TargetPath=\WINDOWS
    Repartition=No
    UnattendSwitch="yes"
;    ProgramFilesDir = "C:\Programs"
;    CommonProgramFilesDir = "C:\Programs\Common"

[GuiUnattended]
    AdminPassword=*
    EncryptedAdminPassword=NO
    AutoLogon=Yes
    AutoLogonCount=1
    OEMSkipRegional=1
    TimeZone=235
    OemSkipWelcome=1
;    ProfilesDir ="C:\Profiles"

[UserData]
    ProductKey=*****-*****-*****-*****-*****
    FullName="*****"
    OrgName=""
    ComputerName=*****

[Display]
    BitsPerPel=32
    Xresolution=1024
    YResolution=768
    Vrefresh=60

[TapiLocation]
    CountryCode=81

[RegionalSettings]
    LanguageGroup=7
    Language=00000411

[Identification]
    JoinWorkgroup=WORKGROUP

[Networking]
    InstallDefaultComponents=Yes

[Branding]
    BrandIEUsingUnattended=Yes

[URL]
    Home_Page=http://www.google.co.jp/

[IEPopupBlocker]
    BlockPopups=Yes
    FilterLevel=High
    ShowInformationBar=No

[WindowsFirewall]
    Profiles = WindowsFirewall.TurnOffFirewall

[WindowsFirewall.TurnOffFirewall]
    Mode = 0

[Components]
    msmsgs=off
    msnexplr=off 
    freecell=off
    hearts=off
    minesweeper=off
    pinball=off
    solitaire=off
    spider=off
    zonegames=off

[Shell]
;    DefaultStartPanelOff = Yes
    DefaultThemesOff = Yes

[SystemFileProtection]
    SFCShowProgress=0
    SFCQuota=0x000000000
```

