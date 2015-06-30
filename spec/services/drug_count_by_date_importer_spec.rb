require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_counts_by_date_importer.rb'

describe "Services::DrugCountsByDateImporter" do

  klass = Services::DrugCountsByDateImporter
  subject = klass.new


	it "should be defined" do
		expect(klass).not_to be nil
	end

	it "should have an API for pulling drug counts by date" do
		data = subject.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
		expect(data.size).not_to be 0
	end

	it "should be able to return data in csv format" do
    data = subject.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
		expect(data.to_csv).to_not be nil
	end




end
