cd "%~dp0"
set PATH=%~dp0msys32\usr\bin;%PATH%
powershell -executionpolicy remotesigned -Command "Invoke-WebRequest https://github.com/msys2/msys2-installer/releases/download/2020-05-17/msys2-base-i686-20200517.tar.xz -OutFile msys2-base-i686-20200517.tar.xz"
powershell -executionpolicy remotesigned -Command "Invoke-WebRequest https://github.com/uuksu/7z.NET/raw/master/7z.NET/7za.exe -OutFile 7za.exe"
7za x msys2-base-i686-20200517.tar.xz
7za x msys2-base-i686-20200517.tar
sed -i 's/Required DatabaseOptional/Never/' msys32/etc/pacman.conf
bash -lic "pacman -Syu --noconfirm"
taskkill /im dirmngr.exe 2>nul
taskkill /im gpg-agent.exe 2>nul
bash -lic "pacman -Syu --noconfirm"
bash -lic "pacman -S diffutils patch git --noconfirm"
cmd /c openssl-build\openssl.cmd
for /f %%i in ('curl https://nsis.sourceforge.io/Download ^| grep Notes ^| grep -o v.* ^| tr -d v ^| cut -d'^"' -f1') do set var=%%i
mkdir nsis & curl -L "https://sourceforge.net/projects/nsis/files/NSIS %var:~0,1%/%var%/nsis-%var%.zip/download" | bsdtar xf - --strip-components 1 -C nsis
curl.exe -kO https://nsis.sourceforge.io/mediawiki/images/1/18/NsProcess.zip
mkdir nsprocess & bsdtar xf NsProcess.zip -C nsprocess
move nsprocess\Plugin\nsProcessW.dll nsis\Plugins\x86-unicode\nsProcess.dll
move nsprocess\Include\nsProcess.nsh nsis\Include
curl.exe -k https://git.landicorp.com/electron-downloadtool/electron-downloadtool/-/raw/5da62a7d62329bd9afe7a1bfda3f759d6bc04c80/node_modules/electron-builder/templates/nsis/include/StrContains.nsh > nsis\Include\strContains.nsh
curl.exe -kO https://download.visualstudio.microsoft.com/download/pr/68d6b204-9df0-4fcc-abcc-08ee0eff9cb2/0b833c703ae7532e54db2d1926e2c3d2e29a7c053358f8c635498ab25bb8c590/vs_BuildTools.exe
vs_buildtools.exe --quiet --add Microsoft.VisualStudio.Workload.VCTools --includeRecommended --installPath "%~dp0msvc" --wait
del msys2-base-i686-20200517.tar* 7za.exe NsProcess.zip vs_BuildTools.exe
rd /s /q nsprocess
rd /s /q nsprocess 2>nul
