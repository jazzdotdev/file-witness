<p align="center"><img width="100" src="https://i.imgur.com/gtf4kBl.png" alt="file-witness logo"></p>


## Generate detached signature

### Generating private key

To generate a shared key-pair we have to call `torchbear`'s `crypto.sign.new_keypair()` function. To do so, create a file named `init.lua` and add this:

```[lua]
local sign_priv, sign_pub = crypto.sign.new_keypair()
local file = io.open("private_key", "w")
local file2 = io.open("public_key", "w")
file:write(tostring(sign_priv), "\n")
file2:write(tostring(sign_pub), "\n")
```

## Creating the signature file from binary file

To create a signature file, we have to first set some environment variables, here's the list:
```
PROJECT     = name of project
TRAVIS_TAG  = release tag
ARCH        = architecture
PLATFORM    = x86/arm/...
CHANNEL     = stable/beta
```

After setting them, we will have to run `torchbear` binary in the directory where we have `private_key` and [init.lua](https://github.com/foundpatterns/file-witness/blob/master/init.lua).

This should create the `.sig` file with following name format: `${PROJECT}-${TRAVIS_TAG}-${ARCH}-${PLATFORM}-${CHANNEL}.sig`

## Credits

Icon made by [Freepik](https://www.freepik.com/) and published by [Flaticon](https://www.flaticon.com/)
