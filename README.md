GSA-ADS
========================

## Site Link
[gsa-ads.praeses.com](http://gsa-ads.praeses.com)

##Build Status
[![Build Status](https://travis-ci.org/Praeses/GSA-ADS.svg?branch=dev)](https://travis-ci.org/Praeses/GSA-ADS)

##Build Instructions
This project is built in a Unix/Linux Environment using the make system.
To build simply type the command 'make' in a command line once all dependencies are met.
To meet the dependencies install: nodejs, ruby, and bundler
Then run the commands:
- bundle install --path=.gems
- npm install

##Dependencies
- haml - used to build html
- scss - used to build css
- coffeescript - used to build javascript
- other node libs - these are used for testing. run "npm install"
- other ruby gems - there are a couple other ruby gems to aid in development.
  Type "bundle install --path .gems" to install them

##Development
start the server using 'make run'
This starts a small sinatra server used to cache api request and format the
output.

##Testing
run "make test"

##Deployment
This application runs inside a Docker container. To deploy it to a server all
that is needed is a working copy of Docker to build the project and run it.
First run the command “make docker_image” in the root of the project. This will
build the Docker image. It can them be ran locally or exported for use on
another system.
