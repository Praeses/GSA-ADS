require 'sinatra'
require 'fileutils'


set :public_folder, Proc.new { File.join(root, "www") }

get '/' do
  File.read(File.join('www', 'index.html'))
end

