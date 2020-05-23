@echo off
set COMPILEDIR=%CD%
set color=1e
color %color%

set XCOPY_EXCLUDE=/EXCLUDE:mod-exclude.txt

:START
cls
echo.
echo.

:MAKEOPTIONS
echo _________________________________________________________________
echo.
echo  Please select an option:
echo    1. Build everything (might take longer)
echo    2. Build stargate.iwd
echo    3. Build mod.ff
echo.
echo    0. Exit
echo.
set /p make_option=:
set make_option=%make_option:~0,1%
if "%make_option%"=="1" goto CHOOSE_LANG
if "%make_option%"=="2" goto MAKE_STARGATE_IWD
if "%make_option%"=="3" goto CHOOSE_LANG
if "%make_option%"=="0" goto FINAL
goto START


:CHOOSE_LANG
echo _________________________________________________________________
echo.
echo  Please choose the language you would like to compile:
echo    1. English
echo.
echo    0. Back
echo.
set /p lang_chosen=:
set lang_chosen=%lang_chosen:~0,1%
if "%lang_chosen%"=="1" goto LANGEN
if "%lang_chosen%"=="0" goto START
goto CHOOSE_LANG


:LANGEN
set CLANGUAGE=English
set LANG=english
set LTARGET=english
goto COMPILE

:COMPILE
echo.

echo  Checking language directories...
if not exist ..\..\zone\%LTARGET% mkdir ..\..\zone\%LTARGET%
if not exist ..\..\zone_source\%LTARGET% xcopy ..\..\zone_source\english ..\..\zone_source\%LTARGET% /SYI %XCOPY_EXCLUDE%

echo  Stargate Mod will be created in %CLANGUAGE%!
if "%make_option%"=="1" goto MAKE_STARGATE_IWD
if "%make_option%"=="2" goto MAKE_STARGATE_IWD
if "%make_option%"=="3" goto MAKE_MOD_FF
goto END


:MAKE_STARGATE_IWD
echo _________________________________________________________________
echo.
echo  Please choose what set of weapon files to use:
echo    1. Only fixes.
echo.
echo    0. Back
echo.
set /p zow_option=:
set zow_option=%zow_option:~0,1%
if "%zow_option%"=="1" goto WEAPONS_FIXES
if "%zow_option%"=="0" goto START
goto MAKE_STARGATE_IWD


:BUILD_STARGATE_IWD
echo _________________________________________________________________
echo.
echo  Building stargate.iwd:
echo    Deleting old stargate.iwd file...
del stargate.iwd
echo    Adding images...
7za a -mx9 -r -tzip stargate.iwd images\*.iwi
echo    Adding sounds...
7za a -mx9 -r -tzip stargate.iwd sound\*.mp3 sound\*.wav
echo    Adding weapons...
7za a -mx9 -r -tzip stargate.iwd weapons\mp\*_mp
echo    Adding empty mod.arena file...
7za a -mx9 -r -tzip stargate.iwd mod.arena
echo  New stargate.iwd file successfully built!
del /f /q weapons\mp\*
rmdir weapons\mp
if "%make_option%"=="1" goto MAKE_MOD_FF
goto END


:WEAPONS_FIXES
xcopy weapons\fixes weapons\mp /SYI %XCOPY_EXCLUDE%
goto BUILD_STARGATE_IWD

:MAKE_MOD_FF
echo _________________________________________________________________
echo.
echo  Building mod.ff:
echo    Deleting old mod.ff file...
del mod.ff

echo    Copying localized strings...
xcopy %LANG% ..\..\raw\%LTARGET% /SYI %XCOPY_EXCLUDE%

echo    Copying game resources...
xcopy images ..\..\raw\images /SYI %XCOPY_EXCLUDE%
xcopy fx ..\..\raw\fx /SYI %XCOPY_EXCLUDE%
xcopy maps ..\..\raw\maps /SYI %XCOPY_EXCLUDE%
xcopy materials ..\..\raw\materials /SYI %XCOPY_EXCLUDE%
xcopy material_properties ..\..\raw\material_properties /SYI %XCOPY_EXCLUDE%
xcopy mp ..\..\raw\mp /SYI %XCOPY_EXCLUDE%
xcopy sound ..\..\raw\sound /SYI %XCOPY_EXCLUDE%
xcopy soundaliases ..\..\raw\soundaliases /SYI %XCOPY_EXCLUDE%
xcopy ui_mp ..\..\raw\ui_mp /SYI %XCOPY_EXCLUDE%
xcopy weapons\fixes ..\..\raw\weapons\mp /SYI %XCOPY_EXCLUDE%
xcopy xmodel ..\..\raw\xmodel /SYI %XCOPY_EXCLUDE%
xcopy xmodelparts ..\..\raw\xmodelparts /SYI %XCOPY_EXCLUDE%
xcopy xmodelsurfs ..\..\raw\xmodelsurfs /SYI %XCOPY_EXCLUDE%

echo    Copying stargate source code...
copy /Y mod.csv ..\..\zone_source
copy /Y mod_ignore.csv ..\..\zone_source\%LTARGET%\assetlist
cd ..\..\bin


echo    Compiling mod...
linker_pc.exe -language %LTARGET% -compress -verbose -cleanup mod 
cd %COMPILEDIR%
copy ..\..\zone\%LTARGET%\mod.ff
echo  New mod.ff file successfully built!
goto END

:END
pause
goto FINAL

:FINAL