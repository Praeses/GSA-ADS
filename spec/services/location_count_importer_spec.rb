require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/location_counts_importer.rb'

describe "Services::LocationCountsImporter" do

  klass = Services::LocationCountsImporter

	it "should be defined" do
		expect(klass).not_to be nil
	end

	it "should have an API for pulling location counts by date" do
		subject = klass.new
		subject.pull(["UNITED+STATES", "US", "UNITED+KINGDOM", "JAPAN"])
		expect(subject.unsaved.size).to_not be 0
	end

	it "should be able to return data in csv format" do
		subject = klass.new
		subject.pull(["UNITED+STATES", "US", "UNITED+KINGDOM", "JAPAN"])
		expect(subject.to_csv).to_not be nil
	end

end


