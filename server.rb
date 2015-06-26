require 'sinatra'
require 'fileutils'
require 'csv'
require './src/services/drug_counts_importer.rb'
require './src/services/drug_name_importer.rb'
require './src/services/location_counts_importer.rb'

require './src/services/location_name_importer.rb'

set :public_folder, Proc.new { File.join(root, "www") }

drug_count_importer = Services::DrugCountsImporter.new
drug_name_importer = Services::DrugNameImporter.new
location_count_importer = Services::DrugCountsImporter.new
location_name_importer =  Services::LocationNameImporter.new

get '/' do
  File.read(File.join('www', 'index.html'))
end

get '/drug_counts.csv' do
	drug_count_importer.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
	drug_count_importer.to_csv
end

get '/location_counts.csv' do
	location_count_importer.pull(["UNITED STATES", "CANADA", "UNITED KINGDOM", "JAPAN"])
	location_count_importer.to_csv
end

get '/drug_name.csv' do
	drug_name_importer.pull
	drug_name_importer.to_csv
end

get '/location_names.csv' do
	location_name_importer.pull
	location_name_importer.to_csv
end
