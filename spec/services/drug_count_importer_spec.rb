require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/drug_counts_importer.rb'

describe "Services::DrugCountsImporter" do

  klass = Services::DrugCountsImporter

	it "should be defined" do
		klass.should_not be nil
	end

	it "should have an API for pulling drug counts by date" do
		subject = klass.new
		subject.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
		subject.unsaved.size.should_not be 0
	end

	it "should be able to return data in csv format" do
		subject = klass.new
		subject.pull(["sodium", "aspirin", "hydrochloride", "calcium"])
		subject.to_csv.should_not be nil
	end

end


