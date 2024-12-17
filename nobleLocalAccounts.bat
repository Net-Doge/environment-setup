@echo off
:: Batch script to create user accounts

:: Array of user details
setlocal EnableDelayedExpansion
set users[0]=Carter A259 P@ssw0rd!@ "Carter-A259" carter
set users[1]=Kat B320 P@ssw0rd!@ "Kat-B320" kat
set users[2]=Jun A266 P@ssw0rd!@ "Jun-A266" jun
set users[3]=Emile A239 P@ssw0rd!@ "Emile-A239" emile
set users[4]=Jorge 052 P@ssw0rd!@ "Jorge-052" jorge
set users[5]=Noble Six P@ssw0rd!@ "Noble-Six" six

for /L %%i in (0,1,5) do (
    set user_info=!users[%%i]!
    for /F "tokens=1-5 delims= " %%a in ("!user_info!") do (
        net user %%e %%c /add
        net user %%e /fullname:"%%d" /passwordreq:yes
        net localgroup Administrators %%e /add
        echo Created %%d account
        echo Added %%d to Administrators
    )
)

echo Noble Team has been Created
endlocal
pause
