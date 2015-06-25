GSA-ADS
========================

##Build Status
[![Build Status](https://travis-ci.org/Praeses/GSA-ADS.svg?branch=dev)](https://travis-ci.org/Praeses/GSA-ADS)

## Site Link
[![gsa-ads.praeses.com](http://gsa-ads.praeses.com)](http://gsa-ads.praeses.com)


##Build Instructions
This project is built in a Unix/Linux Environment using the make system.
To build simply type make in a command line once all dependencies are met.

##Dependencies
- haml - used to build html
- scss - used to build css
- coffeescript - used to build javascript
- other node libs - these are used for testing. run "npm install"
- other ruby gems - there are a couple other ruby gems to aid in development.
  Type "bundle install --path .gems" to install them


##Development
There is a simple rack file to aid in development.
To use it type "bundle exec rackup". This will create a small local html server
to serve the static assets under www

##Testing
run "npm test"
