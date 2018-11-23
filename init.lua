-- File Witness · Code Signing Torchbear App

if (torchbear.settings.verify == "true") then
	dofile("verify.lua")
elseif io.open("private_key", "r") ~= nil or torchbear.settings.sign == nil then
	dofile("sign.lua")
else
	dofile("keygen.lua")
end
