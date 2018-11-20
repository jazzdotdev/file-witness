-- load public key
local f = io.open("public_key", "r")
local pub_key_string = f:read()
local pub_key = crypto.sign.load_public(tostring(pub_key_string))


local sig_file_name = ""
local pfile = io.popen('ls "'.. "." ..'"')

-- looks for the file with ".sig" extension
for file in pfile:lines() do
     if file:match "%.sig$" then
	     sig_file_name = tostring(file)
     end
end

-- load signature from signature file 
f = io.open(sig_file_name, "r")
local signature = tostring(f:read())

local bin_file_name = torchbear.settings.sign
if bin_file_name == nil or bin_file_name == "" then
	bin_file_name = "torchbear"
end

-- loads binary file
local bin_file_content = fs.read_file(bin_file_name)
local is_valid = pub_key:verify_detached(bin_file_content, signature)

if is_valid then
	print("VERIFIED! The signature file is valid\n")
else
	print("The signature file is invalid\n")
end

os.exit()
