@echo -off
fs0:

UpdateVars.efi db db.auth
UpdateVars.efi KEK kek.auth
UpdateVars.efi PK pk.auth

pause
reset -w
