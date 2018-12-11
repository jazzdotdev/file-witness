<p align="center"><img width="100" src="https://i.imgur.com/gtf4kBl.png" alt="file-witness logo"><br>This Project is Currently in Stealth Mode.<br>please do not post a news story until v0.1 is released very shortly.<br>thank you.</p>


## Using torchbear to generate detached signature

Guide to securely upload a private key file to github repository to deploy using TravisCI.

In our case: we have to upload a `private_key` file to our github repo: [torchbear](https://github.com/foundpatterns/torchbear). Then sign binary files with it.

## Dependencies

Assuming you have authenticated travis with github, you will need to download travis command line tool. To install just enter:

```
$ gem install travis
```

In case, this doesn't work you can look up at the travis' github repo: [travis.rb](https://github.com/travis-ci/travis.rb#installation)
You will need to login into `travis` CLI tool to proceed. To login:

```
$ travis login
```

You'll have to enter your github credentials.

## Setup

### Generating private key

To generate a shared key-pair we have to call `torchbear`'s `crypto.sign.new_keypair()` function. To do so, create a file named `init.lua` and add this:

```[lua]
local sign_priv, sign_pub = crypto.sign.new_keypair()
local file = io.open("private_key", "w")
local file2 = io.open("public_key", "w")
file:write(tostring(sign_priv), "\n")
file2:write(tostring(sign_pub), "\n")
```

### Adding the private key to github repo

Keep/move the `private_key` file in the same directory where the `.travis.yml` file is.
We need to encrypt it, so we can push it to the public git repository.
To encrypt:

```
travis encrypt-file private_key --add
```

The above command will create a file with name `private_key.enc` and will add something like this to your `.travis.yml`

```[yaml]
before_install:
- openssl aes-256-cbc -K $encrypted_d833950d04bb_key -iv $encrypted_d833950d04bb_iv
  -in private_key.enc -out private_key -d
```

You have to push this newly created `private_key.enc` to your public repo, do **not** push `private_key`!

Travis will automatically decrypt the file for you, and the content won't be exposed.

You can set the decrypted file name by editing the flag which travis added to our `.travis.yml`. In our case: `-out private_key`, the file name will be `private_key`.

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
