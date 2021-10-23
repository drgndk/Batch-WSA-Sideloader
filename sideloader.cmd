<!-- :: Batch Bootloader

@echo off
:S
set DEFAULT_WSA_DEVICE_IP=127.0.0.1:58526
set "APK_PATH=%1"
cls
echo WSA Sideloader
echo by G6D
echo.
IF [%APK_PATH%] EQU [] goto NO_FILE

:HAS_FILE
adb connect %DEFAULT_WSA_DEVICE_IP%
adb install %APK_PATH%
echo.
echo Press any Key to exit
pause>nul
adb disconnect %WSA_DEVICE_IP%
exit

:NO_FILE
for /F "delims=" %%a in ('mshta.exe "%~F0"') do set "APK_PATH=%%a"
goto HAS_FILE
-->

<html>
    <HTA:APPLICATION ID="g6dwsasl" APPLICATIONNAME="WSA Sideloader by G6D"
    MAXIMIZEBUTTON="no" MINIMIZEBUTTON="no" SELECTION="no" ICON=""
    SCROLL="NO" BORDER="DIALOG">
    <head>
        <title>WSA Sideloader by G6D</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fork-awesome@1.2.0/css/fork-awesome.min.css" crossorigin="anonymous">
        <script>
            window.resizeTo(360,172);

            function closeHTA(file,ip){
            if(file == null) return false;
            var fso = new ActiveXObject("Scripting.FileSystemObject");
            fso.GetStandardStream(1).WriteLine('"'+file.value+'"');
            window.close();
            }
        </script>
        <meta name=" theme-color" content="#2c3e50">
        <style>
            * {
                font-family: Arial;
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

            span {
                text-align: center;
                display: block;
                margin-bottom: 6px;
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
        <span>Browse for the APK File you want to install</span>
        <input id="file" type="file" placeholder="APK File">
        <br>
        <input class="submit" type="submit" value="Install" onclick="closeHTA(document.getElementById('file'));">
    </body>
</html>
