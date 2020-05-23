del z_stargate.iwd
del mod.ff

xcopy ui_mp ..\..\raw\ui_mp /SY

xcopy fx ..\..\raw\fx\ /SY
xcopy maps ..\..\raw\maps\ /SY
xcopy weapons ..\..\raw\weapons\ /SY
xcopy soundaliases ..\..\raw\soundaliases /SY
xcopy rocketarena ..\..\raw\rocketarena /SY
xcopy sound ..\..\raw\sound /SY
xcopy english ..\..\raw\english /SY
xcopy mp ..\..\raw\mp /SY
xcopy script ..\..\raw\script /SY
xcopy materials ..\..\raw\materials /SY
xcopy material_properties ..\..\raw\material_properties /SY
xcopy vision ..\..\raw\vision /SY

copy /Y mod.csv ..\..\zone_source
cd ..\..\bin
linker_pc.exe -language english -compress -cleanup mod
cd ..\mods\stargate
copy ..\..\zone\english\mod.ff

7za a -r -tzip z_stargate.iwd weapons
7za a -r -tzip z_stargate.iwd sound

pause