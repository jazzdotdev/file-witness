-- File Witness · Code Signing Torchbear App

if (torchbear.settings.verify == "true") then
	dofile("verify.lua")
else
	dofile("sign.lua")
end
