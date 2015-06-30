require 'sinatra'
require 'fileutils'
require 'csv'
require './src/services/drug_counts_by_date_importer.rb'
require './src/services/drug_count_importer.rb'
require './src/services/location_counts_by_date_importer.rb'
require './src/services/location_count_importer.rb'
require './src/services/age_count_importer.rb'

set :public_folder, Proc.new { File.join(root, "www") }

drug_count_by_date_importer = Services::DrugCountsByDateImporter.new
drug_count_importer = Services::DrugCountImporter.new
location_count_by_date_importer = Services::LocationCountsByDateImporter.new
location_count_importer =  Services::LocationCountImporter.new
age_count_importer =  Services::AgeCountImporter.new

get '/' do
  File.read(File.join('www', 'index.html'))
end

get '/drug_events_by_date.csv' do
	data = drug_count_by_date_importer.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
	data.to_csv
end

get '/location_events_by_date.csv' do
	data = location_count_by_date_importer.pull(["UNITED STATES", "CANADA", "UNITED KINGDOM", "JAPAN"])
	data.to_csv
end

get '/drug_counts.csv' do
	data = drug_count_importer.pull()
  data.to_csv
end

get '/location_counts.csv' do
	data = location_count_importer.pull()
  data.to_csv
end

get '/age_counts.csv' do
	data = age_count_importer.pull()
  data.to_csv
end


