@echo off
echo Lancement de tous les tests...

call lancer_tests_unitaires.bat
if errorlevel 1 exit /b 1

call lancer_tests_api.bat
if errorlevel 1 exit /b 1

call lancer_tests_ihm.bat
if errorlevel 1 exit /b 1

echo Tous les tests se sont exécutés correctement.
pause