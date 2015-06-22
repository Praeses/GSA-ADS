GSA-ADS
========================


##Build Instructions
This project is built in a Unix/Linux Environment using the make system.
To build simply type make in a command line once all dependencies are met.

##Dependencies
- haml - used to build html
- scss - used to build css
- coffeescript - used to build javascript
- other ruby gems - there are a couple other ruby gems to aid in development.
  Type "bundle install --path .gems" to install them


##Development
There is a simple rack file to aid in development.
To use it type "bundle exec rackup". This will create a small local html server
to serve the static access under www

##Testing
run "bundle exec rspec"
