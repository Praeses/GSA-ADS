require 'sinatra'
require 'fileutils'
require 'csv'
require './src/services/drug_counts_importer.rb'

set :public_folder, Proc.new { File.join(root, "www") }

DRUG_COUNT_IMPORTER = Services::DrugCountsImporter.new
LOCATION_COUNT_IMPORTER = Services::DrugCountsImporter.new

get '/' do
  File.read(File.join('www', 'index.html'))
end

get '/drug_counts.csv' do
	DRUG_COUNT_IMPORTER.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
	DRUG_COUNT_IMPORTER.to_csv
end

get '/location_counts.csv' do
	LOCATION_COUNT_IMPORTER.pull(["UNITED STATES", "CANADA", "UNITED KINGDOM", "JAPAN"])
	LOCATION_COUNT_IMPORTER.to_csv
end