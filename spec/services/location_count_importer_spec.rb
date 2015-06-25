require File.expand_path '../../spec_helper.rb', __FILE__
require './src/services/location_counts_importer.rb'

describe "Services::LocationCountsImporter" do

  klass = Services::LocationCountsImporter

	it "should be defined" do
		klass.should_not be nil
	end

	it "should have an API for pulling location counts by date" do
		subject = klass.new
		subject.pull(["UNITED STATES", "US", "UNITED KINGDOM", "JAPAN"])
		#subject.pull("sodium")
		subject.unsaved.size.should_not be 0
	end

end


