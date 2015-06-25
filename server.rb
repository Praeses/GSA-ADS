require 'sinatra'
require 'fileutils'
require 'csv'
require './src/services/drug_counts_importer.rb'

set :public_folder, Proc.new { File.join(root, "www") }

COUNT_IMPORTER = Services::DrugCountsImporter.new

get '/' do
  File.read(File.join('www', 'index.html'))
end

get '/drug_counts.csv' do
	COUNT_IMPORTER.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
	COUNT_IMPORTER.to_csv
end

