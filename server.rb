require 'sinatra'
require 'fileutils'
require 'csv'
require './src/services/drug_counts_importer.rb'

set :public_folder, Proc.new { File.join(root, "www") }

get '/' do
  File.read(File.join('www', 'index.html'))
end



get '/drug_counts.csv' do
	importer = Services::DrugCountsImporter.new
	importer.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
	importer.to_csv
end

