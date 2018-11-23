-- load public key
local public_key_file = io.open("public_key", "r")
local pub_key_string = public_key_file:read()
local pub_key = crypto.sign.load_public(tostring(pub_key_string))
public_key_file:close()


local sig_file_name = ""
local files_list = io.popen('ls "'.. "." ..'"')

-- looks for the file with ".sig" extension
for file in files_list:lines() do
     if file:match "%.sig$" then
	     sig_file_name = tostring(file)
     end
end

-- load signature from signature file 
local sig_file = io.open(sig_file_name, "r")
local signature = tostring(sig_file:read())
sig_file:close()

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
