@echo off
REM hg2git https://hg01.codeplex.com/facebooksdk facebooksdk

SET CLONE_URL=%1
SET DESTINATION_PATH=%2

@echo.
@echo hg clone %CLONE_URL% %DESTINATION_PATH%.hggit
hg clone %CLONE_URL% %DESTINATION_PATH%.hggit
cd %DESTINATION_PATH%.hggit

@echo.
@echo hg bookmark -r default master
hg bookmark -r default master

@echo.
@echo [git] >> .hg/hgrc
echo [git] >> .hg/hgrc
@echo intree = true >> .hg/hgrc
echo intree = true >> .hg/hgrc

@echo.
@echo hg gexport
hg gexport

cd ..

@echo.
@echo git clone %DESTINATION_PATH%.hggit %DESTINATION_PATH%
git clone %DESTINATION_PATH%.hggit %DESTINATION_PATH%

@echo.
@echo make sure you have "git/*" in .hgignore