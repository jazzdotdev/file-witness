if (torchbear.settings.verify == "true") then
	dofile("verify.lua")
else
	dofile("sign.lua")
end


