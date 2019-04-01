+++
title = "[PukiWiki:wiki] Windows/XP/Integration/HFSLIP/Folder/XX_Services.inf"
date = "2008-12-10T09:33:23Z"
+++


```

[Version]
Signature=$Windows NT$

[Optional Components]
MyThemesRegTweaks

[DefaultInstall]
OptionDesc ="Registry Entries"
Tip        ="Registry Entries"
Modes      =0,1,2,3
AddReg     =REGEntries.AddReg
DelReg     =REGEntries.DelReg

[MyRegTweaks]
OptionDesc ="Registry Entries"
Tip        ="Registry Entries"
Modes      =0,1,2,3
AddReg     =REGEntries.AddReg
DelReg     =REGEntries.DelReg

[REGEntries.AddReg]
; Application Layer Gateway Service サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\ALG","Start",0x00010001,0x00000004
; Computer Browser サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\Browser","Start",0x00010001,0x00000004
; Distributed Link Tracking Client サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\TrkWks","Start",0x00010001,0x00000004
; Error Reporting サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\ersvc","Start",0x00010001,0x00000004
; Fast User Switching Compatibility サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\FastUserSwitchingCompatibility","Start",0x00010001,0x00000004
; Help and Support サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\helpsvc","Start",0x00010001,0x00000004
; Indexing Service サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\Indexing Service","Start",0x00010001,0x00000004
; Remote Registry サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\RemoteRegistry","Start",0x00010001,0x00000004
; Secondary Logon サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\seclogon","Start",0x00010001,0x00000004
; Security Center サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\wscsvc","Start",0x00010001,0x00000004
; Server サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\LanmanServer","Start",0x00010001,0x00000004
; SSDP Discovery Service サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\SSDPSRV","Start",0x00010001,0x00000004
; System Restore Service サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\sr","Start",0x00010001,0x00000004
HKLM,"SYSTEM\CurrentControlSet\Services\srservice","Start",0x00010001,0x00000004
; TCP/IP NetBIOS Helper サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\LmHosts","Start",0x00010001,0x00000004
; Telephony サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\TapiSrv","Start",0x00010001,0x00000004
; Terminal Services サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\TermService","Start",0x00010001,0x00000004
; Uninterruptible Power Supply サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\UPS","Start",0x00010001,0x00000004
; Universal Plug and Play Device Host サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\upnphost","Start",0x00010001,0x00000004
; Print Spooler サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\Spooler","Start",0x00010001,0x00000004
; WebClient サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\WebClient","Start",0x00010001,0x00000004
; Windows Image Acquisition(WIA) サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\stisvc","Start",0x00010001,0x00000004
; Windows Firewall/Internet Connection Sharing (ICS) サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\SharedAccess","Start",0x00010001,0x00000004
; Windows Media Player Network Sharing Service サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\WMPNetworkSvc","Start",0x00010001,0x00000004
; Windows Time サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\W32Time","Start",0x00010001,0x00000004
; Wireless Zero Configuration サービスを無効に
HKLM,"SYSTEM\CurrentControlSet\Services\WZCSVC","Start",0x00010001,0x00000004
```

