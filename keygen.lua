local sign_priv, sign_pub = crypto.sign.new_keypair()

local f = io.open("public_key", "w")
f:write(tostring(sign_pub), "\n")

f = io.open("private_key", "w")
f:write(tostring(sign_priv), "\n")

print("Keys generated and saved as public_key and private_key files", "\n")

os.exit()
