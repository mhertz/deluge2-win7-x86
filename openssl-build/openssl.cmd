cd "%~dp0"
cd ..
set OUT_DIR="%cd%\OpenSSL-Win32"
set NASM_PATH="%cd%\nasm"
set PERL_PATH="%cd%\perl\perl\bin"
set MSYSPATH="%cd%\msys64\usr\bin"
set PATH=%NASM_PATH%;%PERL_PATH%;%MSYSPATH%;%PATH%
rd /s /q OpenSSL-Win32
rd /s /q OpenSSL-Win32
for /f %%i in ('git ls-remote --tags https://github.com/openssl/openssl ^| grep -E 'OpenSSL_[0-9]_[0-9]_[0-9][a-z]' ^| cut -d/ -f3 ^| tr -d "^{}"') do set var=%%i
git clone https://github.com/openssl/openssl -b %var% openssl-build\openssl
for /f "delims=" %%i in ('"%programfiles(x86)%\Microsoft Visual Studio\Installer\vswhere.exe" -version [16.0^,17.0^) -prerelease -products * -requires Microsoft.Component.MSBuild Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath') do call "%%i\VC\Auxiliary\Build\vcvars32.bat"
cd openssl-build\openssl
perl configure VC-WIN32 --prefix=%OUT_DIR% --openssldir=%OUT_DIR% CFLAGS="/W3 /wd4090 /nologo /O2 /GL" LDFLAGS="/nologo /debug /LTCG"
nmake
nmake install
cd ..\..
rd /s /q openssl-build\openssl
rd /s /q openssl-buid\openssl
copy /y OpenSSL-Win32\bin\*.dll overlay\Lib\site-packages
for /f %%i in ('dir /b deluge-2* ^| findstr /v dev') do copy /y OpenSSL-Win32\bin\*.dll %%i\Lib\site-packages
for /f %%i in ('dir /b deluge-2* ^| findstr dev') do copy /y OpenSSL-Win32\bin\*.dll %%i\Lib\site-packages
