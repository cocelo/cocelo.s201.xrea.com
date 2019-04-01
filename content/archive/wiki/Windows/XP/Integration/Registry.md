+++
title = "[PukiWiki:wiki] Windows/XP/Integration/Registry"
date = "2008-12-10T09:33:23Z"
+++

# Registry  {#b1a56887}
Windows XP のレジストリを編集する。


## View  {#scdbb99b}

```
Windows Registry Editor Version 5.00

[HKEY_LOCAL_MACHINE\Software\Microsoft\Dfrg\BootOptimizeFunction]
"Enable"="Y"

[HKEY_LOCAL_MACHINE\Software\Microsoft\OutlookExpless]
"Hide Messenger"=dword:00000002

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Explorer]
"AlwaysUnloadDLL"=dword:00000001
"Max Cached Icons"="4096"

[HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Applets\Tour]
"RunCount"=dword:00000000

[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon]
"SFCDisable"=dword:00000001
"SFCScan"=dword:00000000
"SFCQuota"=dword:00000000
"SFCShowProgress"=dword:00000000

[HKEY_LOCAL_MACHINE\Software\Policies\Microsoft\Windows NT\SystemRestore]
"DisableSR"=dword:00000001
"DisableConfig"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\CrashControl]
"AutoReboot"=dword:00000001

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\FileSystem]
"ContigFileAllocSize"=dword:00001000

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management]
"ClearPageFileAtShutdown"=dword:00000001
"DisablePagingExecutive"=dword:00000001
"SecondLevelDataCache"=dword:00000400

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters]
"MaxCacheEntryTtlLimit"=dword:00093a80

[HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\lanmanserver\parameters]
"AutoShareWks"=dword:00000001

[HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip]
"SynAttackProtect"=dword:00000002
```

