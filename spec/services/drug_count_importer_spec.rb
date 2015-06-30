require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_count_importer.rb'

describe "Services::DrugCountImporter" do

  klass = Services::DrugCountImporter

	it "should be defined" do
		expect(klass).not_to be nil
	end


	it "should have an API for pulling drug names" do
		subject = klass.new
		data = subject.pull
		expect(data.size).not_to be 0
	end


	it "should be able to return data in csv format" do
		subject = klass.new
		data = subject.pull
		expect(data.to_csv).to_not be nil
	end


	it "csv should start with DRUG" do
		subject = klass.new
		data = subject.pull
		expect(data.to_csv).to start_with("DRUG")
	end


end
