@echo off

git stash
git pull origin master
c:
cd\
ipconfig /all >ip.txt
for /f "tokens=2 delims=:(��ѡ)" %%b in ('findstr /c:"IPv4 ��ַ" "ip.txt"') do (httpcfg set iplisten -i %%b
del ip.txt
"C:\Program Files\Google\Chrome\Application\chrome.exe" %%b:88))
