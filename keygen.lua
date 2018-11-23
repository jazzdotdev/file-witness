local sign_priv, sign_pub = crypto.sign.new_keypair()

local public_key_file = io.open("public_key", "w")
public_key_file:write(tostring(sign_pub), "\n")
public_key_file:close()

local private_key_file = io.open("private_key", "w")
private_key_file:write(tostring(sign_priv), "\n")
private_key_file:close()

print("Keys generated and saved as public_key and private_key files", "\n")

os.exit()
