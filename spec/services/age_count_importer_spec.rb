require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/age_count_importer.rb'

describe "Services::AgeCountImporter" do

  klass = Services::AgeCountImporter

	it "should be defined" do
		expect(klass).to_not be nil
	end


	it "should have an API for pulling location names" do
		subject = klass.new
		data = subject.pull
		expect(data.size).to_not be 0
	end


	it "should be able to return data in csv format" do
		subject = klass.new
		data = subject.pull
		expect(data.to_csv).to_not be nil
	end


	it "csv should start with AGE" do
		subject = klass.new
		data = subject.pull
		expect(data.to_csv).to start_with("AGE")
	end


end
