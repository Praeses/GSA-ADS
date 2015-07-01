##Build Instructions
This project is built in a Unix/Linux Environment using the make system.
To build simply type the command 'make' in a command line once all dependencies are met.

To meet the dependencies install: nodejs, ruby, and bundler

This will vary based on your Linux environment. It is recommended to install
these with your distros package manager. For a distro such as Ubuntu this would
be the following commands
```bash
sudo apt-get install nodejs
sudo apt-get install ruby
sudo apt-get install ruby-dev
gem install bundler
```

Then in the project folder run the commands:
```bash
bundle install --path=.gems
npm install
```



##Dependencies
- haml - used to build html
- scss - used to build css
- coffeescript - used to build javascript
- other node libs - these are used for testing. run "npm install"
- other ruby gems - there are a couple other ruby gems to aid in development.
  Type "bundle install --path .gems" to install them


##Development
start the server using 'make run'
This starts a small sinatra server used to cache api requests and format the
output.


##Testing
run "make test"
All test are require to pass to build the docker image and deploy


##Deployment
This application runs inside a Docker container. To deploy it to a server all
that is needed is a working copy of Docker to build the project and/or run it.

To build the docker image, first run the command “make docker_image” in the root of the project. This will
build the Docker image. It can them be ran locally or exported for use on
another system.

Alternatively the image can be downloaded from dockerhub with the following command
"docker pull lex148/gsa-ads"






