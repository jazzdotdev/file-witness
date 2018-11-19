# Integrating TravisCI to use important key-file on public github repository
Guide to securely upload a private key file to github repository to deploy using TravisCI.

In our case: we have to upload a `private_key` file to our github repo: [torchbear](https://github.com/foundpatterns/torchbear). Then sign binary files with it.
#### Dependencies 
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

#### Setup
Keep the `private_key` file in the same directory where the `.travis.yml` file is.
We need to encrypt it, so we can push it to the public git repository.
To encrypt:
```
travis encrypt-file private_key --add
```


The above command will create a file with name `private_key.enc` and will add something like this to your `.travis.yml`
```
before_install:
- openssl aes-256-cbc -K $encrypted_d833950d04bb_key -iv $encrypted_d833950d04bb_iv
  -in private_key.enc -out private_key -d
```

You have to push this newly created `private_key.enc` to your public repo, do **not** push `private_key`!

Done! Travis will automatically decrypt the file for you, and the content won't be exposed. 

You can set the decrypted file name by editing the flag which travis added to our `.travis.yml`. In our case: `-out private_key`, the file name will be `private_key`.
