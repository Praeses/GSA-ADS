
fs = require('fs')

files = fs.readdirSync('./spec/specs')


require("./specs/#{file}") for file in files
