REM Juni 2021: hier muss dann scheinbar im credentials manager github pw eingegeben werden
"C:\Users\felix.dietrich\Documents\R\R-3.6.3\bin\Rscript.exe" "C:\Users\felix.dietrich\Documents\GitHub\website\drdie_NAV.R"
@echo on
cd C:\Users\felix.dietrich\Documents\GitHub\website
git add *
git commit -m "scheduled commit"
git push
@pause