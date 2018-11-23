-- File Witness · Code Signing Torchbear App

if (torchbear.settings.option == "1") then
	dofile("sign.lua")
elseif torchbear.settings.option == "2" then
	dofile("verify.lua")
else
	dofile("keygen.lua")
end
