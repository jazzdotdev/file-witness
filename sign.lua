-- load private key
local priv_key_file = io.open("private_key", "r")
local priv_key_string = priv_key_file:read()
local base64_priv_key = crypto.sign.load_secret(priv_key_string)
priv_key_file:close()


local bin_file_name = ""

-- Checks if the name of file to be signed is provided as environment variable
if os.getenv("PROJECT") ~= nil then
	bin_file_name = os.getenv("PROJECT")
else
	bin_file_name = torchbear.settings.sign 
end

local bin_file_content = fs.read_file(bin_file_name)

-- generates signature
local signature = base64_priv_key:sign_detached(bin_file_content)

-- Name of the generated signature file
local sig_file_name = ""

-- check if the file is running on travis or local machine
if os.getenv("TRAVIS_TAG") ~= nil then
	sig_file_name = bin_file_name .. "-" .. os.getenv("TRAVIS_TAG") .."-".. os.getenv("ARCH")
		.."-".. os.getenv("PLATFORM") .."-".. os.getenv("CHANNEL")..".sig"
else
	sig_file_name = bin_file_name .. "-local.sig"
end

local sig_file = io.open(sig_file_name, "w")
sig_file:write(signature, "\n")
sig_file:close()

print("Signature file: " .. sig_file_name .. " created", "\n")

os.exit()
