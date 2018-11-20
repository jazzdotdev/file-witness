-- read decrypted private key file
local f = io.open("private_key", "r")
local sign_priv = f:read()
local priv_key = crypto.sign.load_secret(sign_priv)

local bin_file_name = ""

if os.getenv("PROJECT") ~= nil then
	bin_file_name = os.getenv("PROJECT")
elseif torchbear.settings.sign ~= nil then 
	bin_file_name = torchbear.settings.sign
else
	bin_file_name = "torchbear" 
end

local bin_file_content = fs.read_file(bin_file_name)

-- generates signature
local signature = priv_key:sign_detached(bin_file_content)

local sig_file_name = bin_file_name .. os.getenv("TRAVIS_TAG") .."-".. os.getenv("ARCH")
.."-".. os.getenv("PLATFORM") .."-".. os.getenv("CHANNEL")..".sig"

local file = io.open(sig_file_name, "w")
file:write(signature, "\n")

os.exit()
