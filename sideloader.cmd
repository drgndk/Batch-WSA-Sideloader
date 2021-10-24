<!-- :: Batch section
@echo off
set "APPLICATION_NAME=WSA Sideloader"
set APPLICATION_VERSION=1.1.2
title %APPLICATION_NAME% by G6D Version %APPLICATION_VERSION%

IF NOT [%1] EQU [] goto QUICKINSTALL
mshta.exe "%~F0"
exit
:QUICKINSTALL
adb connect 127.0.0.1:58526
cls
echo Fast Installer
echo.
adb install %1
adb disconnect 127.0.0.1:58526
exit
-->

<html>
    <head>
        <meta http-equiv="x-ua-compatible" content="ie=9">
        <title>WSA Sideloader by G6D</title>
        <HTA:APPLICATION ID="g6dwsasl" APPLICATIONNAME="WSA Sideloader by G6D"
        MAXIMIZEBUTTON="no" MINIMIZEBUTTON="no" SELECTION="no" ICON="https://gitsisdope.github.io/resources/icons/logo-96.ico"
        SCROLL="NO" BORDER="DIALOG" navigable="yes"/>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <script>
            window.resizeTo(360,282);
        </script>
        <style>
            * {
                user-select:none;
                font-family: 'Poppins', sans-serif;
                color: #C8CCE5;
                margin: 0;
                padding: 0;
                outline: none;
                border: 0px;
            }

            html,body {
                background: rgb(41,48,86);
                background: linear-gradient(90deg, rgba(41,48,86,1) 0%, rgba(54,63,114,1) 100%);

                width: 100%;
                height: 100%;
            }

            body {
                position: absolute;
                top: 0px;
            }

            section {
                
                width: calc(100% - 24px);
                position: relative;
                top: 0px;
                left: 12px;

                border-radius: 10px;
                margin-top: 12px;
            }

            section label {
                margin-left: 18px;
            }

            label .material-icons {
                font-size: 16px;
                position: relative;
                top: 2px;
                left: -6px;
                color: #ECF0F1;
            }

            section small {
                display: block;
                font-size: 11px;
                margin-left: 12px;
                margin-top: 2px;
                width: 85%;
                
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
            }

            input {
                width: calc(100% - 36px);
                height: 32px;
                line-height: 32px;
                padding-left: 12px;
                position: relative;
                left: 12px;
                background: #363F72;
                border-radius: 5px;
                border: 0px solid;
                box-shadow: 0 1.5px 35px -10px #101323;
            }

            input[error="True"] {
                width: calc(100% - 38px);
                height: 30px;
                line-height: 30px;
                border: 1px solid #F04438;
            }

            .ip::-ms-clear {
                display: none;
            }

            .install-btn {
                border-radius: 5px;
                box-shadow: 0 1.5px 35px -10px #101323;
                width: calc(100% - 48px);
                height: 48px;
                line-height: 48px;
                font-size: 24px;
                position: absolute;
                white-space: nowrap;
                overflow: hidden;
                text-overflow: ellipsis;
                padding: 0 12px;
                bottom: 12px;
                left: 12px;
                cursor: pointer;
                background: #2ECC71;
                background: linear-gradient(90deg, #2ECC71 0%, #27AE60 100%);
                opacity: .95;
                color: #ECF0F1;
                text-align: center;
            }
            .install-btn.select {
                background: #FEC84B;
                color: #7A2E0E;
            }
            .install-btn .material-icons {
                position: relative;
                top: 4px;
                left: -2px;
                color: #ECF0F1;
            }
            .install-btn:hover {
                opacity: 1;
            }

            .file-input {
                width: calc(100% - 36px);
                height: 32px;
                line-height: 32px;
                padding-left: 12px;
                position: relative;
                margin: 0;
                left: 12px;
                background: #363F72;
                border-radius: 5px;
                border: 0px solid;
                box-shadow: 0 1.5px 35px -10px #101323;
                display: inline-block;
                text-align: center;
                cursor: pointer;
                position: relative;
            }

            .file-input input[type="file"] {
                display: none;
                height: 0px;
                width: 0px;
                position: absolute;
                top: -1000px;
            }
            .file-input:hover {
                background: #4E5BA6;
            }
        </style>
    </head>
    <body>
        <section name="IP">
            <label><span class="material-icons">&#xE325;</span>WSA Device IP</label>
            <input id="ip" class="ip" error="false" placeholder="127.0.0.1:58526" value="127.0.0.1:58526">
            <small id="default">Default: 127.0.0.1:58526</small>
        </section>
        <section name="APK_FILE">
            <label><span class="material-icons">&#xE226;</span>Your APK File</label>
            <label id="search-file" class="file-input">
                <input id="file" type="file" required/>
                <span id="select">Select a file</span>
            </label>
            <small id="selected_file">No File Selected</small>
        </section>
        <div id="install" class="install-btn select" onclick="document.getElementById('search-file').click();">
            <span class="material-icons">&#xE2C7;</span> Choose File
        </div>
        <script>
            var fileInput = document.getElementById('file');
            var ipInput = document.getElementById('ip');
            var PGRbar = document.getElementById('progress_bar');

            function runCommand(command) {
                
                alert(command);
                var wshShell = new ActiveXObject("WScript.Shell");
                var execOut = wshShell.Exec(command);
                var cmdStdOut = execOut.StdOut;
                return cmdStdOut.ReadLine();
            }

            function install(file) {
                var ip = ipInput.value;
                var output = runCommand("adb connect "+ip);

                if(output.split("").slice(0,9).join("") == "connected" || output.split("").slice(0,17).join("") == "already connected") {
                    runCommand('adb install "'+file+'"');
                    output = runCommand("adb disconnect "+ip);
                }else {
                    ipInput.setAttribute("error","True");
                }
            }

            ipInput.oninput = function () {
                if(ipInput.getAttribute("error")=="True") {
                    ipInput.setAttribute("error","false");
                }
            }

            fileInput.onchange = function() {
                document.getElementById('selected_file').innerText = fileInput.value;
                document.getElementById('select').innerText = "File Selected"
                document.getElementById('install').innerHTML = '<span class="material-icons">&#xEB71;</span>'+" Install";
                document.getElementById('install').setAttribute("class","install-btn");
                document.getElementById('install').setAttribute("onclick","install(fileInput.value)");
            }
        </script>
    </body>
</html>
