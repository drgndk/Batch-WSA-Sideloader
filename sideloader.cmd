<!-- :: Batch Bootloader
@echo off

set DEFAULT_WSA_DEVICE_IP=127.0.0.1:58526
set WSA_DEVICE_IP=%DEFAULT_WSA_DEVICE_IP%
set "APPLICATION_NAME=WSA Sideloader"
set APPLICATION_VERSION=1.1
set "APK_PATH=%1"
title %APPLICATION_NAME% by G6D Version %APPLICATION_VERSION%
:CHECK
IF [%APK_PATH%] EQU [] goto NO_FILE
goto HAS_FILE
:NO_DEVICE
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: NO_DEVICE
echo Current Progress: Change Device IP
for /F "delims=" %%a in ('mshta.exe "%~F0"') do %%a 
goto CHECK
:NO_FILE
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: NO_FILE
echo Current Progress: Browse for File
for /F "delims=" %%a in ('mshta.exe "%~F0"') do %%a
:HAS_FILE
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: HAS_FILE
echo File Path: %APK_PATH%
echo Current Progress: Check Connection
echo.
goto CONNECT
:MULTIPLE_DEVICES
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: MULTIPLE_DEVICES
echo Current Progress: Clearing all devices
for /F "delims=device skip=1" %A in ('adb devices') do adb disconnect %~A
:CONNECT
for /F "delims=" %%a in ('adb connect %WSA_DEVICE_IP%') do echo.%%a | find /I "connected" && (goto CONNECTED) || (goto NOT_CONNECTED)
:NOT_CONNECTED
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: NOT_CONNECTED
echo Current Variable Value: %WSA_DEVICE_IP%
echo.
for /F "delims=" %%a in ('mshta.exe "%~F0"') do %%a
goto CONNECT
:CONNECTED
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: IS_CONNECTED
echo Connected Device: %WSA_DEVICE_IP%
echo Current Progress: Install File
echo.
for /F "delims=" %%a in ('adb install %APK_PATH%') do set "IS_INSTALLED=%%a"
adb disconnect %WSA_DEVICE_IP%
if "%IS_INSTALLED%" EQU "Success" goto INSTALLED
:INSTALLTION_FAILED
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: INSTALLTION_FAILED
echo.
echo Error while the installation of %APK_PATH%
echo Error: %IS_INSTALLED%
echo.
echo Press any key to exit...
pause >nul
goto EXIT_SCRIPT
:INSTALLED
cls
echo %APPLICATION_NAME%
echo by G6D
echo.
echo Debug Info:
echo Section: INSTALLED
echo.
echo Successfully insalled %APK_PATH%
echo.
echo Press any key to exit...
pause >nul
:EXIT_SCRIPT
for /F "delims=device skip=1" %A in ('adb devices') do adb disconnect %~A
exit
-->

<html>
    <HTA:APPLICATION ID="g6dwsasl" APPLICATIONNAME="WSA Sideloader by G6D"
    MAXIMIZEBUTTON="no" MINIMIZEBUTTON="no" SELECTION="no" ICON=""
    SCROLL="NO" BORDER="DIALOG">
    <head>
        <title>WSA Sideloader by G6D</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <script>
            window.resizeTo(360,260);
            function closeHTA(file,ip){
                if(file == null || ip == null) return false;
                var fso = new ActiveXObject("Scripting.FileSystemObject");
                    var file_cmd = 'set APK_PATH="'+file+'"';
                    var ip_cmd = 'set WSA_DEVICE_IP='+ip;
                fso.GetStandardStream(1).WriteLine(file_cmd);
                fso.GetStandardStream(1).WriteLine(ip_cmd);
                window.close();
            }
        </script>
        <style>
            * {
                font-family: 'Poppins', sans-serif;
                color: #ECF0F1;
            }

            html,body {
                background-color: #2c3e50;
                overflow: hidden;
                outline: none;
                border: 0px;
            }
            body {
                margin-top: 12px;
            }

            input {
                
                height: 24px;
                line-height: 24px;
                background-color: #34495E;
                margin-bottom: 6px;
                overflow: hidden;
                outline: none;
                border: 0px;
                width: 320px;
                
            }

            span,small {
                text-align: center;
                display: block;
                margin-bottom: 6px;
            }

            small {
                font-size: 12px;
                margin-bottom: 3px;
            }
            .submit {
                cursor: pointer;
                height: 48px;
                line-height: 48px;
                font-size: 24px;
                font-weight: 500;
            }
            .ip {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <span>WSA Device IP</span>
        <small>Default: 127.0.0.1:58526</small>
        <input id="ip" class="ip" placeholder="127.0.0.1:58526" value="127.0.0.1:58526">
        <br>
        <span>Browse for the APK File you want to install</span>
        <input id="file" type="file" placeholder="APK File" value="">
        <br>
        <input class="submit" type="submit" value="Install" onclick="closeHTA(document.getElementById('file').value,document.getElementById('ip').value);">
    </body>
</html>