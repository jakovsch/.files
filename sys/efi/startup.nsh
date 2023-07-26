@echo -off
fs0:

UpdateVars.efi DB db.auth
UpdateVars.efi KEK kek.auth
UpdateVars.efi PK pk.auth

reset -w
