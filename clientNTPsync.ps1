$NTPHost = Read-Host "Enter NTP server: "
w32tm /config /manualpeerlist:"$NTPHost,0x8" /syncfromflags:manual /update
net stop w32time
net start w32time
w32tm /resync /force
w32tm /query /status
