cd "%~dp0"
cd ..
set PATH=%cd%\msys32\usr\bin;%PATH%
for /f %%i in ('git ls-remote --tags https://github.com/openssl/openssl ^| grep -E 'OpenSSL_[0-9]_[0-9]_[0-9][a-z]' ^| cut -d/ -f3 ^| tr -d "^{}" ^| cut -d_ -f2-4') do set var=%%i
curl -O https://slproweb.com/download/Win32OpenSSL-%var%.exe
openssl-build\innounp.exe -x Win32OpenSSL-%var%.exe
rd /s /q OpenSSL-Win32
rd /s /q OpenSSL-Win32 2>nul
move {app} OpenSSL-Win32
rd /s /q {cf}
rd /s /q {cf} 2>nul
del install_script.iss
copy /y OpenSSL-Win32\*.dll overlay\Lib\site-packages
for /f %%i in ('dir /b deluge-2* ^| findstr /v dev') do copy /y OpenSSL-Win32\*.dll %%i\Lib\site-packages
for /f %%i in ('dir /b deluge-2* ^| findstr dev') do copy /y OpenSSL-Win32\*.dll %%i\Lib\site-packages
del Win32OpenSSL-%var%.exe
