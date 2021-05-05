@echo off
net session >nul 2>&1
if %errorLevel% == 0 (
	GOTO anfang
) else (
        echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
        echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
        "%temp%\getadmin.vbs"
        exit /B
	pause
)
:anfang
curl --insecure "https://www.deskmodder.de/.moinmoin/Blank.ico.zip" --output "C:\Users\%username%\Desktop\blank.ico.zip"
cls
:anfang0
if exist C:\Users\%username%\Desktop\Blank.ico.zip (
	Call :UnZipFile "C:\Users\%username%\Desktop\" "C:\Users\%username%\Desktop\Blank.ico.zip"
	if exist C:\Users\%username%\Desktop\blank.ico (
		if exist C:\Users\%username%\Desktop\Blank.ico (
			copy /Y C:\Users\%username%\Desktop\blank.ico %windir%
			del /Q C:\Users\%username%\Desktop\blank.ico
			cls
			rd C:\Users\%username%\Desktop\blank.ico
			if exist C:\Users\%username%\Desktop\Blank.ico.zip (
				del /Q C:\Users\%username%\Desktop\Blank.ico.zip
				del /Q C:\Users\%username%\Desktop\readme.txt
				cls
				GOTO next0
			)
			GOTO next0
		) else (
			echo blank.ico fehlt im ordner.
			GOTO okeynochmal
		)
	) else (
		echo Die Zip wurde nicht Entpackt bitte versuche es Manuell.
		pause
		GOTO anfang0
	)
) else (
	echo Warum löschst du die Zip, du Vogel.
	pause
	GOTO anfang
)
echo Irgendwas ist falsch gelaufen.
pause
:next0
REG ADD "Computer\HKEY_CURRENT_USER\Control Panel\Desktop" /v JPEGImportQuality /t REG_DWORD /d 64 /f
REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Icons" /V "29" /D "%windir%\Blank.ico,0" /F
REG COPY "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\-{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /s /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
REG COPY "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\-{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /s /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{0DB7E03F-FC29-4DC6-9020-FF41B59E513A}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{0ddd015d-b06c-45d5-8c4c-f59713854639}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{35286a68-3c57-41a1-bbb1-0eae73d76c95}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{a0c69a99-21c8-4671-8703-7934162fcf1d}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{7d83ee9b-2244-4e70-b1f5-5393042af1e4}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FolderDescriptions\{f42ee2d3-909f-4907-8871-4c22fc0bf756}\PropertyBag" /v ThisPCPolicy /t REG_SZ /d Hide /f
taskkill /f /im explorer.exe
start explorer.exe
cls
echo RegEdit by Trackhe.de Finish hf.
pause
exit
:okeynochmal
if exist C:\Users\%username%\Desktop\blank.ico.zip (
    echo Wenn der Fehler wiederholt auftritt bitte eine email an service@trackhe.de senden. (Stellen sie sicher das "Blank.ico" im extrahierten Ordner existiert.)
    pause
	GOTO anfang
) else (
	echo Die blank.ico.zip existiert nicht. Bei wiederhollung des Fehlers bitte eine email an service@trackhe.de senden.
	pause
	GOTO anfang
)
:UnZipFile <ExtractTo> <newzipfile>
set vbs="%temp%\_.vbs"
if exist %vbs% del /f /q %vbs%
>%vbs%  echo Set fso = CreateObject("Scripting.FileSystemObject")
>>%vbs% echo If NOT fso.FolderExists(%1) Then
>>%vbs% echo fso.CreateFolder(%1)
>>%vbs% echo End If
>>%vbs% echo set objShell = CreateObject("Shell.Application")
>>%vbs% echo set FilesInZip=objShell.NameSpace(%2).items
>>%vbs% echo objShell.NameSpace(%1).CopyHere(FilesInZip)
>>%vbs% echo Set fso = Nothing
>>%vbs% echo Set objShell = Nothing
cscript //nologo %vbs%
if exist %vbs% del /f /q %vbs%